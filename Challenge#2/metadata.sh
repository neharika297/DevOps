#!/bin/bash

metadata=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2021-02-01")
echo "$metadata" | jq .