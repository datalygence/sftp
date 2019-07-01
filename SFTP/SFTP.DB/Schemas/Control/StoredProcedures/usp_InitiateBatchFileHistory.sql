create proc Control.usp_InitiateBatchFileHistory
	@SFTPBatchHistoryId int,
	@SFTPBatchFileHistoryId int out
as
BEGIN TRY
	insert into Control.SFTPBatchFileHistory (SFTPBatchHistoryId) values (@SFTPBatchHistoryId)
	set  @SFTPBatchFileHistoryId = scope_identity()
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH