create table Control.SFTPConfig
(
	SFTPConfigId int not null,
	ServerName varchar(50) not null,
	UserName varchar(20) not null,
	Port int not null
);
go
alter table Control.SFTPConfig add constraint PK_Control_SFTPConfig_SFTPConfigId primary key (SFTPConfigId);