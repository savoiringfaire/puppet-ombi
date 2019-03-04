# == Class ombi::service
#
# This class is meant to be called from ombi.
# It ensure the service is running.
#

class ombi::service {
    file { '/etc/systemd/system/ombi.service':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package[$ombi::packages],
      content => template('ombi/ombi.systemd.erb'),
    }

    service { 'ombi':
      ensure     => $ombi::service_ensure,
      enable     => $ombi::service_enable,
      hasrestart => true,
      hasstatus  => true,
      provider   => 'systemd',
      subscribe  => Concat[$ombi::config_file],
    }

    File['/etc/systemd/system/ombi.service'] ~> Service['ombi']
}
