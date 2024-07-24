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

def autoscale(groupnames, identifier_type, *args)
  include Capistrano::DSL
  include Capistrano::Autoscale::Aws::AutoscalingGroup
  include Capistrano::Autoscale::Aws::EC2

  set :aws_autoscale_groups, groupnames

  if autoscale_groups
    autoscale_groups.each do |autoscale_group|
      group_instances = autoscale_group.instances.select do |instance|
        instance.lifecycle_state == 'InService'
      end

      group_instances.each_with_index do |instance, index|
        host = host_by_identifier(instance, identifier_type)
        p "Autoscale group \"#{autoscale_group.auto_scaling_group_name}\" deploying to: #{host}"
        if index == 0
          server(host, args.first.merge(primary: true))
        else
          server(host, *args)
        end
      end
    end
  else
    p "Error: No #{groupnames} autoscale group found."
  end
end

private

def host_by_identifier(instance, identifier_type)
  identifier_type == :ip_address ? ec2_instance(instance.instance_id).private_ip_address : instance.instance_id
end