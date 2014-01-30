class puppet::install::debian inherits puppet {
  if $puppetlabs_repo {
    apt::key { 'puppetlabs':
      key        => '4BD6EC30',
      key_server => 'pgp.mit.edu',
    }

    apt::source { 'puppetlabs':
      location   => 'http://apt.puppetlabs.com',
      repos      => 'main dependencies',
      key        => '4BD6EC30',
      key_server => 'pgp.mit.edu',
    }
    
    Apt::Key['puppetlabs'] -> Apt::Source['puppetlabs'] -> Package['puppet']
  }
  ensure_packages([ 'puppet', 'libaugeas-ruby' ]);
}
