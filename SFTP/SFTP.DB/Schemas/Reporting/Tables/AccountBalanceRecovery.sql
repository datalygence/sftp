create table Reporting.AccountBalanceRecovery
(
	AccountId int not null,
	CollectedDate datetime not null,
	CollectedAmount decimal(16,2) not null,
	CreatedByBatchId int not null
);