.. _onpremleap:

---------------------------------
On-premises DR Runbooks with Leap
---------------------------------

**In this lab...**

Staging the Lab
+++++++++++++++

**THIS LAB USES DEDICATED CLUSTERS USING PRE-RELEASE 5.17 AOS. YOU CANNOT COMPLETE THIS LAB USING THE CLUSTER YOU WERE ASSIGNED FOR OTHER LABS**.

**IT IS CRITICAL TO DELETE YOUR VMS AFTER COMPLETING THE LAB SO OTHER USERS HAVE AVAILABLE MEMORY AND IP ADDRESSES**.

Provisioning Your Application
.............................

#. Log in to Prism Central for your **PrimarySite** cluster at https://10.38.194.40:9440/ using the following credentials:

   - **Username** - admin
   - **Password** - techX2020!

#. Open :fa:`bars` **> Administration > Availability Zones** and observe that the cluster has already been paired to another Prism Central instance containing your **SeccondarySite** cluster. No action is required to add additional Availability Zones for this lab.

   .. figure:: images/1.png

#. Open :fa:`bars` **> Services > Calm** and select **Blueprints** from the sidebar.

#. Select the **FiestaApp** Blueprint and click **Actions > Launch**.

   .. figure:: images/2.png

#. Fill out the following fields and then click **Create** to begin provisioning your application:

   - **Name of the Application** - *Initials*\ -FiestaApp
   - **UserInitials** - *Initials*

#. Monitor the status of the application in the **Audit** tab and proceed once your application enters a **Running** state.

#. On the **Services** tab, select the **NodeReact** service and note the IP Address. This is the web server hosting the front end of your application.

#. Open http://<*NodeReact-VM-IP-Address*> in a new browser tab and validate you can access the Fiesta Inventory Management app.

   .. figure:: images/5.png

Installing Nutanix Guest Tools
..............................

#. Open :fa:`bars` **> Virtual Infrastructure > VMs**.

#. Select your *Initials*\ **-WebServer-...** VM and click **Actions > Update**.

#. Under **Disks**, click :fa:`eject` beside **CD-ROM** to unmount the Cloud-Init disk mounted during the Calm deployment.

#. Click **Save**.

#. Repeat **Steps 2-4** to eject the **CD-ROM** on your *Initials*\ **-MySQL-...** VM.

#. Select both VMs and click **Actions > Install NGT**.

   .. figure:: images/4.png

#. Click **Confirm and Enter Password > Skip and Mount** to mount the NGT .iso to your VMs.

   .. note::

      Nutanix Calm currently supports automatic installation of NGT for single VM blueprints, and plans to support multi-VM blueprints.

#. SSH into your *Initials*\ **-WebServer-...** VM using the following credentials:

   - **User Name** - centos
   - **Password** - nutanix/4u

#. Within the VM SSH session, execute the following to install NGT:

   .. code-block:: bash

      sudo mount /dev/sr0 /mnt
      sudo /mnt/installer/linux/install_ngt.py
      sudo reboot

#. Repeat **Steps 8-9** with your *Initials*\ **-MySQL-...** VM.

#. Once both VMs have rebooted, validate both VMs now have empty CD-ROM drives and **NGT Status** displays **Latest** in Prism Central.

   .. figure:: images/6.png
