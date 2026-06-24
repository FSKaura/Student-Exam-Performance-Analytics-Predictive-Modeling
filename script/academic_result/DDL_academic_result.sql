/*
=======================================================
DDL Script: Create Academic_result Table
=======================================================
Script Pupose:
	This script creates tables in the 'academic_result schema. dropping exixsting tables 
	If they already exixt.
	Run this script to re-define the DDl structure of the academic_result tables
========================================================
*/

--We are creating Table with the name academic_result
IF OBJECT_ID('academic_result.student_exam_scores', 'U') IS NOT NULL
DROP TABLE academic_result.student_exam_scores;		-- If table name exists drop it
CREATE TABLE academic_result.student_exam_scores (
	student_id			NVARCHAR(50),
	hours_studied		DECIMAL(4,1),
	sleep_hours			DECIMAL(4,1),
	attendance_percent	DECIMAL(4,1),
	previous_scores		DECIMAL(5,1),
	exam_score			DECIMAL(5,1),
);
