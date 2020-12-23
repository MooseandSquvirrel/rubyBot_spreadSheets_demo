
$cellReturnText = ""

# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING' ***SAVES cell.text IN RETURN STATEMENT***
def b72Iterate_to_cell(table, userNameVar, my_date, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{my_date}" && r.text.include? "B-7"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStamp1}") || (r.text.include? "#{cellTimeStamp2}") || (r.text.include? "#{cellTimeStamp3}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 2
                            puts "(b72iterate_to_cell) cell.text == #{cell.text}"
                            return cell.text
                        end
                    end
                end
            end
        end
    end
end

def b72Iterate_to_cellBandNum(table, userNameVar, my_date, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3, b7_2bandNumsArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{my_date}" && r.text.include? "B-7"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStamp1}") || (r.text.include? "#{cellTimeStamp2}") || (r.text.include? "#{cellTimeStamp3}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 4
                            puts "(b72iterate_to_cellBandNum) cell.text == #{cell.text}"
                            return cell.text
                        end
                    end
                end
            end
        end
    end
end

# FUNCTION TO ITERATE TO CELL WITH HREF DOWNLOAD LINK
def b72Iterate_to_hrefCell(table, files_href, userNameVar, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3, b7_2bandNumsArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "B-7"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStamp1}") || (r.text.include? "#{cellTimeStamp2}") || (r.text.include? "#{cellTimeStamp3}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 7
                            puts "(b72Iterate_to_hrefCell) href cell..."
                            cell.find_elements(:tag_name, "a").each do |n|
                                puts "(b72Iterate_to_hrefCell) Storing n.attribute(\"href\") into array $_files_href" 
                                $_files_href << n.attribute("href")
                            end
                        end
                    end
                end
            end
        end
    end
end

# STORED BELOW CODE INTO A FUNCTION SO THAT IT CAN BE 'REQUIRED' INTO excelTestParser.rb -- CALLED FUNCTION BELOW TO KEEP CODE RUNNING LIKE ORIGINAL
def b72StoreTable(browser)
    $_wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    # STORE THE TABLE INTO table OBJECT
    $_table = $_wait.until {
        element = $_browser.find_element(:tag_name, "table")
        element if element.displayed?
    }
end

# ITERATE THROUGH TABLE ROWS, THEN TABLE CELLS THEN STORE HREF LINKS OF DOWNLOAD LINK INTO ARRAY files_href
def b72CheckHref(userNameVar, browser, table, b7_2bandNumsArray, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3)
    cellReturnText = ""
    # ACCOUNTING FOR SOUTH KOREA BEING 16 HOURS AHEAD
    date = DateTime.now + (16.0/24)
    $_my_date = date.strftime("%Y/%m/%d")
    $_table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "B-7" && r.text.include? "RUNNING" && r.text.include? "#{$_my_date}"
            if (r.text.include? "#{cellTimeStamp1}") || (r.text.include? "#{cellTimeStamp2}") || (r.text.include? "#{cellTimeStamp3}")
                i = 0
                r.find_elements(:tag_name, "td").each do |cell|
                    i += 1
                    if i == 2 # THIS REACHES THE DOWNLOAD LINK CELL IN THE TABLE
                        while cell.text == 'RUNNING'
                            cellReturnText = b72Iterate_to_cell($_table, userNameVar, $_my_date, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3)
                            if cellReturnText == 'SUCCEED'
                                $_B7counter = 1
                                return
                            end
                            sleep(10) 
                            reloadButton = $_browser.find_element(:id, "refresh").click
                            # GRABS NEW REFERENCE TO TABLE AFTER REFRESH
                            $_table = $_wait.until {
                                element = $_browser.find_element(:tag_name, "table")
                            }
                            sleep(5)
                            redo
                        end 
                    end
                end
            end
        end
    end
end

# CHECK IF DOWNLOAD LINK EXISTS, IF SO CALLS b72Iterate_to_hrefCell TO STORE HREF LINK TO DOWNLOAD INTO files_href ARRAY
def b72StoreReadyDownloadLink(table, cellReturnText, userNameVar, files_href, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3, b7_2bandNumsArray)
    puts "(b72StoreReadyDownloadLink) Function..."
    b72Iterate_to_hrefCell($_table, files_href, userNameVar, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3, b7_2bandNumsArray)
    puts "$_files_href -- (inside b72StoreReadyDownloadLink()):"
    ap $_files_href
end

def b72CheckTableDownload(bandsArray, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3, b7_2bandNumsArray)
    $_B7counter = 0
    $_files_href = []
    band = bandsArray[0]
    i = 0
    while $_B7counter == 0
        # MIGHT NEED TO MAKE cellReturnText INTO EMPTY STRING HERE TO RESET IT FOR EACH LOOP FOR EACH BAND IN ARRAY
        b72CheckHref($_userNameVar, $_browser, $_table, b7_2bandNumsArray, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3)
        puts "(b72CheckTableDownload) $_B7counter: #{$_B7counter}"
    end
    b72StoreReadyDownloadLink(band, $_table, $_userNameVar, $_files_href, cellTimeStamp1, cellTimeStamp2, cellTimeStamp3, b7_2bandNumsArray)
end

#"NAVIGATE GOES TO URI WHICH DOWNLOADS EXCEL FILE FROM ARRAY $_files_href"
def b72DownloadFile(browser, files_href)
    puts "(b72DownloadFile) $_files_href Array of files to Download: "
    ap files_href

    files_href = files_href.uniq
    len = files_href.length

    i = 0
    while i < len
        $_browser.navigate().to("#{files_href[i]}")
        puts "Downloading file: #{files_href[i]}"
        sleep(4)
        i += 1
    end
end

