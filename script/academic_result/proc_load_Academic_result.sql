/*
=============================================================
Stored procedure: Load academic_result Layer (Source -> academic_result)
=============================================================
Script Pupose:
	This stored procedure loads data into the 'academic_result' schema from external CSV files.
	It performs the following actions:
	- Truncates the academic_result tables before loading data.
	- Uses the 'BULK INSERT' command to load data from csv files to bronze tables

Parameters:
	none.
	This stored procedure does not accept any parameters or return any values.

usage Example:
	EXEC academic_result.load_academic_result;
==============================================================
*/

CREATE OR ALTER PROCEDURE academic_result.load_academic_result AS 
 BEGIN
	 BEGIN TRY
		  DECLARE @start_time DATETIME, @end_time DATETIME

			SET @start_time = GETDATE()

			PRINT '=========================';
			PRINT 'TRUNCATE TABLE academic_result.student_exam_scores';
			PRINT '=========================';
			TRUNCATE TABLE academic_result.student_exam_scores 
			PRINT '=========================';
			PRINT 'BULK INSERTING: academic_result.student_exam_scores';
			PRINT '=========================';
			BULK INSERT academic_result.student_exam_scores 
			FROM 'C:\Users\f\Documents\FSK\student_result\student_exam_scores.csv'
			WITH (
				FIRSTROW	= 2,
				FIELDTERMINATOR		= ',',
				ROWTERMINATOR = '0x0a',
				TABLOCK
			)
			SET @end_time = GETDATE()
			PRINT 'Loading Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)+ 'seconds'
		END TRY
		BEGIN CATCH
			PRINT '=========================';
			PRINT 'CONTROLLING ERROR MESSAGE';
			PRINT 'ERROR MESSEGE: ' + ERROR_MESSAGE()
			PRINT 'ERROR MESSEGE: ' + CAST(ERROR_NUMBER() AS NVARCHAR)
			PRINT 'ERROR MESSEGE: ' + CAST(ERROR_STATE() AS NVARCHAR)
			PRINT '=========================';
		END CATCH
END
