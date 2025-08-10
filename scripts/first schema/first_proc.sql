/*
	***CREATE A PROCEDURE TO INSERT DATA TO THE FIRST SCHEMA TABLES***
	TRUNCATE AND INSERT METHOD IS FOLLOWED
	ERROR HANDLING IS DONE

*/

CREATE OR ALTER PROCEDURE first.loading_data AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		SET @start_time=GETDATE();
		TRUNCATE TABLE first.crm_cust_info;
		PRINT 'Inserting Records to crm_cust_info...'
		BULK INSERT first.crm_cust_info
		FROM "C:\Users\Deha\Desktop\sql-project01\sql_dw\datasets\source_crm\cust_info.csv"
		WITH ( FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
		);

		TRUNCATE TABLE first.crm_prd_info;
		PRINT 'Inserting Records to crm_prd_info...'
		BULK INSERT first.crm_prd_info
		FROM "C:\Users\Deha\Desktop\sql-project01\sql_dw\datasets\source_crm\prd_info.csv"
		WITH ( FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
		);

		TRUNCATE TABLE first.crm_sales_details;
		PRINT 'Inserting Records to crm_sales_details...'
		BULK INSERT first.crm_sales_details
		FROM "C:\Users\Deha\Desktop\sql-project01\sql_dw\datasets\source_crm\sales_details.csv"
		WITH ( FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
		);

		TRUNCATE TABLE first.erp_cust_az12;
		PRINT 'Inserting Records to erp_cust_az12...'
		BULK INSERT first.erp_cust_az12
		FROM "C:\Users\Deha\Desktop\sql-project01\sql_dw\datasets\source_erp\CUST_AZ12.csv"
		WITH ( FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
		);

		TRUNCATE TABLE first.erp_loc_a101;
		PRINT 'Inserting Records to erp_loc_a101...'
		BULK INSERT first.erp_loc_a101
		FROM "C:\Users\Deha\Desktop\sql-project01\sql_dw\datasets\source_erp\LOC_A101.csv"
		WITH ( FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
		);

		TRUNCATE TABLE first.erp_px_cat_g1v2;
		PRINT 'Inserting Records to erp_px_cat_g1v2...'
		BULK INSERT first.erp_px_cat_g1v2
		FROM "C:\Users\Deha\Desktop\sql-project01\sql_dw\datasets\source_erp\PX_CAT_G1V2.csv"
		WITH ( FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
		);

		PRINT 'Loaded all data to the tables successfully.'

		SET @end_time=GETDATE()
		PRINT 'Time Taken to Load Data:' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+ 'seconds';
		END TRY
		BEGIN CATCH
			PRINT 'ERROR OCCURED WHILE LOADING DATA INTO FIRST SCHEMA';
			PRINT 'Error:'+ 'ERROR_MESSAGE()';
			PRINT 'Error:'+ CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'Error:'+ CAST(ERROR_STATE() AS NVARCHAR);
		END CATCH
END


