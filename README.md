# Network License Manager for MATLAB on Microsoft Azure (Windows VM)

# Requirements

Before starting, you will require:

- An Azure™ account.

- A valid MathWorks license. For more information on how to configure your license for cloud use, see [MATLAB Parallel Server on the Cloud](https://www.mathworks.com/help/licensingoncloud/matlab-parallel-server-on-the-cloud.html).

- To be an administrator of the network license that you want to use.

# Costs
You are responsible for the cost of the Azure services used when you create cloud resources using this guide. Resource settings, such as instance type, will affect the cost of deployment. For cost estimates, see the pricing pages for each Azure service you will be using. Prices are subject to change.

# Introduction
The following guide will help you automate the process of launching a Network License Manager for MATLAB, running on a Windows virtual machine, using your Azure account. The cloud resources are created using Azure Resource Manager (ARM) templates. For information about the architecture of this solution, see [Learn About Network License Manager for MATLAB Architecture](#learn-about-network-license-manager-for-matlab-architecture).

# Deployment Steps

To view instructions for deploying the Network License Manager for MATLAB reference architecture, select a MATLAB release:

| Release |
| ------- |
| [R2021a](releases/R2021a/README.md) |
| [R2020b](releases/R2020b/README.md) |
| [R2020a](releases/R2020a/README.md) |
| [R2019b](releases/R2019b/README.md) |
| [R2019a\_and\_older](releases/R2019a_and_older/README.md) |


## Learn About Network License Manager for MATLAB Architecture

The network license manager and the resources required by it are created using [Azure Resource Manager templates](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/resource-group-overview). The architecture of the server resources created by the template is illustrated in Figure 2. For more information about each resource, see the [Azure template reference.](https://docs.microsoft.com/en-us/azure/templates/)

![Server Architecture](img/FlexServer_in_Azure_architecture.png?raw=true)

*Figure 2: Network License Manager Architecture*

The following resources are created.

### Networking resources
* Virtual Network (Microsoft.Network/virtualNetworks) The Virtual Network includes the following components:
    * Subnet (Microsoft.Network/virtualNetworks/subnets)
    * Network Security Group (Microsoft.Network/networkSecurityGroups) : Ingress rules from client IP address:
        * Allow 3389: Required for Remote Desktop Protocol to the cluster nodes.
        * Allow 443: Required for communication between client and network license manager for MATLAB Dashboard server.
        * Allow 27000-27001: Required for communication from MATLAB and MATLAB workers to the network license manager for MATLAB.
        * Allow all internal traffic: Open access to network traffic between all cluster nodes internally.
* Network interface (Microsoft.Network/networkInterfaces)
* Public IP Address (Microsoft.Network/publicIPAddresses)

### Instances
* Network license manager instance (Microsoft.Compute/virtualMachines): A Compute instance for the license server.
  * Custom Script Extension (Microsoft.Compute/virtualMachines/extensions): An extension which configures this instance at deployment time to start the network license manager for MATLAB Dashboard web server.

# Technical Support
If you require assistance or have a request for additional features or capabilities, please contact [MathWorks Technical Support](https://www.mathworks.com/support/contact_us.html).