resource "aws_efs_file_system" "efs" {
  creation_token = "${var.service_name}-efs"

  count = var.create_efs ? 1 : 0
}

resource "aws_efs_mount_target" "mount_target" {
  count = var.create_efs ? length(data.aws_subnets.selected.ids) : 0

  file_system_id  = aws_efs_file_system.efs[0].id
  subnet_id       = data.aws_subnets.selected.ids[count.index]
  security_groups = [aws_security_group.security_group.id]
}

data "aws_iam_policy_document" "efs_policy" {
  count = var.create_efs ? 1 : 0

  statement {
    sid    = "Statement01"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
    ]

    resources = [aws_efs_file_system.efs[count.index].arn]
  }
}

resource "aws_efs_file_system_policy" "policy" {
  count = var.create_efs ? 1 : 0

  file_system_id = aws_efs_file_system.efs[count.index].id
  policy         = data.aws_iam_policy_document.efs_policy[count.index].json
}

resource "aws_efs_access_point" "docker_ap" {
  count = var.create_efs ? 1 : 0
  file_system_id = aws_efs_file_system.efs[0].id

  posix_user {
    uid = 0
    gid = 0
  }

  root_directory {
    path = "/root"

    creation_info {
      owner_uid   = 0
      owner_gid   = 0
      permissions = "777"
    }
  }
}
