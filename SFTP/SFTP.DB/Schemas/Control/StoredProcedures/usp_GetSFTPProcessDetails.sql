create proc Control.usp_GetSFTPProcessDetails
	@SFTPProcessId int,
	@SFTPConfigId int out,
	@RemoteDirectory varchar(50) out,
	@LocalSourceDirectory varchar(100) out,
	@LocalProcessingDirectory varchar(100) out,
	@LocalArchiveDirectory varchar(100) out,
	@ActiveFlag bit out,

	@ServerName varchar(50) out,
	@UserName varchar(20) out,
	@Port int out
as
BEGIN TRY
	select
		@SFTPConfigId = SFTPConfigId,
		@RemoteDirectory = RemoteDirectory,
		@LocalSourceDirectory = LocalSourceDirectory,
		@LocalProcessingDirectory = LocalProcessingDirectory,
		@LocalArchiveDirectory = LocalArchiveDirectory,
		@ActiveFlag = ActiveFlag
	from Control.SFTPProcess
	where SFTPProcessId = @SFTPProcessId;

	exec  Control.usp_GetSFTPConfigDetails @SFTPConfigId, @ServerName = @ServerName out, @UserName = @UserName out, @Port = @Port out;

END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH