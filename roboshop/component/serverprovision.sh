#!/bin/bash

AMI_ID="ami-001a179c2bc4afd77"
SGID="sg-08c5594f157c76f58"

aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t2.micro \
    --key-name MyKeyPair \
    --security-group-ids $SGID \
    --count 1