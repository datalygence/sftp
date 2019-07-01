create proc Control.usp_UpdateBatch
	@SFTPBatchHistoryId int,
	@Stage varchar(20),
	@State varchar(20),
	@Status varchar(20)
as
BEGIN TRY

	if @Stage = 'Extract'
	begin
		if @State = 'Start'
			begin
				update Control.SFTPBatchHistory set ExtractStartDatetime = getdate(), Status = 'ExtractStarted' where SFTPBatchHistoryId = @SFTPBatchHistoryId
			end
		if @State = 'End'
			if @Status = 'Succeeded'
				begin
					update Control.SFTPBatchHistory set ExtractEndDatetime = getdate(), Status = 'ExtractSucceeded' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
			if @Status = 'Failed'
				begin
					update Control.SFTPBatchHistory set ExtractEndDatetime = getdate(), Status = 'ExtractFailed' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
	end

	if @Stage = 'FileGeneration'
	begin
		if @State = 'Start'
			begin
				update Control.SFTPBatchHistory set FileGenerationStartDatetime = getdate(), Status = 'FileGenerationStarted' where SFTPBatchHistoryId = @SFTPBatchHistoryId
			end
		if @State = 'End'
			if @Status = 'Succeeded'
				begin
					update Control.SFTPBatchHistory set FileGenerationEndDatetime = getdate(), Status = 'FileGenerationSucceeded' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
			if @Status = 'Failed'
				begin
					update Control.SFTPBatchHistory set FileGenerationEndDatetime = getdate(), Status = 'FileGenerationFailed' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
	end
	
	if @Stage = 'SFTPUpload'
	begin
		if @State = 'Start'
			begin
				update Control.SFTPBatchHistory set SFTPUploadStartDatetime = getdate(), Status = 'SFTPUploadStarted' where SFTPBatchHistoryId = @SFTPBatchHistoryId
			end
		if @State = 'End'
			if @Status = 'Succeeded'
				begin
					update Control.SFTPBatchHistory set SFTPUploadEndDatetime = getdate(), Status = 'SFTPUploadSucceeded' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
			if @Status = 'Failed'
				begin
					update Control.SFTPBatchHistory set SFTPUploadEndDatetime = getdate(), Status = 'SFTPUploadFailed' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
	end

	if @Stage = 'SFTPDownload'
	begin
		if @State = 'Start'
			begin
				update Control.SFTPBatchHistory set SFTPDownloadStartDatetime = getdate(), Status = 'SFTPDownloadStarted' where SFTPBatchHistoryId = @SFTPBatchHistoryId
			end
		if @State = 'End'
			if @Status = 'Succeeded'
				begin
					update Control.SFTPBatchHistory set SFTPDownloadEndDatetime = getdate(), Status = 'SFTPDownloadSucceeded' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
			if @Status = 'Failed'
				begin
					update Control.SFTPBatchHistory set SFTPDownloadEndDatetime = getdate(), Status = 'SFTPDownloadFailed' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
	end

	if @Stage = 'FileArchive'
	begin
		if @State = 'Start'
			begin
				update Control.SFTPBatchHistory set FileArchiveStartDatetime = getdate(), Status = 'FileArchiveStarted' where SFTPBatchHistoryId = @SFTPBatchHistoryId
			end
		if @State = 'End'
			if @Status = 'Succeeded'
				begin
					update Control.SFTPBatchHistory set FileArchiveEndDatetime = getdate(), Status = 'FileArchiveSucceeded' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
			if @Status = 'Failed'
				begin
					update Control.SFTPBatchHistory set FileArchiveEndDatetime = getdate(), Status = 'FileArchiveFailed' where SFTPBatchHistoryId = @SFTPBatchHistoryId
				end
	end

END TRY
BEGIN CATCH 
	declare @DatabaseName sysname = db_name()
	exec Utility.usp_ThrowError @ServerName = @@servername, @DatabaseName = @DatabaseName
END CATCH