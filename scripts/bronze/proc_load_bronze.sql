/*
======================================================================
Stored Procedure: LKoad Bronze Layer (Source > Broinze)
======================================================================
Script Purpose;
	This stored procedure loads data into 'bronze' schema from external CSV files.
	it performs the following actions:
		- truncates the bronze tables before loading data.
		- uses the 'BULK INSERT' command to load data from CSV files to bronze tables.

Parameters:
	None.
	This stored procedure does not accept any parameters or return any values.

Usage Example:
	EXEC bronze.load_bronze;
======================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_b DATETIME, @end_time_b DATETIME;
	BEGIN TRY
	PRINT '===============================';
	PRINT 'Loading Bronze Layer';
	PRINT '===============================';
	SET @start_time_b = GETDATE();
	PRINT '-------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '-------------------------------';

	SET @start_time = GETDATE();
	--bronze.crm_cust_info
	PRINT '>> Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT '>> Inserting Data: bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM  'C:\Users\sakda\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2, --skip first row because first row in crm_cust_info.csv is heading
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>> --------------------'


	SET @start_time = GETDATE();
	--bronze.crm_prd_info
	PRINT '>> Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;

	PRINT '>> Inserting Data: bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM  'C:\Users\sakda\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2, --skip first row because first row in crm_cust_info.csv is heading
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>> --------------------'
	

	SET @start_time = GETDATE();
	--bronze.crm_sales_details
	PRINT '>> Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;

	PRINT '>> Inserting Data: bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM  'C:\Users\sakda\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2, --skip first row because first row in crm_cust_info.csv is heading
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>> --------------------'


	PRINT '-------------------------------';
	PRINT 'Loading ERP Tables';
	PRINT '-------------------------------';

	SET @start_time = GETDATE();
	--bronze.erp_cust_az12
	PRINT '>> Truncating Table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;

	PRINT '>> Inserting Data: bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM  'C:\Users\sakda\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
	WITH (
		FIRSTROW = 2, --skip first row because first row in erp_cust_az12.csv is heading
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>> --------------------'


	SET @start_time = GETDATE();
	--bronze.erp_loc_a101
	PRINT '>> Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;

	PRINT '>> Inserting Data: bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	FROM  'C:\Users\sakda\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
	WITH (
		FIRSTROW = 2, --skip first row because first row in loc_a101.csv is heading
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>> --------------------'


	SET @start_time = GETDATE();
	--bronze.erp_px_cat_g1v2
	PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;

	PRINT '>> Inserting Data: bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM  'C:\Users\sakda\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2, --skip first row because first row in px_cat_g1v2.csv is heading
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>> --------------------'

	SET @end_time_b = GETDATE();
	PRINT '>> Bronze Layer Load Duration:'+CAST(DATEDIFF(second,@start_time_b,@end_time_b) AS NVARCHAR) + 'seconds'
	END TRY
	BEGIN CATCH
		PRINT '=============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=============================================='
	END CATCH
END
