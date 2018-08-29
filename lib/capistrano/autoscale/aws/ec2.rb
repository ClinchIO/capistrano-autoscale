require 'aws-sdk-ec2'
require 'capistrano/autoscale/aws/autoscaling_credentials'

module Capistrano
  module Autoscale
    module Aws
      module EC2
        include Capistrano::Autoscale::Aws::AutoscalingCredentials

        def ec2_client
          @ec2_client ||= ::Aws::EC2::Client.new(autoscaling_credentials)
        end

        def ec2_instance(instance_id)
          ::Aws::EC2::Instance.new(instance_id, client: ec2_client)
        end

      end
    end
  end
end