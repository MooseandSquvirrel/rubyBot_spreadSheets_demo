"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                  Function Entering Bands for Second B7                                 "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def mvDirRoot()
    puts "----- Moving Directories to reach Main Directory of Fixit -----"
    puts "Directory before:"
    puts Dir.pwd
    mainDir = '~/fixit'
    Dir.chdir(File.expand_path(mainDir))
    puts "Directory is now:"
    puts Dir.pwd
end

def b7_2Driver(bandsArray)
    mvDirRoot()
    navigate($_userNameVar)
  
    # GETTING ALL BAND NUMBS WITH .collect (ALREADY PERFORMED ABOVE TO GET THE (JUST STORED THAT ARRAY INTO bandsArray)))
    bandsInnerArray = bandsArray.collect {|x| x.newBandNumbsb7_2}

    # .compact REMOVES ANY POTENTIAL NIL VALUES OF NO GBLS/BAND NUMBERS FOR NEW BANDS CREATED FROM B3 -- POTENTIAL EDGE CASE
    bandsInnerArray = bandsInnerArray.compact

    bandNameCounter = 0
    # STORING ALL FUNCTION OPTIONS AND SELECTING B7
    # INTERACTING WITH DROPDOWN BOX
    select_list = $_wait.until {
        element = $_browser.find_element(:xpath, "//*[@id='templateNo']")
        element if element.displayed?
    }

    # EXTRACTING ALL OPTIONS FROM THE DROPDOWN BOX
    options=select_list.find_elements(:tag_name => "option")

    # REFERENCE URL http://elementalselenium.com/tips/5-select-from-a-dropdown
    dropdown = $_browser.find_element(id: 'templateNo') #### Comma needed between id: and 'templateNo' ?
        select_list = Selenium::WebDriver::Support::Select.new(dropdown)
        select_list.select_by(:value, '45')
        puts "Dropdown option selected:"
        puts selected_option = select_list.selected_options[0].text
        sleep(2)

    # USING BAND PARAMETERS FROM COMMANDLINE GETS AT START OF CREEPER (ARRAY?)
    $_form = $_wait.until {
        if element = $_browser.find_element(:tag_name, "textarea")
            puts "Inputing BAND name into data field."
            element = $_browser.find_element(:tag_name, "textarea")
        else
            puts "BAND data not entered into text field."
        end
        element if element.displayed?
    }
 
    $_keys = false
    lengthCounter = bandsInnerArray.length
    eventNameCounter = 1
        bandsInnerArray.each do |bandNum|
            if bandNum.nil?
                next
            else
                sleep (5)
                bandNum = bandNum.join(",")
                puts "\n(b7_2Driver) bandNum 'ap' before .join(','):"
                if eventNameCounter < lengthCounter
                    $_form.send_keys("#{bandNum}\n")
                    #   CREATE A GLOBAL BOOLEAN HERE TO CHECK IF ANY KEYS ENTERED FOR ANY ARRAY, THAT IS FOR WHETHER TO SUBMIT/CLICK THIS SECOND B7 (IF NO GBLS FROM B3 AT ALL GO TO 'next')
                    $_keys = true
                else
                    $_form.send_keys("#{bandNum} ")
                    $_keys = true
                end
            end
            sleep(1)
            eventNameCounter += 1
        end
    sleep(5)
end
