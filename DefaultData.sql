USE FinanceDB;
GO

SET NOCOUNT ON;

GO
-- Comment out to prevent truncating data.
DELETE FROM dbo.[Transaction]
DELETE FROM dbo.Account
DELETE FROM dbo.TransactionType
DELETE FROM dbo.Schedule
DELETE FROM dbo.AccountType

GO

-- Setting up default data.
INSERT INTO dbo.AccountType (AccountTypeConstant, Name, CreatedDate) VALUES ('CHEQUING', 'Chequing', GETDATE())
INSERT INTO dbo.AccountType (AccountTypeConstant, Name, CreatedDate) VALUES ('SAVINGS', 'Savings', GETDATE())
INSERT INTO dbo.AccountType (AccountTypeConstant, Name, CreatedDate) VALUES ('CREDIT', 'Credit', GETDATE())

GO

INSERT INTO dbo.TransactionType (TransactionTypeConstant, Name, CreatedDate) VALUES ('INCOME', 'Income', GETDATE())
INSERT INTO dbo.TransactionType (TransactionTypeConstant, Name, CreatedDate) VALUES ('EXPENSE', 'Expense', GETDATE())

GO

INSERT INTO dbo.Account (AccountTypeID, Name, Amount, CreatedDate) VALUES (dbo.fnGetAccountTypeIDByConstant('CHEQUING'), 'Test Account', 294.83, GETDATE())

GO

DECLARE @AccountID int 
SELECT TOP 1 @AccountID = AccountID FROM dbo.Account

DECLARE @TransactionTypeID int = dbo.fnGetTransactionTypeIDByConstant('EXPENSE')

INSERT INTO dbo.[Transaction] (TransactionTypeID, AccountID, RepeatTypeID, Amount, StartDate, CreatedDate) VALUES (@TransactionTypeID, @AccountID, dbo.fnGetRepeatTypeIDByConstant('MONTHLY'), 102.15, '2018-08-28', GETDATE())
INSERT INTO dbo.[Transaction] (TransactionTypeID, AccountID, RepeatTypeID, Amount, StartDate, CreatedDate) VALUES (@TransactionTypeID, @AccountID, dbo.fnGetRepeatTypeIDByConstant('WEEKLY'), 65, '2018-07-28', GETDATE())
INSERT INTO dbo.[Transaction] (TransactionTypeID, AccountID, RepeatTypeID, Amount, StartDate, CreatedDate) VALUES (@TransactionTypeID, @AccountID, dbo.fnGetRepeatTypeIDByConstant('BIWEEKLY'), 90, '2018-07-28', GETDATE())
INSERT INTO dbo.[Transaction] (TransactionTypeID, AccountID, RepeatTypeID, Amount, StartDate, CreatedDate) VALUES (@TransactionTypeID, @AccountID, dbo.fnGetRepeatTypeIDByConstant('ONETIME'), 52, '2018-07-09', GETDATE())
INSERT INTO dbo.[Transaction] (TransactionTypeID, AccountID, RepeatTypeID, Amount, StartDate, CreatedDate) VALUES (@TransactionTypeID, @AccountID, dbo.fnGetRepeatTypeIDByConstant('WEEKLY'), 501, '2018-07-10', GETDATE())
INSERT INTO dbo.[Transaction] (TransactionTypeID, AccountID, RepeatTypeID, Amount, StartDate, CreatedDate) VALUES (@TransactionTypeID, @AccountID, dbo.fnGetRepeatTypeIDByConstant('WEEKLY'), 540, '2018-07-07', GETDATE())

GO