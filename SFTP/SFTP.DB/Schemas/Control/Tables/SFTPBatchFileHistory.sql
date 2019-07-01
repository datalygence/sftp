create table Control.SFTPBatchFileHistory
(
	SFTPBatchFileHistoryId int not null identity(1,1),
	SFTPBatchHistoryId int not null,
	FileName varchar(100) not null,
	NumberOfRows int null,
	FileCreatedDatetime datetime not null default getdate(),
	SFTPUploadDatetime datetime null,
	ArchiveDatetime datetime null
);
go
alter table Control.SFTPBatchFileHistory add constraint PK_Control_SFTPBatchFileHistory_SFTPBatchFileHistoryId primary key (SFTPBatchFileHistoryId);

go
alter table Control.SFTPBatchFileHistory add constraint FK_Control_SFTPBatchFileHistory_SFTPBatchHistoryId_Control_SFTPBatchHistory_SFTPBatchHistoryId foreign key (SFTPBatchHistoryId) references Control.SFTPBatchHistory(SFTPBatchHistoryId);