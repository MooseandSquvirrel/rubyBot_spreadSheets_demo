"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               Open Browser for Downloading URL Links to XLSX                                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def browserDownloadFiles(files_href)
    
    browser = Selenium::WebDriver.for :chrome
    browser.get "https://iims.navercorp.com/login?targetUrl=https://iims.navercorp.com/"
    wait = Selenium::WebDriver::Wait.new(:timeout => 60)
    
    # USR DATA ENTRY
    form = wait.until {
        element = browser.find_element(:name, "user")
        element if element.displayed?
    }
    sleep(1)
    form.send_keys("#{$_userNameVar}")
    
    # PW DATA ENTRY
    form = wait.until {
        element = browser.find_element(:name, "password")
        element if element.displayed?
    }
    sleep(1)
    form.send_keys("#{$_pwd}")
   
    # FINDS THE FORM BUTTON WITH XPATH AND THEN USES .execute_script (A JAVASCRIPT ACTION I BELIEVE)
    button = wait.until {
        button = browser.find_element(:xpath, "//*[@id='login-btn']")
        button if button.displayed?
    }
    button.click
    puts "Found form 'Submit' 'login-btn'."

    sleep(3)
    # FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
    card = wait.until {
        card = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li")
        card if card.displayed?
    }
    sleep(1)
    card.click
    bannerOutPut("banner_Backend.txt")

    sleep(3)
    # FIND THE LINK TO STATISTICS PAGE, ACCES STATISTICS PAGE
    statistics = wait.until {
        statistics = browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a")
        statistics if statistics.displayed?
    }
    sleep(1)
    statistics.click
    bannerOutPut("banner_StatisticsPage.txt")

    # FRAME/IFRAME SWITCH REQUIRED TO CONTINUE ACCESSING INNER BROWSER NON-POP-UP WINDOWS/ELEMENTS
    browser.switch_to.default_content
    browser.switch_to.frame("svc-iframe")
  
    len = files_href.length
    i = 0
    while i < len
        # BROWSER DRIVER BASED DOWNLOAD
        puts "Download: #{[i]}"
        puts "Downloading file: #{files_href[i]}"
        browser.navigate().to("#{files_href[i]}")
        puts "Downloading ==> #{files_href[i]}"
        i += 1
        sleep(7)     
    end
    browser.quit
end
