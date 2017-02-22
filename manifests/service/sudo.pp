# == Class: sssd::service::sudo
#
# This class sets up the [sudo] section of /etc/sssd.conf.
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
class sssd::service::sudo {
  assert_private()
  include '::sssd'

  # These varaibles are referenced inside the autofs template.
  $description        = $sssd::sudo_description
  $debug_level        = $sssd::sudo_debug_level
  $debug_timestamps   = $sssd::sudo_debug_timestamps
  $debug_microseconds = $sssd::sudo_debug_microseconds
  $sudo_timed         = $sssd::sudo_timed

  concat::fragment { 'sssd_sudo.service':
    target  => $sssd::conf_file_path,
    content => template("${module_name}/service/sudo.erb")
  }
}
