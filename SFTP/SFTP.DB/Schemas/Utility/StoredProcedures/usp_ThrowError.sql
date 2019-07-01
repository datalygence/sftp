create procedure Utility.usp_ThrowError
    @BatchId int = null,
    @ServerName sysname = null,
    @DatabaseName sysname = null
as

set nocount on;
declare @ProcReturn int = 0;

begin
    declare
        @ErrorDateTime datetime2(7),
        @ErrorNumber int,
        @ErrorSeverity int,
        @ErrorState int,
        @ErrorLine int,
        @ErrorProcedure sysname,
        @ErrorMessage nvarchar(max);

    set @ErrorDateTime = sysdatetime();

    if (nullif(@ServerName, N'') is null)
        set @ServerName = N'(Unspecified)';

    if (nullif(@DatabaseName, N'') is null)
        set @DatabaseName = N'(Unspecified)';
    
    if (error_number() is null)
        return @ProcReturn;
		    
    select
        @ErrorNumber = error_number(),
        @ErrorSeverity = error_severity(),
        @ErrorState = error_state(),
        @ErrorProcedure = isnull(error_procedure(), N'-'),
        @ErrorLine = error_line(),
        @ErrorMessage = error_message();
    
	set @ErrorMessage = N'Error %d, Severity %d, State %d, Server %s, Database %s, ' + N'Procedure %s, Line %d, Message: '+ @ErrorMessage;

    raiserror (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number
        @ErrorSeverity,  -- parameter: original error severity
        @ErrorState,     -- parameter: original error state
        @ServerName,	 -- input parameter	
        @DatabaseName,	 -- input parameter
        @ErrorProcedure, -- parameter: original error procedure name
        @ErrorLine       -- parameter: original error line number
        );
end;
return @ProcReturn;
