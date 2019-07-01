create proc Control.usp_SetupSFTPProcessFileList
as
BEGIN TRY

	drop table if exists #SFTPProcessFileList
	select 
		SFTPProcessFileListId,
		SFTPProcessId,
		FileNameFormat, 
		ExtractSQL,
		ExportSQL,
		ImportTableName,
		ProcessType 
	into #SFTPProcessFileList
	from Control.SFTPProcessFileList
	where 1=2;

	insert into #SFTPProcessFileList (SFTPProcessFileListId, SFTPProcessId, FileNameFormat, ExtractSQL, ExportSQL, ImportTableName, ProcessType )
	select 1, 1, 'Datalygence_MonthEnd_AccountBalance_Out_YYYYMMDD.csv', 'exec Reporting.usp_ExtractAccountBalance', 'exec Reporting.usp_ExportAccountBalance',null, 'Upload' union all
	select 2, 1, 'Datalygence_MonthEnd_CustomerList_Out_YYYYMMDD.csv', 'exec Reporting.usp_ExtractCustomer', 'exec Reporting.usp_ExportCustomer',null, 'Upload' union all
	select 3, 2, 'Datalygence_MonthEnd_In_YYYYMMDD.csv', null, null,'AccountCollection', 'Download';

	merge Control.SFTPProcessFileList as target
	using #SFTPProcessFileList as source on target.SFTPProcessFileListId = source.SFTPProcessFileListId
	when matched and
		target.SFTPProcessId <> source.SFTPProcessId OR 
		target.FileNameFormat <> source.FileNameFormat OR 
		target.ExtractSQL <> source.ExtractSQL OR 
		target.ExportSQL <> source.ExportSQL OR 
		target.ImportTableName <> source.ImportTableName OR 
		target.ProcessType <> source.ProcessType 
	then update set
		target.SFTPProcessId = source.SFTPProcessId,
		target.FileNameFormat = source.FileNameFormat,
		target.ExtractSQL = source.ExtractSQL,
		target.ExportSQL = source.ExportSQL,
		target.ImportTableName = source.ImportTableName,
		target.ProcessType = source.ProcessType
	when not matched then
	insert
	(
		SFTPProcessFileListId,
		SFTPProcessId,
		FileNameFormat,
		ExtractSQL,
		ExportSQL,
		ImportTableName,
		ProcessType
	)
	values
	(
		source.SFTPProcessFileListId,
		source.SFTPProcessId,
		source.FileNameFormat,
		source.ExtractSQL,
		source.ExportSQL,
		source.ImportTableName,
		source.ProcessType
	);
END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH