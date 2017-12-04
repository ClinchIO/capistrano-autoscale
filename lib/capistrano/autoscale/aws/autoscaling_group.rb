require 'aws-sdk'
require 'capistrano/autoscale/aws/credentials'

module Capistrano
  module Autoscale
    module Aws
      module AutoscalingGroup
        include Capistrano::Autoscale::Aws::Credentials
        include Capistrano::DSL

        def autoscale
          @autoscaling ||= ::Aws::AutoScaling::Client.new(credentials)
        end

        def autoscale_groups
          @autoscale_groups ||= autoscale.describe_auto_scaling_groups({auto_scaling_group_names: [autoscale_group_names].flatten}).auto_scaling_groups
        end

        def autoscale_group_names
          fetch(:aws_autoscale_groups)
        end

      end
    end
  end
end