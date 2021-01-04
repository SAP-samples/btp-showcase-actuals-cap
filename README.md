# Energy Consumption Actuals data E2E Demo 
Actuals consumption historical data.
This is database containing data loaded from a system of record (e.g. ERP) for consumption in DWC.
It consumes and exposes data from DWC and it must be deployed on a Space in CSP which is linked to a DWC HANA Cloud instance through the DevOps team.
This is a CAP project with a HANA project inside to develop tables, and an oData service available through a CAP application which consumes the database instance.

# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch` 
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.