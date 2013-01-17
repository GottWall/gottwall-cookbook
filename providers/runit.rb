action :init do
  Chef::Log.info("Make instance via runit #{new_resource.name}")

  gottwall_new_resource = new_resource

  config = gottwall_new_resource.config || gottwall_new_resource.name || node["gottwall"]["config"]
  template_name = gottwall_new_resource.template_name || gottwall_new_resource.name
  log_level = gottwall_new_resource.log_level || node["gottwall"]["log_level"]

  Chef::Log.info(config)

  runit_service gottwall_new_resource.name do
    template_name template_name
    run_restart true
    options :user => gottwall_new_resource.user,
    :group => gottwall_new_resource.group,
    :service_name => gottwall_new_resource.name,
    :config_file => config,
    :pidfile => gottwall_new_resource.pidfile,
    :port => gottwall_new_resource.port,
    :host => gottwall_new_resource.host,
    :virtualenv => gottwall_new_resource.virtualenv
    :log_level => log_level
  end
end
