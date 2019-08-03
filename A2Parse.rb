# CHANGING DIRECTORIES (THIS ONE TO ACCESS TEMP_A2)
def mvDirA2()
    puts "----- Moving Directories to reach TEMP_A2 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    a2Dir = '~/fixit/TEMP_A2'
    Dir.chdir(File.expand_path(a2Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

def parserA2(bandNumber, band, worksheet)
    # CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
   
    index = 1
    totalMemberCounter = 0
    nruCounter = 0
    counter = 0
    while counter < worksheet.sheet_data.rows.size - 1
        cellBandNum = worksheet.sheet_data[index][0].value
        cellCurrentMember = worksheet.sheet_data[index][3].value
        if cellActivitySum_Cnt = worksheet.sheet_data[index][14].nil?
            cellActivitySum_Cnt = 0
        else
            cellActivitySum_Cnt = worksheet.sheet_data[index][14].value
        end
        if cellUniqueUsers_Uccu = worksheet.sheet_data[index][15].nil?
            cellUniqueUsers_Uccu = 0
        else
            cellUniqueUsers_Uccu = worksheet.sheet_data[index][15].value
        end
        # IF USER ENTERED BANDNUMBER MATCHES BAND NUMBER FIRST ROW (IDENTIFY CORRECT BAND TO PARSE IN DOCUMENT)
        if bandNumber == cellBandNum
            # **FINAL RESULTS FOR USER ACTIVITY** 
            band.activitySum = cellActivitySum_Cnt
            band.uniqueUserActivity = cellUniqueUsers_Uccu
            band.sumTotalMemberAvg = (cellActivitySum_Cnt.to_f / cellCurrentMember.to_f) 
            band.uniqueMemberavg = (cellUniqueUsers_Uccu.to_f / cellCurrentMember.to_f)
        else
            index += 1
        end
        counter += 1
    end
end

# **FINAL RESULT** NRUCOUNT STORING RESULTS INTO ORIGINAL EVENT OBJECTS' INSTANCE VARIABLES
def resultsA2(eventName, band, worksheet)
 
    puts "==============================================================================================="
    puts "Results of A2 (#{eventName}):"
    puts "-----------------------------------"
    puts "band.activitySum = #{band.activitySum}"
    puts "band.uniqueUserActivity = #{band.uniqueUserActivity}"
    puts "band.sumTotalMemberAvg = #{band.sumTotalMemberAvg}" 
    puts "band.uniqueMemberavg = #{band.uniqueMemberavg}"
    puts "-----------------------------------"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              A2 Main Parser Function                                   "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# bandsArray PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def a2Parse(eventNumsArray, bandsArray)

    # MOVE TO TEMP_A2
    mvDirA2()

    # COLLECTS FILE(S) WITH .XLSX FORMAT (SHOULD ONLY BE ONE) IN ORDER TO PARSE IT
    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]

    i = 0
    bandNum = 0
    while i < eventNumsArray.length
        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")
        
        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB7first[0]
        
        # ASSIGNS BAND OBJECT FROM ARRAY OF BANDS
        band = bandsArray[i]
        
        bandNumber = eventNumsArray[bandNum]
        parserA2(bandNumber, band, worksheet)
        resultsA2(band.eventName, band, worksheet)
        i += 1
        bandNum += 1
    end
end

