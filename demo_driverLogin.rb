"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                        Driver Login  (up to iFrame switch)                             "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
 
def navigate(userNameVar)
    
    # HEADLESS VERSION OF FIXIT (UNCOMMENT ABOVE CODE AND COMMENT OUT BELOW COPY FOR BROWSER BASED FIXIT)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless') 
    $_browser = Selenium::WebDriver.for :chrome  , options: options
    $_browser.get "https://redacted.com"
    
    $_wait = Selenium::WebDriver::Wait.new(:timeout => 60)
    
    # USR DATA ENTRY
    form = $_wait.until {
        element = $_browser.find_element(:name, "user")
        element if element.displayed?
    }
    sleep(1)
    form.send_keys("#{$_userNameVar}")
    
    # PW DATA ENTRY
    form = $_wait.until {
        element = $_browser.find_element(:name, "password")
        element if element.displayed?
    }
    sleep(1)
    form.send_keys("#{$_pwd}")

    # FINDS THE FORM BUTTON WITH XPATH AND THEN USES .execute_script (A JAVASCRIPT ACTION I BELIEVE)
    button = $_wait.until {
        button = $_browser.find_element(:xpath, "//*[@id='login-btn']")
        button if button.displayed?
    }
    button.click
    sleep(1)

    # FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
    card = $_wait.until {
        card = $_browser.find_element(:xpath, "//*[@id='card-view-search-area']/li")
        card if card.displayed?
    }
    card.click
    sleep(1)
    bannerOutPut("banner_Backend.txt")

    # FIND THE LINK TO STATISTICS PAGE, ACCES STATISTICS PAGE
    sleep(3)
    statistics = $_wait.until {
        statistics = $_browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a")
        statistics if statistics.displayed?
    }
    statistics.click
    sleep(1)
    bannerOutPut("banner_StatisticsPage.txt")

    # FRAME/IFRAME SWITCH REQUIRED TO CONTINUE ACCESSING INNER BROWSER NON-POP-UP WINDOWS/ELEMENTS
    $_browser.switch_to.default_content
    $_browser.switch_to.frame("svc-iframe")
    return $_browser
end
