
variable "cpus" {
  type    = number
  default = 2
}

variable "disk_size" {
  type    = number
  default = 24576
}

variable "memory" {
  type    = number
  default = 2048
}

variable "tmp_files_path" {
  type    = string
  default = "/tmp"
}
