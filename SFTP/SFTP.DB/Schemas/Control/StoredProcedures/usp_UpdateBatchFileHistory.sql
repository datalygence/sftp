create proc Control.usp_UpdateBatchFileHistory
	@SFTPBatchFileHistoryId int,
	@FileName varchar(100),
	@NumberOfRows int
as
BEGIN TRY
	update 
		Control.SFTPBatchFileHistory 
	set 
		FileName = @FileName, 
		NumberOfRows = @NumberOfRows 
	where  
	SFTPBatchFileHistoryId = @SFTPBatchFileHistoryId
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH