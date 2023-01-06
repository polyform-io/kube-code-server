#!/bin/bash
current_dir_name=$(basename $(dirname $PWD))

echo "$HOME/.terragrunt/$current_dir_name.hcl"
