create table Control.SFTPProcess
(
	SFTPProcessId int not null,
	SFTPConfigId int not null,
	RemoteDirectory varchar(50) not null,
	LocalSourceDirectory varchar(100) not null,
	LocalProcessingDirectory varchar(100) null,
	LocalArchiveDirectory varchar(100) not null,
	ActiveFlag bit not null default 1
);
go
alter table Control.SFTPProcess add constraint PK_Control_SFTPProcess_SFTPProcessId primary key (SFTPProcessId);

go
alter table Control.SFTPProcess add constraint FK_Control_SFTPProcess_SFTPConfigId_Control_SFTPConfig_SFTPConfigId foreign key(SFTPConfigId) references Control.SFTPConfig(SFTPConfigId);