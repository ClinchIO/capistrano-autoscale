module Capistrano
  module Autoscale
    module Aws
      module AutoscalingCredentials
        include Capistrano::DSL

        def autoscaling_credentials
          credentials = {
              access_key_id: fetch(:aws_access_key_id, ENV['AWS_ACCESS_KEY_ID']),
              secret_access_key: fetch(:aws_secret_access_key, ENV['AWS_SECRET_ACCESS_KEY'])
          }
          credentials.merge! session_token: fetch(:aws_session_token, ENV['AWS_SESSION_TOKEN']) if fetch(:aws_session_token, ENV['AWS_SESSION_TOKEN'])
          credentials.merge! region: fetch(:aws_region) if fetch(:aws_region)
          credentials
        end

      end
    end
  end
end