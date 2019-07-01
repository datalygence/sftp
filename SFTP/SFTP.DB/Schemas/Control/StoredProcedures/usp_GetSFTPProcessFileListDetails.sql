create proc Control.usp_GetSFTPProcessFileListDetails
	@SFTPProcessId int
as
BEGIN TRY
	select 
		SFTPProcessFileListId,
		SFTPProcessId, 
		FileNameFormat, 
		ExtractSQL, 
		ProcessType
	from 
		Control.SFTPProcessFileList
	where
		SFTPProcessId = @SFTPProcessId
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH