USE excel_r;

select* from manufacturing_data;

# KPI
SELECT
  COUNT(*) AS Total_rows,
  sum(todayManufacturedqty) AS Total_Manufactured_Qty,
  SUM(RejectedQty) AS Total_Rejected_Qty,
  SUM(ProcessedQty) AS Total_Processed_Qty,
  SUM(WOQty) AS Total_Wastage_Qty,
  CONCAT(ROUND(SUM(RejectedQty) / sum(todayManufacturedqty) * 100, 2), '%') AS Rejection_Percentage
FROM manufacturing_data
WHERE todayManufacturedqty IS NOT NULL
  AND todayManufacturedqty > 0
  AND ProcessedQty IS NOT NULL
  AND RejectedQty IS NOT NULL
  AND RejectedQty >= 0;
  
 
##Department-wise Manufacture vs Rejected

SELECT
  DepartmentName,
  sum(todayManufacturedqty) AS Total_Manufactured_Qty,
  SUM(RejectedQty) AS Total_Rejected_Qty,
  CONCAT(ROUND(SUM(RejectedQty) / SUM(todayManufacturedqty) * 100, 2), '%') AS Rejection_Percentage
FROM manufacturing_data
WHERE todayManufacturedqty IS NOT NULL
  AND todayManufacturedqty > 0
  AND RejectedQty IS NOT NULL
  AND RejectedQty >= 0
GROUP BY DepartmentName
ORDER BY Rejection_Percentage DESC;


#Employee-wise Production vs Rejection Performance
SELECT
  EmpName AS Employee_Name,
sum(RejectedQty) AS Total_Rejected_Qty,
  CONCAT(ROUND(SUM(RejectedQty) / SUM(todayManufacturedqty) * 100, 2), '%') AS Rejection_Percentage
FROM manufacturing_data
WHERE RejectedQty IS NOT NULL
  AND RejectedQty >= 0
GROUP BY EmpName
ORDER BY SUM(RejectedQty) DESC;


##Machine-wise Rejection Top 10 

SELECT 
  MachineCode,
  SUM(RejectedQty) AS Total_Rejected_Qty
FROM manufacturing_data
WHERE 
  RejectedQty IS NOT NULL 
  AND RejectedQty > 0
GROUP BY MachineCode
ORDER BY Total_Rejected_Qty DESC
LIMIT 10;

##Manufacture Vs Rejected

SELECT
  SUM(todayManufacturedqty) AS Total_Manufactured_Qty,
  SUM(RejectedQty) AS Total_Rejected_Qty
FROM manufacturing_data
WHERE 
  todayManufacturedqty IS NOT NULL
  AND todayManufacturedqty > 0
  AND RejectedQty IS NOT NULL
  AND RejectedQty >= 0;

