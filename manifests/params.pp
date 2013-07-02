class lldp::params {
  $package = $::operatingsystem ? {
    /RedHat|CentOS/ => "lldpd.${::architecture}",
    default         => 'lldpd',
  }

  $has_status = "${::operatingsystem} ${::operatingsystemmajrelease}" ? {
    'Debian 7' => true,
    default    => false,
  }
}
