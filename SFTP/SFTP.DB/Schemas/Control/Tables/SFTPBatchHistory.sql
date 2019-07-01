create table Control.SFTPBatchHistory
(
	SFTPBatchHistoryId int not null identity(1,1),
	SFTPProcessId int null,
	StartedDatetime datetime null,
	ExtractStartDatetime datetime null,
	ExtractEndDatetime datetime null,
	FileGenerationStartDatetime datetime null,
	FileGenerationEndDatetime datetime null,
	SFTPUploadStartDatetime datetime null,
	SFTPUploadEndDatetime datetime null,
	SFTPDownloadStartDatetime datetime null,
	SFTPDownloadEndDatetime datetime null,
	FileArchiveStartDatetime datetime null,
	FileArchiveEndDatetime datetime null,
	EndDatetime datetime null,
	Status varchar(50) not null
);
go
alter table Control.SFTPBatchHistory add constraint PK_Control_SFTPBatchHistory_SFTPBatchHistoryId primary key(SFTPBatchHistoryId);

go
alter table Control.SFTPBatchHistory add constraint FK_Control_SFTPBatchHistory_SFTPProcessId_Control_SFTPProcess_SFTPProcessId foreign key(SFTPProcessId) references Control.SFTPProcess(SFTPProcessId);