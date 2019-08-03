# MAKE A TEMP DIRECTORY FOR HOUSING THE B7 FOR PARSING
def tempB7_2Dir()
    puts "\n"
    puts "Checking for TEMP_B7_2 Directory..."
    puts "Dirctory before:"
    puts Dir.pwd
    desktopDir = '~/fixit'
    Dir.chdir(File.expand_path(desktopDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking for TEMP_B7_2 Directory..."
    if Dir.exist?("TEMP_B7_2") == false
        puts "Creating TEMP_B7_2 Directory..."
        Dir.mkdir("TEMP_B7_2")
    else
        puts "TEMP_B7_2 Directory exists."
    end
end

# FUNCTION TO GRAB B7.1 FROM ~/DOWNLOADS AND MOVE IT INTO FIXIT'S WORKING DIRECTORY FOR PARSING (PUTTING INSIDE NEW DIRECTORY FOR ORGANIZATION)
def grabXlsxB72()
    puts "\n"
    tempB7_2Dir()
    puts "Grabbing B-7_2 .xlsx from ~/Downloads..."
    puts "Directory before:"
    puts Dir.pwd
    downloadDir = '~/Downloads'
    Dir.chdir(File.expand_path(downloadDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Downloads Directory for B-7_2 download file to move to TEMP_B7_2 for parsing..."
    Dir.glob("*B-7*.xlsx") {|file|
        if file
            puts "Moving file '#{file}' into TEMP_B7_2 Directory, in the working Directory inside Fixit..."
            temp_data_path = '~/fixit/TEMP_B7_2'
            FileUtils.mv("#{file}", File.expand_path(temp_data_path))
        else
            puts "No B-7 file found in ~/Downloads..."
        end
      }
end

def removeTEMPB7_2()
    puts "Moving to Delete TEMP_B7..."
    puts "Directory before:"
    puts Dir.pwd
    fixitDir = '~/fixit'
    Dir.chdir(File.expand_path(fixitDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Deleting TEMP_B7 Directory..."
    thisDir = "~/fixit/TEMP_B7_2"
    FileUtils.remove_dir(File.expand_path(thisDir))
end
