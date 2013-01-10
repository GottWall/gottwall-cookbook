action :init do
  Chef::Log.info("Make instance via supervisor #{new_resource.name}")
end
