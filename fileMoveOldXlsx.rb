# FUNCTION TO MOVE OLD .XLSX FILES FROM ~/DOWNLOADS DIRECTORY TO NEWLY CREATED DIRECTORY ON DESKTOP OLD_XLSX_DATA (CREATES IF NON-EXISTENT)
def oldXlsx()
    puts "\n"
    puts "+++++++++++++++++++++++++++++"
    puts "Dirctory before:"
    puts Dir.pwd
    desktopDir = '~/Desktop'
    Dir.chdir(File.expand_path(desktopDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Desktop for OLD_XLSX_DATA Directory..."
    if Dir.exist?("OLD_XLSX_DATA") == false
        puts "Creating OLD_XLSX_DATA Directory..."
        Dir.mkdir("OLD_XLSX_DATA")
    else
        puts "OLD_XLSX_DATA Directory exists."
    end
end

# FUNCTION TO MOVE THE OLD .XLSX FILES (WITH THE OLD_XLSX_DATA FUNCTION TO CHECK/CREATE FOLDER FOR IT)
def fileMoveOldXlsx()
    puts "\n"
    puts "+++++++++++++++++++++++++++++"
    puts "Checking ~/Desktop for OLD_XLSX_DATA Directory..."
    oldXlsx()
    puts "Directory before:"
    puts Dir.pwd
    downloadDir = '~/Downloads'
    Dir.chdir(File.expand_path(downloadDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Downloads Directory for .xlsx files to clean before initiating Fixit..."
    Dir.glob("*.xlsx") {|file|
        if file
            puts "Storing file name '#{file}' with .xlsx extension into OLD_XLSX_DATA on Desktop..."
            temp_data_path = '~/Desktop/OLD_XLSX_DATA'
            FileUtils.mv("#{file}", File.expand_path(temp_data_path))
        else
            puts "No .xlsx files found in ~/Downloads..."
        end
      }
end

# REMOVES THE .XLSX FILES FROM USERS ~/Downloads DIRECTORY SO fixit CAN FIND THE ONLY XLSX FOLDERS DOWNLOADED.
def initialDownloadsClean()
    puts "\n"
    puts "+++++++++++++++++++++++++++++"
    puts "Directory before:"
    puts Dir.pwd
    downloadDir = '~/Downloads'
    Dir.chdir(File.expand_path(downloadDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Downloads Directory for .xlsx files to clean... "
    Dir.glob('*.xlsx').each do |file| 
        if file
            puts "file #{file} cleaned from Downloads..."
            File.delete(file)
        else
            puts "Nothing to clean from Downloads."
        end
    end
end
