
image_name = "ubuntu-22.04-amd64"

iso_name         = "ubuntu-22.04-live-server-amd64.iso"
iso_checksum     = "sha256:84aeaf7823c8c61baa0ae862d0a06b03409394800000b3235854a6b38eb4856f"
mirror           = "https://releases.ubuntu.com"
mirror_directory = "22.04"

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
  "c",
  "<wait>",
  "set gfxpayload=keep",
  "<enter><wait>",
  "linux /casper/vmlinuz quiet<wait>",
  " autoinstall<wait>",
  " ds=nocloud-net<wait>",
  "\\;s=http://<wait>",
  "{{.HTTPIP}}<wait>",
  ":{{.HTTPPort}}/<wait>",
  " ---",
  "<enter><wait>",
  "initrd /casper/initrd<wait>",
  "<enter><wait>",
  "boot<enter><wait>"
]

http_proxy  = ""
https_proxy = ""
ftp_proxy   = ""
rsync_proxy = ""
no_proxy    = ""
