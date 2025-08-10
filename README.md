# Data-Wrangling-Using-SQL
This project demonstrates a full end-to-end data wrangling workflow using Microsoft SQL Server 
from raw data ingestion to a business-ready analytical layer. 
The process includes schema design, data cleaning, transformation, and preparation for reporting.


Tools Used
- Microsoft SQL Server : Data storage, querying, and transformation
- Draw.io : Data architecture and flow diagrams


# Project Structure

Scripts
- First Schema : Raw data ingestion into staging tables
- Second Schema : Data cleaning, transformation, and integration from the first schema
- Third Schema : Business-ready dimensional model for analytics and reporting

Tests
- Data quality checks performed on both Second and Third schemas:
- Null value checks
- Missing value identification
- Detection of unwanted or inconsistent values

Documents & Images
- Data Architecture Diagram : Visual overview of the system
- Data Flow Diagram : End-to-end process mapping
- Data Integration Diagram : How CRM and ERP data are merged
- Data Catalogue : Field-level documentation for all views

Steps
- Load raw data into the first Schema.
- Run the second Schema scripts to clean and standardize the data.
- Run the third Schema scripts to prepare the final dimensional model.
- Used and created the documents_and_img folder for reference.


Output
The final output is a star-schema-style dimensional model in the third schema, enabling:
- Customer profiling
- Product catalog & hierarchy reporting
- Sales transaction analysis

Datasets:
The datasets used in this project were sourced from Data with Baraa and represent a combination of CRM and ERP systems.

