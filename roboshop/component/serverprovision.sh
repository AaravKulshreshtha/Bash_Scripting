#!/bin/bash

AMI_ID="ami-056b35f582f6afbe7"
SGID="sg-08c5594f157c76f58"

aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t2.micro \
    --key-name Aarav \
    --security-group-ids $SGID \
    --count 1