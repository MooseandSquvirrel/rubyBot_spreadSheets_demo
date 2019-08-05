#!/usr/env/bin ruby

####################################
# EXCELTESTPARSER REQUIRES
####################################
require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'
require 'date'
require 'capybara'
require 'csv'
require "google/apis/sheets_v4"
require "googleauth" 
require "googleauth/stores/file_token_store"
require "fileutils"
require "google_drive"
require 'open-uri'
####################################
# TEST_CREEP REQUIRES
####################################
require 'selenium-webdriver'
require 'pp'
require 'ap'
require 'rspec/expectations'
require 'io/console'
require 'twilio-ruby'
####################################
# MY FILES
####################################
require './fileMoveOldXlsx.rb'
require './welcomeLogin.rb'
require './bandClass.rb'
require './adminsList'
require './datesSection.rb'
require './driverLogin.rb'
require './allDrivers.rb'
require './productionDownloadFile'
require './timeStamps.rb'
require './allDrivers.rb'
require './grabXlsxB10.rb'
require './b10Driver.rb'
require './b10Parse.rb'
require './a2_Driver.rb'
require './grabXlsxA2.rb'
require './a2Parse.rb'
require './writer2.rb'
require './finalResultsToWrite.rb'
require './send_sms.rb'
require './headlessNavigate.rb'
require './browserDownload.rb'
require './parseObject.rb'
require './csvObjArray.rb'
require './try.rb'
####################################

# FUNCTION TO CHECK IF USER LOGGED INTO VPN AND BACKENDSYSTEM
def didYouLogin()
    puts "\n\nDID YOU LOG INTO -- VPN PULSE SECURE-- YET?! \n\n "
    sleep (3)
    puts "IF NOT, DO SO *** NOW *** OR THIS PROGRAM WILL CRASH AND INPUT WILL BE LOST :)...FOREVER.\n\n"
    sleep (5)
    puts "Press 'Enter' to begin."
    gets.strip
    puts "\n\n\n\n"
    puts "----------------------------------------------------------------"
end

# FUNCTION TO PRINT BANNERS
def bannerOutPut(file)
    File.open("#{file}").each do |line|
        puts line
        sleep (0.10)
    end
    sleep (2)
end

# FUNCTION RETURNS ARRAY OF EVENT NAMES FROM EACH EVENT
def getBandNumsArray(bandsArray)
    bandsArray = bandsArray.collect {|x| x}         #" I NEED TO FIGURE OUT HOW TO COLLECT ALL THE BAND NUMBERS INTO AN ARRAY FROM THEIR OBJECTS"
end

# FUNCTION RETURNS NEW BANDS FROM EVENTS COLLECTS FROM B3 PARSE FOR B7_2 DOWNLOADING CHECK (IF CELL CONTAINS ANY BANDNUMS FROM THIS ARRAY)
def getB72bandNums(bandsArray)
    b7_2bandNumsArray = bandsArray.collect {|x| x.newBandNumbsb7_2}         #" I NEED TO FIGURE OUT HOW TO COLLECT ALL THE BAND NUMBERS INTO AN ARRAY FROM THEIR OBJECTS"
end

# FUNCTION TO MOVE TO NEXT ARRAY OF EVENTS WTIH SAME DATE OR BEGIN NAVIGATION/DRIVER/ANALYSIS
def outerLoopOrGo()
    puts "\n"
    puts "----------------------------------------------------------------------------------"
    puts "If no more BANDs with -- different start dates -- to enter info for, type 'go' and hit 'Enter'."
    puts "Otherwise, hit 'Enter' to begin submitting a Summer Camp group with different dates."
    gets.strip != "go"
end

def addToCsv(bandsArrayToCsv)
    i = 0
    len = bandsArrayToCsv.length
    CSV.open("bandNums.csv", "a+") do |csv|
        while i < len
            if bandsArrayToCsv[i].bandNum == ""
                i += 1
            else 
                csv << ["#{bandsArrayToCsv[i].bandNum}"]
                puts "bandsArrayToCsv[i].bandNum: #{bandsArrayToCsv[i].bandNum}"
                i += 1
            end
        end
    end
end

def grabCSV() 
    csvArray = CSVArray.new
    CSV.foreach("bandNums.csv") do |row|
        puts row
        if row.nil? || row == ""
            next
        else
            csvArray.array << row
            # puts "csvArray.array"
            # puts csvArray.array
        end
    end
    puts "All BAND Numbers:"
    ap csvArray.array
    csvArray.array = csvArray.array.uniq
    csvArray
end

# SUPERFLOUS INTEGRAL LOADING MESSAGE
def loadingMessage()
    puts "\n"
    print "Thank you #{$_userNameVar}. Now I will do work for you :)"
    sleep(1)
    print '.'
    sleep(1)
    print '.'
    sleep(1)
    print '.'
    sleep(1)
    puts '.'
end

def mvDirRoot()
    puts "----- Moving Directories to reach ROOT Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    rootDir = '../'
    Dir.chdir(File.expand_path(rootDir))
    puts "Directory is now:"
    puts Dir.pwd
end

# ALL FUNCTIONS FOR B7_1 B3 A2
def go_b10_a2(bandsArray)

    puts "Working with this bandsArray:"
    ap bandsArray
    # bandsArray IS TOTAL BAND NUMBERS FROM CSV AFTER POTENTAIL APPENDING FROM USER, OR WITHOUT APPEND, 
    bandsArray = bandsArray.flatten
    puts "flattened"
    ap bandsArray
    puts "joined"
    bandsArray = bandsArray.join(", ")
    ap bandsArray

    # COUNTER FOR LENGTH OF BANDS ARRAY FOR USE IN FUNCTIONS BELOW
    bandsLength = bandsArray.length   
    #### loadingMessage()

    # DRIVERLOGIN.RB FUNCTION TO LOG INTO BACKEND AND FIND PROPER PAGE/IFRAME
    #### navigate($_userNameVar)                                                           
    sleep (7) 

    #### b10_a2_Driver(bandsLength, bandsArray)
    #### storeTable($_browser)
    #### checkTableDownload(bandsArray) ######### Trying bandsArray instead of bandsArray (might need to switch back to bandsArray)
    #### browserDownloadFiles($_files_href)
    #### grabXlsxB10()
    bandObjArray = []
    bandObjArray = b10Parse(bandsArray)

    bandsCount = bandObjArray.length
    mvDirRoot()
    writeToSheets(bandsCount, bandObjArray)

    puts "\nB10 Parsed\n"
 
    return  ####################################################       ######################

    grabXlsxA2()
    a2Parse(bandsArray)
    puts "\n\nA2 Parsed\n\n"
    band.bandsArray = bandsArray
    band.eventNamesArray = eventNamesArray
    # RESET GLOBAL ARRAY TO EMTPY FOR B7_2
    $_files_href = []
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               RUN                                                      "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def RUN
    #### fileMoveOldXlsx()
    # bannerOutPut("banner_Welcome.txt") #### SUDDENLY STOPPED WORKING WITHOUT CODE CHANGING
    #### didYouLogin()
    #### helloMessage()
    usrNumber = textMessage()
    userName()
    pwd()    
    eventTitleCounter = 0
    bandCounter = 0
    puts "Would you like to add a Band Number to the program to track Data on?\n\nEnter 'y' for YES or 'n' for NO."
    if ('y' == gets.strip)
        bandsArrayToCsv = []
        loop do 
            eventTitleCounter += 1
            event = Band.new
            event.getBandNum()
            if event.loopOrGo() == false
                bandsArrayToCsv << event
                break
            else 
                bandsArrayToCsv << event
            end
        end
        puts "bandsArrayToCsv:"
        ap bandsArrayToCsv
        addToCsv(bandsArrayToCsv)
    else
        puts "Running data on current band numbers in program..."
    end

    csvArray = []
    csvArray = grabCSV()

    go_b10_a2(csvArray.array)
    removeTEMPB10()
    removeTEMPA2()
    events = bandsArray.length
    writer2(bandsArray, lenOuterArray)
    # PRINTING OUT FINAL RESULTS BEFORE WRITING
    finalResults(bandsArray)
    system('say "Analysis, completed. Moving to next, date, group"')

    system('say "Program, Finished."')
    twilio(usrNumber)
end

RUN()
puts "Successful run completed."
