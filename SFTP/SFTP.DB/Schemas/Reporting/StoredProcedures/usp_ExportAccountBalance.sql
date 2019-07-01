create proc Reporting.usp_ExportAccountBalance
	@CreatedByBatchId int
as
BEGIN TRY
	select 
		AccountId, 
		BalanceDate, 
		AccountBalance, 
		CreatedByBatchId
	from 
		Reporting.AccountBalanceFeed
	where 
		CreatedByBatchId = @CreatedByBatchId
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH