/*
===============================================================
DDL Script: create education_analytics Views
===============================================================

Script purpose:
		The script create Views for the education_analytics Layer in the students_results
		The education_analytics layer represents the final analysis all we have do

		The view performs transformations and conbines data from the final_performace layer
		to produce a clean, enriched, and business ready dataset.

	Usage:
		- These Views can be queried directly for analytics and reporting
=================================================================
*/


CREATE OR  ALTER VIEW education_analytics.final_performace as
WITH Final_step as (
SELECT 
	student_id											AS Matriculation_Number,
	hours_studied										AS Hours_Studied,
	sleep_hours											AS Sleep_Hours,
	attendance_percent									AS Attendance_Percent,
	CAST((previous_scores / 100.0) * 5 AS DECIMAL(4,2)) AS Previous_Score,
    CAST((exam_score / 100.0) * 5 AS DECIMAL(4,2))		AS Exam_Score,
	cgpa												AS CGPA,
	grade												AS Grade,
	result_status										AS Result_Status,
	academic_risk_level									AS academic_risk_evel,
	CAST((cgpa / 5.0) * 100 AS DECIMAL(5,2))			AS Performance_Index,
	study_sleep_balance									AS Study_Sleep_Balance			
FROM student_performance.student_exam_scores
)
SELECT 
*,
  CAST(
        ROUND(
            COUNT(*) OVER (PARTITION BY grade) * 100.0
            / COUNT(*) OVER (),
        2)
    AS DECIMAL(5,2))									AS Grade_Percentage,

RANK() OVER (ORDER BY CGPA DESC)						AS cgpa_rank,
CAST(ROUND(AVG(CGPA) OVER (), 2) AS DECIMAL(5,2))		AS Cohort_AverageCgpa
FROM Final_step
