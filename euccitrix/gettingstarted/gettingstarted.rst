.. _citrixgettingstarted:

----------------------
Getting Started
----------------------

Introduction of EUC-Citrix lab track, user scenario is migrating VDI environment from Horizon View to Citrix/AHV, enabling user directories, profile management, flow, reporting.

If you have not previously completed the **Private Cloud** lab track, follow the quick instructions below to provision your user VLAN and Windows Tools VM that will be used throughout this lab track.

Configuring your User VLAN
++++++++++++++++++++++++++

Typically, Hosted POC clusters provide 2x /25 VLANs. In order to provide adequate IP space and support lab requirements for Global Tech Summit, each cluster has been assigned an additional 8x /27 VLANs. The following instructions will walk you through configuring the VLAN you have been individually assigned, and should be used for the remaining labs in this track.

   .. note:: A /27 VLAN provides 32 IP addresses, 5 of which are reserved. You will therefore need to be conscious of cleaning up unneeded VMs to avoid running out of IP space.

#. Log into **Prism Central** using the following credentials:

   - **User Name** - admin
   - **Password** - techX2020!

#. Select :fa:`bars` **> Virtual Infrastructure > Subnets**.

#. Click **Network Config**, select *Your Assigned Cluster*, and click **OK**.

#. Click **+ Create Network** and fill out the following fields, using the **User** specific network details in :ref:`clusterassignments`:

   - **Name** - *Refer to Cluster Assignment Spreadsheet*
   - **VLAN ID** - *Refer to Cluster Assignment Spreadsheet*
   - Select **Enable IP Address Management**
   - **Network IP Address / Prefix Length** - *Refer to Cluster Assignment Spreadsheet*
   - **Gateway IP Address** - *Refer to Cluster Assignment Spreadsheet*
   - **Domain Name Servers** - *Refer to Cluster Assignment Spreadsheet*
   - **Domain Search** - ntnxlab.local
   - **Domain Name** - ntnxlab
   - Select **+ Create Pool**
   - **Start Address** - *Refer to Cluster Assignment Spreadsheet*
   - **End Address** - *Refer to Cluster Assignment Spreadsheet*
   - Click **Submit**

   .. figure:: images/1.png

#. Click **Save**.

Deploying your Tools VM
+++++++++++++++++++++++

#. In **Prism Central**, select :fa:`bars` **> Virtual Infrastructure > VMs**.

#. Click **Create VM**.

#. Select your assigned cluster and click **OK**.

#. Fill out the following fields:

   - **Name** - *Initials*-WinToolsVM
   - **Description** - (Optional) Description for your VM.
   - **vCPU(s)** - 2
   - **Number of Cores per vCPU** - 1
   - **Memory** - 4 GiB

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - ToolsVM.qcow2
      - Select **Add**

   - Select **Add New NIC**
      - **VLAN Name** - *Assigned User VLAN*
      - Select **Add**

#. Click **Save** to create the VM.

#. Select your VM and click **Actions > Power On**.

   Once booted, the VM will automatically complete the Sysprep process, join the **NTNXLAB.local** domain, and log in as the **NTNXLAB\\Administrator** user.
