action :init do
  Chef::Log.info("Make instance via runit #{new_resource.name}")

  gottwall_new_resource = new_resource

  runit_service gottwall_new_resource.name do
    template_name gottwall_new_resource.name
    run_restart false
    options :user => gottwall_new_resource.user,
    :group => gottwall_new_resource.group,
    :service_name => gottwall_new_resource.name,
    :config => gottwall_new_resource.config,
    :pidfile => gottwall_new_resource.pidfile,
    :port => gottwall_new_resource.port,
    :host => gottwall_new_resource.host,
    :virtualenv => gottwall_new_resource.virtualenv
  end

end
