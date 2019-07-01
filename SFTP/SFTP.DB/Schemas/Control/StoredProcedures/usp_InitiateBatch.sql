create proc Control.usp_InitiateBatch
	@SFTPProcessId int,
	@SFTPBatchHistoryId int out
as
BEGIN TRY
	insert into Control.SFTPBatchHistory (SFTPProcessId, StartedDatetime, Status) values (@SFTPProcessId, getdate(), 'BatchInitiated');
	set @SFTPBatchHistoryId = Scope_identity()
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH