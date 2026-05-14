


resource "aws_launch_template" "app" {

  name_prefix = "${var.project_name}-lt"

  image_id = var.ami

  instance_type = var.instance_type
  
  key_name = var.key_name

  vpc_security_group_ids = [
    var.ec2_sg_id
  ]

  iam_instance_profile {
    name = var.instance_profile_name
  }

  user_data = base64encode(
    file("${path.module}/user_data.sh")
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-ec2"
    }
  }
}

resource "aws_autoscaling_group" "app" {

  name = "${var.project_name}-asg"

  desired_capacity = 0

  min_size = 0

  max_size = 0

  vpc_zone_identifier = var.public_subnet_ids

  target_group_arns = [
    var.target_group_arn
  ]

  launch_template {
    id = aws_launch_template.app.id

    version = "$Latest"
  }

  health_check_type = "EC2"

  tag {
    key = "Name"

    value = "${var.project_name}-asg-instance"

    propagate_at_launch = true
  }
}