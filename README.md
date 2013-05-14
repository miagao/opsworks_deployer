opsworks-deployer
==================

Task to deploy via CLI on Opswork.

Please set these environment variables:

export AWS_ACCESS_KEY_ID=%YOUR_ACCESS_KEY_%\n
export AWS_SECRET_ACCESS_KEY=%YOUR_SECRET_KEY_%\n
export OPSWORKS_LAYER_ID=%YOUR_OPSWORKS_LAYER_ID_%\n
export OPSWORKS_APP_ID=%YOUR_APP_ID%\n

on ~/.bash_profile or ~/.bashrc



Usage:
=====

Deploys an app with predefined branch/revision:

rake deploy 

Deploys an app with specified branch/revision/tagtag:
rake deploy['<tag or revision or branch>']
	

Deploy procedure:
================

It tries to deploy each AZ on each region one at a time.






