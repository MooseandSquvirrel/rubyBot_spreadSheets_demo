# MAKE A TEMP DIRECTORY FOR HOUSING THE B7 FOR PARSING
def tempB3Dir()
    puts "\n"
    puts "Checking for TEMP_B3 Directory..."
    puts "Dirctory before:"
    puts Dir.pwd
    desktopDir = '~/fixit'
    Dir.chdir(File.expand_path(desktopDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking for TEMP_B3 Directory..."
    if Dir.exist?("TEMP_B3") == false
        puts "Creating TEMP_B3 Directory..."
        Dir.mkdir("TEMP_B3")
    else
        puts "TEMP_B3 Directory exists."
    end
end

# FUNCTION TO GRAB B7.1 FROM ~/DOWNLOADS AND MOVE IT INTO FIXIT'S WORKING DIRECTORY FOR PARSING (PUTTING INSIDE NEW DIRECTORY FOR ORGANIZATION)
def grabXlsxB3()
    puts "\n"
    tempB3Dir()
    puts "Grabbing B-3 .xlsx from ~/Downloads..."
    puts "Directory before:"
    puts Dir.pwd
    downloadDir = '~/Downloads'
    Dir.chdir(File.expand_path(downloadDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Downloads Directory for B-3 download file to move to TEMP_B3 for parsing..."
    Dir.glob("*B-3*.xlsx") {|file|
        if file
            puts "Moving file '#{file}' into TEMP_B3 Directory, in the working Directory inside Fixit..."
            temp_data_path = '~/fixit/TEMP_B3'
            FileUtils.mv("#{file}", File.expand_path(temp_data_path))
        else
            puts "No B-3 file found in ~/Downloads..."
        end
      }
end

def removeTEMPB3()
    puts "Moving to Delete TEMP_B3..."
    puts "Directory before:"
    puts Dir.pwd
    fixitDir = '~/fixit'
    Dir.chdir(File.expand_path(fixitDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Deleting TEMP_B3 Directory..."
    thisDir = "~/fixit/TEMP_B3"
    FileUtils.remove_dir(File.expand_path(thisDir))
end
