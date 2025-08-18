# Azure Infrastructure Automation with Terraform

A comprehensive Terraform project for automating Azure infrastructure deployment. This project demonstrates infrastructure-as-code best practices with modular architecture for Azure resource management.

## 🏗️ Project Overview

This project automates the deployment of a complete Azure infrastructure including virtual machines, networking, storage, monitoring, and database services. It's built with a modular approach using Terraform modules for maintainability and reusability.

## ☁️ Architecture Diagram
<img width="767" height="396" alt="Image" src="https://github.com/user-attachments/assets/28e1e99b-0703-491b-ba18-98b332035179" />

## ✨ Features

- **Modular Architecture**: Well-structured Terraform modules for each resource type
- **Multi-Platform Support**: Both Linux (CentOS) and Windows Server deployments
- **High Availability**: Availability sets for VM redundancy
- **Network Security**: Network Security Groups with configurable port rules
- **Monitoring & Logging**: Log Analytics workspace and monitoring extensions
- **Backup & Recovery**: Recovery Services Vault for disaster recovery
- **Load Balancing**: Azure Load Balancer for traffic distribution
- **Database**: PostgreSQL database server with backup retention
- **Data Disks**: Configurable data disk attachments for VMs

## 🏛️ Architecture

The project creates the following Azure resources:

- **Resource Group**: Centralized resource management
- **Virtual Network**: Custom VNet with subnet and NSG
- **Virtual Machines**: 
  - 3 Linux VMs (CentOS 8.2) with monitoring extensions
  - 1 Windows VM (Windows Server 2016) with antimalware
- **Storage**: Standard storage account for diagnostics
- **Monitoring**: Log Analytics workspace and monitoring agents
- **Backup**: Recovery Services Vault
- **Load Balancer**: Standard SKU load balancer for Linux VMs
- **Database**: PostgreSQL server with backup retention
- **Data Disks**: 4 managed data disks attached to VMs

## 🚀 Prerequisites

- **Terraform**: Version 1.0 or later
- **Azure CLI**: Authenticated with appropriate permissions
- **Azure Subscription**: Active subscription with resource creation permissions
- **SSH Keys**: For Linux VM access (default: `~/.ssh/id_rsa.pub`)

## 📦 Dependencies

- **Azure Provider**: `hashicorp/azurerm ~> 4.35`
- **Azure Backend**: Remote state storage in Azure Storage

## ⚙️ Configuration

### Environment Variables

The project uses the following configuration:

- **Location**: `canadacentral`
- **Resource Group**: `8543-RG`
- **Virtual Network**: `10.0.0.0/16`
- **Subnet**: `10.0.1.0/24`
- **VM Sizes**: `Standard_B1ms` (Basic tier for cost optimization)

## 📋 Usage

### Deploy Infrastructure

```bash
# Navigate to the Terraform directory
cd terraform-azure

# Initialize and deploy
terraform init
terraform plan
terraform apply
```

### Access Virtual Machines

After deployment, you can access the VMs using the outputs:

```bash
# Get VM information
terraform output

# SSH to Linux VMs (replace with actual public IP)
ssh azureuser@<linux_vm_public_ip>

# RDP to Windows VM (replace with actual public IP)
# Use Remote Desktop Connection with the Windows VM public IP
```

### Destroy Infrastructure

```bash
# Remove all created resources
terraform destroy
```

## 🔧 Module Details

### Resource Group Module (`rgroup-8543`)
- Creates the main resource group for all resources
- Configurable location and tags

### Network Module (`network-8543`)
- Virtual Network with customizable address space
- Subnet with configurable address prefix
- Network Security Group with allowed ports (22, 3389, 5985, 80)

### Common Module (`common-8543`)
- Log Analytics workspace for monitoring
- Recovery Services Vault for backup
- Storage account for diagnostics

### Linux VMs Module (`vmlinux-8543`)
- Deploys 3 CentOS 8.2 VMs
- Network Watcher and monitoring extensions
- Availability set for high availability

### Windows VM Module (`vmwindows-8543`)
- Deploys 1 Windows Server 2016 VM
- Antimalware extension
- Availability set for high availability

### Database Module (`database-8543`)
- PostgreSQL 13 server
- Configurable backup retention (7 days)
- Standard B1ms tier for cost optimization

### Load Balancer Module (`loadbalancer-8543`)
- Standard SKU load balancer
- Backend pool with Linux VMs
- Public frontend IP configuration

### Data Disk Module (`datadisk-8543`)
- 4 managed data disks
- Attached to all VMs (Linux and Windows)

## 📊 Outputs

The project provides comprehensive outputs including:
- Resource group and network information
- VM hostnames, domain names, and IP addresses
- Load balancer and database server names
- Storage and monitoring resource names

## 🔒 Security Features

- Network Security Groups with restricted port access
- SSH key-based authentication for Linux VMs
- Windows VM with antimalware protection
- Private IP addressing for internal communication
