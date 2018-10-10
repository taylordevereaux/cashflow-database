
CREATE DATABASE [FinanceDB];

GO

USE FinanceDB;

GO

CREATE TYPE Constant FROM varchar(50) NOT NULL ;

GO

CREATE TABLE dbo.RepeatType 
(
	RepeatTypeID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	RepeatTypeConstant Constant UNIQUE,
	[Name] varchar(100) NOT NULL ,
	CreatedDate datetime NOT NULL 
)
GO

CREATE FUNCTION dbo.fnGetRepeatTypeIDByConstant(@RepeatTypeConstant Constant) RETURNS int AS
BEGIN
	DECLARE @ID int
	SELECT @ID = RepeatTypeID FROM dbo.RepeatType WHERE RepeatTypeConstant = @RepeatTypeConstant;
	RETURN @ID;
END

GO

CREATE TABLE dbo.TransactionType
(
	TransactionTypeID int  NOT NULL PRIMARY KEY IDENTITY(1,1),
	TransactionTypeConstant Constant UNIQUE,
	[Name] varchar(100) NOT NULL ,
	CreatedDate datetime NOT NULL 
)

GO

CREATE FUNCTION dbo.fnGetTransactionTypeIDByConstant(@TransactionTypeConstant Constant) RETURNS int AS
BEGIN
	DECLARE @ID int
	SELECT @ID = TransactionTypeID FROM dbo.TransactionType WHERE TransactionTypeConstant = @TransactionTypeConstant;
	RETURN @ID;
END

GO

CREATE TABLE dbo.AccountType 
(
	AccountTypeID int  NOT NULL PRIMARY KEY IDENTITY(1,1),
	AccountTypeConstant Constant UNIQUE,
	[Name] varchar(100) NOT NULL ,
	CreatedDate DATETIME NOT NULL 
)

GO 

CREATE FUNCTION dbo.fnGetAccountTypeIDByConstant(@AccountTypeConstant Constant) RETURNS int AS
BEGIN
	DECLARE @ID int
	SELECT @ID = AccountTypeID FROM dbo.AccountType WHERE AccountTypeConstant = @AccountTypeConstant;
	RETURN @ID;
END

GO

CREATE TABLE dbo.Account 
(
	AccountID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	AccountTypeID int NOT NULL FOREIGN KEY REFERENCES dbo.AccountType(AccountTypeID),
	[Name] varchar(100) NOT NULL ,
	Amount decimal(20, 6) NOT NULL ,
	CreatedDate datetime NOT NULL 
)

GO

CREATE TABLE dbo.[RepeatTransaction]
(
	RepeatTransactionID int NOT NULL PRIMARY KEY identity(1,1),
	TransactionTypeID int NOT NULL FOREIGN KEY REFERENCES dbo.TransactionType(TransactionTypeID),
	AccountID int NOT NULL FOREIGN KEY REFERENCES dbo.Account(AccountID),
	RepeatTypeID int NULL FOREIGN KEY REFERENCES dbo.RepeatType(RepeatTypeID),
	Amount decimal(20, 6) NOT NULL,
	StartDate date NOT NULL,
	CreatedDate datetime NOT NULL
)

GO