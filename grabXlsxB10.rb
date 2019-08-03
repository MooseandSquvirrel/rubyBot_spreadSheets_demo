# MAKE A TEMP DIRECTORY FOR HOUSING THE B7 FOR PARSING
def tempB10Dir()
    puts "\n"
    puts "Checking for TEMP_B10 Directory..."
    puts "Dirctory before:"
    puts Dir.pwd
    desktopDir = '~/spreadEm/spreadSheets'
    Dir.chdir(File.expand_path(desktopDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking for TEMP_B10 Directory..."
    if Dir.exist?("TEMP_B10") == false
        puts "Creating TEMP_B10 Directory..."
        Dir.mkdir("TEMP_B10")
    else
        puts "TEMP_B10 Directory exists."
    end
end

# FUNCTION TO GRAB B7.1 FROM ~/DOWNLOADS AND MOVE IT INTO FIXIT'S WORKING DIRECTORY FOR PARSING (PUTTING INSIDE NEW DIRECTORY FOR ORGANIZATION)
def grabXlsxB10()
    puts "\n"
    tempB10Dir()
    puts "Grabbing B-10 .xlsx from ~/Downloads..."
    puts "Directory before:"
    puts Dir.pwd
    downloadDir = '~/Downloads'
    Dir.chdir(File.expand_path(downloadDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Downloads Directory for B-10 download file to move to TEMP_B10 for parsing..."
    Dir.glob("*B-10*.xlsx") {|file|
        if file
            puts "Moving file '#{file}' into TEMP_B10 Directory, in the working Directory inside Fixit..."
            temp_data_path = '~/spreadEm/spreadSheets/TEMP_B10'
            FileUtils.mv("#{file}", File.expand_path(temp_data_path))
        else
            puts "No B-10 file found in ~/Downloads..."
        end
      }
end

def removeTEMPB10()
    puts "Moving to Delete TEMP_B10..."
    puts "Directory before:"
    puts Dir.pwd
    fixitDir = '~/spreadEm/spreadSheets'
    Dir.chdir(File.expand_path(fixitDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Deleting TEMP_B10 Directory..."
    thisDir = "~/fixit/TEMP_B10"
    FileUtils.remove_dir(File.expand_path(thisDir))
end
