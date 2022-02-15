data "cloudinit_config" "app-script" {
    gzip          = false
    base64_encode = false

    part {
        content_type = "text/x-shellscript"
        content = templatefile("${path.module}/scripts/app.sh",{
            app_host = aws_eip.app-eip.public_ip
            region = var.region
            database_name = var.database_name
            database_user = var.database_user
            database_pass = var.database_pass
            database_host = aws_network_interface.database2app-nic.private_ip
            admin_user = var.admin_user
            admin_pass = var.admin_pass
            bucket_name = aws_s3_bucket.nextcloud-s3.bucket
            iam_key = aws_iam_access_key.nextcloud-ak.id
            iam_secret = aws_iam_access_key.nextcloud-ak.secret
        })
    }
}

data "cloudinit_config" "database-script" {
    gzip          = false
    base64_encode = false

    part {
        content_type = "text/x-shellscript"
        content = templatefile("${path.module}/scripts/database.sh",{
            database_name = var.database_name
            database_user = var.database_user
            database_pass = var.database_pass
        })
    }
}