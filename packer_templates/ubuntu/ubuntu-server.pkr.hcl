#
# For usage see README.md
#

source "virtualbox-iso" "server" {
  vm_name = "${var.image_name}_${source.name}"

  guest_os_type           = "Ubuntu_64"
  virtualbox_version_file = ".vbox_version"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"

  iso_url      = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  iso_checksum = "${var.iso_checksum}"

  cpus                 = "${var.cpus}"
  disk_size            = "${var.disk_size}"
  hard_drive_interface = "${var.hard_drive_interface}"
  memory               = "${var.memory}"

  http_directory = "${path.root}/${var.http_directory}"

  ssh_password = "${var.ssh_password}"
  ssh_port     = "${var.ssh_port}"
  ssh_timeout  = "${var.ssh_timeout}"
  ssh_username = "${var.ssh_username}"

  headless = "${var.headless}"

  boot_wait    = "${var.boot_wait}"
  boot_command = "${var.boot_command}"

  shutdown_command = "echo '${var.ssh_username}' | sudo -S shutdown -P now"

  format = "${var.ovf_format}"

  output_directory = "${path.root}/${source.type}_${var.image_name}_${source.name}"
}

source "parallels-iso" "server" {
  vm_name = "${var.image_name}_${source.name}"

  guest_os_type          = "ubuntu"
  prlctl_version_file    = ".prlctl_version"
  parallels_tools_flavor = "lin"

  iso_url      = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  iso_checksum = "${var.iso_checksum}"

  cpus      = "${var.cpus}"
  disk_size = "${var.disk_size}"
  memory    = "${var.memory}"

  http_directory = "${path.root}/${var.http_directory}"

  ssh_password = "${var.ssh_password}"
  ssh_port     = "${var.ssh_port}"
  ssh_timeout  = "${var.ssh_timeout}"
  ssh_username = "${var.ssh_username}"

  boot_wait    = "${var.boot_wait}"
  boot_command = "${var.boot_command}"

  shutdown_command = "echo '${var.ssh_username}' | sudo -S shutdown -P now"

  output_directory = "${path.root}/${source.type}_${var.image_name}_${source.name}"
}

source "vmware-iso" "server" {
  vm_name = "${var.image_name}_${source.name}"

  guest_os_type       = "ubuntu-64"
  tools_upload_flavor = "linux"

  iso_url      = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  iso_checksum = "${var.iso_checksum}"

  cpus      = "${var.cpus}"
  disk_size = "${var.disk_size}"
  memory    = "${var.memory}"
  vmx_data = {
    "cpuid.coresPerSocket"    = "1"
    "ethernet0.pciSlotNumber" = "32"
  }
  vmx_remove_ethernet_interfaces = true

  http_directory = "${path.root}/${var.http_directory}"

  ssh_password = "${var.ssh_password}"
  ssh_port     = "${var.ssh_port}"
  ssh_timeout  = "${var.ssh_timeout}"
  ssh_username = "${var.ssh_username}"

  headless = "${var.headless}"

  boot_wait    = "${var.boot_wait}"
  boot_command = "${var.boot_command}"

  shutdown_command = "echo '${var.ssh_username}' | sudo -S shutdown -P now"

  output_directory = "${path.root}/${source.type}_${var.image_name}_${source.name}"
}

build {
  sources = [
    "source.parallels-iso.server",
    "source.virtualbox-iso.server",
    "source.vmware-iso.server"
  ]

  provisioner "shell" {
    environment_vars = ["HOME_DIR=/home/vagrant"]
    execute_command  = "echo '${var.ssh_username}' | {{ .Vars }} sudo -E -S sh -eu '{{ .Path }}'"
    scripts = [
      "${path.root}/${var.local_common_server_scripts_path}/update.sh",
      "${path.root}/${var.global_custom_scripts_path}/motd.sh",
      "${path.root}/${var.global_common_scripts_path}/sshd.sh",
      "${path.root}/${var.local_common_server_scripts_path}/networking.sh",
      "${path.root}/${var.local_common_server_scripts_path}/sudoers.sh",
      "${path.root}/${var.local_common_server_scripts_path}/vagrant.sh",
      "${path.root}/${var.global_common_scripts_path}/virtualbox.sh",
      "${path.root}/${var.local_common_server_scripts_path}/vmware.sh",
      "${path.root}/${var.global_common_scripts_path}/parallels.sh",
      "${path.root}/${var.local_common_server_scripts_path}/hyperv.sh",
      "${path.root}/${var.local_common_server_scripts_path}/cleanup.sh",
      "${path.root}/${var.global_common_scripts_path}/minimize.sh"
    ]
    expect_disconnect = true
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    output              = "${path.root}/${var.build_artifacts_output_path}/${source.type}/${var.image_name}/${var.image_name}_${source.name}.box"
  }

  post-processor "shell-local" {
    environment_vars = [
      "SOURCE_DIR=${path.root}/${source.type}_${var.image_name}_${source.name}",
      "TARGET_DIR=${path.root}/${var.build_artifacts_output_path}/${source.type}/${var.image_name}",
      "FILE_PATTERN=${var.image_name}*"
    ]
    scripts = [
      "${path.root}/${var.helpers_scripts_path}/sh/copy_disk_files.sh",
      "${path.root}/${var.helpers_scripts_path}/sh/cleanup_input_artifact.sh"
    ]
  }
}
