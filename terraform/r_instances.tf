# Instance: Apps
resource "aws_instance" "app" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.terraform.key_name}"
  security_groups = ["${aws_security_group.allow_basics.name}"]

  tags = {
    Name = "App"
  }

  connection {
    type        = "ssh"
    agent       = false
    private_key = "${file("./keys/id_rsa")}"
    user        = "ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      # Update package list
      "sudo apt-get update",
      "sudo apt-get autoremove -y",
      # Install basics tools
      "sudo apt-get install -y make wget curl htop python python3",
    ]
  }

}

# Instance: LocalBalancer
resource "aws_instance" "loadbalancer" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.terraform.key_name}"
  security_groups = ["${aws_security_group.allow_basics.name}"]

  tags = {
    Name = "LocalBalancer"
  }

  connection {
    type        = "ssh"
    agent       = false
    private_key = "${file("./keys/id_rsa")}"
    user        = "ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      # Update package list
      "sudo apt-get update",
      "sudo apt-get autoremove -y",
      # Install basics tools
      "sudo apt-get install -y make wget curl htop python python3",
    ]
  }

}

# Ubuntu 18.04 distro
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
