# == Class: sssd::service::pam
#
# This class sets up the [pam] section of /etc/sssd.conf.
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
class sssd::service::pam {
  assert_private()
  include '::sssd'

  # These varaibles are referenced inside the pam template.
  $description                    = $sssd::pam_description
  $debug_level                    = $sssd::pam_debug_level
  $debug_timestamps               = $sssd::pam_debug_timestamps
  $debug_microseconds             = $sssd::pam_debug_microseconds
  $reconnection_retries           = $sssd::pam_reconnection_retries
  $command                        = $sssd::pam_command
  $offline_credentials_expiration = $sssd::pam_offline_credentials_expiration
  $offline_failed_login_attempts  = $sssd::pam_offline_failed_login_attempts
  $offline_failed_login_delay     = $sssd::pam_offline_failed_login_delay
  $pam_verbosity                  = $sssd::pam_verbosity
  $pam_id_timeout                 = $sssd::pam_id_timeout
  $pam_pwd_expiration_warning     = $sssd::pam_pwd_expiration_warning
  $get_domains_timeout            = $sssd::pam_get_domains_timeout
  $pam_trusted_users              = $sssd::pam_trusted_users
  $pam_public_domains             = $sssd::pam_public_domains

  concat::fragment { 'sssd_pam.service':
    target  => $sssd::conf_file_path,
    content => template("${module_name}/service/pam.erb")
  }
}
