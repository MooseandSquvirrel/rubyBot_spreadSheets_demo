"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            Dates Section                                               "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def dates(bandsArray)
    bandsArray.each do |x|
        # COVER THE 3 DATES AFTER event.startDate
        daysParsed = Date.parse(x.startDate)
        datesArray = []
        i = 0
        # EVENT DATE RANGE PLUS 3 DAYS AFTER
        while i < 3
            datesArray << daysParsed.to_s
            if x.totalDays == 1
                break
            else
                daysParsed += 1
                i += 1
            end
        end

        # COVERS THE DATES LEADING UP TO THE EVENT'S :start_date (14 DAYS BEFORE :start_date)
        daysParsed = Date.parse(x.startDate)
        i = 0
        # -14 for two weeks before x 
        earlyDaysParsed = daysParsed - 14
        while i < 15
            datesArray << earlyDaysParsed.to_s
            earlyDaysParsed += 1
            i += 1
        end
        
        datesArray = datesArray.sort
        # SETTING datesArray INSIDE EVENT INSTANCE VARIABLE
        x.datesArray = datesArray

        # CREATING DATE RANGE FOR FINAL RESULTS TABLE (EX. "6/23 - 6/26")
        days = Date.parse(x.startDate)
       
        # EXTRACTS MONTH AND DAY FROM PARSED DATE STRING FOR startDate
        dateMonth = days.strftime('%m')
        dateDayBeg = days.strftime('%d')
        dateYear = days.strftime('%Y')

        endDay = Date.parse(x.startDate)

        # EXRACTS MONTH AND DAY FROM PARSED DATE STRING endDay FOR endDate (THIS ALLOWS FOR ADDITION OF TOTAL DAYS OF EVENT TO START DATE)
        dateMonthEndDate = endDay.strftime('%m').to_i
        dateDayEndDate = endDay.strftime('%d').to_i
        dateYearEndDate = endDay.strftime('%Y').to_i
        endDate = (DateTime.new(dateYearEndDate, dateMonthEndDate, dateDayEndDate)) + x.totalDays.to_i
    
        # EXTRACT MONTH AND DAY AND YEAR FOR ENDDATE (THIS EXTRACTS THE FINAL END MONTH YEAR AND DAY FOR A2 FUNCTION AFTER ABOVE ADDITION OF TOTAL DAYS OF EVENT)
        # REMOVED .to_i TO KEEP THE LEADING '0' FOR INPUT INTO A2 ON DAYS AND MONTHS LESS THAN 10
        dateMonthEndDate = endDate.strftime('%m')
        dateDayEndDate = endDate.strftime('%d')
        dateYearEndDate = endDate.strftime('%Y')

        # GETS STARTING DATE OF EVENT ( -1 TO :total_days SO THE ARITHMATIC GETS THE CORRECT DAY)
        dateDayEnd = days.strftime('%d').to_i + (x.totalDays.to_i - 1)
        x.campDates = "#{dateMonth}/#{dateDayBeg} - #{dateMonth}/#{dateDayEnd}"
        
        # GETS START DATE OF EVENT FOR A2
        x.a2StartDate = "#{dateMonth}#{dateDayBeg.to_s}#{dateYear}"

        # GETS ENDING DATE OF EVENT FOR A2
        x.a2EndDate  = "#{dateMonthEndDate}#{dateDayEndDate.to_s}#{dateYearEndDate}"
    end
end
