include_recipe "build-essential"

configure_options = node['erlang']['configure_options'].join(" ")

packages = value_for_platform_family(
             "rhel" => ["libuuid-devel","cmake","check","check-devel"],
             "default" => ["libtool", "libncurses5-dev", "libssl-dev", "cmake", "check"]
           )

packages.each do |dev_pkg|
  package dev_pkg
end

install_path = "#{node['erlang']['prefix_dir']}/bin/erl"
archive_dir = "#{node['erlang']['url']}"[/(otp.*)\.tar\.gz$/, 1]

remote_file "#{Chef::Config[:file_cache_path]}/otp.tar.gz" do
  source "#{node['erlang']['url']}"
  mode "0644"
  not_if { ::File.exists?(install_path) }
end

bash "build-and-install-erlang" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -xvf otp.tar.gz
  NUM_OF_CPUS=`cat /proc/cpuinfo |grep processor|wc -l`
  (cd #{archive_dir} && ./configure #{configure_options})
  (cd #{archive_dir} && make -j ${NUM_OF_CPUS} && make install)
  EOF
  not_if { ::File.exists?(install_path) }
end
