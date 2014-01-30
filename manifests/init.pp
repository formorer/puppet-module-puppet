# Class: puppet
#
# This module manages puppet
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class puppet 
(
 $puppetlabs_repo = $puppet::params::puppetlabs_repo,
 $master = $puppet::params::master,
 $run_agent = $puppet::params::run_agent,
 $report = $puppet::params::report,
 $pluginsync = $puppet::params::pluginsync,
 $environment = $puppet::params::environment,
 $listen = $puppet::params::listen
)
{
 # this class does nothing, use puppet::client or puppet::master
}
