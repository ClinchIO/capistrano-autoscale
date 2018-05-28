require 'aws-sdk-core'

require 'capistrano/all'
require 'capistrano/dsl'

require 'capistrano/autoscale/version'
require 'capistrano/autoscale/aws/autoscaling_group'
require 'capistrano/autoscale/aws/ec2'

module Capistrano
  module Autoscale
  end
end

def autoscale(groupnames, *args)
  include Capistrano::DSL
  include Capistrano::Autoscale::Aws::AutoscalingGroup
  include Capistrano::Autoscale::Aws::EC2

  set :aws_autoscale_groups, groupnames

  if autoscale_groups
    instances = []
    
    autoscale_groups.each do |autoscale_group|
      group_instances = autoscale_group.instances.select do |instance|
        instance.lifecycle_state == 'InService'
      end
      instances += group_instances
    end

    instances.each do |instance|
      hostname = ec2_instance(instance.instance_id).private_ip_address
      p "Autoscale deploying to: #{hostname}"
      server(hostname, *args)
    end
  else
    p "Error: No #{groupnames} autoscale group found."
  end
end