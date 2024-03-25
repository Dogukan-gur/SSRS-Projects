In this project main aim is to develop certain reports that are actively used by different parts of the organization.
Required data is taken from the production database by SSIS.
![ETL_1](https://github.com/Dogukan-gur/SSRS-Projects/assets/117075526/42e46e9e-ac1d-41cf-bbdf-91a745f94ed7)

Tables in the production database are not taken directly, data are taken by SQL queries.
![etl_katmanlar_sorguekranı](https://github.com/Dogukan-gur/SSRS-Projects/assets/117075526/446555ed-ef2e-43dd-8fee-1be078fb1386)


In this pipeline, all data flow tasks contain lookups to take up-to-date data and in some tasks, data need to be changed or need to be updated therefore additional SQL Tasks and/or lookups are introduced. 
![ETL_kopf_detay](https://github.com/Dogukan-gur/SSRS-Projects/assets/117075526/587a1af1-0829-45e0-bbdd-102501ca194a)
![etl_güncelleme örneği](https://github.com/Dogukan-gur/SSRS-Projects/assets/117075526/b0241a7a-f583-48f4-bf6f-7f04f3ca861b)


In order to increase the performance of the reports procedures are introduced to the system.![ssms-2](https://github.com/Dogukan-gur/SSRS-Projects/assets/117075526/51130fa1-6474-4d6f-89b2-426ad9079adf)
