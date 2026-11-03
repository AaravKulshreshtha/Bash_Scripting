#!/bin/bash

AMI_ID="resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
SGID="sg-08c5594f157c76f58"

aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t3.micro \
    --key-name Aarav \
    --security-group-ids $SGID \
    --count 1