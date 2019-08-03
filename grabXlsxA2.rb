# MAKE A TEMP DIRECTORY FOR HOUSING THE A2 FOR PARSING
def tempA2_2Dir()
    puts "\n"
    puts "Checking for TEMP_A2 Directory..."
    puts "Dirctory before:"
    puts Dir.pwd
    desktopDir = '~/fixit'
    Dir.chdir(File.expand_path(desktopDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking for TEMP_A2 Directory..."
    if Dir.exist?("TEMP_A2") == false
        puts "Creating TEMP_A2 Directory..."
        Dir.mkdir("TEMP_A2")
    else
        puts "TEMP_A2 Directory exists."
    end
end

# FUNCTION TO GRAB A2 FROM ~/DOWNLOADS AND MOVE IT INTO FIXIT'S WORKING DIRECTORY FOR PARSING (PUTTING INSIDE NEW DIRECTORY FOR ORGANIZATION)
def grabXlsxA2()
    puts "\n"
    tempA2_2Dir()
    puts "Grabbing A-2 .xlsx from ~/Downloads..."
    puts "Directory before:"
    puts Dir.pwd
    downloadDir = '~/Downloads'
    Dir.chdir(File.expand_path(downloadDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Downloads Directory for A-2 download file to move to TEMP_A2 for parsing..."
    Dir.glob("*A-2*.xlsx") {|file|
        if file
            puts "Moving file '#{file}' into TEMP_A2 Directory, in the working Directory inside Fixit..."
            temp_data_path = '~/fixit/TEMP_A2'
            FileUtils.mv("#{file}", File.expand_path(temp_data_path))
        else
            puts "No A-2 file found in ~/Downloads..."
        end
      }
end

def removeTEMPA2()
    puts "Moving to Delete TEMP_A2..."
    puts "Directory before:"
    puts Dir.pwd
    fixitDir = '~/fixit'
    Dir.chdir(File.expand_path(fixitDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Deleting TEMP_A2 Directory..."
    thisDir = "~/fixit/TEMP_A2"
    FileUtils.remove_dir(File.expand_path(thisDir))
end
