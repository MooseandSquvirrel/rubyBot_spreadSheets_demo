
class Band
        
    @@stringsHash = {:band_nums => "Enter a new Band number to evaluate for B10/A2, then hit 'enter':"}

    # COUNTER TO IGNORE THE 'puts stringsHash[:band_num]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    def getBandNum()
        counter = 0
        band_num_check = ""
        @bandNum = ""
        while band_num_check != 'y' || band_num_check != "exit"
            if counter == 0
                puts @@stringsHash[:band_nums]
            end
            counter += 1
            band_num = gets.strip
            if band_num == "exit"
                return
            end
            puts "\n"
            puts "Is '#{band_num}' the correct BAND number for #{@eventName}?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
            band_num_check = gets.strip
            if band_num_check == "exit"
                return
            end
            if band_num_check == 'y'
                @bandNum = band_num 
                break
            end
            if band_num_check == 'n'
                puts "\n"
                puts "-------------------------------------------------------"
                puts "Re-Enter the correct BAND number for '#{@eventName}' and press 'Enter':"
                redo
            end
            if band_num_check != 'y' || band_num_check != 'n'
                puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
                puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
                puts "\n"
                puts "**** Now Re-Enter the BAND number for #{@eventName} 'Enter'. ****"
                redo
            end
        end
    end

    # GETTER TO DEFINE FINAL @bandNum RESULT FOR ACCESSING THE INSTANCE VARIABLE OUTSIDE THE CLASS WITH DOT NOTATION
    def bandNum
        @bandNum
    end

    # FOR ARRAY OF DATES TO INCLUDE OR EXCLUDE WHILE PARSING EACH B7/B3
    attr_accessor :datesArray, :a2StartDate, :a2EndDate

    # FOR NEW BAND NUMBERS FROM THE NEW BANDS CREATING DURING EVENT FOR B7-2 DRIVE/PARSE.RB
    attr_accessor :newBandNumbsb7_2

    # FOR HOLDING THE adminsCount FOR SUBTRACTING FROM VARIABLES IN THE LATER PARSING
    attr_accessor :adminCount

    # FOR TOTAL BANDSARRAY AND EVENTNAMESARRAY STORAGE IN ORDER TO ACCESS IN 'GO' FUNCTIONS IN RUN
    attr_accessor :bandsArray, :eventNamesArray

    "-----------------------------------------------------------------------------------------------------------------------------------------------------"
    "                                                           Result Variables for B7.1, B3, A2, and B7.2"
    "-----------------------------------------------------------------------------------------------------------------------------------------------------"
        
    attr_accessor :campDates, :totalMemberCount, :coachesCount, :nruCount, :nruPercentage, :totalLeaderCount, :newLeaderCount, :newLeaderPerc, :newGblCount, 
        :gblAvg, :gblNru, :nruPerGbl, :totalNru, :activitySum, :uniqueUserActivity, :sumTotalMemberAvg, :uniqueMemberavg, :testCoachesCount, :newGblPerc

    # hoursMinutes2 IS TO ACCOUNT FOR EXTRA MINUTE THAT MIGHT NEED TO BE ACCOUNTED FOR FOR CHECKING TIME SUBMITED FOR CELL CHECKING FOR DOWNLOAD LINKS
    attr_accessor :hoursMinutesA2_backUp, :hoursMinutesB71_backUp, :hoursMinutesB3_backUp, :hoursMinutes2, :hoursMinutesB72_backUp
    "-----------------------------------------------------------------------------------------------------------------------------------------------------"
    "-----------------------------------------------------------------------------------------------------------------------------------------------------"

    # bandsArray << stringsHash
    def loopOrGo()
        puts "\n"
        puts "----------------------------------------------------------------------------------"
        puts "If no more BANDs to enter info for, type 'go' and hit 'Enter'."
        puts "Otherwise, hit 'Enter' to begin submitting another BAND number."
        gets.strip != "go"
    end
end 
