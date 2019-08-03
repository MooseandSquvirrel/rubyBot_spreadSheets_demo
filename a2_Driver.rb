"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                  Function Entering Bands & Date for A2                                 "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def a2_Driver(bandsLength, bandsArray)

    bandNameCounter = 0
    
    # STORING ALL FUNCTION OPTIONS AND SELECTING B7
    # INTERACTING WITH DROPDOWN BOX
    select_list = $_wait.until {
        element = $_browser.find_element(:xpath, "//*[@id='templateNo']")
        element if element.displayed?
    }
    
    # EXTRACTING ALL OPTIONS FROM THE DROPDOWN BOX
    options = select_list.find_elements(:tag_name => "option")

    # REFERENCE URL http://elementalselenium.com/tips/5-select-from-a-dropdown
    dropdown = $_browser.find_element(id: 'templateNo') #### Comma needed between id: and 'templateNo' ?
        select_list = Selenium::WebDriver::Support::Select.new(dropdown)
        select_list.select_by(:value, '3')
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

    # ENTER BAND NUMBS INTO TEXT FIELD
    until bandNameCounter == bandsLength
        $_form.send_keys("#{bandsNamesArray[bandNameCounter]}\n")
        bandNameCounter += 1
    end
    sleep(2)

    puts "Band numbers entered into A2 Text Field..."

    # USING BAND PARAMETERS FROM COMMANDLINE GETS AT START OF CREEPER (ARRAY?)
    $_form = $_wait.until {
        if element = $_browser.find_element(:id, "startedAt")
            puts "Inputing BAND event start date into data field for A2."
            element = $_browser.find_element(:id, "startedAt")
        else
            puts "BAND event start date not entered into text field for A2."
        end
        element if element.displayed?
    }
    # $_form.send_keys("#{band.a2StartDate}\n")
    $_form.send_keys("01012017\n")


    # USING BAND PARAMETERS FROM COMMANDLINE GETS AT START OF CREEPER (ARRAY?)
    $_form = $_wait.until {
        if element = $_browser.find_element(:id, "endedAt")
            puts "Inputing BAND event end date into data field for A2."
            element = $_browser.find_element(:id, "endedAt")
        else
            puts "BAND event end date not entered into text field for A2."
        end
        element if element.displayed?
    }
    date = DateTime.now
    todaysDate = date.strftime('%m%d%Y') 
    $_form.send_keys("#{todaysDate}\n")
end
  
def clickit()
    $_form = $_wait.until {
        element = $_browser.find_element(:id, "execute")
        element if element.displayed?
    }
    $_form.click
    sleep(5)
    puts "Execute Clicked"
end

def alert_clickit()
    # alert = $_browser.switch_to.alert
    $_form = $_wait.until {
        alert = $_browser.switch_to.alert
    }
    $_form.accept
    sleep(5)
    puts "Alert Clicked"
end
