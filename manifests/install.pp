class puppet::install inherits puppet {
  
  if $puppetlabs_repo {
    case $operatingsystem {
      'Debian': { include puppet::install::debian }
      default: { notice ("OS ${operatingsystem} is unsupported") }
    }
  } 
}