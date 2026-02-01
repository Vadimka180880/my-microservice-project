resource "aws_eks_addon" "ebs_csi" {
  count        = var.enable_ebs_csi_addon ? 1 : 0
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "aws-ebs-csi-driver"

  service_account_role_arn = var.ebs_csi_role_arn != "" ? var.ebs_csi_role_arn : null

  depends_on = [aws_eks_cluster.this]
}
