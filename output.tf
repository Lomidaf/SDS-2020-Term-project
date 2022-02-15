output "nextcloud-ip" {
  value = "${aws_eip.app-eip.public_ip}/nextcloud"
}
