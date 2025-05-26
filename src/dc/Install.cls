Class dc.Install Extends %RegisteredObject
{

ClassMethod ImportSQL()
{
    Do ##class(%SYSTEM.SQL.Schema).ImportDDL($lb("/tmp/chinook.sql"), "/tmp/chinook_ERRORS.sql")

    #; Set sql = 
    #; "SELECT inputRecordCount, statement" _
    #; "FROM %SQL_Diag.Result" _
    #; "where " _
    #; "    createTime >= current_date " _
    #; "    and statement like 'LOAD DATA FROM FILE ''/tmp/%.csv'' INTO ""CHINOOK"" . ""%"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' " _
    #; "    and (errorCount is not null  or errorCount > 0) " _
    #; "order by statement"
    #; Set rs = ##class(%SQL.Statement).%ExecDirect(, sql)
    #; While (rs.%Next()) {
    #;     Write "Error on the following statement: "_rs.statement, !
    #; }
    
    #; Set sql = 
    #; "select ref.statement, ref.inputRecordCount, curr.inputRecordCount  "_
    #; "from ( "_
    #; "	select 347 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/Album.csv'' INTO ""CHINOOK"" . ""ALBUM"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 275 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/Artist.csv'' INTO ""CHINOOK"" . ""ARTIST"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 59 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/Customer.csv'' INTO ""CHINOOK"" . ""CUSTOMER"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 8 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/Employee.csv'' INTO ""CHINOOK"" . ""EMPLOYEE"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 25 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/Genre.csv'' INTO ""CHINOOK"" . ""GENRE"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 412 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/Invoice.csv'' INTO ""CHINOOK"" . ""INVOICE"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 2239 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/InvoiceLine.csv'' INTO ""CHINOOK"" . ""INVOICELINE"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 5 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/MediaType.csv'' INTO ""CHINOOK"" . ""MEDIATYPE"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 18 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/Playlist.csv'' INTO ""CHINOOK"" . ""PLAYLIST"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 8715 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/PlaylistTrack.csv'' INTO ""CHINOOK"" . ""PLAYLISTTRACK"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; "	union  "_
    #; "	select 3503 as inputRecordCount, 'LOAD DATA FROM FILE ''/tmp/Track.csv'' INTO ""CHINOOK"" . ""TRACK"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }' as statement  "_
    #; ") ref  "_
    #; "full join ( "_
    #; "	SELECT top all inputRecordCount, statement "_
    #; "	FROM %SQL_Diag.Result "_
    #; "	where  "_
    #; "		createTime >= current_date  "_
    #; "		and statement like 'LOAD DATA FROM FILE ''/tmp/%.csv'' INTO ""CHINOOK"" . ""%"" USING { ""FROM"" :FROM { ""FILE"" :FILE { ""HEADER"" :HEADER TRUE } } }'  "_
    #; "	order by statement "_
    #; ") curr  "_
    #; "on curr.statement = ref.statement "_
    #; "where  "_
    #; "	ref.inputRecordCount is null  "_
    #; "	or curr.inputRecordCount is null  "_
    #; "	or ref.inputRecordCount <> curr.inputRecordCount "
    #; Set rs = ##class(%SQL.Statement).%ExecDirect(, sql)
    #; While (rs.%Next()) {
    #;     Write "Error on the following statement: "_rs.statement, !
    #; }
}

}