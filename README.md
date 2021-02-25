[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/btp-showcase-forecast)](https://api.reuse.software/info/github.com/SAP-samples/btp-showcase-forecast)

# SAP Business Technology Platform Showcase: Access SAP HANA Cloud Database Underneath SAP Data Warehouse Cloud

# Description

This project creates an SAP HANA Deployment Infrastructure (aka HDI) container on SAP HANA Cloud and persist actual sales data originated from an external system in the same SAP Data Warehouse Cloud’s existing persistence area. We will show how to provide bi-directional access between SAP Data Warehouse Cloud and SAP HANA Cloud’s managed datasets, and also how to expose SAP HANA Cloud and SAP Data Warehouse Cloud’s artifacts, like a table or a Graphical View, as oData services.

This project is part of the [SAP Business Technology Platform Showcase – Overall End-to-End Demo](https://blogs.sap.com/2021/01/27/sap-business-technology-platform-showcase-overall-end-to-end-demo/) blog.

## Requirements

* SAP HANA Cloud
* SAP Data Warehouse Cloud
* SAP Analytics Cloud

If you still don’t have an SAP account for starting your developments, don’t worry… SAP is providing you with a completely free SAP trial account (https://saphanajourney.com/free-trial/), so you can join our network and get access to all SAP BTP solutions (SAP HANA Cloud. SAP Data Warehouse Cloud, SAP Analytics Cloud) required for you to implement all projects & artifacts presented in this blog,

## Download and Installation

You can just clone this project and deploy it in any SAP HANA Cloud instance.

# Documentation for: Use CAP to consume DWC tables/views and expose HDI tables/views as OData Services

This project serves an example where we can use a [Cloud Application Programming model (CAP)](https://cap.cloud.sap/docs/about/) to

1. Consume DWC views as synonyms and use them to do further development – like building HANA calculation view
2. Expose the calculation view built from DWC view as an OData Service
3. Create a new HANA table and expose it as an OData Service.

## Prerequisites

1. Data Warehouse Cloud (DWC) with SAP HANA Cloud
2. SAP Cloud Platform (SCP) linked to the DWC SAP HANA Cloud
3. Business Application Studio (BAS).

## Data Warehouse Cloud Setup

1. We assume, a DWC space with an underlying HANA Cloud is available:

![](/images/DWC_Space.png)

2. A database user is created under the DWC space and the credentials can be copied later to be used to create a user-define service in SCP:

Database User:

![](/images/DWC_DB_user.png)

To get the credentials -> Click on the right most information icon of the Database user

![](/images/DWC_DB_user_credentials.png)

3. You have the database id of the DWC -> can be found in the information section at the left bottom corner in the DWC main page:

![](/images/DWC_DB_Id.png)

4. A graphical view has been created in DWC:

![](/images/DWC_Graphical_View.png)

## SAP Cloud Platform Setup

For SCP, we assume you have a space available in SCP account and it is connected to the DWC's HANA Cloud instance.
Here, you create a user-provided service in the space to access the DWC database user. Use the json credentials from the DWC Database user for the json parameters.

![](/images/SCP_UserProvidedService.png)

## Development Environment - Business Application Studio

Business Application Studio will be used as the development environment to create the application.

### Create a Dev Space in BAS

Create a Dev Space of any name and type &quot;Cloud Business Application&quot; and add the extensions for

1. SAP HANA Calculation View Editor 2. SAP HANA Database Explorer 3. SAP HANA Tools.

![](/images/BAS_DevSpace.png)

The dev space will be created and will be in RUNNING state in few mins:

![](/images/BAS_DevSpace_Running.png)

Click on the dev space to open the development environment.

![](/images/BAS_EmptyDevSpaceEnvironment.png)

At the bottom of the screen we notice it highlights – &quot;The organization and space in CF have not been set&quot;.

### Add Cloud Foundry as the target in BAS

Now, we add our SCP Cloud Foundry Space as a target Use View -> Find Command to find the command to create New Cloud Foundry target:

![](/images/BAS_CloudFoundryCommand.png)

Enter all the subsequent details to be connected to the cloud foundry space – the same space where you create your user-defined service in SCP. Now at the bottom on BAS, you should be able to see you are connected to the Cloud Foundry Space:

![](/images/BAS_CloudFoundryConnected.png)

Business Application Studio is now connected to your Cloud Foundry Space and we can proceed to create our project.

### Create a CAP project

From the welcome page of BAS, choose to create a new project from Template:

![](/images/BAS_Welcome.png)

The choose CAP Project:

![](/images/BAS_ProjectFromTemplate.png)

For creating a CAP project, enter a project name and check all the options adding features to the project:

![](/images/BAS_CAP_EnterProjectDetails.png)

Once the project is created, choose to open the project in a new Workspace:

![](/images/BAS_OpenProjectInWorkspace.png)

The above project will create the structure of the project with db (for creating all db related artefacts which will deployed in your HDI container), srv (to create any odata service) and app (for UI application development) folder and the mta.yaml file (this file is used to define all the elements of your project and also the dependencies):

![](/images/BAS_ProjectStructure.png)

#### mta.yaml

The default mta.yaml file after the project creation looks like the below:

It contains a &quot;modules&quot; section for SERVER (srv) and SIDECAR (db) modules. Modules section is a set of code or content which needs to be deployed to a specified location.

It also contains a &quot;resources&quot; section - Something required by the MTA at run time but not provided by the MTA, for example, a managed service or an instance of a user-provided service. Here we can see if specifies an HDI container service name which will be needed by MTA to deploy the DB artefacts.

![](/images/Initial_mta_yaml.png)

#### Prepare your project to access DWC

Since we need to access the DWC database and the SCP user-provided service for cross container access, we add them to the resources section of the mta.yaml file.

Modify the mta.yaml file to add the database id of the DWC as a dependent resource for your HDI container. And also add the SCP user-defined service as an existing service:

![](/images/BAS_mta_yaml_DWCDependency.png)

### Consume DWC view in CAP Project

We have created a graphical view in DWC which needs to access by our HDI container. Here, we follow the cross container access method to be able to use the DWC view in our environment. All the DB related objects will be created under db folder. You can create separate folders under "db" folder to organize the files accordingly.

#### Create a hdbsynonymconfig file

Create a hdbsynonymconfig file (DWC_ACCESS.hdbsynonymconfig)

![](/images/HDB_SynonymConfig.png) 

#### Create a hdbgrants file

To give privileges to the owner of the synonym object, we need to create hdbgrants file (DWC_ACCESS.hdbgrants)

![](/images/HDBGrants.png)

#### Create a synonym object
DWC_ACCESS.hdbsynonym

![](/images/HDB_Synonym.png)

#### Create an access role to expose the synonym

default_access_role.hdbsynonym

![](/images/HDB_RoleDWCSynonym.png)

Now the above synonym is available to be used in any of the development artifacts.

#### Create a calculation view based on the synonym

Create a simple calculation view with aggregation node and add the synonym as a data source to the node -\&gt; mark few columns as attributes and measures and activate the calculation view.

We will then later expose this calculation view as an OData Service (CV_EN_CONS_X_PROD_ACTUALS.hdbcalculationview).

![](/images/BAS_CalculationView.png)

### Create a new table in your project

#### Create an HDB Table

(E_CONS_ACTUALS_HDI.hdbtable):

![](/images/HDB_Table.png)

#### Create HDB Roles to allow access to the HDB Table to other containers

1. DWC\_CONSUMPTION\_ROLE.hdbrole

![](/images/HDB_ConsumptionRole.png) 

1. DWC\_CONSUMPTION\_ROLE\_G.hdbrole  this role has the WITH GRANT option

![](/images/HDB_ConsumptionRole_WithGrant.png)

Now we have all the artefacts created in our development environment and we need to expose them as OData services to the outside world.

To expose the HANA tables/views as OData service, we need to use them in a CDS Model ([https://cap.cloud.sap/docs/advanced/hana](https://cap.cloud.sap/docs/advanced/hana)).

### Create a CDS Model in your Project

Create a new file in the db folder, and name is schema.cds

Use the annotation @cds.persistence.exists to tell CDS that this object already exists on the database and must not be generated.

Here in this example, we are defining a namespace dwc.odata.

![](/images/HDB_CDS_Entity.png) 

Now we expose the above 2 entities as OData service.

### Create a CDS Service to expose the entities as OData Service

 Create a file under the "srv" folder as service.cds

 ![](/images/HDB_CDS_Service.png)

### Prepare your CAP project for HANA Cloud

On SAP HANA Cloud, CDS models are deployed through the hdbtable and hdbview formats instead of hdbcds. Edit your _package.json_ to [set the deploy-format to hdbtable](https://cap.cloud.sap/docs/guides/databases#hana-cloud).
 Add the following highlighted part in the &quot;cds&quot; section of package.json.

 ![](/images/HDB_PackageJSON.png)

The Final Structure of the project would look like this:

![](/images/BAS_FinalStructure.png)

### Deploy the application to SCP

Now we have the project created with all relevant objects, prepared it for deployment of the DB objects on HANA Cloud. Now we need to deploy the application to SCP. To do that, open a new terminal

![](/images/BAS_OpenTerminal.png)

#### Execute the following commands in the terminal:

Build Project:

- export NODE\_ENV=production
- cds build/all –clean

Create HDI container (project name-db) in SCP's HANA Cloud – name can also be found in the mta.yaml file:

- cf create-service hana hdi-shared dasc-showcase-actuals-cap-db

The execute the following 2 commands to deploy the db folder and srv folder respective in SCP

- cf push -f gen/db -k 256M

  --The above command will deploy your db folder artefacts (tables/views) to your HDI container

- cf push -f gen/srv --random-route -k 320M

  --This command will deploy your application exposing it as OData service and will generate a random application url

Once the above commands are successful, you can go to your space in SCP and check the applications and the HDI container created:

#### HDI Container in SCP

In the Service Instances section we can find the HDI container has been created and has both the db and srv applications bound to it.

![](/images/SCP_HDIContainer.png)

#### Deployed Applications in SCP

In the Applications section of the SCP space, we can see the db and the srv applications we created:

![](/images/SCP_DeployedApplications.png)

To launch the application, you can get the url from the srv application -> click on it: 
![](/images/SCP_srv_application.png)

Click on the above application route, and it will take you to the OData services:

![](/images/SCP_OdataService.png)

You can now view the data by clicking the object name above:

![](/images/OdataService_Data.png)

## Known Issues

No known issues identified.

## How to obtain support

[Create an issue](https://github.com/SAP-samples/btp-showcase-actuals-cap/issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

## Contributing

Feel free to comment in the [SAP Business Technology Platform Showcase – Overall End-to-End Demo](https://blogs.sap.com/2021/01/27/sap-business-technology-platform-showcase-overall-end-to-end-demo/) blog.

## License
Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.
