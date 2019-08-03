# MOVE TO PROPER DIRECTORY FOR PARSING
def mvDirB3()
    puts "----- Moving Directories to reach TEMP_B3 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b3Dir = '~/fixit/TEMP_B3'
    Dir.chdir(File.expand_path(b3Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

# COACHES COUNT FOR EVENT/BAND 
def coachesCount(band, worksheet, b3TotalRowCount, adminsArray, bandNum)
    band.coachesCount = band.totalMemberCount - 5
end

def nruPercentage(band)
    band.nruPercentage = ("#{((band.nruCount / band.coachesCount).round(2) * 100)}%")
end

# TOTAL LEADER COUNT FOR EVENT/BAND
def totalLeaderCount(band, worksheet, b3TotalRowCount, adminsArray, datesArray, bandNum, adminsWithBANDName)
    leaderArray = []
    totalLeaderArray = []
    index = 1
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < b3TotalRowCount
        if not worksheet.sheet_data[index][10].nil?
            cellDateCreated = worksheet.sheet_data[index][10].value
            cellCoachesName = worksheet.sheet_data[index][5].value
            cellBandNum = worksheet.sheet_data[index][0].value
            if cellBandNum == bandNum 
                # IF -NOT- IN adminsArray THEN IT IS COACH
                if not adminsArray.include?("#{cellCoachesName}")
                    if not adminsWithBANDName.include?("#{cellCoachesName}")
                        # STORING ALL LEADER NAMES (MULTIPLES INCLUDED)
                        leaderArray << worksheet.sheet_data[index][5].value
                    end
                end
            end
        end
        index += 1
    end
    # DELETES MULTIPLES OF LEADERS
    draftLeaderArray = leaderArray.uniq - adminsArray

    # TO FLOAT FOR DIVISION PURPOSES LATER
    totalLeaderArrayLength = draftLeaderArray.length.to_f

    band.totalLeaderCount = totalLeaderArrayLength
end

# NEW LEADER COUNT FOR EVENT/BAND
def newLeaderCount(band, worksheet, b3TotalRowCount, adminsArray, datesArray, bandNum, adminsWithBANDName)
    newLeaderArray = []
    index = 1
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < b3TotalRowCount
        if not worksheet.sheet_data[index][10].nil?
            cellDateCreated = worksheet.sheet_data[index][10].value
            cellCoachesName = worksheet.sheet_data[index][5].value
            cellBandNum = worksheet.sheet_data[index][0].value
            if cellBandNum == bandNum 
                if not adminsArray.include?("#{cellCoachesName}")
                    # DATES BELOW 'DECIDES' IF LEADER IS NEW
                    if datesArray.include?("#{cellDateCreated}")
                        if not adminsWithBANDName.include?("#{cellCoachesName}")
                            newLeaderArray << worksheet.sheet_data[index][5].value
                        end
                    end
                end
            end
        end
        index += 1
    end
    # DELETES MULTIPLES OF LEADERS
    tempNewLeaderArray = newLeaderArray.uniq

    # TO FLOAT FOR DIVISION PURPOSES LATER
    newLeaderArrayLength = tempNewLeaderArray.length.to_f

    band.newLeaderCount = newLeaderArrayLength
end

# NEW GBL COUNT FOR EVENT/BAND && NEW BAND NUMBERS FOR B7-2 PARSE/DRIVE.RB
def newGblCount(band, worksheet, b3TotalRowCount, adminsArray, datesArray, bandNum)
    newGblArray = []
    newBandNumbsb7_2 = []
    index = 1
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < b3TotalRowCount
        if not worksheet.sheet_data[index][10].nil?
            cellDateCreated = worksheet.sheet_data[index][10].value
            cellCoachesName = worksheet.sheet_data[index][5].value
            cellBandMemSize = worksheet.sheet_data[index][14].value.to_i
            cellBandNum = worksheet.sheet_data[index][0].value
            if cellBandNum == bandNum 
                if not adminsArray.include?("#{cellCoachesName}")
                    # DATES BELOW 'DECIDES' IF LEADER IS NEW
                    if datesArray.include?("#{cellDateCreated}")
                        if cellBandMemSize > 1
                            newGblArray << worksheet.sheet_data[index][5].value
                            # COLLECTING BAND NUMBER FOR B7-2 PARSE/DRIVE.RB
                            newBandNumbsb7_2 << worksheet.sheet_data[index][7].value
                        end
                    end
                end
            end
        end
        index += 1
    end
    # TO FLOAT FOR DIVISION PURPOSES LATER
    tempGblArrayLength = newGblArray.length.to_f

    band.newGblCount = tempGblArrayLength
    band.newBandNumbsb7_2 = newBandNumbsb7_2
end

# NEW LEADER AVG FUNCTION
def newLeaderPerc(band, coachesCount, newLeaderCount)
    newLeaderPerc = "#{((newLeaderCount / coachesCount).round(2) * 100)}%"
    band.newLeaderPerc = newLeaderPerc
end

# NEW GBL PERC FUNCTION
def newGblPerc(band)
    newGblPerc = "#{((band.newGblCount / band.newLeaderCount).round(2) * 100)}%"
    band.newGblPerc = newGblPerc
end

# EXTRANEOUS PRINT STATEMENT TO SHOW RESULTS OF B3 LOOP (PER EVENT)
def resultsB3(band, eventName)

    puts "==============================================================================================="
    puts "Results of first B3 (#{eventName})"
    puts "-----------------------------------"
    puts "totalMemberCount: #{band.totalMemberCount}"
    puts "nruPercentage: #{band.nruPercentage}"
    puts "coachesCount: #{band.coachesCount}"
    puts "totalLeaderCount: #{band.totalLeaderCount}"
    puts "newLeaderCount: #{band.newLeaderCount}"
    puts "newGblCount: #{band.newGblCount}"
    puts "newLeaderPerc: #{band.newLeaderPerc}%"
    puts "newGblPerc: #{band.newGblPerc}%"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B3 Loop Main                                              "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def b3Parse(eventNumsArray, bandsArraywDates)

    # SETTING UP ARRAY OF ADMINS NAMES FROM ADMINS EXCEL SPREADSHEET -- FOR USE IN B3 (AND B7.1?) TO REMOVE ADMINS WHO CREATED BANDS
    # **** THIS DOES NOT INCLUDE 'BAND' NAME AS ADMIN ****S
    adminsArray = adminsList()

    # SETTING UP ARRAY WITH 'BAND' NAME INCLUDED WTIH ALL OTHER ADMINS TOO ( EVENTUALLY DELETE ABOVE CODE AFTER REPLACING FUNCTIONS WITH BELOW CODE)
    adminsWithBANDName = adminsNamesList()

    # Move to TEMP_B3
    mvDirB3()

    # COLLECT FILE NAME(S) IN TEMP_B3 (JUST WANT IT TO BE ONE BUT MIGHT GET MULTIPLES IF NOT WORKING PROPERLY)
    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]

    i = 0
    bandNum = 0
    while i < eventNumsArray.length
        workbookB3 = RubyXL::Parser.parse("#{fileNamesArray[0]}")
        # DEFINES WORKBOOK AS WORKSHEET
        worksheet = workbookB3[0]
        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]
        # USE TO ITERATE IN filterBandNums FUNCTION TO GRAB ROW COUNT SPECIFIC FOR EACH BAND IN ORDER TO ITERATE IN LATER FUNCTIONS
        b3TotalRowCount = worksheet.sheet_data.rows.size - 1
        # **FINAL RESULT** SAVE COACHESCOUNT (USED IN B3 AND FINAL RESULT GRAPH) - STORED INTO RESULT IN BAND OBJECT
        coachesCount(band, worksheet, b3TotalRowCount, adminsArray, band.bandNum)
        # **FINAL RESULT** SAVE NRUPERCENTAGE - STORED INTO RESULT IN BAND OBJECT
        nruPercentage(band)
        # **FINAL RESULT** totalLeadersCount - STORED INTO RESULT IN BAND OBJECT
        totalLeaderCount(band, worksheet, b3TotalRowCount, adminsArray, band.datesArray, band.bandNum, adminsWithBANDName)
        # **FINAL RESULT** newLeaderCount - STORED INTO RESULT IN BAND OBJECT
        newLeaderCount(band, worksheet, b3TotalRowCount, adminsArray, band.datesArray, band.bandNum, adminsWithBANDName)
        # **FINAL RESULT** new_GBL_LeaderCount - STORED INTO RESULT IN BAND OBJECT
        newGblCount(band, worksheet, b3TotalRowCount, adminsArray, band.datesArray, band.bandNum)
        # **FINAL RESULT** newLeaderPerc - STORED INTO RESULT IN BAND OBJECT
        newLeaderPerc(band, band.coachesCount, band.newLeaderCount)
        # RESULTS PRINTED FOR B3 FOR ONE EVENT
        resultsB3(band, band.eventName)
        i += 1
    end
end
