# == Class: sssd::service::autofs
#
# This class sets up the [autofs] section of /etc/sssd.conf.
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
class sssd::service::autofs {
  assert_private()
  include '::sssd'

  # These varaibles are referenced inside the autofs template. 
  $autofs_negative_timeout = $sssd::autofs_negative_timeout
  $debug_level             = $sssd::autofs_debug_level
  $debug_timestamps        = $sssd::autofs_debug_timestamps
  $debug_microseconds      = $sssd::autofs_debug_microseconds
  $description             = $sssd::autofs_description

  concat::fragment { 'sssd_autofs.service':
    target  => $sssd::conf_file_path,
    content => template("${module_name}/service/autofs.erb")
  }
}
