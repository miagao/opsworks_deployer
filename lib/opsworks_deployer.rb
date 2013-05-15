class OpsworksDeployer < Rails::Railtie

  rake_tasks do
    # Authenticate to AWS
    task :confirm do
        confirm_token = rand(36**6).to_s(36)
        STDOUT.puts "Confirm deploy? Enter '#{confirm_token}' to confirm:"
        input = STDIN.gets.chomp
        raise "Aborting [ACTION]. You entered #{input}" unless input == confirm_token
    end

    desc "Deploy the app to the LIVE environment"
    task :deploy,[:tag] => :confirm do |t , args|
      config_file = File.read(File.join( File.dirname(__FILE__), 'config', 'aws.yml.erb'))
      AWS_CONFIG = YAML.load(ERB.new(config_file).result)['production']
      puts AWS_CONFIG
      AWS.config(AWS_CONFIG)
      client = AWS::OpsWorks.new.client
      tag = args.tag
      config_file2 = File.read(File.join( File.dirname(__FILE__), 'config', 'opsworks.yml.erb'))
      regions = YAML.load(ERB.new(config_file2).result)['production']


      deploy_options = {}
      deploy_options[:command] = {name:'deploy'}

      azs = ['us-east-1a','us-east-1b','us-east-1c','us-east-1d']

      azs.each do |zone|
        regions.each do |region, options|
          p options
          deploy_options[:instance_ids] = []
          deploy_options[:app_id]   = options['app_id']
          deploy_options[:comment]  = "rake deploy from '#{Socket.gethostname}'"
          instances = client.describe_instances({layer_id: options['layer_id']})
          next if instances.nil? || instances.empty?

          if tag
            app_options = {}
            app_options[:app_id] = options['app_id']
            app_revision = {}
            app_revision[:revision] = tag
            app_options[:app_source] = app_revision
            client.update_app( app_options )
            tag = false
          end
          # Capture the details for each 'online' instance
          instances[:instances].each do |instance|
           puts instance
            if 'online' == instance[:status] && zone == instance[:availability_zone]
              deploy_options[:instance_ids] << instance[:instance_id]
              deploy_options[:stack_id] = instance[:stack_id]
            end
          end

          puts "Deploying to #{deploy_options[:instance_ids].count} instances in the #{region.upcase} region... in Zone #{zone.upcase}"
          deploy_id = client.create_deployment deploy_options


          deployment_options = {}
          deployment_options[:deployment_ids] = []
          deployment_options[:deployment_ids] << deploy_id.deployment_id

          begin
            sleep 5
            deployments = client.describe_deployments deployment_options
            next if deployments.nil? || deployments.empty?
            response = "running"
            deployments[:deployments].each do |deploy|
              response = deploy[:status]
            end
            puts "...#{response}..."
          end while response == "running"
          sleep 5
          puts "...DONE!"
        end
      end
    end
  end
end
