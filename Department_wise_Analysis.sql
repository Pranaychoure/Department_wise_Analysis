create database Sep_3rd_week   ----Created database
use Sep_3rd_week               -----Selected database
select * from test_Details    -----Viewing the imported data
alter table [dbo].[Week_3]
add week int
update [dbo].[Week_3]
set week = 3                 -------Inserting a column in the table

Select Column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Week_3'   ---Viewing the all the header in Column (if i put one by one it will be time consuming)
DECLARE @cols NVARCHAR(MAX);
SELECT @cols = STRING_AGG(COLUMN_NAME, ', ')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'week_3';

PRINT @cols;                     ----making all the headers from column to row for easily pasting it down to the query

Select Distinct M.Bill_Dt, M.Week,  M.Visit_Id, M.Barcode, M.Patient_Name, M.Test_Name, M.Test_Code, M.CPRR, M.Ref_Doc_Name, M.pr_officer,
M.Ref_Doc_Created_On, M.Client_Name, M.Client_Code, M.Client_Type, M.Client_Category, 
M.Test_Rate, M.Total_B2B, M.Total_Paid, M.Test_wise_Paid, M.Territory_Name, M.Territory_Code, M.Sales_Person, T.[Department], P.[Department_tagging]
into Week_3_MIS_DATA from [dbo].[Week_3] as M
left join [dbo].[Test_details] as T on M.[Test_Code] = T.[Test_Code]
left join  [dbo].[Test_master] as P on T.[Department] = P.[department]  -----using a joins to mapping the master file data and after that creating a independent table for that table.

Select department_tagging as 'Department', count (test_code) as 'Count_of_tests' from Week_3_MIS_DATA
group by Department_tagging
order by count_of_tests DESC  ---Analysis Purpose-Department wise test data

Select top 10 Test_Name , count (test_code) as 'Count_of_tests' from Week_3_MIS_DATA
where department_tagging = 'TB'
group by test_name 
order by count_of_tests DESC   -----Top 10 tests from the department of TB

