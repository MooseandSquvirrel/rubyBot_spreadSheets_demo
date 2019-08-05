# CHANGING DIRECTORIES (THIS ONE TO ACCESS TEMP_B10)
def mvDirB10()
    puts "----- Moving Directories to reach TEMP_B10 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b7Dir = '~/spreadEm/spreadSheets/TEMP_B10'
    Dir.chdir(File.expand_path(b7Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

def parserB10(worksheet)
    index = 1
    counter = 0
    b10ResultsBandsArray = []
    while counter < worksheet.sheet_data.rows.size - 1
        bandObj = ParseBandObj.new
        bandObj.band_num = worksheet.sheet_data[index][0].value 
        bandObj.total_members = worksheet.sheet_data[index][3].value
        bandObj.non_admins = worksheet.sheet_data[index][5].value
        bandObj.nru1 = worksheet.sheet_data[index][6].value
        bandObj.EXUs = worksheet.sheet_data[index][7].value
        bandObj.new_leaders = worksheet.sheet_data[index][9].value
        bandObj.new_leader_bands = worksheet.sheet_data[index][10].value
        bandObj.GBLs = worksheet.sheet_data[index][11].value
        bandObj.nru2 = worksheet.sheet_data[index][12].value
        bandObj.existing_leaders = worksheet.sheet_data[index][14].value
        bandObj.existing_leader_bands = worksheet.sheet_data[index][15].value
        bandObj.existingGBL = worksheet.sheet_data[index][16].value
        bandObj.nru3 = worksheet.sheet_data[index][17].value
        b10ResultsBandsArray << bandObj
        index += 1
        counter += 1
    end
    puts "(parserB10)b10ResultsBandsArray:"
    ap b10ResultsBandsArray
end

# **FINAL RESULT** NRUCOUNT STORING RESULTS INTO ORIGINAL EVENT OBJECTS' INSTANCE VARIABLES
def resultsB10(bandObj, worksheet)
    puts "==============================================================================================="
    puts "Results of B10:"
    puts "-----------------------------------"
    
    puts "bandObj.band_num :" 
    puts bandObj.band_num  

    puts "bandObj.total_members :"
    puts bandObj.total_members 

    puts "bandObj.non_admins :"
    puts bandObj.non_admins 

    puts "bandObj.nru1 :"
    puts bandObj.nru1 

    puts "bandObj.EXUs :"
    puts bandObj.EXUs 

    puts "bandObj.new_leaders :"
    puts bandObj.new_leaders 

    puts "bandObj.new_leader_bands :"
    puts bandObj.new_leader_bands 

    puts" bandObj.GBLs :"
    puts bandObj.GBLs 

    puts "bandObj.nru2 :"
    puts bandObj.nru2 

    puts "bandObj.existing_leaders :"
    puts bandObj.existing_leaders 

    puts "bandObj.existing_leader_bands :"
    puts bandObj.existing_leader_bands 

    puts "bandObj.existingGBL :"
    puts bandObj.existingGBL 

    puts "bandObj.nru3 :"
    puts bandObj.nru3 

    puts "-----------------------------------"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B7_1 Main Parser Function                                 "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# bandsArraywDates PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def b10Parse(bandsArray)
    # MOVE TO TEMP_B10
    mvDirB10()
    # COLLECTS FILE(S) WITH .XLSX FORMAT (SHOULD ONLY BE ONE) IN ORDER TO PARSE IT
    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]
    i = 0
    workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")
    # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
    worksheet = workbookB7first[0]

    b10ResultsBandsArray = []
    b10ResultsBandsArray = parserB10(worksheet)

    #### API Googlespreadsheets function to add b10Resultsarray with while loop to sheets

    puts "sleeping for 2 seconds"
    sleep(2)
    len = b10ResultsBandsArray.length
    i = 0
    count = 0
    until i == len - 1
        band = b10ResultsBandsArray[i]
        resultsB10(band, worksheet)
        count += 1
        puts "count: #{count}"
        i += 1
        puts "len #{len}"
    end
    
    return b10ResultsBandsArray
end

