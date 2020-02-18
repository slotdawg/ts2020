.. _citrixfiles:

-----------------
Integrating Files
-----------------

<Info about Files, UPM, folder redirection>

**In this lab you will configure Nutanix Files to provide user profiles and data storage for your non-persistent Citrix desktops.**

Creating Profiles Share
+++++++++++++++++++++++

For the purposes of saving time and resources, a Nutanix Files instance has already been deployed to your cluster. For a quick overview on deploying Nutanix Files, click `here <http://youtube.com>`_.

#. In **Prism Element > File Server > Share/Export**, click **+ Share/Export**.

   .. figure:: images/1.png

#. Under **Basic**, fill out the following fields and click **Next**:

   - **Name** - *Initials*\ **-CitrixProfiles**
   - **Description** - User profiles and data
   - **File Server** - BootcampFS
   - **Select Protocol** - SMB

   .. note::

      As this environment leverages a single-node Files deployment, you are not given the option between **Standard** and **Distributed** share types. <Info on profiles and distributed share - optimizes the sharding of data for this use case by distributing users' home directories evenly across all VMs in the AFS cluster.>

#. Fill out the following fields and click **Next > Create**:

   - Select **Enable Access Based Enumeration (ABE)**
   - Select **Self Service Restore**
   - Select **Blocked File Types** - .mp3,.mp4

   .. figure:: images/13.png

   .. note::

     Access Based Enumeration (ABE) is a Microsoft Windows (SMB protocol) feature which allows the users to view only the files and folders to which they have read access when browsing content on the file server.

     Self Service Restore enabled support for Windows Previous Versions on an SMB share.

     Either of these features can be enabled/disabled on a per share basis.

.. #. Repeat **Steps 1-3** to create an additional Share named *Initials*\ **-DepartmentShare**, without any Blocked File Types.

   .. figure:: images/14.png

#. In **Prism Element > File Server > File Server**, select **BootcampFS** and click **Protect**.

   .. figure:: images/2.png

     Observe the default Self Service Restore schedules, this feature controls the snapshot schedule for Windows' Previous Versions functionality. Supporting Windows Previous Versions allows end users to roll back changes to files without engaging storage or backup administrators. Note these local snapshots do not protect the file server cluster from local failures and that replication of the entire file server cluster can be performed to remote Nutanix clusters.

#. From your *Initials*\ **-WinTools** VM, validate you can access ``\\BootcampFS.ntnxlab.local\Initials-CitrixProfiles\`` from File Explorer.

   .. figure:: images/3.png

   .. note::

     To learn more about Files capabilities, including Quotas, Antivirus integration, monitoring, and more, see the `Nutanix Files Guide <https://portal.nutanix.com/#/page/docs/details?targetId=Files-v3_6:Files-v3_6>`_ on the Nutanix Portal.

Configuring Share Permissions
+++++++++++++++++++++++++++++

<exposition about why we're setting these permissions, allowing all users to create a top level directory that they own for their profile>

#. From your *Initials*\ **-WinTools** VM, open ``\\BootcampFS.ntnxlab.local\`` in File Explorer.

#. Right-click your share and select **Properties**.

   .. figure:: images/4.png

#. Select the **Security** tab and click **Advanced**.

#. Select the default **Users (BootcampFS\\Users)** entry and click **Remove**.

#. Click **Add**.

#. Click **Select a principal** and specify **Everyone** in the **Object Name** field. Click **OK**.

#. Fill out the following fields and click **OK**:

   - **Type** - Allow
   - **Applies to** - This folder only
   - Select **Read & execute**
   - Select **List folder contents**
   - Select **Read**
   - Select **Write**

   .. figure:: images/5.png

#. Click **OK > OK > OK**.

   .. figure:: images/6.png

Configuring Citrix User Profile Management
++++++++++++++++++++++++++++++++++++++++++

<todo on citrix UPM being installed as part of VDA, we are enabling the processing of those logons and telling it where to look for profiles>

#. In **Citrix Studio > Policies**, right-click **Policies > Create Policy**.

   .. figure:: images/7.png

#. Select **Profile Management > Basic Settings** from the **All Settings** drop down menu. Optionally you can filter for only policies supported on **1912 Single-Session OS** from the **All Versions** drop down menu.

   .. figure:: images/8.png

#. Search for **Enable Profile management** and click **Select**. Select **Enabled** and click **OK**.

   .. figure:: images/9.png

#. Search for **Path to user store** and click **Select**. Select **Enabled** and specify ``\\BootcampFS\Initials-CitrixProfiles\%USERNAME%\!CTX_OSNAME!!CTX_OSBITNESS!`` as the path. Click **OK**.

   .. figure:: images/10.png

   .. note::

     The specified path will not only create unique top level directories within the share for each user, but will also create a platform specific subdirectory for their profile to avoid incompatability issues, such as trying to apply a Windows 10 user profile to a Windows 2012 session.

#. Click **Next**.

#. Click **Assign** to the right of **Delivery Group**.

#. Select your Non-Persistent Delivery Group from the **Delivery Group** drop down menu. Click **OK**.

   .. figure:: images/11.png

   .. note::

     Studio offers many different means of applying policies. Across a more diverse environment it may make sense to configure UPM settings based on OUs or Tags.

#. Click **Next**.

#. Provide a friendly **Policy name** (e.g. **UPM**) and select **Enable policy**. Review your configuration and click **Finish**.

   .. figure:: images/12.png

Testing Profiles and Folder Redirection
+++++++++++++++++++++++++++++++++++++++

#. Log in to Citrix StoreFront as **NTNXLAB\\operator02** and connect to a **Pooled Windows 10 Desktop**.

#. Make some simple changes such as adding files to your Documents folder and changing the desktop background. Note the hostname of the desktop to which you are connected.

   .. figure:: images/afsprofiles15.png

#. Open **PowerShell** and try to create a file with a blocked file type by executing the following command:

   .. code-block:: PowerShell

      New-Item \\BootcampFS\INITIALS-CitrixProfiles\operator02\Win10RS6x64\UPM_Profile\Documents\test.mp3

   Observe that creation of the new file is denied.

#. Sign out of the **Pooled** desktop. Do not just close the Citrix Workspace session as the desktop will not be re-provisioned.

#. Again, log in to Citrix StoreFront as **NTNXLAB\\operator02** and connect to a **Pooled Windows 10 Desktop**. Note that your files and settings persist across sessions, despite the underlying desktop being freshly provisioned every time you log in.

#. Open ``\\BootcampFS\Initials-CitrixProfiles\operator02`` in **File Explorer**. Drill down into the directory structure to find the data associated with your user profile.

#. Log in to Citrix StoreFront as **NTNXLAB\\operator01** and connect to a **Pooled Windows 10 Desktop**. Open ``\\BootcampFS\Initials-CitrixProfiles\`` and note that you don't see or have access to **operator02**'s profile directory. Disable **Access Based Enumeration (ABE)** in **Prism > File Server > Share/Export > home > Update** and try again.

#. (Optional) Create and save a text file in the **Documents** folder of your non-persistent virtual desktop. After ~1 hour, return to your virtual desktop, modify and save the document you previously created. Right-click the file and select **Restore previous versions**. Select an available previous version of the document and click **Open** to access the file.

.. figure:: images/afsprofiles16.png

Takeaways
+++++++++

- Nutanix provides native file services suitable for storing user profiles and data.

- AFS can be deployed on the same Nutanix cluster as your virtual desktops, resulting in better utilization of storage capacity and the elimination of an additional storage silo.

- Supporting mixed workloads (e.g. virtual desktops and file services) is further enhanced by Nutanix's ability to mix different node configurations within a single cluster, such as:

  - Mixing storage heavy and compute heavy nodes
  - Expanding a cluster with Storage Only nodes to increase storage capacity without incurring additional virtualization licensing costs
  - Mixing different generations of hardware (e.g. NX-3460-G6 + NX-6235-G5)
  - Mixing all flash nodes with hybrid nodes
  - Mixing NVIDIA GPU nodes with non-GPU nodes
