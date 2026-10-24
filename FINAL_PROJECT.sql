Create DATABASE FINAL;

USE FINAL;

Create table Data_Set (
Patient_iD int not null,
Patient_name varchar (25) not null,
Age int not null,
Gender char (1) Check (Gender In ('M','F')),
DOB date,
Address varchar (200) not null,
Contact_details varchar (25) not null,
Doctor_name varchar (25) not null,
Doctor_iD varchar (20) not null,
NPI varchar (30),
Tax_iD varchar (15),
Facility varchar (20),
Total_amount Decimal (12,2) not null,
Paid_amount decimal (12,2) not null,
Mode_of_payment varchar (10) not null,
Admission_date date,
Occupation varchar (100) not null,
Amount_paid_by_insurance decimal (12,2) not null,
Insurance varchar (20),
Primary key (Patient_iD)
);

Select count(*) from final_set;

rename table final_set to FINAL_TABLE;

Alter table final_table
rename column ï»¿Patient_ID to Patient_iD,
rename column Amount_Paid_By_Insurance to APBI;

Select sum(Patient_iD is null) as Patient_iD_NULL,
sum(Patient_Name is null) as Patient_Name_NULL,
sum(Gender is null) as Gender_NULL,
sum(Age is null) as Age_NULL,
sum(DOB is null) as DOB_NULL,
sum(Address is null) as Address_NULL,
sum(Contact_Details is null) as Contact_Details_NULL,
sum(Doctor_Name is null) as  Doctor_Name_NULL,
sum(Doctor_ID is null) as Doctor_ID_NULL,
sum(NPI is null) as NPI_NULL,
sum(Tax_ID is null) as  Tax_ID_NULL,
sum(Facility is null) as Facility_NULL,
sum(Admission_Date is null) as Admission_Date_NULL,
sum(Occupation is null) as Occupation_NULL,
sum(Insurance is null) as Insurance_NULL,
sum(Total_Amount is null) as Total_Amount_NULL,
sum(Paid_Amount is null) as Paid_Amount_NULL,
sum(APBI is null) as APBI_NULL,
sum(Mode_of_Payment is null) as Mode_of_Payment_NULL
from final_table;

Select min(age) as Minimum_age,
max(age) as Maximum_age,
round(avg(age),2) as Average_age
from final_table;

Describe data_set;

Select Gender, count(*) as Total_Count from final_table
group by Gender;

select min(Admission_Date) as Earliest_admission,
max(Admission_Date) as Latest_admission from final_table;

SELECT 
    MIN(Total_Amount) AS Minimum_Amount,
    MAX(Total_Amount) AS Maximum_amount,
    MIN(Paid_Amount) AS Minimum_paid,
    MAX(Paid_Amount) AS Maximum_paid,
    MIN(APBI) AS Minimum_APBI,
    MAX(APBI) AS Maximum_APBI
    from final_table;
    
    Select Patient_iD, Total_Amount, Paid_Amount from final_table
    where Paid_Amount > Total_Amount;
    
    Select Patient_iD, Total_Amount, APBI from final_table
    where APBI > Total_Amount;
    
    Select Mode_of_Payment, count(*) as Total_Count from final_table
    group by Mode_of_Payment
    order by Total_Count DESC;
    
    Select Patient_iD, Patient_Name, Mode_of_Payment, Total_Amount, Paid_Amount from final_table
    where Mode_of_Payment is Null
    or TRIM(Mode_of_Payment);
    
    Select Insurance, count(*) as Total_Count from final_table
    group by Insurance
    Order by Total_Count DESC;
    
    Select Doctor_Name, count(*) as Total_count from final_table
    group by Doctor_Name
    order by Total_count DESC;
    
    Select Facility, count(*) as Total_count from final_table
    group by Facility
    order by Total_count DESC;
    
    Select NPI, length(Trim(NPI)) as NPI_Length,
    count(*) as Total_Count from final_table
    group by NPI, length(Trim(NPI))
    order by Total_Count DESC;
    
    Select Tax_ID, length(Trim(Tax_ID)) as Tax_ID_Length,
    count(*) as Total_Count from final_table
    group by Tax_ID, length(Trim(Tax_ID))
    order by Total_Count DESC;
    
    Select Contact_Details, length(Trim(Contact_Details)) as Contact_Details_Length,
    count(*) as Total_Count from final_table
    group by Contact_Details, length(Trim(Contact_Details))
    order by Total_Count DESC;
    
    SELECT
    Patient_iD,
    DOB,
    Age,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Calculated_Age
FROM `final_table`
WHERE ABS(
    Age - TIMESTAMPDIFF(YEAR, DOB, CURDATE())
) > 1;

SELECT
    Patient_iD,
    DOB,
    Admission_Date,
    Age,
    TIMESTAMPDIFF(
        YEAR,
        DOB,
        Admission_Date
    ) AS Age_At_Admission
FROM `final_table`
WHERE ABS(
    Age - TIMESTAMPDIFF(YEAR, DOB, Admission_Date)
) > 1;

SELECT
    Patient_iD,
    DOB,
    Admission_Date,
    Age,
    TIMESTAMPDIFF(YEAR, DOB, Admission_Date) AS Age_At_Admission,
    Age - TIMESTAMPDIFF(YEAR, DOB, Admission_Date) AS Age_Difference
FROM `final_table`
WHERE ABS(
    Age - TIMESTAMPDIFF(YEAR, DOB, Admission_Date)
) > 1
LIMIT 10;

SELECT COUNT(*) AS Mismatch_Count
FROM `final_table`
WHERE ABS(
    Age - TIMESTAMPDIFF(YEAR, DOB, Admission_Date)
) > 1;

SELECT 
    Patient_iD,
    Age,
    DOB,
    Admission_Date
FROM final_table
LIMIT 20;

SELECT
    Patient_iD,
    Age AS Old_Age,
    DOB,
    Admission_Date,
    TIMESTAMPDIFF(YEAR, DOB, Admission_Date) AS Correct_Age
FROM final_table
LIMIT 20;

SELECT 
    MIN(TIMESTAMPDIFF(YEAR, DOB, Admission_Date)) AS Min_Age,
    MAX(TIMESTAMPDIFF(YEAR, DOB, Admission_Date)) AS Max_Age,
    AVG(TIMESTAMPDIFF(YEAR, DOB, Admission_Date)) AS Avg_Age
FROM final_table;

UPDATE final_table
SET Age = TIMESTAMPDIFF(YEAR, DOB, Admission_Date);

UPDATE final_table
SET Age = TIMESTAMPDIFF(YEAR, DOB, Admission_Date)
WHERE Patient_ID IS NOT NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE final_table
SET Age = TIMESTAMPDIFF(YEAR, DOB, Admission_Date);

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;

SELECT COUNT(*) AS Mismatch_Count
FROM final_table
WHERE Age <> TIMESTAMPDIFF(YEAR, DOB, Admission_Date);

SET SQL_SAFE_UPDATES = 1;

SELECT Gender, COUNT(*) AS Count
FROM final_table
GROUP BY Gender;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(Contact_Details IS NULL OR TRIM(Contact_Details) = '') AS Blank_Contacts,
    COUNT(DISTINCT Contact_Details) AS Unique_Contacts
FROM final_table;

SELECT
    SUM(Contact_Details IS NULL) AS Null_Contacts,
    SUM(TRIM(Contact_Details) = '') AS Blank_Contacts
FROM final_table;

UPDATE final_table
SET Contact_Details = NULL
WHERE TRIM(Contact_Details) = '';

SELECT
    COUNT(*) AS Total_Rows,
    SUM(Contact_Details IS NULL) AS Missing_Contacts
FROM final_table;

SELECT Contact_Details
FROM final_table
WHERE Contact_Details IS NOT NULL
  AND Contact_Details NOT REGEXP '^[0-9()+ -]+$'
LIMIT 20;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Doctor_ID) AS Unique_Doctors,
    SUM(Doctor_ID IS NULL OR TRIM(Doctor_ID) = '') AS Missing_Doctor_ID
FROM final_table;

SELECT
    Doctor_ID,
    COUNT(DISTINCT Doctor_Name) AS Doctor_Name_Count
FROM final_table
GROUP BY Doctor_ID
HAVING COUNT(DISTINCT Doctor_Name) > 1;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT NPI) AS Unique_NPI,
    SUM(NPI IS NULL OR TRIM(NPI) = '') AS Missing_NPI
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Tax_ID) AS Unique_Tax_ID,
    SUM(CASE
        WHEN Tax_ID IS NULL OR TRIM(Tax_ID) = ''
        THEN 1 ELSE 0
    END) AS Missing_Tax_ID
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Doctor_ID) AS Unique_Doctor_ID,
    SUM(CASE
        WHEN Doctor_ID IS NULL OR TRIM(Doctor_ID) = ''
        THEN 1 ELSE 0
    END) AS Missing_Doctor_ID
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Facility) AS Unique_Facility,
    SUM(CASE
        WHEN Facility IS NULL OR TRIM(Facility) = ''
        THEN 1 ELSE 0
    END) AS Missing_Facility
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Insurance) AS Unique_Insurance,
    SUM(CASE
        WHEN Insurance IS NULL OR TRIM(Insurance) = ''
        THEN 1 ELSE 0
    END) AS Missing_Insurance
FROM final_table;

SELECT *
FROM final_table
WHERE Insurance IS NULL
   OR TRIM(Insurance) = '';
   
   SELECT
    Facility,
    COUNT(*) AS Missing_Count
FROM final_table
WHERE Insurance IS NULL
   OR TRIM(Insurance) = ''
GROUP BY Facility
ORDER BY Missing_Count DESC;

SELECT
    h.Patient_ID,
    h.Doctor_ID,
    h.Facility,
    d.Insurance
FROM final_table h
JOIN final_table d
    ON h.Doctor_ID = d.Doctor_ID
WHERE (h.Insurance IS NULL OR TRIM(h.Insurance) = '')
  AND d.Insurance IS NOT NULL
  AND TRIM(d.Insurance) <> '';
  
  Select Doctor_ID
  from final_table;
  
  SELECT
    h.Doctor_ID,
    h.Facility,
    COUNT(DISTINCT d.Insurance) AS Insurance_Count,
    GROUP_CONCAT(DISTINCT d.Insurance) AS Insurance_Companies
FROM final_table h
JOIN final_table d
    ON h.Doctor_ID = d.Doctor_ID
WHERE h.Insurance IS NULL
   OR TRIM(h.Insurance) = ''
GROUP BY h.Doctor_ID, h.Facility
ORDER BY Insurance_Count DESC;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(Insurance) AS Non_Null_Insurance,
    SUM(
        CASE
            WHEN Insurance IS NULL OR TRIM(Insurance) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_Insurance
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Mode_of_Payment) AS Unique_Payment_Modes,
    SUM(
        CASE
            WHEN Mode_of_Payment IS NULL OR TRIM(Mode_of_Payment) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_Payment_Mode
FROM final_table;

SELECT *
FROM final_table
WHERE Mode_of_Payment IS NULL
   OR TRIM(Mode_of_Payment) = '';
   
   UPDATE final_table
SET Mode_of_Payment = 'Unknown'
WHERE Mode_of_Payment IS NULL
   OR TRIM(Mode_of_Payment) = '';
   
   SELECT COUNT(*) AS Unknown_Payment_Mode
FROM final_table
WHERE Mode_of_Payment = 'Unknown';

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Admission_Date) AS Unique_Dates,
    SUM(
        CASE
            WHEN Admission_Date IS NULL
            THEN 1
            ELSE 0
        END
    ) AS Missing_Dates
FROM final_table;

SELECT
    MIN(Admission_Date) AS Earliest_Date,
    MAX(Admission_Date) AS Latest_Date
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Occupation) AS Unique_Occupations,
    SUM(
        CASE
            WHEN Occupation IS NULL OR TRIM(Occupation) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_Occupation
FROM final_table;

SELECT
    Patient_ID,
    Patient_Name,
    Age,
    Gender,
    Occupation
FROM final_table
WHERE Occupation IS NULL
   OR TRIM(Occupation) = '';
   
   UPDATE final_table
SET Occupation = 'Unknown'
WHERE Occupation IS NULL
   OR TRIM(Occupation) = '';
   
   SELECT COUNT(*) AS Unknown_Occupation
FROM final_table
WHERE Occupation = 'Unknown';

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Patient_Name) AS Unique_Names,
    SUM(
        CASE
            WHEN Patient_Name IS NULL OR TRIM(Patient_Name) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_Names
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT DOB) AS Unique_DOBs,
    SUM(
        CASE
            WHEN DOB IS NULL
            THEN 1
            ELSE 0
        END
    ) AS Missing_DOB
FROM data_set;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Contact_Details) AS Unique_Contacts,
    SUM(
        CASE
            WHEN Contact_Details IS NULL OR TRIM(Contact_Details) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_Contacts
FROM final_table;

SELECT
    Patient_ID,
    Patient_Name,
    Contact_Details
FROM final_table
WHERE Contact_Details IS NULL
   OR TRIM(Contact_Details) = '';
   
   UPDATE final_table
SET Contact_Details = 'Unknown'
WHERE Contact_Details IS NULL
   OR TRIM(Contact_Details) = '';
   
   SELECT COUNT(*) AS Unknown_Contacts
FROM final_table
WHERE Contact_Details = 'Unknown';

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Address) AS Unique_Addresses,
    SUM(
        CASE
            WHEN Address IS NULL OR TRIM(Address) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_Addresses
FROM final_table;

SELECT
    Patient_ID,
    Patient_Name,
    Address
FROM final_table
WHERE Address IS NULL
   OR TRIM(Address) = '';
   
   UPDATE final_table
SET Address = 'Unknown'
WHERE Address IS NULL
   OR TRIM(Address) = '';
   
   SELECT COUNT(*) AS Unknown_Addresses
FROM final_table
WHERE Address = 'Unknown';

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Doctor_Name) AS Unique_Doctors,
    SUM(
        CASE
            WHEN Doctor_Name IS NULL OR TRIM(Doctor_Name) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_Doctor_Name
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Patient_ID) AS Unique_Patient_IDs
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Doctor_ID) AS Unique_Doctor_IDs,
    SUM(
        CASE
            WHEN Doctor_ID IS NULL OR TRIM(Doctor_ID) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_Doctor_ID
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(
        CASE
            WHEN Total_Amount IS NULL
            THEN 1
            ELSE 0
        END
    ) AS Missing_Total_Amount
FROM final_table;

SELECT
    MIN(Total_Amount) AS Minimum_Amount,
    MAX(Total_Amount) AS Maximum_Amount,
    COUNT(*) AS Negative_Amount_Rows
FROM final_table
WHERE Total_Amount < 0;

SELECT
    MIN(Total_Amount) AS Minimum_Amount,
    MAX(Total_Amount) AS Maximum_Amount
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(
        CASE
            WHEN Paid_Amount IS NULL
            THEN 1
            ELSE 0
        END
    ) AS Missing_Paid_Amount
FROM final_table;

SELECT
    MIN(Paid_Amount) AS Minimum_Paid,
    MAX(Paid_Amount) AS Maximum_Paid,
    SUM(
        CASE
            WHEN Paid_Amount < 0 THEN 1
            ELSE 0
        END
    ) AS Negative_Rows
FROM final_table;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(
        CASE
            WHEN APBI IS NULL
            THEN 1
            ELSE 0
        END
    ) AS Missing_Insurance_Payment
FROM final_table;

SELECT
    MIN(APBI) AS Minimum_Insurance_Payment,
    MAX(APBI) AS Maximum_Insurance_Payment,
    SUM(
        CASE
            WHEN APBI < 0 THEN 1
            ELSE 0
        END
    ) AS Negative_Rows
FROM final_table;

SELECT COUNT(*) AS Total_Rows
FROM final_table;

SELECT *
FROM final_table;