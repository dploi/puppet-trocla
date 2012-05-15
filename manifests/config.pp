class trocla::config($ruby='system') {
  if $trocla::config::ruby == 'system' or $trocla::config::ruby == 'both' {
    require trocla::master
  }
  if $trocla::config::ruby == 'ree' or $trocla::config::ruby == 'both' {
    require trocla::master::ree
  }

  # deploy default config file and link it for trocla cli lookup
  file{
    "/etc/puppet/troclarc.yaml":
      content => "---\nadapter_options:\n    :path: /etc/puppet/troclarc.yaml/trocla_data.yaml\n",
      owner => root, group => puppet, mode => 0640;
    '/etc/troclarc.yaml':
      ensure => link,
      target => "/etc/puppet/troclarc.yaml";
    "/etc/puppet/trocla_data.yaml":
      ensure => present,
      owner => puppet, group => 0, mode => 0600;
  }
}
