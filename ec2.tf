resource "aws_instance" "db" {
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = ["sg-0053ce598ea3ca93b"] 
    instance_type = "t3.micro"
# provisioners will run when you are creating resources
# they will not once the resources are created

provisioner "local-exec" {
    command = "echo ${self.private_ip} > private_ips.txt"
  }

#provisioner "local-exec" {
    #command = "ansible-playbook -i private.ip.txt web.yaml"
  #}

connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo dnf install ansible",
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]
  }
}