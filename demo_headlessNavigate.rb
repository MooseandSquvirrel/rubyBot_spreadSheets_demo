"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                        Headless Driver Login  (to download href_files array)                             "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
 
def headlessNavigate(userNameVar)

    # HEADLESS VERSION OF FIXIT (UNCOMMENT ABOVE CODE AND COMMENT OUT BELOW COPY FOR BROWSER BASED FIXIT)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless') 
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-popup-blocking')
    options.add_argument('--window-size=1366,768')
    download_dir = File.expand_path('~/Downloads')
    options.add_preference(:download, directory_upgrade: true,
                                    prompt_for_download: false,
                                    default_directory: download_dir)

    options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })

    $browser = Selenium::WebDriver.for :chrome, options: options

    bridge = $browser.send(:bridge)
    path = '/session/:session_id/chromium/send_command'
    path[':session_id'] = bridge.session_id
    bridge.http.call(:post, path, cmd: 'Page.setDownloadBehavior',
                                params: {
                                behavior: 'allow',
                                downloadPath: download_dir
                                })
    $_browser = Selenium::WebDriver.for :chrome, options: options
    $_browser.get "https://redacted.com/"
    
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
    if button = $_browser.find_element(:xpath, "//*[@id='login-btn']")
        puts "Found form 'Submit' 'login-btn'."
        button = $_browser.find_element(:xpath, "//*[@id='login-btn']").click
        sleep(1)
    else
        puts "No form 'Submit' login-btn found."
    end

    # FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
    if card = $_browser.find_element(:xpath, "//*[@id='card-view-search-area']/li")
        puts "Card link found.\n"
        card = $_browser.find_element(:xpath, "//*[@id='card-view-search-area']/li").click
        sleep(1)
        bannerOutPut("banner_Backend.txt")
    else
        puts "Card link not found for clickable 'square' card before Main Menu screen."
    end

    # FIND THE LINK TO STATISTICS PAGE, ACCES STATISTICS PAGE
    sleep(3)
    if statistics = $_browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a")
        puts "Statistics link found.\n"
        card = $_browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a").click
        sleep(1)
       bannerOutPut("banner_StatisticsPage.txt")
    else
        puts "Statistcs link not found."
    end

    # FRAME/IFRAME SWITCH REQUIRED TO CONTINUE ACCESSING INNER BROWSER NON-POP-UP WINDOWS/ELEMENTS
    $_browser.switch_to.default_content
    $_browser.switch_to.frame("svc-iframe")
    
    files_href = ["http://redacted","http://redacted"]

    len = files_href.length
    i = 0
    while i < len
        # BROWSER DRIVER BASED DOWNLOAD
        puts "Downloading file: #{files_href[i]}"
        $_browser.navigate().to("#{files_href[i]}")
        puts "File Downloaded..."
        puts "Downloading ==> #{files_href[i]}"
        puts "Download: #{[i]}"
        i += 1
        sleep(7)
    end
end
