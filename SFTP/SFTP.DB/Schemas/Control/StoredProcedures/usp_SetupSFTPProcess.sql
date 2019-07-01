create proc Control.usp_SetupSFTPProcess
as
BEGIN TRY
	drop table if exists #SFTPProcess;
	select 
		SFTPProcessId,
		SFTPConfigId,
		RemoteDirectory,
		LocalSourceDirectory,
		LocalProcessingDirectory,
		LocalArchiveDirectory,
		ActiveFlag
	into #SFTPProcess
	from 
		Control.SFTPProcess
	where 1 = 2;

	insert into #SFTPProcess (SFTPProcessId,SFTPConfigId,RemoteDirectory,LocalSourceDirectory,LocalProcessingDirectory,LocalArchiveDirectory,ActiveFlag)
	select 1,1, '.\Datalygence\MonthEnd', 'C:\Solutions\datalygence\sftp\SFTP\MonthEnd\Source', 'C:\Solutions\datalygence\sftp\SFTP\MonthEnd\Processing', 'C:\Solutions\datalygence\sftp\SFTP\MonthEnd\Archive',1 union all
	select 2,1, '.\Datalygence\MonthEnd', 'C:\Solutions\datalygence\sftp\SFTP\MonthEnd\Source', 'C:\Solutions\datalygence\sftp\SFTP\MonthEnd\Processing', 'C:\Solutions\datalygence\sftp\SFTP\MonthEnd\Archive',1;

	merge Control.SFTPProcess as target
	using #SFTPProcess as source on target.SFTPProcessId = source.SFTPProcessId
	when matched and
		target.SFTPConfigId <> source.SFTPConfigId OR 
		target.RemoteDirectory <> source.RemoteDirectory OR 
		target.LocalSourceDirectory <> source.LocalSourceDirectory OR 
		target.LocalProcessingDirectory <> source.LocalProcessingDirectory OR 
		target.LocalArchiveDirectory <> source.LocalArchiveDirectory OR 
		target.ActiveFlag <> source.ActiveFlag 
	then update set
		target.SFTPConfigId = source.SFTPConfigId,
		target.RemoteDirectory = source.RemoteDirectory,
		target.LocalSourceDirectory = source.LocalSourceDirectory,
		target.LocalProcessingDirectory = source.LocalProcessingDirectory,
		target.LocalArchiveDirectory = source.LocalArchiveDirectory,
		target.ActiveFlag = source.ActiveFlag
	when not matched then
	insert
	(
		SFTPProcessId,
		SFTPConfigId,
		RemoteDirectory,
		LocalSourceDirectory,
		LocalProcessingDirectory,
		LocalArchiveDirectory,
		ActiveFlag
	)
	values
	(
		source.SFTPProcessId,
		source.SFTPConfigId,
		source.RemoteDirectory,
		source.LocalSourceDirectory,
		source.LocalProcessingDirectory,
		source.LocalArchiveDirectory,
		source.ActiveFlag
	);
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH