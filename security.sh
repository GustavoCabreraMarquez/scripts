#!/bin/bash
#author: Gustavo Marquez
#Applies certain rule into all sg's in logged account/region


#Static Variables
protocol='tcp'
port_range=22
source_address='10.17.0.0/16'
region='us-east-1'

#Here you'll set which account the script will be ran against 
profile='localstack'

#Getting the secruity group name list
security_groups=$(aws ec2 describe-security-groups --profile $profile --region $region | grep GroupName | sed 's/[":,]//g' | sed 's/GroupName//g')

echo '##########'
echo '##########'
echo "Remember to configure you're desired account profile to use this script, happy coding ;)"
echo '##########'
echo '##########'
sleep 2


for sg in $security_groups; do
	echo $sg_name

	aws ec2 authorize-security-group-ingress --group-id $sg --protocol $protocol --port $port_range --cidr $source_address --region $region --profile $profile


	echo added onbound traffic for source ip $source_address and port $port_range for security group $sg 

done
