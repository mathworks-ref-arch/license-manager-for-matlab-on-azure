# Network License Manager for MATLAB on Microsoft Azure

# Requirements

Before starting, you will need the following:

- An Azure™ account.

- A valid MathWorks license. For more information, see [Configure MATLAB Distributed Computing Server Licensing on the Cloud](https://www.mathworks.com/support/cloud/configure-matlab-distributed-computing-server-licensing-on-the-cloud.html).

# Costs
You are responsible for the cost of the Azure services used when you create cloud resources using this guide. Resource settings, such as instance type, will affect the cost of deployment. For cost estimates, see the pricing pages for each Azure service you will be using. Prices are subject to change.

# Introduction
The following guide will help you automate the process of launching a Network License Manager for MATLAB on Azure using your Azure account. The cloud resources are created using Azure Resource Manager (ARM) templates. For information about the architecture of this solution, see [Learn About Network License Manager for MATLAB Architecture](#learn-about-network-license-manager-architecture).

# Deployment Steps

## Step 1. Launch the Template

Click the **Deploy to Azure** button below to deploy the cloud resources on Azure. This will open the Azure Portal in your web browser.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmathworks-ref-arch%2Flicense-manager-for-matlab-on-azure%2Fmaster%2Fazuredeploy-R2018b.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

> Server Platform: Windows Server 2016

> Network License Manager for MATLAB Release: R2018b

## Step 2. Configure the Cloud Resources
Clicking the Deploy to Azure button opens the "Custom deployment" page in your browser. You can configure the parameters on this page. It is easier to complete the steps if you position these instructions and the Azure Portal window side by side.

1. Specify and check the defaults for these resource parameters:

    | Parameter label                                    | Description 
    | -------------------------------------------------- | ----------- 
    | **Subscription** (required)                            | Choose an Azure subscription to use for purchasing resources.
    | **Resource group** (required)                          | Choose a name for the resource group that will hold the resources. It is recommended to create a new resource group for each deployment. This allows all resources to be deleted simultaneously.
    | **Location** (required)                                | Choose the region to start resources in. Ensure that you select a location which supports your requested instance types. To check which services are supported in each location, see [Azure Region Services](https://azure.microsoft.com/en-gb/regions/services/). 
    | **Instance type** (required)                           | Choose the Azure instance type to use for the license server. The selected [Azure instance type](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes) must support premium storage.
    | **IP address range of client** (required)              | Specify the IP address range that can be used to access the resources using the form x.x.x.x/x. To find your IP address, search for "my IP address" in your web browser and copy and paste the address into the input box. Append "/32" to restrict access to your address only, or specify a CIDR range.
    | **Admin username** (required)                          | Enter a username you would like to use to connect to the Network License Manager for MATLAB Dashboard. 
    | **Admin password** (required)                          | Enter a password you would like to use to connect to the Network License Manager for MATLAB Dashboard.

2. Tick the box to accept the Azure Marketplace terms and conditions.
    
3. Click the **Purchase** button.

When you click Purchase, the resources are created using Azure template deployments. Template deployment can take several minutes.

# Step 3: Connect to the Dashboard
> **Note**: The Internet Explorer web browser is not supported for interacting with the dashboard.

1. In the Deployments for your resource group, select the Microsoft.Template deployment created in step 2 and expand the **Outputs** section.
2. Look for the key named `NetworkLicenseManagerAddress` and copy the corresponding URL listed under value. This is the HTTPS endpoint to the Network License Manager for MATLAB Dashboard.

# Step 4: Sign in to the Dashboard
1. Paste the Network License Manager Address URL into a web browser.
2. At the sign in screen, enter the username and password you created in Step 2.

    ![Console Login](images/Console_Login.png)
    
> **Note**: The dashboard uses a self-signed certificate which can be changed. For information on changing the self-signed certificates, see [Change Self-signed Certificate](#change-self-signed-certificate).

# Step 5: Upload the License File
> **Note**: You will need the fixed Host ID to get a license file from the MathWorks License Center for your product. For more information, see the documentation for your product.

1. In the dashboard, go to **Administration > Manage License**.
2. Click **Browse License File** to select the license file you want to upload and click **Open**.
3. Click **Upload**.

    ![Console Upload](images/Console_Upload.png)
    
You are now ready to use the Network License Manager on Azure.

To configure your MATLAB products deployed in Azure to use the Network License Manager, see the product documentation. An example for MATLAB Distributed Computing Server can be found at [MATLAB Distributed Computing Server on Azure](https://github.com/mathworks-ref-arch/mdcs-on-azure).

# Additional Information
## Delete Your Cloud Resources
You can remove the Resource Group and all associated resources when you are done with them. Note that you cannot recover resources once they are deleted.
1. Sign in to the Azure Portal.
2. Select the Resource Group containing your resources.
3. Select the "Delete resource group" icon to destroy all resources deplyoyed in this group.
4. You will be prompted to enter the name of the resource group to confirm the deletion.

    ![Resource Group Delete](images/Resource_Group_Delete.png)

## Change Self-signed Certificate
You can change the self-signed certificate used to connect to the dashboard. To upload an HTTPS certificate:
1. On the dashboard navigation menu, select **Administration** > **Manage HTTPS Certificate**.
1. Click **Browse Certificate...** and select a certificate file. Only `.pfx` files are supported.
1. Enter the certificate password in the **Certificate Password** field.
1. Click **Upload**.

The server will automatically restart after uploading a certificate. You will need to sign out and sign back in.

## Troubleshooting
If your resource group fails to deploy, check the Deployments section of the Resource Group. It will indicate which resource deployments failed and allow you to navigate to the relevant error message.

## Use Existing Virtual Network
You can launch the reference architecture within an existing virtual network and subnet using the azuredeploy-existing-vnet.json template. 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmathworks-ref-arch%2Flicense-manager-for-matlab-on-azure%2Fmaster%2Fazuredeploy-existing-vnet-R2018b.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

> Server Platform: Windows Server 2016

> MATLAB Release: R2018b

This template requires the following two additional parameters:

| Parameter label                                    | Description 
| -------------------------------------------------- | ----------- 
| **Virtual Network Resource ID** (required)             | The Resource ID of an existing virtual network to deploy your server into. You can find this under the Properties of your virtual network.
| **Subnet Name** (required)                             | The name of an existing subnet within your virtual network to deploy your server into.

## Learn About Network License Manager for MATLAB Architecture

The Network License Manager and the resources required by it are created using [Azure Resource Manager templates](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/resource-group-overview). The architecture of the server resources created by the template is illustrated in Figure 2. For more information about each resource, see the [Azure template reference.](https://docs.microsoft.com/en-us/azure/templates/) 

![Server Architecture](images/FlexServer_in_Azure_architecture.png?raw=true)

*Figure 2: Network License Manager Architecture*

The following resources are created.

### Networking resources
* Virtual Network (Microsoft.Network/virtualNetworks) The Virtual Network includes the following components:
    * Subnet (Microsoft.Network/virtualNetworks/subnets)
    * Network Security Group (Microsoft.Network/networkSecurityGroups) : Ingress rules from client IP address:
        * Allow 3389: Required for Remote Desktop Protocol to the cluster nodes.
        * Allow 443: Required for communication between client and Network License Manager for MATLAB Dashboard server.
        * Allow 27000-27001: Required for communication from MATLAB and MATLAB workers to the Network License Manager for MATLAB.
        * Allow all internal traffic: Open access to network traffic between all cluster nodes internally.
* Network interface (Microsoft.Network/networkInterfaces)
* Public IP Address (Microsoft.Network/publicIPAddresses)
    
### Instances
* Network License Manager instance (Microsoft.Compute/virtualMachines): A Compute instance for the license server.
  * Custom Script Extension (Microsoft.Compute/virtualMachines/extensions): An extension which configures this instance at deployment time to start the Network License Manager for MATLAB Dashboard web server.

# Enhancement Request
Provide suggestions for additional features or capabilities using the following link: [https://www.mathworks.com/cloud/enhancement-request.html](https://www.mathworks.com/cloud/enhancement-request.html)

# Technical Support
Email: `cloud-support@mathworks.com`

