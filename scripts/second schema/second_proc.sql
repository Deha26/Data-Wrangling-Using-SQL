CREATE OR ALTER PROCEDURE second.loading_data1 AS
BEGIN
	 DECLARE @start_time DATETIME,@end_time DATETIME;
	 BEGIN TRY
		SET @start_time=GETDATE();
		------------------------------------

		TRUNCATE TABLE second.crm_cust_info;
		INSERT INTO second.crm_cust_info( 
			cst_id, 
			cst_key, 
			cst_firstname,
			cst_lastname,
			cst_marital_status,
			cst_gndr,
			cst_create_date
		)
		SELECT 
			cst_id, cst_key,
			TRIM(cst_firstname) as cst_firstname, TRIM(cst_lastname) as cst_lastname,
			CASE UPPER(TRIM(cst_marital_status))
				 WHEN 'M' THEN 'Married'
				 WHEN 'S' THEN 'Single'
				 ELSE 'N/A'
			END as cst_marital_status,
			CASE UPPER(TRIM(cst_gndr))
				 WHEN 'M' THEN 'Male'
				 WHEN 'F' THEN 'Female'
				 ELSE 'N/A'
			END as cst_gndr,
			cst_create_date
		FROM(
			SELECT *,
			ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date) AS ranking
			FROM first.crm_cust_info
			WHERE cst_id IS NOT NULL
			)temp
		WHERE ranking=1;

		-------------------------------------

		TRUNCATE TABLE second.crm_prd_info;
		INSERT INTO second.crm_prd_info( 
			prd_id,
			cat_id,
			prd_key,
			prd_nm,
			prd_cost,
			prd_line,
			prd_start_dt,
			prd_end_dt
		)
		SELECT 
			prd_id,
			REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
			SUBSTRING(prd_key,7,len(prd_key)) as prd_key,
			prd_nm,
			ISNULL(prd_cost,0) as prd_cost,
			CASE UPPER(TRIM(prd_line))
				 WHEN 'R' THEN 'Road'
				 WHEN 'T' THEN 'Touring'
				 WHEN 'M' THEN 'Mountain'
				 WHEN 'S' THEN 'Others'
				 ELSE 'N/A'
			END as prd_line,
			CAST(prd_start_dt AS DATE) as prd_start_dt,
			CAST(
				DATEADD(DAY,-1,
				LEAD(CAST(prd_start_dt as DATE)) OVER(PARTITION BY prd_key ORDER BY CAST(prd_start_dt AS DATE)))
			AS DATE) as prd_end_date
		FROM first.crm_prd_info;

		-----------------------------------------

		TRUNCATE TABLE second.crm_sales_details;
		INSERT INTO second.crm_sales_details(
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,
			sls_quantity,
			sls_price
		)
		SELECT sls_ord_num, sls_prd_key, sls_cust_id,
			   CASE 
					WHEN sls_order_dt='0' OR LEN(sls_order_dt)<>8 THEN NULL
					ELSE CAST(sls_order_dt AS DATE)
			   END AS sls_order_dt,
			   CASE 
					WHEN sls_ship_dt='0' OR LEN(sls_ship_dt)<>8 THEN NULL
					ELSE CAST(sls_ship_dt AS DATE)
			   END AS sls_ship_dt,
			   CASE 
					WHEN sls_due_dt='0' OR LEN(sls_due_dt)<>8 THEN NULL
					ELSE CAST(sls_due_dt AS DATE)
			   END AS sls_due_dt,
			   CASE 
					WHEN sls_sales IS NULL OR sls_sales<=0 OR sls_sales<>sls_quantity*abs(sls_price) THEN sls_quantity*abs(sls_price)
					ELSE sls_sales
			   END AS sls_sales,
			   sls_quantity,
			   CASE 
					WHEN sls_price IS NULL OR sls_price<=0 THEN sls_sales/NULLIF(sls_quantity,0)
					ELSE sls_price
			   END AS sls_price
			FROM first.crm_sales_details;


		----------------------------------------

		TRUNCATE TABLE second.erp_cust_az12;
		INSERT INTO second.erp_cust_az12(
			cid,
			bdate,
			gen
		)
		SELECT 
			  CASE 
				  WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
				  ELSE cid
			  END AS cid,
			  CASE 
				  WHEN bdate > GETDATE() THEN NULL
				  ELSE bdate
			  END AS bdate,
			  CASE gen
				  WHEN 'M' THEN 'Male'
				  WHEN 'F' THEN 'Female'
				  ELSE 'N/A'
			  END AS gen
		FROM first.erp_cust_az12;

		TRUNCATE TABLE second.erp_loc_a101;
		INSERT INTO second.erp_loc_a101(
			cid,
			cntry
		)
		SELECT 
			  REPLACE(cid,'-','') as cid,
			  CASE 
				  WHEN TRIM(cntry)='DE' THEN 'Germany'
				  WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
				  WHEN TRIM(cntry)='' OR TRIM(cntry) IS NULL THEN 'N/A'
				  ELSE TRIM(cntry)
			  END AS cntry
		FROM  first.erp_loc_a101;


		---------------------------------------

		TRUNCATE TABLE second.erp_px_cat_g1v2;
		INSERT INTO second.erp_px_cat_g1v2(
			id,
			cat,
			subcat,
			maintenance
		)
		SELECT id,
			   cat,
			   subcat,
			   maintenance
		FROM first.erp_px_cat_g1v2;

		SET @end_time=GETDATE();

	END TRY
	BEGIN CATCH
		PRINT 'ERROR OCCURED WHILE LOADING DATA INTO FIRST SCHEMA';
			PRINT 'Error:'+ 'ERROR_MESSAGE()';
			PRINT 'Error:'+ CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'Error:'+ CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH
END




