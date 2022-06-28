
variable "boot_command" {
  type = list(string)
  default = [
    " <wait>",
    " <wait>",
    " <wait>",
    " <wait>",
    " <wait>",
    "<esc><wait>",
    "<f6><wait>",
    "<esc><wait>",
    "<bs><bs><bs><bs><wait>",
    " autoinstall<wait5>",
    " ds=nocloud-net<wait5>",
    ";s=http://<wait5>{{.HTTPIP}}<wait5>:{{.HTTPPort}}/<wait5>",
    " ---<wait5>",
    "<enter><wait5>"
  ]
}

variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "ftp_proxy" {
  type    = string
  default = "${env("ftp_proxy")}"
}

variable "git_revision" {
  type    = string
  default = "__unknown_git_revision__"
}

variable "hard_drive_interface" {
  type    = string
  default = "sata"
}

variable "headless" {
  type    = bool
  default = true
}

variable "http_proxy" {
  type    = string
  default = "${env("http_proxy")}"
}

variable "https_proxy" {
  type    = string
  default = "${env("https_proxy")}"
}

variable "image_name" {
  type    = string
  default = "ubuntu-20.04-amd64"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
}

variable "iso_name" {
  type    = string
  default = "ubuntu-20.04.3-live-server-amd64.iso"
}

variable "locale" {
  type    = string
  default = "en_US.UTF-8"
}

variable "mirror" {
  type    = string
  default = "https://releases.ubuntu.com"
}

variable "mirror_directory" {
  type    = string
  default = "20.04"
}

variable "no_proxy" {
  type    = string
  default = "${env("no_proxy")}"
}

# TODO - check if required
#variable "ovf_file" {
#  type    = string
#  default = "ubuntu-20.04-amd64_server"
#}

# possible values: "ovf", "ova"
variable "ovf_format" {
  type    = string
  default = "ovf"
}

variable "rsync_proxy" {
  type    = string
  default = "${env("rsync_proxy")}"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "ssh_timeout" {
  type    = string
  default = "3600s"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}
