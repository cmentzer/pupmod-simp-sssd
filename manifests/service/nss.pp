# This class sets up the [nss] section of /etc/sssd.conf.
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
class sssd::service::nss {
  assert_private()
  include '::sssd'

  # These varaibles are referenced inside the autofs template.
  $command                       = $sssd::nss_command
  $description                   = $sssd::nss_description
  $debug_level                   = $sssd::nss_debug_level
  $debug_timestamps              = $sssd::nss_debug_timestamps
  $debug_microseconds            = $sssd::nss_debug_microseconds
  $default_shell                 = $sssd::nss_default_shell
  $enum_cache_timeout            = $sssd::nss_enum_cache_timeout
  $entry_cache_nowait_percentage = $sssd::nss_entry_cache_nowait_percentage
  $entry_negative_timeout        = $sssd::nss_entry_negative_timeout
  $fallback_homedir              = $sssd::nss_fallback_homedir
  $filter_users                  = $sssd::nss_filter_users
  $filter_groups                 = $sssd::nss_filter_groups
  $filter_users_in_groups        = $sssd::nss_filter_users_in_groups
  $get_domains_timeout           = $sssd::nss_get_domains_timeout
  $memcache_timeout              = $sssd::nss_memcache_timeout
  $override_homedir              = $sssd::nss_override_homedir
  $override_shell                = $sssd::nss_override_shell
  $reconnection_retries          = $sssd::nss_reconnection_retries
  $user_attributes               = $sssd::nss_user_attributes
  $vetoed_shells                 = $sssd::nss_vetoed_shells

  concat::fragment { 'sssd_nss.service':
    target  => $sssd::conf_file_path,
    content => template("${module_name}/service/nss.erb")
  }
}
