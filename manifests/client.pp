class puppet::client inherits puppet
{
    anchor {'ntp::client::begin': } ->
        class {'puppet::install': } ->
    anchor {'ntp::client::end': }
  
    $run_agent_param = $run_agent ? {
        true => 'yes',
        default => 'no'
    }

    augeas { "manage_service" :
        context => "/files/etc/default/puppet",
        changes => [
            "set START ${run_agent_param}"
            ],
        notify => Exec["reload-puppet"]
    }

    $run_agent_service = $run_agent ? {
        true => 'running',
        default => 'stopped'
    }

    service { 'puppet':
        enable => $run_agent,
        ensure => $run_agent_service
    }

    Augeas['manage_service'] -> Service['puppet']


    if $master {
        augeas { "puppet_master":
            context => "/files/etc/puppet/puppet.conf",
            changes => [
                "set agent/server ${master}",
            ],
            notify => Exec["reload-puppet"]
        }
    }

    if $listen {
        augeas { "puppet_listen":
            context => "/files/etc/puppet/puppet.conf",
            changes => [
                "set agent/listen ${listen}"
            ],
            notify => Exec["reload-puppet"]
        }
    } else {
               augeas { "puppet_listen":
            context => "/files/etc/puppet/puppet.conf",
            changes => [
                "set agent/listen false"
            ],
            notify => Exec["reload-puppet"]
        }
    }

    if $environment {
     augeas { "puppet_environment":
            context => "/files/etc/puppet/puppet.conf",
            changes => [
                "set agent/environment ${environment}",
            ],
            notify => Exec["reload-puppet"]
        }
    }

    exec { "reload-puppet":
        command => '/usr/sbin/service puppet force-reload',
        refreshonly => true,
    }
}
