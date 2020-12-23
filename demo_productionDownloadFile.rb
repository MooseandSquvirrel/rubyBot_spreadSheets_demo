
# $cellReturnText = ""

# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING' ***SAVES cell.text IN RETURN STATEMENT***
def iterate_to_cell(band, table, bandNum, userNameVar, my_date, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{my_date}"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 2
                            return cell.text
                        end
                    end
                end
            end
        end
    end
end

# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING' ***SAVES cell.text IN RETURN STATEMENT***
def iterate_to_cellB10(band, table, bandNum, userNameVar, my_date, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{my_date}" && r.text.include? "B-10"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 2
                            return cell.text
                        end
                    end
                end
            end
        end
    end
end

# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING' ***SAVES cell.text IN RETURN STATEMENT***
def iterate_to_cellA2(band, table, bandNum, userNameVar, my_date, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{my_date}" && r.text.include? "A-2"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}")
                        i = 0
                        r.find_elements(:tag_name, "td").each do |cell|
                            i += 1
                            if i == 2
                                return cell.text
                            end
                        end
                    end
                end
            end
        end
    end
end

# FUNCTION TO ITERATE TO CELL WITH HREF DOWNLOAD LINK
def iterate_to_hrefCells(band, table, bandNum, files_href, userNameVar, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{$_my_date}"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}") 
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 7
                            cell.find_elements(:tag_name, "a").each do |n|
                                puts "Storing n.attribute(\"href\") into array $_files_href" 
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
def storeTable(browser)
    $_wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    # STORE THE TABLE INTO table OBJECT
    $_table = $_wait.until {
        element = $_browser.find_element(:tag_name, "table")
        element if element.displayed?
    }
end

def b10Cell(band, userNameVar, bandNum)
    if $_B10counter == 0
        i = 0
        r.find_elements(:tag_name, "td").each do |cell|
            i += 1
            if i == 2 # THIS REACHES THE DOWNLOAD LINK CELL IN THE TABLE
                while $_B10counter == 0
                    cellReturnText = iterate_to_cellB10($_table, bandNum, userNameVar, $_my_date)
                    if cellReturnText == 'SUCCEED'
                        $_B10counter = 1
                        return
                    end
                    if cellReturnText == 'FAIL'
                        return
                    end
                    puts "B10"
                    puts "STILL RUNNING..."
                    sleep(10) 
                    reloadButton = $_browser.find_element(:id, "refresh").click
                    # GRABS NEW REFERENCE TO TABLE AFTER REFRESH
                    $_table = $_wait.until {
                        element = $_browser.find_element(:tag_name, "table")
                        element if element.displayed?
                    }
                    puts "After Reload, table:"
                    puts $_table
                    puts "---------------------------------------------------------"
                    sleep(5)
                    redo
                end
            end
        end
    end
end

def a2Cell(band, userNameVar, bandNum)
    i = 0
    r.find_elements(:tag_name, "td").each do |cell|
        i += 1
        if i == 2 # THIS REACHES THE DOWNLOAD LINK CELL IN THE TABLE
            while cell.text == 'RUNNING'
                cellReturnText = iterate_to_cellA2($_table, bandNum, userNameVar, $_my_date)
                if cellReturnText == 'SUCCEED'
                    $_A2counter = 1
                    return 
                end
                # BELOW if ACCOUNTS FOR SECOND A2
                if $_A2counter == 0
                    puts "$_A2counter: #{$_A2counter}"
                    puts "A-2"
                    puts "STILL RUNNING..."
                    sleep(10) 
                    reloadButton = $_browser.find_element(:id, "refresh").click
                    # GRABS NEW REFERENCE TO TABLE AFTER REFRESH
                    $_table = $_wait.until {
                        element = $_browser.find_element(:tag_name, "table")
                        element if element.displayed?
                    }
                    puts "After Reload, table:"
                    puts $_table
                    puts "---------------------------------------------------------"
                    sleep(5)
                    redo
                end
            end
        end
    end
end

# ITERATE THROUGH TABLE ROWS, THEN TABLE CELLS THEN STORE HREF LINKS OF DOWNLOAD LINK INTO ARRAY files_href
def checkHref(userNameVar, browser, table, bandNum)
    functionCounter = 0
    cellReturnText = ""
    # ACCOUNTING FOR SOUTH KOREA BEING 16 HOURS AHEAD
    date = DateTime.now + (16.0/24)
    $_my_date = date.strftime("%Y/%m/%d")
    $_table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{$_my_date}"
            if (r.text.include? "#{$_cellTimeStamp0}") || (r.text.include? "#{$_cellTimeStamp1}") || (r.text.include? "#{$_cellTimeStamp2}")  
                if r.text.include? "B-10"
                    b10Cell(band, userNameVar, bandNum)
                end
                if r.text.include? "A-2" &&  "RUNNING"
                    a2Cell(band, userNameVar, bandNum)
                end
                functionCounter += 1 
            end
        end
    end
end

# CHECK IF DOWNLOAD LINK EXISTS, IF SO CALLS iterate_to_hrefCells TO STORE HREF LINK TO DOWNLOAD INTO files_href ARRAY
def storeReadyDownloadLink(table, bandNum, userNameVar, files_href)
    puts "(storeReadyDownloadLink) calling iterate_to_hrefCells..."
    iterate_to_hrefCells($_table, bandNum, files_href, userNameVar)
    puts "(storeReadyDownloadLink) $_files_href now:"
    ap $_files_href
end

# FUNCTION TO CHECK IF DOWNLOAD LINK IS READY IN CELL, IF NOT RELOAD PAGE, IF SO, STORE INTO $_files_href ARRAY
def checkTableDownload(bandsArray)
    $_B10counter = 0
    $_A2counter = 0
    $_files_href = []
    bandNum = bandsArray[0]
    puts "(checkTableDownload) bandNum: #{bandNum}"
    i = 0
    while (($_B10counter == 0 || $_A2counter == 0) && (i < 2))
        # MIGHT NEED TO MAKE cellReturnText INTO EMPTY STRING HERE TO RESET IT FOR EACH LOOP FOR EACH BAND IN ARRAY
        checkHref($_userNameVar, $_browser, $_table, bandNum)
        puts "(checkTableDownload) $_B10counter: #{$_B10counter} -- $_A2counter: #{$_A2counter}"
        puts"(checkTableDownload) restarting loop 'while $_B10counter == 0 || $_A2counter == 0 && (i < 2)'..."
        i += 1
    end
    storeReadyDownloadLink($_table, bandNum, $_userNameVar, $_files_href)
end

# NAVIGATE GOES TO URI WHICH DOWNLOADS EXCEL FILE FROM ARRAY $_files_href 
def downloadFile(browser, files_href)
    files_href = files_href.uniq
    len = files_href.length

    i = 0
    while i < len
        $_browser.navigate().to("#{files_href[i]}")
        puts "Downloading ==> #{files_href[i]}"
        i += 1
        sleep(7)     
    end
end
