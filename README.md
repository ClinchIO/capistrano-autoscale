# Capistrano::Autoscale

This plugin was written to ease the deployment of Rails applications to AWS AutoScale groups.


## Installation

Add this line to your application's Gemfile:

```gem 'capistrano-autoscale'```

Add this statement to your Capfile:

```require 'capistrano/autoscale```

## Configuration

Below are the Capistrano configuration options with their defaults:

```
set :aws_access_key_id,     ENV['AWS_ACCESS_KEY_ID']
set :aws_secret_access_key, ENV['AWS_SECRET_ACCESS_KEY']
set :aws_region,            ENV['AWS_REGION']
```

And set the autoscale group:

```
autoscale '<auto-scale-group-name>', user: '<deployment user>', roles: [<array of cap roles>]
```