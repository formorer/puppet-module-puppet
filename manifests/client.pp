class puppet::client inherits puppet
{
    anchor {'ntp::client::begin': } ->
        class {'puppet::install': } ->
    anchor {'ntp::client::end': }
  
    $run_agent_param = $run_agent ? {
        true => 'yes',
        default => 'no'
    }

    notify { "${run_agent} ${run_agent_param}": }
    augeas { "manage_service" :
        context => "/files/etc/default/puppet",
        changes => [
            "set START ${run_agent_param}"
            ]
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
            ]
        }
    }

    if $environment {
     augeas { "puppet_environment":
            context => "/files/etc/puppet/puppet.conf",
            changes => [
                "set agent/environment ${environment}",
            ]
        }
    }


}
