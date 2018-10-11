USE CashFlowDB;
GO

SET NOCOUNT ON;

GO
-- Comment out to prevent truncating data.
DELETE FROM CashFlow.[RecurringTransaction]
DELETE FROM CashFlow.Account
DELETE FROM CashFlow.Schedule
DELETE FROM [Lookup].TransactionType
DELETE FROM [Lookup].AccountType

GO

-- Setting up default data.
INSERT INTO [Lookup].AccountType (AccountTypeConstant, Name, CreatedDate) VALUES ('CHEQUING', 'Chequing', GETDATE())
INSERT INTO [Lookup].AccountType (AccountTypeConstant, Name, CreatedDate) VALUES ('SAVINGS', 'Savings', GETDATE())
INSERT INTO [Lookup].AccountType (AccountTypeConstant, Name, CreatedDate) VALUES ('CREDIT', 'Credit', GETDATE())

GO

INSERT INTO [Lookup].TransactionType (TransactionTypeConstant, Name, CreatedDate) VALUES ('INCOME', 'Income', GETDATE())
INSERT INTO [Lookup].TransactionType (TransactionTypeConstant, Name, CreatedDate) VALUES ('EXPENSE', 'Expense', GETDATE())

GO

INSERT INTO [CashFlow].Account (AccountTypeID, Name, Amount, CreatedDate) VALUES ([Lookup].fnGetAccountTypeIDByConstant('CHEQUING'), 'Test Account', 294.83, GETDATE())

GO

DECLARE @AccountID int,
@ScheduleId int

SELECT TOP 1 @AccountID = AccountID FROM [CashFlow].Account

DECLARE @TransactionTypeID int = [Lookup].fnGetTransactionTypeIDByConstant('EXPENSE')

-- Every Day 
INSERT INTO [CashFlow].[Schedule] (StartDate, EndDate, RecurrenceAmount, RecurrenceType, [DayOfMonth], [Ordinal], [DayOfWeek], [CreatedDate])
	VALUES ('2018-09-01', '2020-09-10', 1, 'Daily', null, null, null, GETDATE())
	SET @ScheduleId = SCOPE_IDENTITY(); 
INSERT INTO [CashFlow].[RecurringTransaction] (TransactionTypeID, AccountID, ScheduleId, Amount, [Description], CreatedDate) 
	VALUES (@TransactionTypeID, @AccountID, @ScheduleId, 2.55, 'Daily Transaction', GETDATE())
-- Weekly
INSERT INTO [CashFlow].[Schedule] (StartDate, EndDate, RecurrenceAmount, RecurrenceType, [DayOfMonth], [Ordinal], [DayOfWeek], [CreatedDate])
	VALUES ('2018-09-07', '2020-09-10', 1, 'Weekly', null, null, null, GETDATE())
	SET @ScheduleId = SCOPE_IDENTITY(); 
INSERT INTO [CashFlow].[RecurringTransaction] (TransactionTypeID, AccountID, ScheduleId, Amount, [Description], CreatedDate) 
	VALUES (@TransactionTypeID, @AccountID, @ScheduleId, 7.55, 'Weekly Transaction', GETDATE())
-- Bi-Weekly
INSERT INTO [CashFlow].[Schedule] (StartDate, EndDate, RecurrenceAmount, RecurrenceType, [DayOfMonth], [Ordinal], [DayOfWeek], [CreatedDate])
	VALUES ('2018-09-06', '2020-09-10', 2, 'Weekly', null, null, null, GETDATE())
	SET @ScheduleId = SCOPE_IDENTITY(); 
INSERT INTO [CashFlow].[RecurringTransaction] (TransactionTypeID, AccountID, ScheduleId, Amount, [Description], CreatedDate) 
	VALUES (@TransactionTypeID, @AccountID, @ScheduleId, 100.00, 'BiWeekly general', GETDATE())
-- Bi-Weekly
INSERT INTO [CashFlow].[Schedule] (StartDate, EndDate, RecurrenceAmount, RecurrenceType, [DayOfMonth], [Ordinal], [DayOfWeek], [CreatedDate])
	VALUES ('2018-09-06', '2020-09-10', 2, 'Weekly', null, null, null, GETDATE())
	SET @ScheduleId = SCOPE_IDENTITY(); 
INSERT INTO [CashFlow].[RecurringTransaction] (TransactionTypeID, AccountID, ScheduleId, Amount, [Description], CreatedDate) 
	VALUES (@TransactionTypeID, @AccountID, @ScheduleId, 100.00, 'Biweekly travel', GETDATE())
-- Monthly
INSERT INTO [CashFlow].[Schedule] (StartDate, EndDate, RecurrenceAmount, RecurrenceType, [DayOfMonth], [Ordinal], [DayOfWeek], [CreatedDate])
	VALUES ('2018-09-06', '2020-09-10', 1, 'Monthly', 01, null, null, GETDATE())
	SET @ScheduleId = SCOPE_IDENTITY(); 
INSERT INTO [CashFlow].[RecurringTransaction] (TransactionTypeID, AccountID, ScheduleId, Amount, [Description], CreatedDate) 
	VALUES (@TransactionTypeID, @AccountID, @ScheduleId, 700, 'Monthly Rent', GETDATE())
-- Monthly
INSERT INTO [CashFlow].[Schedule] (StartDate, EndDate, RecurrenceAmount, RecurrenceType, [DayOfMonth], [Ordinal], [DayOfWeek], [CreatedDate])
	VALUES ('2018-09-06', '2020-09-10', 1, 'Monthly', null, 'Last', 'Friday', GETDATE())
	SET @ScheduleId = SCOPE_IDENTITY(); 
INSERT INTO [CashFlow].[RecurringTransaction] (TransactionTypeID, AccountID, ScheduleId, Amount, [Description], CreatedDate) 
	VALUES (@TransactionTypeID, @AccountID, @ScheduleId, 102.15, 'Monthly Insurance', GETDATE())
-- Yearly 
INSERT INTO [CashFlow].[Schedule] (StartDate, EndDate, RecurrenceAmount, RecurrenceType, [DayOfMonth], [Ordinal], [DayOfWeek], [CreatedDate])
	VALUES ('2018-09-06', '2020-09-10', 1, 'Yearly', 01, null, null, GETDATE())
	SET @ScheduleId = SCOPE_IDENTITY(); 
INSERT INTO [CashFlow].[RecurringTransaction] (TransactionTypeID, AccountID, ScheduleId, Amount, [Description], CreatedDate) 
	VALUES (@TransactionTypeID, @AccountID, @ScheduleId, 54.98, 'Yearly CC cost', GETDATE())

GO