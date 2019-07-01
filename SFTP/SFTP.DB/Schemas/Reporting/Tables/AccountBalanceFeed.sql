create table Reporting.AccountBalanceFeed
(
	AccountId int not null,
	BalanceDate datetime not null,
	AccountBalance decimal(16,2) not null,
	CreatedByBatchId int not null,
	CreatedDatetime datetime not null default getdate()
);