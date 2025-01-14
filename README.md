EKS Cluster Deployment with Terraform:
======================================

This repository contains the Terraform configuration files to deploy an Amazon Elastic Kubernetes Service (EKS) cluster on AWS. The configuration includes the creation of VPC, subnets, route tables, security groups, EKS cluster, node groups, NAT gateways, and Internet Gateway. This setup ensures a robust, scalable infrastructure for running Kubernetes workloads.

Project Structure:
------------------
The project is organized into multiple Terraform files, each serving a specific purpose:

provider.tf: Defines the AWS provider and authentication settings for Terraform to interact with AWS.

vpc.tf: Defines the Virtual Private Cloud (VPC) configuration, including CIDR block and other essential settings.

subnet.tf: Creates public and private subnets within the VPC for EKS and other resources.

routes.tf: Defines route tables and routes to handle traffic for public and private subnets.

securitygroup.tf: Configures security groups for the EKS cluster, nodes, and other resources, ensuring proper access control.

ekscluster.tf: Defines the main EKS cluster, including the Kubernetes control plane.

nodegroup.tf: Defines the worker node groups, which are EC2 instances that run the Kubernetes workloads.

nat.tf: Creates a NAT Gateway for routing traffic from private subnets to the internet securely.

igw.tf: Defines the Internet Gateway (IGW) for routing traffic from public subnets to the internet.

Prerequisites:
--------------
To deploy the EKS cluster using this configuration, ensure the following prerequisites are met:

Terraform: Terraform 1.0 or later is required to apply the infrastructure.

AWS CLI: The AWS Command Line Interface (CLI) should be configured with the necessary credentials for AWS.

IAM Permissions: Ensure that the AWS IAM user has sufficient permissions to create EKS clusters, VPCs, subnets, security groups, EC2 instances, and other required resources.

Setup and Usage:
----------------

1. Clone the Repository
First, clone this repository to your local machine:

git clone https://github.com/Saikumar099/Terraform_EKS_Cluster.git

cd Terraform_EKS_Cluster

2. Configure AWS Credentials
Make sure your AWS credentials are set up. You can configure them using the AWS CLI:

                 aws configure

Alternatively, set the environment variables directly:

export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export AWS_DEFAULT_REGION="us-east-1"

3. Initialize Terraform
Run the following command to initialize the Terraform configuration:

                 terraform init

This will download the necessary provider plugins and initialize the working directory.

4. Plan the Infrastructure
To review the changes that Terraform will apply, run the terraform plan command:

                 terraform plan

This will show you a preview of the infrastructure that will be created, including the VPC, subnets, route tables, EKS cluster, node groups, and other resources.

5. Apply the Configuration
To apply the changes and create the resources in AWS, run the terraform apply command:

                 terraform apply

Terraform will prompt for confirmation to apply the changes. Type yes to proceed.

6. Access the EKS Cluster
After the EKS cluster is created, you can update your kubeconfig file to connect to the cluster:

               aws eks --region us-east-1 update-kubeconfig --name EKS_cluster_first

7. Verify the Cluster
You can verify that the EKS cluster is up and running by checking the Kubernetes nodes:

               kubectl get nodes

This will list the EC2 instances that are part of your EKS cluster.

Files Overview:
---------------

provider.tf
This file contains the AWS provider configuration, specifying the region and any necessary authentication details.

vpc.tf
Defines the VPC for the EKS cluster, with a CIDR block and other essential settings for networking.

subnet.tf
Creates both public and private subnets within the VPC for hosting EKS nodes and other resources.

routes.tf
Configures route tables and routes for the VPC, directing traffic between subnets and to the internet via the Internet Gateway or NAT Gateway.

securitygroup.tf
Creates security groups that define the rules for access to the EKS cluster, worker nodes, and other resources.

ekscluster.tf
Defines the EKS cluster itself, including settings for the control plane and integration with AWS services.

nodegroup.tf
Specifies the configuration for the worker node groups, which are EC2 instances that will run the Kubernetes pods and workloads.

nat.tf
Defines the NAT Gateway, which allows private subnets to access the internet securely.

igw.tf
Creates an Internet Gateway for enabling internet access for the public subnets.

Clean Up:
---------
To destroy the infrastructure and clean up all the resources created by Terraform, use the following command:

               terraform destroy
This will prompt you to confirm before destroying all the resources.

Additional Notes:
-----------------
Ensure that your IAM user or role has sufficient permissions to perform all the operations that Terraform will execute.
If using an existing VPC, update the Terraform files accordingly to reference the existing VPC, subnets, and other resources.
