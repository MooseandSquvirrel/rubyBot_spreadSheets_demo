"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                  Function Entering Bands for First B7                                  "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def b10_Driver(bandsLength, bandsArray, bandNumbsArray)
  
    bandNameCounter = 0

    # STORING ALL FUNCTION OPTIONS AND SELECTING B7
    # INTERACTING WITH DROPDOWN BOX
    select_list = $_wait.until {
        element = $_browser.find_element(:xpath, "//*[@id='templateNo']")
        element if element.displayed?
    }
    puts "Function collected from dropdown function options. (into select_list):"
    pp select_list
    
    # EXTRACTING ALL OPTIONS FROM THE DROPDOWN BOX
    options=select_list.find_elements(:tag_name => "option")

    # REFERENCE URL http://elementalselenium.com/tips/5-select-from-a-dropdown
    dropdown = $_browser.find_element(id: 'templateNo') #### Comma needed between id: and 'templateNo' ?
        select_list = Selenium::WebDriver::Support::Select.new(dropdown)
        select_list.select_by(:value, '59')
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
    $_form.send_keys("#{bandNumbsArray}\n")
    sleep(2)
    puts "Good"
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
