opsworks-deployer
==================

Task to deploy via CLI on Opswork.

Please set these environment variables:

export AWS_ACCESS_KEY_ID

export AWS_SECRET_ACCESS_KEY

export OPSWORKS_LAYER_ID

export OPSWORKS_APP_ID

on ~/.bash_profile or ~/.bashrc



Usage:
=====

rake deploy

rake deploy['tag or revision or branch']


Deploy procedure:
================

It tries to deploy each AZ one at a time.






