# == Class: sssd::service::pac
#
# This class sets up the [pac] section of /etc/sssd.conf.
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
class sssd::service::pac {
  assert_private()
  include '::sssd'

  # These varaibles are referenced inside the pac template. 
  $allowed_uids       = $sssd::pac_allowed_uids
  $description        = $sssd::pac_description
  $debug_level        = $sssd::pac_debug_level
  $debug_timestamps   = $sssd::pac_debug_timestamps
  $debug_microseconds = $sssd::pac_debug_microseconds

  concat::fragment { 'sssd_pac.service':
    target  => $sssd::conf_file_path,
    content => template("${module_name}/service/pac.erb")
  }
}
