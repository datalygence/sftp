create proc Reporting.usp_ExtractCustomer
	@CreatedByBatchId int
as
BEGIN TRY
	insert into Reporting.Customer(AccountId, FirstName, LastName, CreatedByBatchId)
	select NEWID(), 'Jack', 'Ainsley', @CreatedByBatchId union all
	select NEWID(), 'Barnabe', 'Allerton', @CreatedByBatchId union all
	select NEWID(), 'Callum', 'Addington', @CreatedByBatchId union all
	select NEWID(), 'Gorden', 'Hastings', @CreatedByBatchId union all
	select NEWID(), 'Coloman', 'Kendall', @CreatedByBatchId union all
	select NEWID(), 'Adrian', 'Lindsey', @CreatedByBatchId union all
	select NEWID(), 'Ben', 'Northcott', @CreatedByBatchId
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH