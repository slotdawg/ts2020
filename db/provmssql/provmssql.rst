.. _provmssql:

---------------------------
Provisioning MSSQL with Era
---------------------------

Introduction (including Time Machine primer)

**In this lab you will...**

Creating a New MSSQL Database Server
++++++++++++++++++++++++++++++++++++

Background on Era capabilities to provision databases to existing servers or create new servers that follow best practices.

#. In **Era**, select **Databases** from the dropdown menu and **Sources** from the lefthand menu.

#. Click **+ Provision > Single Node Database**.

   .. figure:: images/1.png

#. In the **Provision a Database** wizard, fill out the following fields to configure the Database Server:

   - **Engine** - Microsoft SQL Server
   - **Database Server** - Create New Server
   - **Database Server Name** - *Initials*\ -MSSQL2
   - **Description** - (Optional)
   - **Software Profile** - *Initials*\ _MSSQL_2016
   - **Compute Profile** - CUSTOM_EXTRA_SMALL
   - **Network Profile** - *User VLAN*\ _MSSQL_NETWORK
   - Select **Join Domain**
   - **Windows Domain Profile** - NTNXLAB
   - **Windows License Key** - (Leave Blank)
   - **Administrator Password** - nutanix/4u
   - **Instance Name** - MSSQLSERVER

    *What is the Instance Name for?*
   - **Server Collation** - Default

    *What is Server Collation for?*
   - **Database Parameter Profiile** - DEFAULT_SQLSERVER_INSTANCE_PARAMS

    *What are Database Parameters for?*
   - **SQL Service Startup Account** - ntnxlab.local\\Administrator
   - **SQL Service Startup Account Password** - nutanix/4u

   .. figure:: images/2.png

#. Click **Next**, and fill out the following fields to configure the Database:

   - **Database Name** - *Initials*\ -fiesta
   - **Description** - (Optional)
   - **Size (GiB)** - 200 (Default)
   - **Database Parameter Profile** - DEFAULT_SQLSERVER_DATABASE_PARAMS

   .. figure:: images/3.png

   <Info about common use cases for pre and post scripts>

#. Click **Next** and fill out the following fields to configure the Time Machine for your database:

   - **Name** - *initials*\ -fiesta_TM (Default)
   - **Description** - (Optional)
   - **SLA** - DEFAULT_OOB_BRONZE_SLA
   - **Schedule** - (Defaults)

   .. figure:: images/4.png

#. Click **Provision** to begin creating your new database server VM and **fiesta** database.

#. Select **Operations** from the dropdown menu to monitor the provisioning. This process should take approximately 20 minutes.

   .. figure:: images/5.png

   Info on best practices applied by Era when provisioning a DB from a software profile.

Exploring the Provisioned DB Server
++++++++++++++++++++++++++++++++++++

#. In **Prism Element > Storage > Volume Groups**, locate the **ERA_**\ *Initials*\ **_MSSQL2_\*** VG and observe the layout on the **Virtual Disk** tab. <What does this tell us?>

   .. figure:: images/6.png

#. View the disk layout of your newly provisioned VM in Prism. <What are all of these disks and how is this different from the original VM we registered?>

   .. figure:: images/7.png

#. In Prism, note the IP address of your *Initials*\ **-MSSQL2** VM and connect to it via RDP using the following credentials:

   - **User Name** - NTNXLAB\\Administrator
   - **Password** - nutanix/4u

#. Open **Start > Run > diskmgmt.msc** to view the in-guest disk layout. Right-click an unlabeled volume and select **Change Drive Letter and Paths** to view the path to which Era has mounted the volume. Note there are dedicated drives corresponding to SQL data and log locations, similar to the original SQL Server to which you manually applied best practices. <Anything else to share here?>

   .. figure:: images/7b.png

Migrating Fiesta App Data
+++++++++++++++++++++++++

<Intro on other ways app data could be migrated (AAG versus export/import)>

#. From your *Initials*\ **-MSSQL2** RDP session, launch **Microsoft SQL Server Management Studio** from the desktop and click **Connect** to authenticate as the currently logged in user.

   .. figure:: images/8.png

#. Expand the *Initials*\ **-fiesta** database and note that it contains no tables. With the database selected, click **New Query** from the menu to import your production application data.

   .. figure:: images/9.png

#. Copy and paste the following script into the query editor and click **Execute**:

   .. literalinclude:: FiestaDB-MSSQL.sql
     :caption: FiestaDB Data Import Script
     :language: sql

   .. figure:: images/10.png

#. Note the status bar should read **Query executed successfully**.

#. You can view the contents of the database by clicking **New Query** and executing the following:

   .. code-block:: sql

   SELECT * FROM dbo.products
   SELECT * FROM dbo.stores
   SELECT * FROM dbo.InventoryRecords

   .. figure:: images/11.png

Provision Fiesta Web Tier
+++++++++++++++++++++++++

Manipulating data using **SQL Server Management Studio** is boring, especially when THE *Sharon Santana* went through all of the trouble of building a neat front end for your business critical app. In this section you'll deploy the web tier of the application and connect it to your production database.

#. Download the **Fiesta** blueprint used to provision only the web tier by clicking :download:`here <FiestaNoDB.json>`.

#. From **Prism Central > Calm**, select **Blueprints** from the lefthand menu and click **Upload Blueprint**.

   .. figure:: images/12.png

#. Select **FiestaNoDB.json**.

#. Select your Calm project and click **Upload**.

   .. figure:: images/13.png

#. In order to launch the Blueprint you must first assign a network to the VM. Select the **NodeReact** Service, and in the **VM** Configuration menu on the right, select *Your Assigned User VLAN* as the **NIC 1** network.

   .. figure:: images/14.png

#. Click **Credentials** to define a private key used to authenticate to the CentOS VM that will be provisioned by the Blueprint.

#. Expand the **CENTOS** credential and use your preferred SSH key, or paste in the following value as the **SSH Private Key**:

   ::

     -----BEGIN RSA PRIVATE KEY-----
     MIIEowIBAAKCAQEAii7qFDhVadLx5lULAG/ooCUTA/ATSmXbArs+GdHxbUWd/bNG
     ZCXnaQ2L1mSVVGDxfTbSaTJ3En3tVlMtD2RjZPdhqWESCaoj2kXLYSiNDS9qz3SK
     6h822je/f9O9CzCTrw2XGhnDVwmNraUvO5wmQObCDthTXc72PcBOd6oa4ENsnuY9
     HtiETg29TZXgCYPFXipLBHSZYkBmGgccAeY9dq5ywiywBJLuoSovXkkRJk3cd7Gy
     hCRIwYzqfdgSmiAMYgJLrz/UuLxatPqXts2D8v1xqR9EPNZNzgd4QHK4of1lqsNR
     uz2SxkwqLcXSw0mGcAL8mIwVpzhPzwmENC5OrwIBJQKCAQB++q2WCkCmbtByyrAp
     6ktiukjTL6MGGGhjX/PgYA5IvINX1SvtU0NZnb7FAntiSz7GFrODQyFPQ0jL3bq0
     MrwzRDA6x+cPzMb/7RvBEIGdadfFjbAVaMqfAsul5SpBokKFLxU6lDb2CMdhS67c
     1K2Hv0qKLpHL0vAdEZQ2nFAMWETvVMzl0o1dQmyGzA0GTY8VYdCRsUbwNgvFMvBj
     8T/svzjpASDifa7IXlGaLrXfCH584zt7y+qjJ05O1G0NFslQ9n2wi7F93N8rHxgl
     JDE4OhfyaDyLL1UdBlBpjYPSUbX7D5NExLggWEVFEwx4JRaK6+aDdFDKbSBIidHf
     h45NAoGBANjANRKLBtcxmW4foK5ILTuFkOaowqj+2AIgT1ezCVpErHDFg0bkuvDk
     QVdsAJRX5//luSO30dI0OWWGjgmIUXD7iej0sjAPJjRAv8ai+MYyaLfkdqv1Oj5c
     oDC3KjmSdXTuWSYNvarsW+Uf2v7zlZlWesTnpV6gkZH3tX86iuiZAoGBAKM0mKX0
     EjFkJH65Ym7gIED2CUyuFqq4WsCUD2RakpYZyIBKZGr8MRni3I4z6Hqm+rxVW6Dj
     uFGQe5GhgPvO23UG1Y6nm0VkYgZq81TraZc/oMzignSC95w7OsLaLn6qp32Fje1M
     Ez2Yn0T3dDcu1twY8OoDuvWx5LFMJ3NoRJaHAoGBAJ4rZP+xj17DVElxBo0EPK7k
     7TKygDYhwDjnJSRSN0HfFg0agmQqXucjGuzEbyAkeN1Um9vLU+xrTHqEyIN/Jqxk
     hztKxzfTtBhK7M84p7M5iq+0jfMau8ykdOVHZAB/odHeXLrnbrr/gVQsAKw1NdDC
     kPCNXP/c9JrzB+c4juEVAoGBAJGPxmp/vTL4c5OebIxnCAKWP6VBUnyWliFhdYME
     rECvNkjoZ2ZWjKhijVw8Il+OAjlFNgwJXzP9Z0qJIAMuHa2QeUfhmFKlo4ku9LOF
     2rdUbNJpKD5m+IRsLX1az4W6zLwPVRHp56WjzFJEfGiRjzMBfOxkMSBSjbLjDm3Z
     iUf7AoGBALjvtjapDwlEa5/CFvzOVGFq4L/OJTBEBGx/SA4HUc3TFTtlY2hvTDPZ
     dQr/JBzLBUjCOBVuUuH3uW7hGhW+DnlzrfbfJATaRR8Ht6VU651T+Gbrr8EqNpCP
     gmznERCNf9Kaxl/hlyV5dZBe/2LIK+/jLGNu9EJLoraaCBFshJKF
     -----END RSA PRIVATE KEY-----

   .. figure:: images/15.png

#. Click **Save** and click **Back** once the Blueprint has completed saving.

#. Click **Launch** and fill out the following fields:

   - **Name of the Application** - XYZ-Fiesta
   - **db_dialect** - mssql
   - **db_doma

   .. figure:: images/16.png

#. Click **Create**.

#. Select the **Audit** tab to monitor the deployment. This process should take < 5 minutes.

   .. figure:: images/17.png

#. Once the application status changes to **Running**, select the **Services** tab and select the **NodeReact** service to obtain the **IP Address** of your web server.

   .. figure:: images/18.png

#. Open \http://*NODEREACT-IP-ADDRESS:5001*/ in a new browser tab to access the **Fiesta** application.

Congratulations! You've completed the deployment of your production application.
