# Class: ombi
# ===========================
#
# For version 19.1 stable of ombi.
#
# Does not use ombi-styled relative paths (${MainDir}). Relative paths may be
#   used, and are relative to $service_dir. Absolute paths preferred.
#
# Uses default ombi configuration values for ubuntu. Parameters correspond to
#   ombi conf file settings:
#   https://github.com/ombi/ombi/blob/c0eedc342b422ea2797bc85a3fb19c0a2c60e716/ombi.conf
#

class ombi (
  # Puppet settings
  Boolean                   $manage_ppa           = true,
  Boolean                   $manage_user          = true,
  Tuple[Boolean, String]    $manage_service_dirs  = [true, '/home'],
  Tuple[Boolean, String]    $manage_data_dirs     = [true, '/home/ombi'],
  Boolean                   $manage_certs         = true,
  Boolean                   $manage_pass_file     = true,
  String                    $user                 = 'ombi',
  String                    $group                = 'ombi',
  String                    $service_dir          = '/home/ombi',
  String                    $config_file          = '/etc/ombi.conf',
  Boolean                   $service_enable       = true,
  Boolean                   $service_ensure       = true,

  # Paths Section
  String                    $main_dir             = "${service_dir}/downloads",
  String                    $destination_dir      = "${service_dir}/dst",
  Optional[String]          $intermediate_dir     = "${service_dir}/inter",
  String                    $nzb_dir              = "${service_dir}/nzb",
  String                    $queue_dir            = "${service_dir}/queue",
  String                    $temp_dir             = "${service_dir}/tmp",
  Optional[String]          $web_dir              = '/usr/share/ombi/webui',
  Array[String]             $script_dir           = ["${service_dir}/scripts"],
  Optional[String]          $lock_file            = "${service_dir}/ombi.lock",
  String                    $log_file             = "${service_dir}/dst/ombi.log",
  String                    $config_template      = '/usr/share/ombi/ombi.conf',
  Optional[Array[String]]   $required_dir         = undef,
  Optional[String]          $cert_store           = undef,
  Array[String]             $packages             = ['unrar', 'par2', 'parchive'],
  Optional[String]          $user_resource_group  = undef,
  Array[String]             $managed_service_dirs = flatten([$service_dir, $main_dir, $script_dir]),
  Array[String]             $managed_data_dirs    = [$intermediate_dir, $destination_dir, $nzb_dir, $queue_dir, $temp_dir],
) {
  include ::ombi::install
  include ::ombi::config
  include ::ombi::service
}
