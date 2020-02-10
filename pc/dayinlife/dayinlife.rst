.. _dayinlife:

-----------------
A Day in the Life
-----------------

Introduction

**In this lab you will...**

Configuring Storage
+++++++++++++++++++

Using your **Cluster Assignment Spreadsheet**, identify your **Prism Element** cluster IP.

#. In a browser, open **Prism Element** and log in using the following local user credentials:

   - **Username** - admin
   - **Password** - techX2020!

   .. figure:: images/1.png

#. Select **Storage** from the drop down menu.

   .. figure:: images/2.png

   <Exposition about storage overview dashboad, data reduction/efficiency, capacity>

   .. figure:: images/3.png

#. Select **Table** and click **+Storage Container**.

   .. figure:: images/4.png

#. Provide a unique **Name** for the **Storage Container**, and click **Advanced Settings** to explore additional configuration options.

   .. figure:: images/5.png

   <Exposition about different options, when to use them, when you would need different storage containers, configuring resiliency, how they all share 1 pool of physical storage>

#. Click **Save** to create the storage and mount it to all available hosts within the cluster.

Provisioning a New Network
++++++++++++++++++++++++++

<Exposition about need to create additional VM network>

.. note::

   Typically, Hosted POC clusters provide 2x /25 VLANs. In order to provide adequate IP space and support lab requirements for Global Tech Summit, each cluster has been assigned an additional 8x /27 VLANs. A /27 VLAN provides 32 IP addresses, 5 of which are reserved. You will therefore need to be conscious of cleaning up unneeded VMs to avoid running out of IP space.

#. Select **VM** from the **Prism Element** drop down menu.

#. Select **Network Config**.

   .. figure:: images/9.png

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

   .. figure:: images/8.png

#. Click **Save**.

#. Close the **Network Configuration** window.

Responding to VM Creation Requests
++++++++++++++++++++++++++++++++++

<Some exposition about building template images, ability to merge in unattend files, script via CLI>

#. Return to the **VM** page in **Prism Element** from the drop down menu.

#. Click **+ Create VM**.

   .. figure:: images/10.png

#. Fill out the following fields to complete the user VM request:

   - **Name** - *Initials*\ -WinToolsVM
   - **Description** - Manually deployed Tools VM
   - **vCPU(s)** - 2
   - **Number of Cores per vCPU** - 1
   - **Memory** - 4 GiB

   - Select **+ Add New Disk**
      - **Type** - DISK
      - **Operation** - Clone from Image Service
      - **Image** - WinToolsVM.qcow2
      - Select **Add**

   - Select **Add New NIC**
      - **VLAN Name** - *Assigned User VLAN*
      - Select **Add**

#. Click **Save** to create the VM.

#. Using the search field at the top of the table, filter for the requested VM. Select the VM and click **Power On** from the list of actions below the table.

   .. figure:: images/12.png

#. Once the VM has completed booting, Carol can note the IP address

   .. figure:: images/11.png

   With previous infrastructure, Carol has had issues with newly created VM networks not working as expected, and has had to engage in lengthy troubleshooting sessions with her network admin counterpart to identify the source of the issue. With AHV, Carol is easily able to visualize the complete network path of the virtual machine she has provisioned.

#. Try it yourself by selecting the **Network** page from the **Prism Element** drop down menu and filtering by VLAN or VM name.

   .. figure:: images/13.png

Enabling User Self Service
++++++++++++++++++++++++++

#. Return to the **Home** page of **Prism Element**.

#. Access **Prism Central** by clicking the **Launch** button and logging in with the following credentials:

   - **User Name** - admin
   - **Password** - techX2020!

   .. figure:: images/6.png

Exploring Categories
====================

<Categories are used to...>

#. In **Prism Central**, select :fa:`bars` **> Virtual Infrastructure > Categories**.

   .. figure:: images/14.png

#. Click **New Category** and fill out the following fields:

   - **Name** - Team
   - **Purpose** - Allowing resource access based on Application Team
   - **Values** - Fiesta
                  ToDo

   .. figure:: images/15.png

#. Click **Save**.

#. Select the existing **Environment** category and note the available values. **Environment** is a **SYSTEM** category, and while you can add additional values, you cannot modify or delete the Category or any of its out of the box values.

   .. figure:: images/16.png

#. Select :fa:`bars` **> Virtual Infrastructure > VMs**.

#. Using the checkboxes, select the **AutoAD**, **DDC**, and **NTNX-BootcampFS-1** VMs and click **Actions > Manage Categories**.

   .. figure:: images/17.png

#. In the search bar, begin typing **Environment** and select the **Production** value.

   .. figure:: images/18.png

   .. note::

      For categories tied to Security, Protection, or Recovery policies, related policies will appear in this window to show the impact of applying a Category to an entity.

#. Click **Save**.

#. Select the *Initials*\ **-WinToolsVM** provisioned by Carol in the previous exercise, and click **Actions > Manage Categories**. Assign the **Team: Fiesta** category and **Save**.

Exploring Roles
===============

<Roles are used to...>

Carol needs to support two types of users working on the Fiesta team, developers who need to provision VMs for test environments, and operators who monitor multiple environments within the organization, but who have very limited capabilities to modify each environment.

#. In **Prism Central**, select :fa:`bars` **> Administration > Roles**.

   The Developer role provides...

#. Select the built-in **Developer** role and optionally review the approved actions for the role. Click **Manage Assignment**.

   .. figure:: images/19.png

#. Under **Users and Groups**, specify the **SSP Developers** User Group which should be automatically discovered from the NTNXLAB.local domain.

#. Under **Entities**, use the drop down menu to specify the following resources:

   - **AHV Cluster** - *Your Assigned Cluster*
   - **AHV Subnet** - *Your Assigned User VLAN*
   - **Category** - Environment:Testing, Environment:Staging, Environment:Dev, Team:Fiesta

   .. figure:: images/20.png

#. Click **Save**.

   The default Operator roll includes the ability to delete VMs and applications deployed from Blueprints, which isn't desired in our environment. Rather than building a new role from scratch, we can clone to existing role and modify to suit our needs. The desired operator role should be able to view VM metrics, perform power operations, and update VM configurations such as vCPU or memory to address application performance issues.

#. Select the built-in **Operator** role and click **Duplicate**.

#. Fill out the following fields and click **Save** to create your custom role:

   - **Role Name** - SmoothOperator
   - **Description** - Limited operator accounts
   - **App** - No Access
   - **VM** - Edit Access
   - Do **NOT** select **Allow VM Creation**

   .. figure:: images/21.png

#. Refresh **Prism** and select your **SmoothOperator** role. Click **Manage Assignment**.

#. Create the following assignment:

   - **Users and Groups** - operator01
   - **Entity Categories** - Environment:Production, Environment:Testing, Environment:Staging, Environment:Dev

   Operator01 is a user who has access to all VMs tagged with any of the Environment categories, but lacks generic access to specific clusters.

#. Click **New User** to add an additional assignment to the same role:

   - **Users and Groups** - operator02
   - **Entity Categories** - EnvironmentDev, Team:Fiesta

   Operator02 is a user who sees all VMs tagged with either the Dev or Fiesta category values.

   .. figure:: images/22.png

#. For infrastructure administrators such as Carol, you can map AD users to the **Prism Admin** or **Super Admin** roles through selecting :fa:`bars` **> Prism Central Settings > Role Mapping** and adding a new **Cluster Admin** or **User Admin** mapping to AD accounts.

   .. figure:: images/28.png

Exploring Projects
==================

In order for non-infrastructure administrators to access Calm, allowing them to create or manage applications and Blueprints, users or groups must first be assigned to a **Project**, which acts as a logical container for...

#. In **Prism Central**, select :fa:`bars` **> Services > Calm**.

#. Select **Projects** from the lefthand menu and click **+ Create Project**.

   .. figure:: images/23.png

#. Fill out the following fields:

   - **Project Name** - *Initials*\ -FiestaProject
   - **AHV Cluster** - *Your assigned cluster*
   - Under **Infrastructure**, select **Select Provider > Nutanix**
   - Click **Select Clusters & Subnets**
   - Select *Your Assigned Cluster*
   - Under **Subnets**, select **Primary**, **Secondary**, and *Your Assigned User VLAN*, and click **Confirm**
   - Mark *Your Assigned User VLAN* as the default network by clicking the :fa:`star`
   - Under **Users, Groups, and Roles**, select **+ User**
      - **Name** - SSP Developers
      - **Role** - Developers
      - **Action** - Save
   - Select **+ User**
      - **Name** - Operator02
      - **Role** - SmoothOperator
      - **Action** - Save
   - Under **Quotas**, specify
      - **vCPUs** - 100
      - **Storage** - <Leave Blank>
      - **Memory** - 100

   .. figure:: images/24.png

   .. note::

      Adding the User/Group mappings before adding the Infrastructure can cause adding the Infrastructure to fail. To avoid this, add the Infrastructure before the User/Group mappings.

#. Click **Save & Configure Environment**.

Note that only **Operator02** was given access to the **Calm** project, rather than all Operator accounts.

Staging Blueprints
==================

While developers will have the ability to create and publish, Carol wants to provide a common blueprint used by the team.

#. Download the **Fiesta-Multi** blueprint by clicking :download:`here <Fiesta-Multi.json>`.

#. From **Prism Central > Calm**, select **Blueprints** from the lefthand menu and click **Upload Blueprint**.

   .. figure:: images/25.png

#. Select **Fiesta-Multi.json**.

#. Select your Calm project and click **Upload**.

   .. figure:: images/26.png

#. In order to launch the Blueprint you must first assign a network to the VM. Select the **NodeReact** Service, and in the **VM** Configuration menu on the right, select *Your Assigned User VLAN* as the **NIC 1** network.

#. Specify the **Team: Fiesta** and **Environment: Dev** categories for the **NodeReact** Service.

   .. figure:: images/27.png

#. Repeat the **NIC 1** and **Category** assignment for the **MySQL** Service.

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

#. Click **Save** and click **Back** once the Blueprint has completed saving.

Within an hour, Carol has prepared the environment to service <more exposition>.

Developer Workflow
++++++++++++++++++

Meet Dan. Dan works as part of the Fiesta Engineering team and...

#. Log out of the local **admin** account and log back into **Prism Central** with Dan's credentials:

   - **User Name** - devuser01@ntnxlab.local
   - **Password** - nutanix/4u

#. Select the :fa:`bars` menu and note that you now have significantly restricted access to the environment.

#. On the **VMs** page, you should already see your *Initials*\ **-WinToolsVM** as available to be managed by Dan.

#. Select the VM and note Dan can get basic metrics associated with his VM, as well as control the VM configuration, power operations, and even delete the VM.

   .. figure:: images/29.png

   There are two workflows that could be followed for self-service creation of VMs: Traditional VM creation wizard and Calm. One of Dan's requirements is a Linux virtual machine that runs multiple tools required as part of his development workflow.

#. Click **Create VM** and fill out the following fields to provision a traditional virtual machine, similar to the manual VM deployment process Carol followed earlier in the lab:

   - **Create VM from** - Disk Images
   - **Select Disk Images** - Linux_ToolsVM.qcow2
   - **Name** - *Initials* -LinuxToolsVM
   - **Target Project** - *Initials* -FiestaProject
   - **Network** - *User Assigned VLAN*
   - **Categories** - Envrionment:Dev
   - Select **Manually configure CPU and Memory for this VM**
   - **CPU** - 2
   - **Cores Per CPU** - 1
   - **Memory** - 4 GiB

#. Click **Save** and note the VM is immediately powered on following creation.

   In addition to the tools VM, Dan also desires to deploy infrastructure that can be used to test new builds of the Fiesta application. Having end users deploy multi-tier applications through single-VM provisioning and manual integration is slow, inconsistent, and doesn't result in high user satisfaction - luckily we can leverage the pre-created Blueprint for Fiesta staged to our project by Carol.

#. Select :fa:`bars` **> Services > Calm**.

#. Select **Blueprints** from the left hand menu and open the **Fiesta-Multi** Blueprint.

   .. figure:: images/30.png

   .. note::

      If you're unfamiliar with Calm Blueprints, explore the following key components of the **Fiesta-Multi** Blueprint:

      - Select either the **NodeReact** or **MySQL** service and review the **VM** configuration in the configuration pane on the right hand of the screen.

         .. figure:: images/31.png

      - Select the **Package** tab and click **Configure Install** to view the installation tasks for the selected service. These are the scripts and actions associated with the configuration of each Service or VM.

         .. figure:: images/32.png

      - Under **Application Profile**, select **AHV** and view the variables defined for the Blueprint. Variables allow for runtime customization and can also be used on a per application profile basis to build a single application Blueprint that allows you to provision an application to multiple environments, including AHV, ESXi, AWS, GCP, and Azure.

         .. figure:: images/33.png

      - Select the **Create** Action under **Application Profile** to visualize dependencies between services. Dependencies can be defined explicitly, but depending on assignment of variables Calm will also identify implicit dependencies. In this Blueprint, you see the web tier installation process will not begin until the MySQL database is running.

         .. figure:: images/34.png

      - Click **Credentials** in the toolbar at the top of the Blueprint Editor and expand the existing **CENTOS** credential. Blueprints can contain multiple credentials which can be used to authenticate to VMs to execute scripts, or securely pass credentials directly into scripts.

         .. figure:: images/35.png

      - Click **Back**.

      If you're interested in building a Blueprint from scratch, check out <insert lab link here>.

#. Click **Launch** to provision an instance of the Blueprint.

   .. figure:: images/36.png

#. Fill out the following fields and click **Create**:

   - **Name of of the Application** - *Initials* -FiestaMySQL
   - **db_password** - nutanix/4u

   .. figure:: images/37.png

#. Select the **Audit** tab to monitor the deployment of the Fiesta development environment. Complete provisioning of the app should take approximately

   .. figure:: images/38.png

#. While the application is provisioning, open :fa:`bars` **> Administration > Projects** and select your project.

#. Review the **Summary**, **Usage**, **VMs**, and **Users** tabs to see what type of data is made available to users. These breakouts make it easy to understand on a per project, vm, or user level, what resources are being consumed.

   .. figure:: images/39.png

#. Return to **Calm > Applications >** *Initials*\ **-FiestaMySQL** and wait for the application to move from **Provisioning** to **Running**. Select the **Services** tab and select the **NodeReact** Service to obtain the IP of the web tier.

   .. figure:: images/40.png

#. Open \http://<*NodeReact-VM-IP*> in a new browser tab and validate the app is running.

   .. figure:: images/41.png

   By leveraging the built-in RBAC capabilities of Prism Central and Calm, Carol has enabled the engineering team...

Operator Workflows
++++++++++++++++++

Meet Ronald and Elise.

#. Log out of the **devuser01** account and log back into **Prism Central** with Ronald's credentials:

   - **User Name** - operator01@ntnxlab.local
   - **Password** - nutanix/4u

#. As expected, all VMs with **Environment** category values assigned are available. Note that you have no ability to **Create** or **Delete** VMs, but the abilities to power manage and change VM configurations are present.

   What else can be accessed by this user? Is Calm available?

   .. figure:: images/42.png

#. Log out of the **operator01** account and log back into **Prism Central** with Elise's credentials:

   - **User Name** - operator02@ntnxlab.local
   - **Password** - nutanix/4u

#. Note that only resources tagged with the **Team: Fiesta** category are available to be managed.

   .. figure:: images/43.png

#. Elise receives an alert that memory utilization is high on the **nodereact** VM. Update the configuration to increase memory and power cycle the VM.

Using Entity Browser, Search, and Analysis
++++++++++++++++++++++++++++++++++++++++++

#. Log out of the **operator02** account and log back into **Prism Central** with Carol's AD credentials:

   - **User Name** - adminuser01@ntnxlab.local
   - **Password** - nutanix/4u

#. Open :fa:`bars` **> Infrastructure > VMs**. Prism Central's **Entity Browser** provides a robust UI for sorting, searching, and viewing entities such as VMs, Images, Clusters, Hosts, Alerts, and more!

#. Select **Filters** and explore the available options. Specify the following example filters:

   - **Name** - Contains *Initials*
   - **Categories** - Team: Fiesta
   - **Hypervisor** - AHV
   - **Power State** - On

   Take notice of other helpful filters available such as VM efficiency, memory usage, and storage latency.

#. Select all of the filtered VMs and click the **Label** icon to apply a custom label to your group of filtered VMs (e.g. *Initials* AHV Fiesta VMs).

   .. figure:: images/44.png

#. Clear all filters and select your new label to quickly return to your previously identified VMs. Labels provide an additional means of taxonomy for entities, without tying them to specific policies as is with categories.

   .. figure:: images/45.png

#. Select the **Focus** dropdown to access different out of box views. Which view should be used to understand if your VMs are included as part of a DR plan?

#. Click **Focus > + Add Custom** to create a VM view (e.g. *XYZ-VM-View*) that displays **CPU Usage**, **CPU Ready Time**, **IO Latency**, **Working Set Size Read**, and **Working Set Size Write**. Such a view could be used to helping to spot VM performance problems.

   .. figure:: images/46.png

#. To fully appreciate the power of Prism Central of leveraging the Entity Browser in combination with Search & the Analysis page, view the following video:

   - <Embedded Atreyee video>

Improved Life Cycle Management
++++++++++++++++++++++++++++++

<Thiago's embedded, interative LCM demos for PE & PC>

Next Steps
++++++++++

In this lab we've explored who Prism Central can be used to enable critical functionality for multiple personas, including:

   - Simplified operations for virtual infrastructure owners
   - Categories
   - Projects
   - AD-integrated self-service for application developers and operators
   - Calm
   - EB/Search/Analysis

Continue to the following exercise to dive deeper into Prism Central's operational insights and smart datacenter automation capabilities!
