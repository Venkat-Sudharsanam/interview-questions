#!/bin/bash

if [[ -f /etc/redhat-release ]]; then
    PM=$(rpm -qa --queryformat '%{NAME}-%{VERSION}\n' | sort)
elif [[ -f /etc/debian_version ]]; then
    PM=$(dpkg-query -W -f='${Package}-${Version}\n' | sort)
else
    echo "Unsupported Linux distribution"
    exit 1
fi

KERNEL_VERSION=$(uname -r)

RUNNING_PROCESSES=$(ps aux)

# Print the results
echo "Kernel version: $KERNEL_VERSION"
echo "Installed packages:"
for i in $PM
do
  echo $i
done
echo "Running processes:"
echo "$RUNNING_PROCESSES"