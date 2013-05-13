# Rakefile
require 'rubygems'
require 'bundler'
require 'yaml'
require 'rake'
Bundler.require if defined?(Bundler)

# Authenticate to AWS
AWS.config(YAML.load_file('config/aws.yml')['production'])
client = AWS::OpsWorks.new.client
task :confirm do
    confirm_token = rand(36**6).to_s(36)
    STDOUT.puts "Confirm deploy? Enter '#{confirm_token}' to confirm:"
    input = STDIN.gets.chomp
    raise "Aborting [ACTION]. You entered #{input}" unless input == confirm_token
end


desc "Deploy the app to the LIVE environment"
task :deploy,[:tag] => :confirm do |t , args|
  tag = args.tag
  regions = YAML.load_file('config/opsworks.yml')

  deploy_options = {}
  deploy_options[:command] = {name:'deploy'}
  # Loop through each region
  if tag
    app_options = {}
    app_options[:app_id] = options['app_id']
    app_revision = {}
    app_revision[:revision] = tag
    app_options[:app_source] = app_revision
    client.update_app( app_options )
  end

  azs = ['east-1a','east-1b','east-1c','east-1d']

  azs.each do |zone|
    regions.each do |region, options|
      deploy_options[:instance_ids] = []
      deploy_options[:app_id]   = options['app_id']
      deploy_options[:comment]  = "rake deploy from '#{Socket.gethostname}'"
      instances = client.describe_instances({layer_id: options['layer_id']})
      next if instances.nil? || instances.empty?

      # Capture the details for each 'online' instance
      instances[:instances].each do |instance|
        puts instance
        if 'online' == instance[:status] && izone.to_s == instance[:availability_zone=]
          deploy_options[:instance_ids] << instance[:instance_id]
          deploy_options[:stack_id] = instance[:stack_id]
        end
      end

      puts "Deploying to #{deploy_options[:instance_ids].count} instances in the #{region.upcase} region..."
      #deploy_id = client.create_deployment deploy_options


      deployment_options = {}
      deployment_options[:deployment_ids] = []
      deployment_options[:deployment_ids] << deploy_id.deployment_id
      #deployment_options[:deployment_ids] << "19f9ae90-136e-4a93-85a1-a35c6712048b"

      begin
        sleep 5
        #deployments = client.describe_deployments deployment_options
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
