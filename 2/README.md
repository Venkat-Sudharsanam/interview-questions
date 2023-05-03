# Script to check the dis utils

To run this script the ec2 instance should be configured with below :
```
sudo yum install python3 python3-pip vim jq -y

sudo pip3 install awscli

aws configure
```
With that you can run the disk-ustil.sh

#Script to connect to VM and run
```
cd 2/
ssh username@remote_machine_ip_address 'bash -s' < ./vm-details.sh
```
If it is a EC2 machine, follow the below command:
```
chmod 400 <file>.pem
scp -i <file>.pem ./vm-details.sh ec2-user@ec2-instance-ip-address:/home/ec2-user/

ssh -i "<file>.pem" ec2-user@ec2-3-69-93-134.eu-central-1.compute.amazonaws.com
cd /home/ec2-user
sudo chmod +x vm-details.sh
./vm-details.sh
```