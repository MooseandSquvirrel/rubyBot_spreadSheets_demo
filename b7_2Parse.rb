# CHANGING DIRECTORIES (THIS ONE TO ACCESS TEMP_B7)
def mvDirB7_2()
    puts "----- Moving Directories to reach TEMP_B7_2 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b7Dir = '~/fixit/TEMP_B7_2'
    Dir.chdir(File.expand_path(b7Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

def adminCounterB72(band, worksheet)
    adminNumbArray = adminNumbers()
    return adminNumbArray
end


def parserb72(band, worksheet, adminNumbArray)
    # CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 1
    totalMemberCounter = 0
    nruCounter = 0
    gblNru = 0
    counter = 0
    nruArray = []
    
    while counter < worksheet.sheet_data.rows.size - 1
        cellOriginalBandNum = worksheet.sheet_data[index][7].value
        if band.newBandNumbsb7_2.include?("#{cellOriginalBandNum}")
            nruArray << cellOriginalBandNum
            nruCounter += 1
            index += 1
        else
            index += 1
        end
        counter += 1
    end

    finalNruArray = nruArray - adminNumbArray
    gblNru= finalNruArray.length - band.adminCount

    # **FINAL RESULT** gblNru, nruPerGbl, totalNru
    band.gblNru = gblNru.to_f
    band.nruPerGbl = (gblNru / band.newGblCount)
    band.totalNru = (band.nruCount + gblNru).to_f
   
end

# **FINAL RESULT** NRUCOUNT STORING RESULTS INTO ORIGINAL EVENT OBJECTS' INSTANCE VARIABLES
def resultsB7_2(eventName, band, worksheet)
 
    puts "==============================================================================================="
    puts "Results of Second B7:"
    puts "-----------------------------------"
    puts "band.gblNru: #{band.gblNru}"
    puts "band.nruPerGbl: #{band.nruPerGbl}"
    puts "band.totalNru: #{band.totalNru}"
    puts "-----------------------------------"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B7_2 Main Parser Function                                 "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# bandsArraywDates PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def b7_2Parse(events, bandsArraywDates)
    mvDirB7_2()

    # COLLECTS FILE(S) WITH .XLSX FORMAT (SHOULD ONLY BE ONE) IN ORDER TO PARSE IT
    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]
  
    i = 0
    bandNum = 0
    while i < events
        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")
        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB7first[0]
        # ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]
        # GETTING COUNT OF ADMIN NUMBS IN SPREADSHEET TO ME SUBTRACTED FROM TOTAL NRU COUNTS IN PARSERB72 (MIGHT BE NO ADMINS IN B7_2, THIS IS JUST FOR EDGE CASE POTENTIALLY)
        adminNumbArray = adminCounterB72(band, worksheet)
        parserb72(band, worksheet, adminNumbArray)
        resultsB7_2(band.eventName, band, worksheet)
        i += 1 
    end
end
