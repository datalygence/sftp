create proc Control.usp_CloseBatch
	@SFTPBatchHistoryId int,
	@Status varchar(50)
as
BEGIN TRY
	update 
		Control.SFTPBatchHistory 
	set 
		EndDatetime = getdate(), 
		Status = @Status
	where SFTPBatchHistoryId = @SFTPBatchHistoryId
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH