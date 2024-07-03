# sql-projects


## Introduction
Welcome to my SQL projects repository! This repository contains a collection of SQL scripts and queries that demonstrate my proficiency in SQL using the AdventureWorks2014 database. AdventureWorks2014 is a sample database provided by Microsoft, which simulates a manufacturing company.

## Table of Contents
* Introduction
* Prerequisites
* Installation
* Usage
* Project Structure
* Contributing
* License
* Contact

## Prerequisites
Before you begin, ensure you have the following prerequisites installed:

* SQL Server (2014 or later)
* SQL Server Management Studio (SSMS) or any other SQL client
* AdventureWorks2014 database

## Installation

1. Download and Install SQL Server: You can download SQL Server from the Microsoft website.

2. Download and Install SSMS: Get SQL Server Management Studio from the Microsoft website.

3. Download AdventureWorks2014: You can download the AdventureWorks2014 database from the Microsoft SQL Server Samples repository.

4. Restore the AdventureWorks2014 Database: Use SSMS to restore the downloaded AdventureWorks2014 backup file.

```sql Copy code
RESTORE DATABASE AdventureWorks2014
FROM DISK = 'path_to_your_backup_file.bak'
WITH MOVE 'AdventureWorks2014_Data' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014.mdf',
     MOVE 'AdventureWorks2014_Log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014.ldf';
```

## Usage
To get started with the SQL scripts and queries in this repository, follow these steps:

Clone the repository:

```bash
Copy code
git clone https://github.com/yourusername/adventureworks2014-sql-projects.git
cd adventureworks2014-sql-projects
```

Open SSMS and connect to your SQL Server instance.

Open a new query window and load one of the provided SQL scripts.

Execute the script to see the results.

## Project Structure
The repository is structured as follows:

Copy code
.
├── README.md
├── LICENSE
├── queries
│   ├── sales_analysis.sql
│   ├── employee_performance.sql
│   ├── product_inventory.sql
│   └── customer_segmentation.sql
├── procedures
│   ├── usp_get_sales_by_region.sql
│   ├── usp_get_top_customers.sql
│   └── usp_get_employee_sales_performance.sql
└── views
    ├── vw_sales_overview.sql
    ├── vw_product_performance.sql
    └── vw_customer_activity.sql
    
queries/: Contains individual SQL query scripts demonstrating various analyses and operations.
procedures/: Contains SQL scripts for stored procedures that encapsulate complex business logic.
views/: Contains SQL scripts for creating views that provide simplified access to complex queries.

## Contributing
Contributions are welcome! If you have suggestions for improvements or additional queries/procedures/views, feel free to open an issue or submit a pull request.

Fork the repository.
Create your feature branch (git checkout -b feature/AmazingFeature).
Commit your changes (git commit -m 'Add some AmazingFeature').
Push to the branch (git push origin feature/AmazingFeature).
Open a pull request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Contact
If you have any questions or feedback, please contact me at [patrickmckown@outlook.com].

