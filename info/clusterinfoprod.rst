.. _clusterinfo:

--------------------
Your Cluster Details
--------------------

.. .. _clusterassignments:

Cluster Assignments
+++++++++++++++++++

Refer to **YOUR NAME** in the table below for all critical environmental information, including IP addresses that you will use to complete the self-paced labs. **Please ensure you are using only the cluster details you have been assigned in order to not create issues for other participants. You can filter the spreadsheet based on your name to hide assignments for other users.**

`Click here to open to Cluster Assignment spreadsheet in a new tab. <https://nutanixinc-my.sharepoint.com/:x:/g/personal/matthew_bator_nutanix_com/EYLklsAvsexJng_QI_baOqQBtCSUFCKuSbJpWx3EvyuK3Q>`_

.. note::

   .. raw:: html

     <strong><font color="red">If you are using the Google Chrome browser and macOS 10.5 Catalina, you may encounter issues with self-signed certifications in Prism and be unable to access the cluster. See below for available workarounds.</font></strong>

  **Workaround 1** - Use Firefox and accept the self-signed certificate.

  **Workaround 2** - In Chrome, type *thisisunsafe* in your browser and it will trust the page for the remainder of the browser session.

.. _stagingdetails:

Cluster Staging Details
+++++++++++++++++++++++

Each attendee will have access to a a **SHARED** AOS 5.11.2.3 (AHV 20170830.337) cluster, staged as follows:

.. note::

  Refer to :ref:`clusterassignments` for the *XX* and *YY* octets for your cluster and replace where appropriate.

  For example, if your **Cluster/Prism Element Virtual IP** is 10.42.10.37, substitute *42* for *XX* and *10* for *YY* below.

Virtual Machines
................

The following VMs/Services have already been provisioned to each cluster:

.. list-table::
   :widths: 25 25 50
   :header-rows: 1

   * - VM Name
     - IP Address
     - Description
   * - **Prism Central**
     - 10.XX.YY.39
     - Nutanix Prism Central 5.11.2
   * - **AutoAD**
     - 10.XX.YY.41
     - ntnxlab.local Domain Controller
   * - **GTSPrismOpsLabUtilityServer**
     - 10.XX.YY.42
     - Shared VM used in Prism Pro labs
   * - **BootcampFS**
     - (DHCP) bootcampfs.ntnxlab.local
     - Single-node Nutanix Files cluster
   * - **DDC**
     - 10.XX.YY.45
     - Shared Citrix Delivery Controller/StoreFront
   * - **Era**
     - 10.XX.YY.22
     - Shared Era

Images
......

All disk images required to complete the labs have been uploaded to the Image Service for each cluster.

..

   .. list-table::
   :widths: 50 50
   :header-rows: 1

   * - Image Name
     - Description
   * - **Windows2012R2.qcow2**
     - Pre-built Windows Server 2012 R2 Standard Disk Image (Sysprep)
   * - **Windows10-1709.qcow2**
     - Pre-built Windows 10 Disk Image (Sysprep)
   * - **CentOS7.qcow2**
     - Pre-built CentOS 7 Disk Image
   * - **ToolsVM.qcow2**
     - Pre-built Windows Server 2012 R2 + Tools (pgAdmin, CyberDuck, text editors, etc.) Disk Image
   * - **acs-centos7.qcow2**
     - CentOS Kubernetes Host for Karbon Disk Image
   * - **ERA-Server-build-1.0.1.qcow2**
     - Era 1.0.1 Disk Image
   * - **xtract-vm-2.0.3.qcow2**
     - Xtract for VMs 2.0.3 Disk Image
   * - **hycu-3.5.0-6253.qcow2**
     - HYCU 3.5.0 Appliance Disk Image
   * - **VeeamAvailability_1.0.457.vmdk**
     - Veeam Backup Proxy for AHV 1.0 Disk Image
   * - **VeeamBR-9.5.4.2615.Update4.iso**
     - Veeam Backup & Replication 9.5 Update 4 ISO Image

Credentials
...........

The lab guides will explicitly share any unique credentials, the table below contains common credentials used throughout the labs:

.. list-table::
  :widths: 33 33 33
  :header-rows: 1

  * - Name
    - Username
    - Password
  * - **Prism Element**
    - admin
    - techX2020!
  * - **Prism Central**
    - admin
    - techX2020!
  * - **Controller VMs**
    - nutanix
    - techX2020!
  * - **Prism Central VM**
    - admin
    - techX2020!
  * - **NTNXLAB Domain**
    - NTNXLAB\\Administrator
    - nutanix/4u

Networks
........

At the beginning of each lab track, you will be instructed to create a user specific VLAN, detailed in the :ref:`clusterassignments` spreadsheet. This network will be used for the majority of exercises. The following, additional virtual networks have been pre-configured for each cluster:

.. list-table::
   :widths: 33 33 33
   :header-rows: 1

   * -
     - **Primary** Network
     - **Secondary** Network
   * - **IPAM**
     - Enabled
     - Enabled
   * - **DHCP Pool**
     - 10.XX.YY.50 - 124
     - 10.XX.YY.132 - 229
   * - **Default Gateway**
     - 10.XX.YY.1
     - 10.XX.YY.129
   * - **Netmask**
     - 255.255.255.128
     - 255.255.255.128
   * - **DNS**
     - 10.XX.YY.40 (DC VM)
     - 10.XX.YY.40 (DC VM)

.. raw:: html

   <strong><font color="red">Unless instructed otherwise in a lab, please use your user specific VLAN for VM deployments. If instructed to use the Primary or Secondary networks for an exercise, be sure to clean up unneeded VMs afterwards (or remove their NICs) to ensure IP space availability. With ~6 users sharing each cluster, IP space and memory are the two most contended resources.</font></strong>
