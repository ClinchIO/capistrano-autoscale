require 'aws-sdk-autoscaling'
require 'capistrano/autoscale/aws/autoscaling_credentials'

module Capistrano
  module Autoscale
    module Aws
      module AutoscalingGroup
        include Capistrano::Autoscale::Aws::AutoscalingCredentials
        include Capistrano::DSL

        def autoscale_groups
          ::Aws::AutoScaling::Client.new(autoscaling_credentials).describe_auto_scaling_groups({auto_scaling_group_names: [autoscale_group_names].flatten}).auto_scaling_groups
        end

        def autoscale_group_names
          fetch(:aws_autoscale_groups)
        end

      end
    end
  end
end