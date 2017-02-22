# == Class: sssd::service::ssh
#
# This class sets up the [ssh] section of /etc/sssd.conf.
# You may only have one of these per system.
#
# This class should be controlled via hiera, by setting the values 
# of the keys exposed in init.pp that correspond to this section
# of the conf file. 
#
# == Authors
#
# * Trevor Vaughan <mailto:tvaughan@onyxpoint.com>
# * Clayton Mentzer <mailto:clayton.mentzer@onyxpoint.com>
#
class sssd::service::ssh {

  include '::sssd'

  # These varaibles are referenced inside the ssh template.
  $description             = $sssd::ssh_description
  $debug_level             = $sssd::ssh_debug_level
  $debug_timestamps        = $sssd::ssh_debug_timestamps
  $debug_microseconds      = $sssd::ssh_debug_microseconds
  $ssh_hash_known_hosts    = $sssd::ssh_hash_known_hosts
  $ssh_known_hosts_timeout = $sssd::ssh_known_hosts_timeout

  concat::fragment { 'sssd_ssh.service':
    target  => $sssd::conf_file_path,
    content => template("${module_name}/service/ssh.erb")
  }
}
