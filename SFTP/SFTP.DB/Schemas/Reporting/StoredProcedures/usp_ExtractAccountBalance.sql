create proc Reporting.usp_ExtractAccountBalance
	@CreatedByBatchId int
as
BEGIN TRY
	insert into Reporting.AccountBalanceFeed (AccountId,BalanceDate,AccountBalance,CreatedByBatchId)
	select 1, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId union all
	select 2, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId union all
	select 3, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId union all
	select 4, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId union all
	select 5, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId union all
	select 6, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId union all
	select 7, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId union all
	select 8, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId union all
	select 9, cast(getdate() as date), ROUND(RAND(CHECKSUM(NEWID())) * (1000), 2), @CreatedByBatchId
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH