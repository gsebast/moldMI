
variable "build_artifacts_output_path" {
  type    = string
  default = "../../builds/artifacts"
}

variable "certificates_path" {
  type    = string
  default = "../_certs"
}

variable "extras_scripts_path" {
  type    = string
  default = "../_scripts/extras"
}

variable "global_common_scripts_path" {
  type    = string
  default = "../_scripts/defaults"
}

variable "global_custom_scripts_path" {
  type    = string
  default = "../_scripts/custom"
}

variable "helpers_scripts_path" {
  type    = string
  default = "../_scripts/helpers"
}

variable "http_directory" {
  type    = string
  default = "../_http/ubuntu"
}

variable "local_common_desktop_scripts_path" {
  type    = string
  default = "scripts/common/desktop"
}

variable "local_custom_desktop_scripts_path" {
  type    = string
  default = "scripts/custom/desktop"
}

variable "local_custom_server_scripts_path" {
  type    = string
  default = "scripts/custom/server"
}

variable "local_common_server_scripts_path" {
  type    = string
  default = "scripts/common/server"
}
