.. _oraclepatch:

------------------
Patching Databases
------------------

Introduction

**In this lab you will...**

Manual Oracle VM Deployment
+++++++++++++++++++++++++++

#. In **Prism Central**, select :fa:`bars` **> Virtual Infrastructure > VMs**.

   .. figure:: images/1.png

#. Click **Create VM**.

#. Select your assigned cluster and click **OK**.

#. Fill out the following fields:

   - **Name** - *Initials*-OracleProd
   - **Description** - (Optional) Description for your VM.
   - **vCPU(s)** - 2
   - **Number of Cores per vCPU** - 1
   - **Memory** - 8 GiB

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_bootdisk.qcow2
      - Select **Add**

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk1.qcow2
      - Select **Add**

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk2.qcow2
      - Select **Add**

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk3.qcow2
      - Select **Add**

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk4.qcow2
      - Select **Add**

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk5.qcow2
      - Select **Add**

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk6.qcow2
      - Select **Add**

    - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk7.qcow2
      - Select **Add**

    - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk8.qcow2
      - Select **Add**

    - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - Oracle19c_disk9.qcow2
      - Select **Add**

   - Select **Add New NIC**
      - **VLAN Name** - *Assigned User VLAN*
      - Select **Add**

#. Click **Save** to create the VM.

#. Select your VM and click **Actions > Power On**.

.. #. Once powered on, click **Actions > Launch Console** and complete Windows Server setup:

Registering Production Oracle VM
++++++++++++++++++++++++++++++++

Unlike the MS SQL labs, the intention here is to directly register a database, along with the database server, in order to manage your production Oracle database with Era.

#. In **Era**, select **Databases** from the dropdown menu and **Sources** from the lefthand menu.

   .. figure:: images/1.png

#. Click **+ Register** and fill out the following **Database Server** fields:

   - **Engine** - Oracle
   - **Database is on a Server this is** - Not Registered
   - **IP Address or Name of VM** - *Initials*\ -OracleProd
   - **Era Drive User** - oracle

      *The Era Drive User can be any user on the VM that has sudo access with NOPASSWD setting. Era will use this user's credentials to perform various operations, such as taking snapshots.*

   - **Oracle Database Home** - /u02/app/oracle/product/19.0.0/dbhome_1

      *This is the directory where the Oracle database software is installed, and is a mandatory parameter for registering a database server.*

   - **Provide Credentials Through** - Password
   - **Password** - Nutanix/4u

   .. figure:: images/2.png

#. Click **Next**, and fill out the following **Database** fields:

   - **Database Name in Era** - *Initials*\ _ORCL19C
   - **SID** - orcl18c

      *What is the SID?*

   .. figure:: images/3.png

#. Click **Next**, and modify the following **Time Machine** default values:

   - **SLA** - DEFAULT_OOB_GOLD_SLA

   .. figure:: images/4.png

#. Click **Register** to begin registering both the Database Server and the existing Database on your production Oracle VM.

#. Select **Operations** from the dropdown menu to monitor the registration. This process should take approximately 5 minutes.

Patching Oracle with Era
++++++++++++++++++++++++

Waiting on Teague
