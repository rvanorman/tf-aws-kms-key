provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_kms_key" "vault" {
  description = "Vault unseal key"
  #deletion_window_in_days = 10

  tags = {
    Name = "${var.engineer}-vault-kms-unseal"
  }
}

# Add an alias to the key
resource "aws_kms_alias" "alias" {
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.vault.key_id
}
