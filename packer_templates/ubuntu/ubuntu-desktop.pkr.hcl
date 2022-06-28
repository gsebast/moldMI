#
# For usage see README.md
#

locals {
  desktop             = true
  cleanup_pause       = ""
  install_vagrant_key = true
  update              = true
}

source "virtualbox-iso" "desktop" {
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

build {
  sources = [
    "source.virtualbox-iso.desktop"
  ]

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/vagrant",
      "CLEANUP_PAUSE=${local.cleanup_pause}",
      "DESKTOP=${local.desktop}",
      "UPDATE=${local.update}",
      "INSTALL_VAGRANT_KEY=${local.install_vagrant_key}",
      "SSH_USERNAME=${var.ssh_username}",
      "SSH_PASSWORD=${var.ssh_password}",
      "ftp_proxy=${var.ftp_proxy}",
      "http_proxy=${var.http_proxy}",
      "https_proxy=${var.https_proxy}",
      "rsync_proxy=${var.rsync_proxy}",
      "no_proxy=${var.no_proxy}"
    ]
    execute_command = "echo '${var.ssh_username}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "${path.root}/${var.local_common_desktop_scripts_path}/update.sh",
      "${path.root}/${var.local_common_desktop_scripts_path}/desktop.sh",
      "${path.root}/${var.local_custom_desktop_scripts_path}/timezone.sh"
    ]
    expect_disconnect = true
  }

  provisioner "file" {
    source      = "${path.root}/${var.local_custom_desktop_scripts_path}/input_source.sh"
    destination = "/tmp/input_source.sh"
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_username}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    inline          = ["mv /tmp/input_source.sh /sbin/input_source.sh && chmod 755 /sbin/input_source.sh"]
  }

  provisioner "file" {
    source      = "${path.root}/${var.local_custom_desktop_scripts_path}/input_source.desktop"
    destination = "/tmp/input_source.desktop"
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_username}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    inline          = ["mv /tmp/input_source.desktop /etc/xdg/autostart/input_source.desktop"]
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/vagrant",
      "CLEANUP_PAUSE=${local.cleanup_pause}",
      "DEBIAN_FRONTEND=noninteractive",
      "DESKTOP=${local.desktop}",
      "UPDATE=${local.update}",
      "INSTALL_VAGRANT_KEY=${local.install_vagrant_key}",
      "SSH_USERNAME=${var.ssh_username}",
      "SSH_PASSWORD=${var.ssh_password}",
      "ftp_proxy=${var.ftp_proxy}",
      "http_proxy=${var.http_proxy}",
      "https_proxy=${var.https_proxy}",
      "rsync_proxy=${var.rsync_proxy}",
      "no_proxy=${var.no_proxy}"
    ]
    execute_command = "echo '${var.ssh_username}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "${path.root}/${var.local_common_desktop_scripts_path}/vagrant.sh",
      "${path.root}/${var.local_common_desktop_scripts_path}/sshd.sh",
      "${path.root}/${var.local_common_desktop_scripts_path}/vmware.sh",
      "${path.root}/${var.local_common_desktop_scripts_path}/virtualbox.sh",
      "${path.root}/${var.local_common_desktop_scripts_path}/parallels.sh",
      "${path.root}/${var.global_custom_scripts_path}/motd.sh",
      "${path.root}/${var.local_common_desktop_scripts_path}/minimize.sh",
      "${path.root}/${var.local_common_desktop_scripts_path}/cleanup.sh"
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
      "FILE_PATTERN=${var.image_name}*",
    ]
    scripts = [
      "${path.root}/${var.helpers_scripts_path}/sh/copy_disk_files.sh",
      "${path.root}/${var.helpers_scripts_path}/sh/cleanup_input_artifact.sh"
    ]
  }
}
