.. _regmssql:

--------------------
Register Existing DB
--------------------

Introduction

**In this lab you will...**

Exploring Era Resources
+++++++++++++++++++++++

#. In **Prism Central > VMs > List**, identify the IP address assigned to the **EraServer-\*** VM using the **IP Addresses** column.

#. Open \https://*ERA-VM-IP:8443*/ in a new browser tab.

#. Login using the following credentials:

   - **Username** - admin
   - **Password** - nutanix/4u

#. From the **Dashboard** dropdown, select **Administration**.

#. Under **Cluster Details**, note that Era has already been configured for your assigned cluster.

   .. figure:: images/1.png

#. Select **Era Resources** from the left-hand menu.

#. Under **VLANs Available for Network Profiles**, click **Add**. Select your *User* VLAN and click **Add**.

   .. figure:: images/2.png

#. From the dropdown menu, select **SLAs**.

   <Something about SLAs>

#. From the dropdown menu, select **Profiles**.

#. <Something about Compute profiles>

#. Under **Network**, click **+ Create**.

   .. figure:: images/3.png

#. Fill out the following fields and click **Create**:

   - **Engine** - Microsoft SQL Server
   - **Name** - *Assigned User VLAN*-MSSQL-NETWORK
   - **Public Service VLAN** - *Assigned User VLAN*

   .. figure:: images/4.png

#. Click **+ Create** again and fill out the following fields:

   - **Engine** - Oracle
   - **Type** - Single Instance
   - **Name** - *Assigned User VLAN*-ORACLE-NETWORK
   - **Public Service VLAN** - *Assigned User VLAN*

#. Click **Create** to finish creating your Oracle network profile.

   .. figure:: images/4b.png

Registering Your MSSQL VM
+++++++++++++++++++++++++

Background on what's required to register a DB, what Era can do with it once registered.

#. In **Era**, select **Database Servers** from the dropdown menu and **List** from the lefthand menu.

   .. figure:: images/5.png

#. Click **+ Register** and fill out the following fields:

   - **Engine** - Microsoft SQL Server
   - **IP Address or Name of VM** - *Initials*\ -MSSQL
   - **Windows Administrator Name** - Administrator
   - **Windows Administrator Password** - nutanix/4u
   - **Instance** - MSSQLSERVER (This should auto-populate after providing credentials)
   - **Connect to SQL Server Admin** - Windows Admin User
   - **User Name** - Administrator

   .. figure:: images/6.png

   .. note::

    You can click **API Equivalent** for many operations in Era to enter an interactive wizard providing JSON payload based data you've input or selected within the UI, and examples of the API call in multiple languages (cURL, Python, Golang, Javascript, and Powershell).

    .. figure:: images/11.png

#. Click **Register** to begin ingesting the Database Server into Era.

#. Select **Operations** from the dropdown menu to monitor the registration. This process should take approximately 5 minutes.

   .. figure:: images/7.png

<Talk about ability to directly register an existing DB and not just a DB server>

Creating A Software Profile
+++++++++++++++++++++++++++

<Before you can provision new DBs from an existing DB, you need to create a profile. What's a profile, etc.>

#. Select **Profiles** from the dropdown menu and **Software** from the lefthand menu.

   .. figure:: images/8.png

#. Click **+ Create** and fill out the following fields:

   - **Engine** - Microsoft SQL Server
   - **Name** - *Initials*\ _MSSQL_2016
   - **Description** - (Optional)
   - **Database Server** - Select your registered *Initials*\ -MSSQL VM

   .. figure:: images/9.png

#. Click **Create**.

#. Select **Operations** from the dropdown menu to monitor the registration. This process should take approximately 5 minutes.

   .. figure:: images/10.png

#. Once the profile creation completes successfully, power off your *Initials*\ **-MSSQL** VM in Prism.
