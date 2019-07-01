create table Control.SFTPProcessFileList
(
	SFTPProcessFileListId int not null,
	SFTPProcessId int not null,
	FileNameFormat varchar(100) not null, 
	ExtractSQL varchar(255) null,
	ExportSQL varchar(255) null,
	ImportTableName varchar(100) null,
	ProcessType varchar(10) not null,
	ActiveFlag bit not null default 1
);
go
alter table Control.SFTPProcessFileList add constraint PK_Control_SFTPProcessFileList_SFTPProcessFileListId primary key (SFTPProcessFileListId);

go
alter table Control.SFTPProcessFileList add constraint FK_Control_SFTPProcessFileList_SFTPProcessId_Control_SFTPProcess_SFTPProcessId foreign key(SFTPProcessId) references Control.SFTPProcess(SFTPProcessId);