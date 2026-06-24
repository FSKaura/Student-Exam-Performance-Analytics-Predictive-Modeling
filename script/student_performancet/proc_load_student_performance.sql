/*
================================================================
Stored procedure: Load student_performance lAYER (academic_result -> student_performance)
================================================================
Script purpose:
	This stored procedure perfores the ETL (Extract, Transfore, Load) process to populate the 'student_performance' Schema tables from the 'academic_result' Schema.
Actions perforemed:
	- Truncates student_performance table.
	- inserts transformed and cleansed data from academic_result into student_performance tables.

parameters:
	None.
	This stored procedure does not not accept any parameters or returen any values.

usage Example:
	EXEC student_performance.load_student_exam_scores
*/


--EXEC student_performance.load_student_exam_scores
CREATE OR ALTER PROCEDURE student_performance.load_student_exam_scores AS
BEGIN 
	BEGIN TRY
	DECLARE @start_time DATETIME, @end_time DATETIME;
			SET @start_time = GETDATE();
		PRINT 'Loading data into student_performance.student_exam_scores';
		PRINT 'TRUNCATING TABLE DEN RELOAD';
		TRUNCATE TABLE student_performance.student_exam_scores;	
		INSERT INTO student_performance.student_exam_scores (
		student_id,
		hours_studied,
		sleep_hours,
		attendance_percent,
		previous_scores,
		exam_score,
		cgpa,
		grade,
		result_status,
		academic_risk_level,
		study_sleep_balance
		)

		 SELECT
			student_id,
			hours_studied,
			sleep_hours,
			attendance_percent,
			previous_scores,
			exam_score,
			cgpa,
		 CASE
				WHEN cgpa >= 4.50 THEN 'A'
				WHEN cgpa >= 3.50 THEN 'B'
				WHEN cgpa >= 2.40 THEN 'C'
				WHEN cgpa >= 1.50 THEN 'D'
				ELSE 'F'
			END AS  grade,
			CASE
				WHEN cgpa >= 1.50 THEN 'Pass'
				ELSE 'Fail'
			END AS result_status,
			CASE
				WHEN attendance_percent < 60 OR hours_studied < 2 THEN 'High Risk'
				WHEN attendance_percent BETWEEN 60 AND 74 THEN 'Medium Risk'
				ELSE 'Low Risk'
			END AS academic_risk_level,
			CASE
				WHEN hours_studied >= 6 AND sleep_hours BETWEEN 7 AND 9 THEN 'Optimal'
				WHEN sleep_hours < 5 THEN 'Sleep Deprived'
				ELSE 'Imbalanced'
			END AS study_sleep_balance
			 FROM (
		SELECT
			*,
			CAST(((previous_scores + exam_score) / 2.0) / 100 * 5 AS DECIMAL(4,2)) AS cgpa
		FROM academic_result.student_exam_scores
		)t
		ORDER BY cgpa DESC

		
		

		SET @end_time = GETDATE()
		PRINT '>>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'sceonds'
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
