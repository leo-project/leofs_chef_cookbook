default['erlang']['install_method'] = 'package'

if erlang['install_method'] == 'package'
  case platform
  when "smartos"
    default['erlang']['prefix_dir']         = '/opt/local'
  else
    default['erlang']['prefix_dir']         = '/usr'
  end
else
  default['erlang']['prefix_dir']         = '/usr/local'
end

default['erlang']['binary'] = "#{erlang['prefix_dir']}/bin/erlang"

default['erlang']['url'] = 'http://www.erlang.org/download/otp_src_R16B01.tar.gz'
default['erlang']['configure_options'] = %W{--prefix=#{erlang['prefix_dir']}}

