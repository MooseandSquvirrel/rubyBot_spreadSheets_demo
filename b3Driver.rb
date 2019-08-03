"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                      Function Entering Bands for B3                                    "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def b3(eventNumsArray, bandsLength)
    
    bandsNumArray = eventNumsArray
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
        select_list.select_by(:value, '48')
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
    until bandNameCounter == bandsLength
        $_form.send_keys("#{bandsNumArray[bandNameCounter]}\n")
        bandNameCounter += 1
    end
    sleep(2)
    puts "Band Numbers entered into b3 field..."
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
