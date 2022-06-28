
image_name = "ubuntu-20.04-amd64"

iso_name         = "ubuntu-20.04.4-live-server-amd64.iso"
iso_checksum     = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
mirror           = "https://releases.ubuntu.com"
mirror_directory = "20.04"

cpus      = 2
disk_size = 65536
memory    = 2048

headless = true

boot_command = [
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

http_proxy  = ""
https_proxy = ""
ftp_proxy   = ""
rsync_proxy = ""
no_proxy    = ""
