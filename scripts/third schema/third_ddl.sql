/*
	***CREATE THIRD SCHEMA TABLES***
	From the first and second schema, 
	we collectively create views with:
	#Customers -- Dimension Table
	#Products  -- Dimension Table
	#Sales     -- Facts Table
	This third schema tables can be used for analysis and reporting.
*/

DROP VIEW IF EXISTS third.customer_dim;
GO
CREATE VIEW third.customer_dim AS
SELECT 
	 ROW_NUMBER() OVER(ORDER BY cst_id) as customer_index,
	 ci.cst_id as customer_id,
	 ci.cst_key as customer_key,
	 ci.cst_firstname as firstname,
	 ci.cst_lastname as lastname,
	 la.cntry as coutry,
	 ci.cst_marital_status as marital_status,
	 CASE
		 WHEN ci.cst_gndr<> 'n/a' THEN ci.cst_gndr
		 ELSE COALESCE(ca.gen,'n/a')
	 END as gender,
	 ca.bdate as birthdate,
	 ci.cst_create_date as create_date
FROM second.crm_cust_info ci
LEFT JOIN second.erp_cust_az12 ca
ON ci.cst_key=ca.cid
LEFT JOIN second.erp_loc_a101 la
ON ci.cst_key=la.cid;

GO


DROP VIEW IF EXISTS third.product_dim;
GO
CREATE VIEW third.product_dim AS
SELECT 
	  ROW_NUMBER() OVER(ORDER BY pi.prd_start_dt,pi.prd_key) as product_index,
	  pi.prd_id as product_id,
	  pi.prd_key as product_key,
	  pi.prd_nm as product_name,
	  pi.cat_id as category_id,
	  pc.cat as category,
	  pc.subcat as subcategory,
	  pc.maintenance as maintenance,
	  pi.prd_cost as cost,
	  pi.prd_line as product_line,
	  pi.prd_start_dt as product_start_date
FROM second.crm_prd_info pi
LEFT JOIN second.erp_px_cat_g1v2 pc
ON pi.cat_id=pc.id
WHERE pi.prd_end_dt IS NULL;
GO



DROP VIEW IF EXISTS third.sales_fact;
GO
CREATE VIEW third.sales_fact AS
SELECT 
	 sd.sls_ord_num as order_number,
	 prd.product_index as product_index,
	 cus.customer_index as customer_index,
	 sd.sls_order_dt as order_date,
	 sd.sls_ship_dt as shipping_date,
	 sd.sls_due_dt as due_date,
	 sd.sls_sales as sales_amount,
	 sd.sls_quantity as quantity,
	 sd.sls_price as price
FROM second.crm_sales_details sd
LEFT JOIN third.product_dim prd
ON sd.sls_prd_key=prd.product_key
LEFT JOIN third.customer_dim cus
ON sd.sls_cust_id=cus.customer_id;

