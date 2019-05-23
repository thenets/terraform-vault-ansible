# SSH key used to access EC2 machines
resource "aws_key_pair" "terraform" {
  key_name   = "terraform"
  public_key = "${file("./keys/id_rsa.pub")}"
}
