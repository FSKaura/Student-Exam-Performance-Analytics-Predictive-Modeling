/*
=======================================================
DDL Script: Create student_performancet Table
=======================================================
Script Pupose:
	This script creates tables in the 'student_performancet schema. dropping exixsting tables 
	If they already exixt.
	Run this script to re-define the DDL structure of student_performance tables
========================================================
*/


-- >>>>Inserting data into student_performance.student_exam_scores <<<<

IF OBJECT_ID('student_performance.student_exam_scores', 'U') IS NOT NULL
DROP TABLE student_performance.student_exam_scores;		-- If table name exists drop it
CREATE TABLE student_performance.student_exam_scores (
	student_id			NVARCHAR(50),
	hours_studied		DECIMAL(4,1),
	sleep_hours			DECIMAL(4,1),
	attendance_percent	DECIMAL(4,1),
	previous_scores		DECIMAL(5,1),
	exam_score			DECIMAL(5,1),
	cgpa				DECIMAL(5,2),
	grade				NVARCHAR(50),
	result_status		NVARCHAR(50),
	academic_risk_level NVARCHAR(50),
	study_sleep_balance NVARCHAR(50),
);
