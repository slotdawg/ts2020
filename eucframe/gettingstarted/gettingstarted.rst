.. _citrixgettingstarted:

----------------------
Getting Started
----------------------

<Introduction of EUC Xi Frame lab track, user scenario is migrating VDI environment from Horizon View to Citrix/AHV, enabling user directories, profile management, flow, reporting.>

If you have not previously completed the **Private Cloud** lab track, follow the quick instructions below to provision the user VLANvthat will be used throughout this lab track.

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

   .. figure:: images/1.png

#. Click **Save**.
