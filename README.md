## Sample 3-tier application for GCP provisioning exercise
  
This repository contains code to provision a simple 3-tier sample application to GCP app engine using Terraform as the provisioning engine. The application consists of a node.js client frontend, an express API, and a MySQL database. Once provisioned, the client should display successful connections to the api and database.
   
##### Instructions to set up the deployment for your environment:
1. Edit `stack.tf`. There are 3 value placeholders beginning with `EXAMPLE`. Replace the 'EXAMPLE' values with ones appropriate for your environment. Also in `stack.tf`, set your desired region in the `provider` stanza (we've left a default of `us-east1`)
2. Edit `vars.tf`. For each variable, add a value by assigning a default (eg: `default = some_value`)
3. Edit the node js api code at `./node/api/app.yaml`. Replace PROJECT, REGION, and STACK_NAME with your project, region, and stack_name.
4. Edit the node js api code at `./node/api/routes/testDB.js`. Locat the `var connection` declaration, and edit the `socketPath` as done in the last step.
5. In the same file, edit the database connection parameters (database, user, and password)
6. Add the password to google secret manager, with the name provided in your `vars.tf`
  
The application is now ready to be deployed with terraform. 
