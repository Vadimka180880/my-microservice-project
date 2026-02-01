resource "aws_eks_addon" "ebs_csi" {
  count        = var.enable_ebs_csi_addon ? 1 : 0
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "aws-ebs-csi-driver"

  depends_on = [aws_eks_cluster.this]
}
