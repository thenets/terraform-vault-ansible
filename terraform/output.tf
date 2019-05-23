output "app_public_ip" {
  value = ["${aws_instance.app.*.public_ip}"]
}

output "loadbalancer_public_ip" {
  value = ["${aws_instance.loadbalancer.*.public_ip}"]
}
