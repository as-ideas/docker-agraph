#!/bin/bash

aws_user=${1:-default}
aws_ecr_account=283521545545.dkr.ecr.eu-west-1.amazonaws.com

aws ecr get-login --no-include-email --profile $aws_user | bash &>/dev/null

export VERSION=6.4.5 && export ACCOUNT=$aws_ecr_account && make
export VERSION=6.4.5 && export ACCOUNT=$aws_ecr_account && make push