resource "aws_iam_role" "codedeploy" {
  name = "aws-codedeploy"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy.name
}

resource "aws_codedeploy_app" "abc-service" {
  name = "abc-service"
}


resource "aws_codedeploy_deployment_group" "abc-service" {
  app_name              = aws_codedeploy_app.abc-service.name
  deployment_group_name = "${var.env}"
  service_role_arn      = aws_iam_role.codedeploy.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Iscodedeploy"
      type  = "KEY_AND_VALUE"
      value = "true"
    }

    ec2_tag_filter {
      key   = "enviornment"
      type  = "KEY_AND_VALUE"
      value = "${var.env}"
    }
  }


  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

}
