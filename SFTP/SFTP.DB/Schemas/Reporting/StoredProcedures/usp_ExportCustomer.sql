create proc Reporting.usp_ExportCustomer
	@CreatedByBatchId int
as
BEGIN TRY
	select 
		CustomerId,
		AccountId,
		FirstName,
		LastName,
		CreatedByBatchId
	from 
		Reporting.Customer
	where 
		CreatedByBatchId = @CreatedByBatchId
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH