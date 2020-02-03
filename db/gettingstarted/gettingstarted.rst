.. _dbgettingstarted:

----------------------
Getting Started
----------------------

Introduction of DB lab track, user scenario of admin having to manage multiple database engines, provide services to users, slowed by manual process, lots of storage sprawl - start with manual deployment on Nutanix and integrate Era.

Configuring your User VLAN
++++++++++++++++++++++++++

Typically, Hosted POC clusters provide 2x /25 VLANs. In order to provide adequate IP space and support lab requirements for Global Tech Summit, each cluster has been assigned an additional 8x /27 VLANs. The following instructions will walk you through configuring the VLAN you have been individually assigned, and should be used for the remaining labs in this track.

   .. note:: A /27 VLAN provides 32 IP addresses, 5 of which are reserved. You will therefore need to be conscious of cleaning up unneeded VMs to avoid running out of IP space.

#. In **Prism Central**, select :fa:`bars` **> Virtual Infrastructure > Subnets**.\

#. Click **Network Config**, select *Your Assigned Cluster*, and click **OK**.

#. Click **+ Create Network** and fill out the following fields:

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

Configuring a Project
+++++++++++++++++++++

In this lab you will leverage multiple pre-built Calm Blueprints to provision your applications...

#. In **Prism Central**, select :fa:`bars` **> Services > Calm**.\

#. Select **Projects** from the lefthand menu and click **+ Create Project**.

   .. figure:: images/2.png

#. Fill out the following fields:

   - **Project Name** - *Initials*\ -Project
   - **AHV Cluster** - *Your assigned cluster*
   - Under **Users, Groups, and Roles**, select **+ User**
      - **Name** - Administrators
      - **Role** - Project Admin
      - **Action** - Save
   - Under **Infrastructure**, select **Select Provider > Nutanix**
   - Click **Select Clusters & Subnets**
   - Select *Your Assigned Cluster*
   - Under **Subnets**, select **Primary**, **Secondary**, and *Your Assigned User VLAN*, and click **Confirm**
   - Mark *Your Assigned User VLAN* as the default network by clicking the :fa:`star`

   .. figure:: images/3.png

#. Click **Save & Configure Environment**.
