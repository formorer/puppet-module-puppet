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
  $puppetlabs_repo = $puppet::params::puppetlabs_repo
)
{
 # this class does nothing, use puppet::client or puppet::master
}
