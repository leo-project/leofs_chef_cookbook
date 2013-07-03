name              "erlang"
maintainer        "leofs.org"
maintainer_email  "cookbooks@leofs.org"
license           "Apache 2.0"
description       "Installs Erlang."
version           "0.0.1"

depends           "build-essential"
depends           "yum"
depends           "apt"

recipe "erlang", "Installs erlang"
recipe "erlang::package", "Installs erlang using packages."
recipe "erlang::source", "Installs erlang from source."

%w{ debian ubuntu centos redhat fedora freebsd smartos }.each do |os|
  supports os
end
