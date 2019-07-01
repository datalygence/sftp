create proc Control.usp_SetupSFTPConfig
as
BEGIN TRY
	drop table if exists #SFTPConfig;
	select 
		SFTPConfigId, 
		ServerName,
		UserName,
		Port 
	into #SFTPConfig 
	from 
		Control.SFTPConfig 
	where 1 = 2;

	insert into #SFTPConfig (SFTPConfigId, ServerName,UserName,Port)
	select 1, '127.0.0.1', 'datalygence', 22

	merge Control.SFTPConfig as target
	using #SFTPConfig as source on target.SFTPConfigId = source.SFTPConfigId
	when matched and
		target.ServerName <> source.ServerName OR
		target.UserName <> source.UserName OR
		target.Port <> source.Port
	then update set
		target.ServerName = source.ServerName,
		target.UserName = source.UserName,
		target.Port = source.Port
	when not matched then
	insert
	(
		SFTPConfigId, 
		ServerName,
		UserName,
		Port
	)
	values
	(
		source.SFTPConfigId,
		source.ServerName,
		source.UserName,
		source.Port
	);
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH