/*
    ***CREATE first Schema Tables***
	FROM SOURCE_CRM : cust_info, prd_info, sales_details
	FROM SOURCE_ERP : erp_cust_az12, erp_loc_a101, erp_px_cat_g1v2
	Note:NVARCHAR is used to retrieve wide range of characters,
	     especially with large datasets.
*/

DROP TABLE IF EXISTS first.crm_cust_info;
CREATE TABLE first.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

DROP TABLE IF EXISTS first.crm_prd_info;
CREATE TABLE first.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt NVARCHAR(50),
	prd_end_dt DATE
);

DROP TABLE IF EXISTS first.crm_sales_details;
CREATE TABLE first.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt NVARCHAR(50),
	sls_ship_dt NVARCHAR(50),
	sls_due_dt NVARCHAR(50),
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

DROP TABLE IF EXISTS first.erp_cust_az12;
CREATE TABLE first.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
);

DROP TABLE IF EXISTS first.erp_loc_a101;
CREATE TABLE first.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);

DROP TABLE IF EXISTS first.erp_px_cat_g1v2;
CREATE TABLE first.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);