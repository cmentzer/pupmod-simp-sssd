# == Class: sssd
#
# This class allows you to install and configure SSSD.
# It will forcefully disable nscd which consequently prevents you from using an
# nscd module at the same time, which is the correct behavior.
#
# @param client_package_name
#   The name of the sssd client package (varies by OS)
#
# @param client_package_version
#   The version of the sssd client package
#
# @param conf_file_path
#   The path to the configuration file for sssd.
#
# @param conf_dir_owner
#   The owner of the sssd configuration directory.
#
# @param conf_dir_path
#   The sssd configuration directory.
#
# @param install_user_tools
#   Determines if this module should install the sssd tools package
#
# @param nscd_service_name
#   The name of the nscd service. sssd cannot coexist with nscd, so this
#   module will disable it. This is intended behavior.
#
# @param package_name
#   The name of the sssd package that will be installed.
#
# @param package_version
#   The version of the package to be installed.
#
# @param sssd_service_path
#   The path to the service executable for the sssd service
#
# @param sssd_service_name
#   The name of the sssd service
#
# @param tools_package_name
#   The name of the sssd tools package
#
# @param tools_package_version
#   The version of the tools package to be installed
#
# @param app_pki_dir
#   Controls the basepath of the $app_pki_key, $app_pki_cert,
#   $app_pki_ca, $app_pki_ca_dir, and $app_pki_crl parameters.
#
# @param auditd
#   Determines if auditd is enabled at a global level. If it is,
#   this module will take steps to ensure sssd and auditd work
#   together.
#
# @param pki
#   Determines if pki is enabled at a global level. If it is,
#   this module will take steps to ensure that sssd and pki work
#   together.
#
# @param app_pki_cert_source
#   Determines the location that pki will look for certificates.
#
# @param sssd_description
# @param sssd_domains
# @param sssd_services
# @param sssd_config_file_version
# @param sssd_debug_level
# @param sssd_debug_timestamps
# @param sssd_debug_microseconds
# @param sssd_default_domain_suffix
# @param sssd_full_name_format
# @param sssd_krb5_rcache_dir
# @param sssd_override_space
# @param sssd_reconnection_retries
# @param sssd_re_expression
# @param sssd_try_inotify
# @param sssd_user
#
# @param autofs_description
# @param autofs_debug_level
# @param autofs_debug_timestamps
# @param autofs_debug_microseconds
# @param autofs_negative_timeout
#
# @param nss_description
# @param nss_command
# @param nss_debug_level
# @param nss_debug_timestamps
# @param nss_debug_microseconds
# @param nss_default_shell
# @param nss_enum_cache_timeout
# @param nss_entry_cache_nowait_percentage
# @param nss_entry_negative_timeout
# @param nss_fallback_homedir
# @param nss_filter_users
# @param nss_filter_groups
# @param nss_filter_users_in_groups
# @param nss_get_domains_timeout
# @param nss_memcache_timeout
# @param nss_override_homedir
# @param nss_override_shell
# @param nss_reconnection_retries
# @param nss_user_attributes
# @param nss_vetoed_shells
#
# @param pac_description
# @param pac_allowed_uids
# @param pac_debug_level
# @param pac_debug_timestamps
# @param pac_debug_microseconds
#
# @param pam_description
# @param pam_command
# @param pam_debug_level
# @param pam_debug_timestamps
# @param pam_debug_microseconds
# @param pam_get_domains_timeout
# @param pam_offline_credentials_expiration
# @param pam_offline_failed_login_attempts
# @param pam_offline_failed_login_delay
# @param pam_id_timeout
# @param pam_public_domains
# @param pam_pwd_expiration_warning
# @param pam_trusted_users
# @param pam_verbosity
# @param pam_reconnection_retries
#
# @param ssh_description
# @param ssh_debug_level
# @param ssh_debug_timestamps
# @param ssh_debug_microseconds
# @param ssh_hash_known_hosts
# @param ssh_known_hosts_timeout
#
# @param sudo_description
# @param sudo_debug_level
# @param sudo_debug_timestamps
# @param sudo_debug_microseconds
# @param sudo_timed
#
# @author Trevor Vaughan <mailto:tvaughan@onyxpoint.com>
# @author Clayton Mentzer <mailto:clayton.mentzer@onyxpoint.com>
#
class sssd (

  ## These variables control the initial installation and configuration
  ## of the sssd package and its dependencies.
  Optional[String]               $client_package_name,
  Optional[String]               $client_package_version,
  Stdlib::Absolutepath           $conf_file_path,
  Optional[String]               $conf_dir_owner,
  Stdlib::Absolutepath           $conf_dir_path,
  Boolean                        $install_user_tools,
  Optional[String]               $nscd_service_name,
  Optional[String]               $package_name,
  Optional[String]               $package_version,
  Stdlib::Absolutepath           $sssd_service_path,
  Optional[String]               $sssd_service_name,
  Optional[String]               $tools_package_name,
  Optional[String]               $tools_package_version,

  ## These parameters control integration of the sssd module with other SIMP
  ## modules / services.
  Stdlib::Absolutepath           $app_pki_dir,
  Boolean                        $auditd               = simplib::lookup('simp_options::auditd', { 'default_value' => false}),
  Variant[Boolean,Enum['simp']]  $pki                  = simplib::lookup('simp_options::pki', { 'default_value' => false}),
  Stdlib::Absolutepath           $app_pki_cert_source  = simplib::lookup('simp_options::pki::source', { 'default_value' => '/etc/pki/simp/x509'}),

  ## Parameters for the [sssd] section of the config file:
  Optional[String]               $sssd_description,
  Array[String]                  $sssd_domains,
  Sssd::Services                 $sssd_services,
  Integer                        $sssd_config_file_version,
  Optional[Sssd::DebugLevel]     $sssd_debug_level,
  Boolean                        $sssd_debug_timestamps,
  Boolean                        $sssd_debug_microseconds,
  Optional[String]               $sssd_default_domain_suffix,
  Optional[String]               $sssd_full_name_format,
  Optional[String]               $sssd_krb5_rcache_dir,
  Optional[String]               $sssd_override_space,
  Integer                        $sssd_reconnection_retries,
  Optional[String]               $sssd_re_expression,
  Boolean                        $sssd_try_inotify,
  Optional[String]               $sssd_user,

  ## Parameters for the [autofs] section of the config file:
  Optional[String]               $autofs_description,
  Optional[Sssd::DebugLevel]     $autofs_debug_level,
  Boolean                        $autofs_debug_timestamps,
  Boolean                        $autofs_debug_microseconds,
  Optional[Integer]              $autofs_negative_timeout,

  ## Parameters for the [nss] section of the config file:
  Optional[String]               $nss_description,
  Optional[String]               $nss_command,
  Optional[Sssd::DebugLevel]     $nss_debug_level,
  Boolean                        $nss_debug_timestamps,
  Boolean                        $nss_debug_microseconds,
  Optional[String]               $nss_default_shell,
  Integer                        $nss_enum_cache_timeout,
  Integer                        $nss_entry_cache_nowait_percentage,
  Integer                        $nss_entry_negative_timeout,
  Optional[String]               $nss_fallback_homedir,
  String                         $nss_filter_users,
  String                         $nss_filter_groups,
  Boolean                        $nss_filter_users_in_groups,
  Optional[Integer]              $nss_get_domains_timeout,
  Optional[Integer]              $nss_memcache_timeout,
  Optional[String]               $nss_override_homedir,
  Optional[String]               $nss_override_shell,
  Integer                        $nss_reconnection_retries,
  Optional[String]               $nss_user_attributes,
  Optional[String]               $nss_vetoed_shells,

  ## Parameters for the [pac] section of the config file:
  Optional[String]               $pac_description,
  Array[String]                  $pac_allowed_uids,
  Optional[Sssd::DebugLevel]     $pac_debug_level,
  Boolean                        $pac_debug_timestamps,
  Boolean                        $pac_debug_microseconds,

  ## Parameters for the [pam] section of the config file:
  Optional[String]               $pam_description,
  Optional[String]               $pam_command,
  Optional[Sssd::DebugLevel]     $pam_debug_level,
  Boolean                        $pam_debug_timestamps,
  Boolean                        $pam_debug_microseconds,
  Optional[Integer]              $pam_get_domains_timeout,
  Integer                        $pam_offline_credentials_expiration,
  Integer                        $pam_offline_failed_login_attempts,
  Integer                        $pam_offline_failed_login_delay,
  Integer                        $pam_id_timeout,
  Optional[String]               $pam_public_domains,
  Integer                        $pam_pwd_expiration_warning,
  Optional[String]               $pam_trusted_users,
  Integer                        $pam_verbosity,
  Integer                        $pam_reconnection_retries,

  ## Parameters for the [ssh] section of the config file:
  Optional[String]               $ssh_description,
  Optional[Sssd::DebugLevel]     $ssh_debug_level,
  Boolean                        $ssh_debug_timestamps,
  Boolean                        $ssh_debug_microseconds,
  Boolean                        $ssh_hash_known_hosts,
  Optional[Integer]              $ssh_known_hosts_timeout,

  ## Parameters for the [sudo] section of the config file:
  Optional[String]               $sudo_description,
  Optional[Sssd::DebugLevel]     $sudo_debug_level,
  Boolean                        $sudo_debug_timestamps,
  Boolean                        $sudo_debug_microseconds,
  Boolean                        $sudo_timed,
) {

  include '::sssd::install'
  include '::sssd::service'

  if $auditd {
    include '::auditd'

    auditd::rule { 'sssd':
      content => "-w ${sssd::conf_dir_path}/ -p wa -k CFG_sssd"
    }
  }

  concat { $sssd::conf_file_path:
    owner          => 'root',
    group          => 'root',
    mode           => '0640',
    ensure_newline => true,
    warn           => true,
    notify         => Class['sssd::service']
  }

  concat::fragment { 'sssd_main_config':
    target  => $conf_file_path,
    content => template("${module_name}/sssd.conf.erb")
  }

  if $pki {
    include '::sssd::pki'

    Class['sssd::install'] -> Class['sssd::pki']
    Class['sssd::pki'] ~> Class['sssd::service']
  }

  Class['sssd::install'] ~> Class['sssd::service']
}
