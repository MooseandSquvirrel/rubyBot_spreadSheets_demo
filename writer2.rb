"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               Writter_2                                                  "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

# MAKE A TEMP DIRECTORY FOR HOUSING THE FINAL RESULTS 
def finalResultsDir()
    puts "\n"
    puts "Checking for finalResults Directory..."
    puts "Dirctory before:"
    puts Dir.pwd
    desktopDir = '~/Desktop'
    Dir.chdir(File.expand_path(desktopDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking for Final_Results Directory..."
    if Dir.exist?("Final_Results") == false
        puts "Creating Final_Results Directory..."
        Dir.mkdir("Final_Results")
    else
        puts "Final_Results Directory exists."
    end
    puts "Dirctory before:"
    puts Dir.pwd
    seleniumDir = '~/fixit'
    Dir.chdir(File.expand_path(seleniumDir))
    puts "Directory is now:"
    puts Dir.pwd
end

def mvFinalRes()
    puts "mvFinalRes function."
    Dir.glob("*Worksheet*.xlsx") {|file|
        if file
            puts "Moving file '#{file}' into Final_Results Directory on Desktop..."
            temp_data_path = '~/Desktop/Final_Results'
            FileUtils.mv("#{file}", File.expand_path(temp_data_path))
        else
            puts "No Final_Result .xlsx file found in current Directory..."
        end 
    }
end

# def writer2(bandsArray, page, lenOuterArray)
def writer2(bandsArray, lenOuterArray)
    finalResultsDir()
    # EQUALS LENGTH OF ARRAY
    bandsLength = bandsArray.length
    workbookFinal = RubyXL::Workbook.new
    worksheet = workbookFinal[0]

    worksheet.insert_row(0)
    # TITLE ROW CELL FILLING
    i = 0
    while i < 15
        titlesArray = []
        titlesArray = ["Summer Camp", "Brand", "Camp Date", "Band", "Total Members", "Coaches(Non-Admins", "NRUs", "NRU%", "Total Leaders", "New Leaders", "New Leaders %", "New GBLs", "New GBL %", "GBL NRUs", "NRUS per GBL", "Total NRUs", "Activity Sum", "Unique Users w/ Activity", "Sum/Total Member", "Unique/Member"]

        worksheet.add_cell(0, i, "#{titlesArray[i]}")
        worksheet.change_column_width(i, 25)
        worksheet.change_row_height(0, 40) 
        worksheet.change_column_font_name(i, 'Calibri')
        worksheet.change_column_font_size(i, 14)
        worksheet.sheet_data[0][i].change_font_bold(true)        
        worksheet.sheet_data[0][i].change_horizontal_alignment('center')
        # VERTICALLY CENTERS TEXT
        worksheet.change_row_vertical_alignment(0, 'distributed')
        # TITLE ROW BOTTOM UNDERLINE
        worksheet.sheet_data[0][i].change_border(:bottom, 'medium')
        worksheet.change_row_border_color(0, :bottom, 'ed553b')
        # FILL TITLE ROW WITH GREY
        worksheet.change_row_fill(0, '00FF00')
        i += 1
    end

    bandsArrayCounter = 0
    row = 1
    # LOOP UNTIL ALL BANDS IN bandsArray HAVE BEEN WRITTEN IN DOCUMENT 
    until bandsArrayCounter == bandsLength
        worksheet.insert_row(row)
        band = bandsArray[bandsArrayCounter]
        contentArray = []
        contentArray = [band.eventName, band.brandName, band.campDates, band.bandNum, band.totalMemberCount, band.coachesCount, band.nruCount, band.nruPercentage, band.totalLeaderCount, band.newLeaderCount, band.newLeaderPerc, band.newGblCount, band.newGblPerc, band.gblNru, band.nruPerGbl, band.totalNru]
        i = 0
        index = 0

        # DATA ROW FILING
        i = 0
        while i < 15
            worksheet.add_cell(row, i, "#{contentArray[i]}")
            worksheet.change_column_width(i, 25)
            worksheet.change_row_height(row, 40)  # Sets first row height to 30
            worksheet.change_column_font_name(i, 'Calibri')
            worksheet.change_column_font_size(i, 14)
            # HOZONTALLY CENTERS TEXT
            worksheet.sheet_data[row][i].change_horizontal_alignment('center')
            # VERTICALLY CENTERS TEXT
            worksheet.change_row_vertical_alignment(row, 'distributed')
            # TITLE ROW BOTTOM UNDERLINE
            worksheet.sheet_data[0][i].change_border(:bottom, 'medium')
            worksheet.change_row_border_color(row, :bottom, 'ed553b')
            # FILL ROW WITH WHITE
            if row.even?
                worksheet.change_row_fill(row, 'D3D3D3')
            else
                worksheet.change_row_fill(row, 'ffffff')
            end
            i += 1
        end
        row += 1
        bandsArrayCounter += 1
    end
    workbookFinal.write("#{worksheet}.xlsx")
    mvFinalRes()
    puts "Writing: #{worksheet}.xlsx to Final_Results on Desktop..."
end
