opsworks-deployer
==================

Task to deploy via CLI on Amazon OpsWorks.

Usage:
=====

Please, set these environment variables on ~/.bash_profile or ~/.bashrc file:

```
export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY>
export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_KEY>
export OPSWORKS_LAYER_ID=<YOUR_OPSWORKS_LAYER_ID>
export OPSWORKS_APP_ID=<YOUR_APP_ID>
```

Deploys an app with predefined branch/revision:

```
rake deploy 
```

Deploys an app with specified branch/revision/tag:

```
rake deploy['\<tag name, revision or branch\>']
```	

Deploy procedure:
================

It tries to deploy each AZ on each region one at a time.
