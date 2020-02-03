.. _mssqldeploy:

----------------
Deploying MS SQL
----------------

Introduction

**In this lab you will...**

Manual VM Deployment
++++++++++++++++++++

#. In **Prism Central**, select :fa:`bars` **> Virtual Infrastructure > VMs**.

   .. figure:: images/1.png

#. Click **Create VM**.

#. Select your assigned cluster and click **OK**.

#. Fill out the following fields:

   - **Name** - *Initials*-MSSQL
   - **Description** - (Optional) Description for your VM.
   - **vCPU(s)** - 2
   - **Number of Cores per vCPU** - 1
   - **Memory** - 4 GiB

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - MSSQL-2016-VM.qcow2
      - Select **Add**

   - Select **Add New NIC**
      - **VLAN Name** - *Assigned User VLAN*
      - Select **Add**

#. Click **Save** to create the VM.

#. Select your VM and click **Actions > Power On**.

#. Once powered on, click **Actions > Launch Console** and complete Windows Server setup:

   - Click **Next**
   - **Accept** the licensing agreement
   - Enter **nutanix/4u** as the Administrator password and click **Finish**

#. Log in to the VM using the Administrator password you configured.

#. Launch **File Explorer** and note the current drive configuration.

   .. figure:: images/2.png

   <Info about MSSQL 2016 already being installed but VM doesn't follow best practices, high level overview of best practices for disk configuration and links to BPG>

#. From the desktop, launch the **01 - Rename Server.ps1** PowerShell script shortcut and fill out the following fields:

   - **Enter the Nutanix cluster IP** - *Assigned Nutanix Cluster IP*
   - **Enter the Nutanix user name for...** - admin
   - **Enter the Nutanix password for "admin"** - techX2020!

   <Explain what script does>

#. Once VM has rebooted, log in and launch the **02 - Complete Build.ps1** Powershell script shortcut. Fill out the following fields:

   - **Enter the Nutanix cluster IP** - *Assigned Nutanix Cluster IP*
   - **Enter the Nutanix user name for...** - admin
   - **Enter the Nutanix password for "admin"** - techX2020!
   - **Enter the Nutanix container name** - Default

   <Explain what script does>

#. Once VM has rebooted, verify the new disk configuration in **Prism** and **File Explorer**

   .. figure:: images/3.png

   .. figure:: images/4.png

#. Log in to your *Initials*\ **-MSSQL** VM and launch SQL Server Management Studio from the desktop.

#. Connect using **Windows Authentication** and verify the database server is available, with only system databases provisioned.

   .. figure:: images/5.png

   Congratulations! <acli, API, Calm, etc. could be used to further automate this process, but this only solves a day 1 provisioning problem and can still result in storage sprawl.
