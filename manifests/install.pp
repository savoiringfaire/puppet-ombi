# == Class ombi::install
#
# This class is called from ombi for install.
#

class ombi::install {
  include apt
  if ($ombi::manage_ppa) {
    apt::ppa { 'ppa:modriscoll/ombi': }

    apt::key { 'ppa:modriscoll/ombi':
      id => '0x0778B73662C73F57DB254490780F1E2D6CDE748F'
    }

    package { 'ombi':
      ensure  => present,
      require => [
        Apt::Ppa['ppa:modriscoll/ombi'],
        Apt::Key['ppa:modriscoll/ombi'],
        Class['apt::update'],
      ]
    }
  }

  package { $ombi::packages:
    ensure  => latest,
    require => Class['apt::update'],
  }

  group { $::ombi::group:
      ensure     => present,
  } -> if ($::ombi::manage_user) {
    user { $::ombi::user:
      ensure     => present,
      comment    => 'ombi [Puppet Managed]',
      home       => $::ombi::service_dir,
      membership => minimum,
      groups     => $::ombi::user_resource_group,
      managehome => true,
      system     => true,
      password   => '!',
    }
  }
}
