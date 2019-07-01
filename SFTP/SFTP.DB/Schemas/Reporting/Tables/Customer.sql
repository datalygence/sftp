Create table Reporting.Customer
(
	CustomerId int identity(1,1) not null,
	AccountId varchar(40) not null,
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	CreatedByBatchId int not null
);

go
alter table Reporting.Customer add constraint PK_Reporting_Customer_CustomerId primary key(CustomerId);