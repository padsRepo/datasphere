-- Create DB and start
CREATE DATABASE IF NOT EXISTS accounting;
USE accounting;

-- Create Chart of Accounts or PASS if already made
-- Accounts Receivable #12001
CREATE TABLE IF NOT EXISTS accountsReceivable(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  valueLoaned decimal(7,2),
  unitsLoaned int(5),
  valuePayed decimal(7,2),
  dateOpened datetime,
  dateClosed datetime,
  dueDate datetime,
  customerID int,
  recieptID int,
  PRIMARY KEY(snid)
);


/*
Inventory #13x
*/
-- Raw Materials #131001
CREATE TABLE IF NOT EXISTS rawMaterials(
  snid int(7) NOT NULL AUTO_INCREMENT,
  category ENUM("Clear", "Color", "Joint", "Dichro", "Opal") NOT NULL,
  make varchar(30) NOT NULL,
  model ENUM("Tube", "Rod", "Frit", "Sheets", "Strips", "Tumbled;Polished", "Crushed/Rough", "Sample") NOT NULL,
  diameter decimal(7,2),
  thickness decimal(7,2),
  inchesPerUnit int(2),
  inchesPerPc int(2),
  pcsPerCs decimal(7,2),
  oz decimal(7,2),
  PRIMARY KEY(snid)
);

CREATE TABLE IF NOT EXISTS rmIn(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL,
  category varchar(30) NOT NULL,
  make varchar(30) NOT NULL,
  model varchar(30) NOT NULL,
  debit decimal(7,2) NOT NULL,
  pcsIn int(4) NOT NULL,
  invoiceID varchar(50) NOT NULL,
  purchaseDate datetime,
  FOREIGN KEY(snid) REFERENCES rawMaterials(snid)
);

CREATE TABLE IF NOT EXISTS rmOut(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL,
  category varchar(30) NOT NULL,
  make varchar(30) NOT NULL,
  model varchar(30) NOT NULL,
  units int(3),
  waste int(3),
  rnd int(3),
  FOREIGN KEY(snid) REFERENCES rawMaterials(snid)
);


-- Production Work #132001
CREATE TABLE IF NOT EXISTS productionWork(
  snid int(7) NOT NULL AUTO_INCREMENT,
  model varchar(25) NOT NULL,
  description varchar(50) NOT NULL,
  msrp decimal(7,2) NOT NULL,
  wholesale decimal(7,2) NOT NULL,
  inchesPerUnit int(2) NOT NULL,
  image varchar(125) NOT NULL,
  image2 varchar(125) NOT NULL,
  image3 varchar(125) NOT NULL,
  image4 varchar(125) NOT NULL,
  image5 varchar(125) NOT NULL,
  link varchar(255),
  PRIMARY KEY(snid)
);
CREATE TABLE IF NOT EXISTS pwIn(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL,
  model varchar(25) NOT NULL,
  unitsIn int(3) NOT NULL,
  FOREIGN KEY(snid) REFERENCES productionWork(snid)
);

CREATE TABLE IF NOT EXISTS pwOut(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL,
  model varchar(25) NOT NULL,
  unitsOut int(3) NOT NULL,
  FOREIGN KEY(snid) REFERENCES productionWork(snid)
);


-- Custom Work #133001
CREATE TABLE IF NOT EXISTS customWork(
  snid int(7) NOT NULL AUTO_INCREMENT,
  model varchar(50) NOT NULL,
  description TEXT NOT NULL,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  mfgDate datetime,
  image BLOB,
  image2 BLOB,
  image3 BLOB,
  image4 BLOB,
  image5 BLOB,
  link varchar(255),
  invoiceID varchar(25),
  customerID int(7),
  employeeID int(7),
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY(snid)
);


-- Prototypes #134001
CREATE TABLE IF NOT EXISTS prototypes(
  snid int(7) NOT NULL AUTO_INCREMENT,
  model varchar(50) NOT NULL,
  description varchar(50) NOT NULL,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  image BLOB,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY(snid)
);


-- Store Inventory #135001
CREATE TABLE IF NOT EXISTS storeInventory(
  snid int(7) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  msrp decimal(7,2) NOT NULL,
  unitsPerCs int(3) NOT NULL,
  image BLOB,
  image2 BLOB,
  image3 BLOB,
  image4 BLOB,
  image5 BLOB,
  link varchar(255),
  PRIMARY KEY(snid)
);
CREATE TABLE IF NOT EXISTS siIn(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL,
  description varchar(50) NOT NULL,
  debit decimal(7,2),
  purchaseDate datetime,
  unitsIn int(3),
  invoiceID varchar(25),
  FOREIGN KEY(snid) REFERENCES storeInventory(snid)
);
CREATE TABLE IF NOT EXISTS siOut(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL,
  description varchar(50) NOT NULL,
  unitsOut int(3),
  FOREIGN KEY(snid) REFERENCES storeInventory(snid)
);


-- Building #14001
CREATE TABLE IF NOT EXISTS building(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  purchaseDate datetime NOT NULL,
  depreciationLife int(2) NOT NULL,
  receiptID varchar(16) NOT NULL,
  PRIMARY KEY(snid)
);


-- Building Improvements #15001
CREATE TABLE IF NOT EXISTS buildingImprovements(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  purchaseDate datetime,
  depreciationLife int(2) NOT NULL,
  receiptID varchar(50),
  PRIMARY KEY(snid)
);


-- Land Improvements #16001
CREATE TABLE IF NOT EXISTS landImprovements(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  purchaseDate datetime,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


/*
Furniture and Fixtures #17x
*/
-- Computer Equipment #171001
CREATE TABLE IF NOT EXISTS computerEquipment(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2),
  credit decimal(7,2),
  purchaseDate datetime,
  depreciationLife int(3),
  receiptID varchar(25),
  PRIMARY KEY(snid)
);

-- Store Equipment #172001
CREATE TABLE IF NOT EXISTS storeEquipment(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2),
  credit decimal(7,2),
  purchaseDate datetime,
  depreciationLife int(3),
  receiptID varchar(25),
  PRIMARY KEY(snid)
);

-- Machinery and Equipment #173001
CREATE TABLE IF NOT EXISTS machineryEquipment(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2),
  credit decimal(7,2),
  purchaseDate datetime,
  depreciationLife int(3),
  receiptID varchar(25),
  PRIMARY KEY(snid)
);

-- Office Equipment #174001
CREATE TABLE IF NOT EXISTS officeEquipment(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2),
  credit decimal(7,2),
  purchaseDate datetime,
  depreciationLife int(3),
  receiptID varchar(25),
  PRIMARY KEY(snid)
);

-- Shop Equipment #175001
CREATE TABLE IF NOT EXISTS shopEquipment(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(7) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2),
  credit decimal(7,2),
  purchaseDate datetime,
  depreciationLife int(3),
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Accounts Payable #21001
CREATE TABLE IF NOT EXISTS accountsPayable(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50),
  debit decimal(7,2),
  credit decimal(7,2),
  dateOpened datetime,
  dateClosed datetime,
  dueDate datetime,
  customerID int,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Unearned Sales Revenue #22001
CREATE TABLE IF NOT EXISTS unearnedSalesRevenue(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2),
  credit decimal(7,2),
  dateOpen datetime,
  dateClosed datetime,
  dueDate datetime,
  customerID int,
  receiptID int,
  PRIMARY KEY(snid)
);


-- Allowance for Doubtful Accounts #23001
CREATE TABLE IF NOT EXISTS allowanceForDoubtfulAccounts(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  debit decimal(7,2),
  credit decimal(7,2),
  customerID int,
  receiptID int,
  PRIMARY KEY(snid)
);


-- Capital #31001
CREATE TABLE IF NOT EXISTS capital(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  transactionDate datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Drawings #32001
CREATE TABLE IF NOT EXISTS drawings(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  transactionDate datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Sales Revenue #41001
CREATE TABLE IF NOT EXISTS salesRevenue(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  saleDate datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  customerID int,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Supplies Expense #51001
CREATE TABLE IF NOT EXISTS suppliesExpense(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  date datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  customerID int,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Utilities Expense #52001
CREATE TABLE IF NOT EXISTS utilitiesExpense(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  dueDate datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  customerID int,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Travel Expense #53001
CREATE TABLE IF NOT EXISTS travelExpense(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  date datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  customerID int,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Delivery Expense #54001
CREATE TABLE IF NOT EXISTS deliveryExpense(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  date datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  customerID int,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Rent Expense #55001
CREATE TABLE IF NOT EXISTS rentExpense(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  date datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  customerID int,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);


-- Salary Expense #56001
CREATE TABLE IF NOT EXISTS salaryExpense(
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  snid int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  date datetime,
  debit decimal(7,2) NOT NULL,
  credit decimal(7,2),
  employeeID int,
  receiptID varchar(25),
  PRIMARY KEY(snid)
);

ALTER TABLE accountsReceivable AUTO_INCREMENT=12001;
ALTER TABLE rawMaterials AUTO_INCREMENT=131001;
ALTER TABLE productionWork AUTO_INCREMENT=132001;
ALTER TABLE customWork AUTO_INCREMENT=133001;
ALTER TABLE prototypes AUTO_INCREMENT=134001;
ALTER TABLE storeInventory AUTO_INCREMENT=135001;
ALTER TABLE building AUTO_INCREMENT=14001;
ALTER TABLE buildingImprovements AUTO_INCREMENT=15001;
ALTER TABLE landImprovements AUTO_INCREMENT=16001;
ALTER TABLE computerEquipment AUTO_INCREMENT=171001;
ALTER TABLE storeEquipment AUTO_INCREMENT=172001;
ALTER TABLE machineryEquipment AUTO_INCREMENT=173001;
ALTER TABLE officeEquipment AUTO_INCREMENT=174001;
ALTER TABLE shopEquipment AUTO_INCREMENT=175001;
ALTER TABLE accountsPayable AUTO_INCREMENT=21001;
ALTER TABLE unearnedSalesRevenue AUTO_INCREMENT=22001;
ALTER TABLE allowanceForDoubtfulAccounts AUTO_INCREMENT=23001;
ALTER TABLE capital AUTO_INCREMENT=31001;
ALTER TABLE drawings AUTO_INCREMENT=32001;
ALTER TABLE salesRevenue AUTO_INCREMENT=41001;
ALTER TABLE suppliesExpense AUTO_INCREMENT=51001;
ALTER TABLE utilitiesExpense AUTO_INCREMENT=52001;
ALTER TABLE travelExpense AUTO_INCREMENT=53001;
ALTER TABLE deliveryExpense AUTO_INCREMENT=54001;
ALTER TABLE rentExpense AUTO_INCREMENT=55001;
ALTER TABLE salaryExpense AUTO_INCREMENT=56001;
USE accounting;

--Assets
--Other Assets(FF and Inv below)
CREATE VIEW IF NOT EXISTS qar1 AS
SELECT
  SUM(valueLoaned) AS debit,
  SUM(valuePayed) AS credit,
  SUM(valueLoaned) - SUM(valuePayed) AS dif
FROM accountsReceivable
;

CREATE VIEW IF NOT EXISTS qb1 AS
SELECT
  SUM(debit) as debit,
  SUM(credit) as credit,
  SUM(debit) - SUM(credit) as dif,
  ROUND(SUM(debit / depreciationLife), 2) as depreciationCost
FROM building
;

CREATE VIEW IF NOT EXISTS qbi1 AS
SELECT
  SUM(debit) as debit,
  SUM(credit) as credit,
  SUM(debit) - SUM(credit) as dif,
  ROUND(SUM(debit / depreciationLife), 2) as depreciationCost
FROM buildingImprovements
;

CREATE VIEW IF NOT EXISTS qli1 AS
SELECT
  SUM(debit) as debit,
  SUM(credit) as credit,
  SUM(debit) - SUM(credit) as dif
FROM landImprovements
;


--Furniture and Fixtures
CREATE VIEW IF NOT EXISTS qce1 AS
SELECT
  SUM(debit) as debit,
  SUM(credit) as credit,
  SUM(debit) - SUM(credit) as dif,
  ROUND(SUM(debit / depreciationLife), 2) as depreciationCost
FROM computerEquipment
;

CREATE VIEW IF NOT EXISTS qse1 AS
SELECT
  SUM(debit) as debit,
  SUM(credit) as credit,
  SUM(debit) - SUM(credit) as dif,
  ROUND(SUM(debit / depreciationLife), 2) as depreciationCost
FROM storeEquipment
;

CREATE VIEW IF NOT EXISTS qme1 AS
SELECT
  SUM(debit) as debit,
  SUM(credit) as credit,
  SUM(debit) - SUM(credit) as dif,
  ROUND(SUM(debit / depreciationLife), 2) as depreciationCost
FROM machineryEquipment
;

CREATE VIEW IF NOT EXISTS qoe1 AS
SELECT
  SUM(debit) as debit,
  SUM(credit) as credit,
  SUM(debit) - SUM(credit) as dif,
  ROUND(SUM(debit / depreciationLife), 2) as depreciationCost
FROM officeEquipment
;

CREATE VIEW IF NOT EXISTS qshe1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif,
  ROUND(SUM(debit / depreciationLife), 2) AS depreciationCost
FROM shopEquipment
;

CREATE VIEW IF NOT EXISTS qff1 AS
SELECT
  SUM(qce1.debit + qse1.debit + qme1.debit + qoe1.debit + qshe1.debit) AS debit,
  SUM(qce1.credit + qse1.credit + qme1.credit + qoe1.credit + qshe1.credit) AS credit,
  SUM((qce1.debit + qse1.debit + qme1.debit + qoe1.debit + qshe1.debit) - (qce1.credit + qse1.credit + qme1.credit + qoe1.credit + qshe1.credit)) AS dif,
  SUM(qce1.depreciationCost + qse1.depreciationCost + qme1.depreciationCost + qoe1.depreciationCost + qshe1.depreciationCost) AS totalDepCost
FROM qce1, qse1, qme1, qoe1, qshe1
;


--Inventory
CREATE VIEW IF NOT EXISTS qcw1 AS
SELECT
  SUM(debit) AS totalDR,
  SUM(credit) AS totalCR,
  SUM(debit) - SUM(credit) AS totalOH
FROM customWork
;


CREATE VIEW IF NOT EXISTS qproto1 AS
SELECT
  SUM(debit) AS totalDR,
  SUM(credit) AS totalCR,
  SUM(debit) - SUM(credit) AS totalOH
FROM prototypes
;


CREATE VIEW IF NOT EXISTS qrm1 AS
SELECT
  rawMaterials.snid,
  SUM(rmIn.debit) AS debit,
  SUM(rmIn.pcsIn) AS pcsIn,
  ROUND(SUM(rmIn.debit) / SUM(rmIn.pcsIn), 2) AS costPerPc,
  ROUND(rawMaterials.inchesPerPc / rawMaterials.inchesPerUnit, 0) AS unitsPerPc,
  ROUND((rawMaterials.inchesPerPc / rawMaterials.inchesPerUnit) * SUM(rmIn.pcsIn), 0) AS unitsIn,
  ROUND((rawMaterials.inchesPerPc / rawMaterials.inchesPerUnit) * rawMaterials.pcsPerCs, 0) AS unitsPerCs,
  ROUND(SUM(rmIn.debit) / ((rawMaterials.inchesPerPc / rawMaterials.inchesPerUnit) * SUM(rmIn.pcsIn)), 2) AS costPerUnit
FROM rawMaterials, rmIn
WHERE rawMaterials.snid = rmIn.snid
GROUP BY rawMaterials.snid
;


CREATE VIEW IF NOT EXISTS qrm2 AS
SELECT
  rawMaterials.snid,
  SUM(rmOut.units) AS units,
  SUM(rmOut.waste) AS waste,
  SUM(rmOut.rnd) AS rnd,
  SUM(rmOut.units) + SUM(rmOut.waste) + SUM(rmOut.rnd) AS unitsOut
FROM rawMaterials, rmOut
WHERE rawMaterials.snid = rmOut.snid
GROUP BY rawMaterials.snid
;

CREATE VIEW IF NOT EXISTS vRawMaterials AS
SELECT
  CONCAT(rawMaterials.snid, " ", rawMaterials.category, " ", rawMaterials.make, " ", rawMaterials.model) AS description,
  rawMaterials.diameter AS diameter,
  rawMaterials.thickness AS thickness,
  rawMaterials.oz as oz,
  qrm1.debit as debit,
  qrm1.costPerUnit * qrm2.unitsOut AS credit,
  qrm1.costPerUnit * qrm2.units AS uDR,
  qrm1.costPerUnit * qrm2.waste AS wDR,
  qrm1.costPerUnit * qrm2.rnd AS rndDR,
  qrm1.costPerPc AS costPerPc,
  qrm1.costPerUnit AS costPerUnit,
  rawMaterials.inchesPerUnit AS inchesPerUnit,
  rawMaterials.inchesPerPc AS inchesPerPc,
  rawMaterials.pcsPerCs AS pcsPerCs,
  qrm1.unitsPerPc AS unitsPerPc,
  qrm1.unitsPerCs AS unitsPerCs,
  qrm1.pcsIn AS pcsIn,
  qrm1.unitsIn AS unitsIn,
  qrm2.unitsOut AS unitsOut,
  qrm1.unitsIn - qrm2.unitsOut AS unitsOH,
  qrm2.units AS units,
  qrm2.waste AS waste,
  qrm2.rnd AS rnd
FROM rawMaterials, qrm1, qrm2
WHERE rawMaterials.snid = qrm1.snid AND qrm1.snid = qrm2.snid
GROUP BY rawMaterials.snid
;


CREATE VIEW IF NOT EXISTS qpw1 AS
SELECT
  productionWork.snid,
  SUM(pwIn.unitsIn) AS unitsIn,
  SUM(pwIn.unitsIn) * productionWork.wholesale AS debit
FROM productionWork, pwIn
WHERE productionWork.snid = pwIn.snid
GROUP BY productionWork.snid
;

CREATE VIEW IF NOT EXISTS qpw2 AS
SELECT
  productionWork.snid,
  SUM(pwOut.unitsOut) AS unitsOut,
  SUM(pwOut.unitsOut) * productionWork.wholesale AS credit
FROM productionWork, pwOut
WHERE productionWork.snid = pwOut.snid
GROUP BY productionWork.snid
;

CREATE VIEW IF NOT EXISTS vProductionWork AS
SELECT
  CONCAT(productionWork.snid, " ", productionWork.model, " ", productionWork.description) AS description,
  productionWork.msrp AS msrp,
  productionWork.wholesale AS wholesale,
  productionWork.inchesPerUnit AS inchesPerUnit,
  qpw1.unitsIn AS unitsIn,
  qpw2.unitsOut AS unitsOut,
  qpw1.unitsIn - qpw2.unitsOut AS unitsOH,
  qpw1.debit,
  qpw2.credit,
  (qpw1.unitsIn - qpw2.unitsOut) * productionWork.msrp AS retailValue
FROM productionWork, qpw1, qpw2
WHERE productionWork.snid = qpw1.snid AND qpw1.snid = qpw2.snid
GROUP BY productionWork.snid
;


CREATE VIEW IF NOT EXISTS qsi1 AS
SELECT
  storeInventory.snid,
  SUM(siIn.debit) AS debit,
  SUM(siIn.unitsIn) AS unitsIn,
  ROUND(SUM(siIn.debit) / SUM(siIn.unitsIn), 2) AS costPerUnit
FROM storeInventory, siIn
WHERE storeInventory.snid = siIn.snid
GROUP BY storeInventory.snid
;

CREATE VIEW IF NOT EXISTS qsi2 AS
SELECT
  storeInventory.snid,
  SUM(siOut.unitsOut) AS unitsOut
FROM storeInventory, siOut
WHERE storeInventory.snid = siOut.snid
GROUP BY storeInventory.snid
;

CREATE VIEW IF NOT EXISTS vStoreInventory AS
SELECT
  storeInventory.snid,
  storeInventory.description,
  storeInventory.msrp,
  storeInventory.unitsPerCs,
  qsi1.debit AS debit,
  ROUND(SUM((qsi1.debit / qsi1.unitsIn) * qsi2.unitsOut), 2) AS credit,
  qsi1.unitsIn AS unitsIn,
  qsi2.unitsOut AS unitsOut,
  qsi1.unitsIn - qsi2.unitsOut AS unitsOH,
  ROUND(qsi1.debit / qsi1.unitsIn, 2) AS costPerUnit
FROM storeInventory, qsi1, qsi2
WHERE storeInventory.snid = qsi1.snid AND qsi1.snid = qsi2.snid
GROUP BY storeInventory.snid
;

CREATE VIEW IF NOT EXISTS qi1 AS
SELECT
  SUM(vRawMaterials.debit + vStoreInventory.debit) AS debit,
  SUM(vRawMaterials.credit + vStoreInventory.credit) AS credit,
  SUM((vRawMaterials.debit + vStoreInventory.debit) - (vRawMaterials.credit + vStoreInventory.credit)) AS dif
FROM vRawMaterials, vStoreInventory
;


--Liabilities
CREATE VIEW IF NOT EXISTS qap1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM accountsPayable
;

CREATE VIEW IF NOT EXISTS qusr1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM unearnedSalesRevenue
;

CREATE VIEW IF NOT EXISTS qada1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM allowanceForDoubtfulAccounts
;


--Rev, Exp, OE
--Revenue
CREATE VIEW IF NOT EXISTS qsr1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM salesRevenue
;

--Expenses
CREATE VIEW IF NOT EXISTS qsupexp1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM suppliesExpense
;

CREATE VIEW IF NOT EXISTS que1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM utilitiesExpense
;

CREATE VIEW IF NOT EXISTS qte1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM travelExpense
;

CREATE VIEW IF NOT EXISTS qde1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM deliveryExpense
;

CREATE VIEW IF NOT EXISTS qre1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM rentExpense
;

CREATE VIEW IF NOT EXISTS qsalexp1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM salaryExpense
;


--Owners Equity
CREATE VIEW IF NOT EXISTS qcap1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM capital
;

CREATE VIEW IF NOT EXISTS qdraw1 AS
SELECT
  SUM(debit) AS debit,
  SUM(credit) AS credit,
  SUM(debit) - SUM(credit) AS dif
FROM drawings
;

--Reports
CREATE VIEW IF NOT EXISTS qreports1 AS
SELECT
  SUM((qsr1.debit + qap1.debit + qusr1.debit + qcap1.debit) - (qar1.dif +  qi1.debit + qb1.debit + qbi1.debit + qli1.debit + qff1.debit + qap1.credit + qsupexp1.debit + que1.debit + qte1.debit + qde1.debit + qdraw1.debit + qre1.debit + qsalexp1.debit)) AS cash,
  SUM(qre1.debit + qb1.credit + qbi1.credit + qli1.credit + qff1.credit + qi1.credit + vRawMaterials.rndDR + qada1.dif + qsalexp1.debit + qsupexp1.debit + qte1.debit + que1.debit + qde1.debit) AS totalExp,
  SUM(qsr1.debit + qusr1.credit) AS salesRev,
  SUM(qap1.dif + qusr1.dif + qada1.dif) AS totalLiab
FROM qsr1, qap1, qcap1, qar1, qb1, qbi1, qli1, qff1, qsupexp1, que1, qte1, qde1, qada1, qdraw1, qre1, qsalexp1, vRawMaterials, qi1, qusr1
;

CREATE VIEW IF NOT EXISTS qreports2 AS
SELECT
  SUM(qreports1.cash + qar1.dif + qi1.dif + qb1.dif + qbi1.dif + qli1.dif + qff1.dif - vRawMaterials.rndDR) AS totalAssets,
  SUM(qreports1.salesRev - qreports1.totalExp) AS incomeloss,
  SUM(qcap1.debit + (qreports1.salesRev - qreports1.totalExp)) AS total,
  SUM((qcap1.debit + (qreports1.salesRev - qreports1.totalExp)) - qdraw1.debit) AS agCap
FROM qreports1, qi1, qar1, qb1, qbi1, qli1, qff1, vRawMaterials, qcap1, qdraw1 
;

CREATE VIEW IF NOT EXISTS incomeStatement AS
SELECT
  qreports1.salesRev AS salesRev,
  qre1.debit AS rentDep,
  qb1.credit AS buildingDep,
  qbi1.credit AS buildingImpDep,
  qli1.credit AS landImpDep,
  qff1.credit AS furnitureFixturesDep,
  qi1.credit AS cogs,
  vRawMaterials.rndDR AS rnd,
  qada1.dif AS badDebtExp,
  qsalexp1.debit AS salaryExp,
  qsupexp1.debit AS suppliesExp,
  que1.debit AS utilitiesExp,
  qte1.debit AS travelExp,
  qde1.debit AS deliveryExp,
  qreports1.totalExp AS totalExp,
  qreports2.incomeloss AS incomeloss
FROM qreports1, qreports2, qre1, qb1, qbi1, qli1, qff1, qi1, vRawMaterials, qsalexp1, qse1, que1, qte1, qde1, qsupexp1, qusr1, qada1
;

CREATE VIEW IF NOT EXISTS statementofOwnersEquity AS
SELECT
  qcap1.debit AS capital,
  qreports2.incomeloss AS incomeloss,
  qreports2.total AS total,
  qdraw1.debit AS drawings,
  qreports2.agCap AS endCapital
FROM qcap1, qreports2, qdraw1
;

CREATE VIEW IF NOT EXISTS balanceSheet AS
SELECT
  qreports1.cash AS cash,
  qar1.dif AS accountsReceivable,
  qi1.dif AS inventory,
  qb1.debit AS building,
  qb1.credit AS buildingDep,
  qb1.dif AS buildingDif,
  qbi1.debit AS buildingImp,
  qbi1.credit AS buildingImpDep,
  qbi1.dif AS buildingImpDif,
  qli1.dif AS landImp,
  qff1.debit AS furnitureFixtures,
  qff1.credit AS furnitureFixturesDep,
  qff1.dif AS furnitureFixturesDif,
  qreports2.totalassets AS totalAssets,
  qap1.dif AS accountsPayable,
  qusr1.dif AS unearnedSalesRevenue,
  qada1.dif AS allowanceForDoubtfulAccounts,
  qreports1.totalLiab AS totalLiabilities,
  statementofOwnersEquity.endCapital AS capital,
  SUM(qreports1.totalLiab + statementofOwnersEquity.endCapital) AS totalLiabOE  
FROM qreports1, qreports2, qar1, qi1, qb1, qbi1, qli1, qff1, qap1, qusr1, qada1, qcap1, statementofOwnersEquity
;