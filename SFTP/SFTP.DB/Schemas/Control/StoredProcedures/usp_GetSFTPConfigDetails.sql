create proc Control.usp_GetSFTPConfigDetails
	@SFTPConfigId int,
	@ServerName varchar(50) out,
	@UserName varchar(20) out,
	@Port int out
as
BEGIN TRY
	select 
		@ServerName = ServerName,
		@UserName = UserName,
		@Port = Port
	from 
		Control.SFTPConfig
	where 
		SFTPConfigId = @SFTPConfigId;
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH