# == Class: lldp
#
# Installs and runs lldpd + adds facts returning vlan & switch port
# information
#
# === Examples
#
#   include lldp
#
class lldp inherits lldp::params {

  $baseurl = 'http://widehat.opensuse.org/repositories/home:/vbernat/'

  case $::operatingsystem {
    /RedHat|CentOS/: {
      $repourl = "${baseurl}/RedHat_RHEL-${::lsbmajdistrelease}"
      yumrepo { 'lldp':
        baseurl     => $repourl,
        descr       => 'lldp package from vbernat',
        enabled     => 1,
        gpgcheck    => 1,
        gpgkey      => "${repourl}/repodata/repomd.xml.key",
        includepkgs => 'lldpd',
      }
    }
    /Debian/: {
      $repourl = "${baseurl}/Debian_${::lsbmajdistrelease}.0"
      apt::key { '72E0A4F6':
        ensure => present,
        source => "${repourl}/Release.key",
      }
      apt::sources_list { 'lldp':
        ensure  => present,
        content => "deb ${repourl}",
      }
    }
  }

  package { 'lldpd':
    ensure => present,
    name   => $lldp::params::package,
  }

  service { 'lldpd':
    ensure    => running,
    enable    => true,
    require   => Package['lldpd'],
    hasstatus => $lldp::params::has_status,
  }
}
