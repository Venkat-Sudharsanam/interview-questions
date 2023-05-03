#!/bin/bash

set -x

#Set the threshold for disk usage (in percent)
threshold=80


#Get the current disk usage for all non-root filesystems
disk_usage=$(df -h | awk 'NR>1 && !/\/$/{print $5 " " $6}')

#Loop through each line of the output and check if usage is above threshold
while read -r line; do
  usage=$(echo $line | awk '{ print $1 }' | cut -d'%' -f1)
  mount_point=$(echo $line | awk '{ print $2 }')
  if [ $usage -gt $threshold ]; then
    # Get the availability zone and region
    availability_zone=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
    region=${availability_zone:0:-1}

    # Create a new volume and wait for it to become available
    response=$(aws ec2 create-volume --availability-zone $availability_zone --region $region --size 10 --volume-type gp2 --tag-specifications 'ResourceType=volume,Tags=[{Key=Name,Value=NewDisk}]' --output json)
    volume_id=$(echo "$response" | jq -r '.VolumeId')
    aws ec2 wait volume-available --volume-ids $volume_id --region $region

    # Attach the new volume to the instance
    instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
    device=$(aws ec2 attach-volume --device /dev/xvdf --instance-id $instance_id --volume-id $volume_id --region $region --output json | jq -r '.Device')
    sleep 60
    # Create a new filesystem on the new volume and mount it
    sudo mkfs -t ext4 $device
    sudo mkdir /mnt/newdisk
    sudo mount $device /mnt/newdisk

    # Find the directory with the most usage on the mount point
    dir_to_move=$(sudo du -h $mount_point --max-depth=1 | sort -h -r | awk 'NR>1{print $2}' | while read line; do echo "$line $usage"; done | sort -h -r -k 2 | head -n 1 | cut -d' ' -f1)

    # Move the directory with high usage to the new mount point and create a new mount point for it
    sudo mkdir $mount_point/moved
    sudo mv $dir_to_move $mount_point/moved
    sudo mkdir $dir_to_move
    sudo mount $device $dir_to_move
  fi
done <<< "$disk_usage"