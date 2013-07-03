if platform_family?('rhel')
  include_recipe 'yum::epel'
end

['erlang'].each do |pkg|
  package pkg do
    action :install
  end
end
