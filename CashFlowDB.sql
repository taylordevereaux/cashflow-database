
USE [master];

GO

CREATE DATABASE [CashFlowDB];

GO

USE CashFlowDB;

GO

CREATE TYPE Constant FROM varchar(50) NOT NULL ;

GO

CREATE SCHEMA [CashFlow]

GO

CREATE SCHEMA [Lookup]

GO

CREATE TABLE [Lookup].TransactionType
(
	TransactionTypeId int  NOT NULL PRIMARY KEY IdENTITY(1,1),
	TransactionTypeConstant Constant UNIQUE,
	[Name] varchar(100) NOT NULL ,
	CreatedDate datetime NOT NULL 
)

GO

CREATE FUNCTION [Lookup].fnGetTransactionTypeIdByConstant(@TransactionTypeConstant Constant) RETURNS int AS
BEGIN
	DECLARE @Id int
	SELECT @Id = TransactionTypeId FROM [Lookup].TransactionType WHERE TransactionTypeConstant = @TransactionTypeConstant;
	RETURN @Id;
END

GO

CREATE TABLE [Lookup].AccountType 
(
	AccountTypeId int  NOT NULL PRIMARY KEY IdENTITY(1,1),
	AccountTypeConstant Constant UNIQUE,
	[Name] varchar(100) NOT NULL ,
	CreatedDate DATETIME NOT NULL 
)

GO 

CREATE FUNCTION [Lookup].fnGetAccountTypeIdByConstant(@AccountTypeConstant Constant) RETURNS int AS
BEGIN
	DECLARE @Id int
	SELECT @Id = AccountTypeId FROM [Lookup].AccountType WHERE AccountTypeConstant = @AccountTypeConstant;
	RETURN @Id;
END

GO

CREATE TABLE [CashFlow].Account 
(
	AccountId int NOT NULL PRIMARY KEY IdENTITY(1,1),
	AccountTypeId int NOT NULL FOREIGN KEY REFERENCES [Lookup].AccountType(AccountTypeId),
	[Name] varchar(100) NOT NULL ,
	Amount decimal(20, 6) NOT NULL ,
	CreatedDate datetime NOT NULL 
)

GO


CREATE TABLE [CashFlow].[Schedule](
	[ScheduleId] [int] PRIMARY KEY IdENTITY(1,1) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[RecurrenceAmount] [int] NOT NULL DEFAULT (1),
	[RecurrenceType] [varchar](7) NOT NULL CHECK ([RecurrenceType] IN ('Yearly','Monthly','Weekly','Daily')),
	[DayOfMonth] [int] NULL CHECK ([DayOfMonth]>=1 AND [DayOfMonth]<=28),
	[Ordinal] [varchar](6) NULL CHECK ([Ordinal] in ('Last','Forth','Third','Second','First')),
	[DayOfWeek] [varchar](9) NULL CHECK ([DayOfWeek] IN ('Saturday','Friday','Thursday','Wednesday','Tuesday','Monday', 'Sunday')),
	[CreatedDate] [datetime] NOT NULL,
)

GO

CREATE TABLE [CashFlow].[TransactionSchedule]
(
	TransactionScheduleId int NOT NULL PRIMARY KEY identity(1,1),
	TransactionTypeId int NOT NULL FOREIGN KEY REFERENCES [Lookup].TransactionType(TransactionTypeId),
	AccountId int NOT NULL FOREIGN KEY REFERENCES [CashFlow].Account(AccountId),
	ScheduleId int NULL FOREIGN KEY REFERENCES [CashFlow].Schedule(ScheduleId),
	Amount decimal(20, 6) NOT NULL,
	[Description] varchar(255) NOT NULL,
	CreatedDate datetime NOT NULL
)

GO

ALTER TABLE CashFlow.[TransactionSchedule] 
	ADD CONSTRAINT UNQ_TRANS_SCHED_ID UNIQUE (ScheduleId)

GO