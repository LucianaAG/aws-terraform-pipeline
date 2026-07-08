# user definition

resource "aws_iam_user" "env_user" {
  name = "${var.env}-user"
}

# group definition

resource "aws_iam_group" "env_group" {
  name = "${var.env}-group"
}

# policy definition

resource "aws_iam_policy" "env_policy" {
  name = "${var.env}-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:*", "vpc:*"]
        Resource = "*"
      }
    ]
  })
}

# assign group to user

resource "aws_iam_user_group_membership" "env_membership" {
  user = aws_iam_user.env_user.name
  groups = [aws_iam_group.env_group.name]
}

# attach policy to group

resource "aws_iam_group_policy_attachment" "env_attachment" {
  group = aws_iam_group.env_group.name
  policy_arn = aws_iam_policy.env_policy.arn
}

