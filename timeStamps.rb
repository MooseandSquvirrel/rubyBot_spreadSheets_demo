
def timeStamp()
    $_cellTimeStamp0 = ""
    $_cellTimeStamp1 = ""
    $_cellTimeStamp2 = ""
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    minutes2 = ((minutes1.to_i) + 1).to_s
    minutes3 = ((minutes1.to_i) - 1).to_s
    hours = (DateTime.now - (8.0/24.0))
    tmpHours = (hours.strftime '%H')
    $_cellTimeStamp0 = "#{tmpHours}:#{minutes3}"
    $_cellTimeStamp1 = "#{tmpHours}:#{minutes2}"
    $_cellTimeStamp2 = "#{tmpHours}:#{minutes1}"
end

# def timestampA2(bandsArray)
#     band = bandsArray[0]
#     # MINUS 8 FOR SOUTH KOREA TIME ZONE
#     minutes1 = Time.now.strftime '%M'
#     minutes2 = ((minutes1.to_i) + 1).to_s
#     hours = (DateTime.now - (8.0/24.0))
#     tmpHours = (hours.strftime '%H')
#     band.hoursMinutesA2_backUp = "#{tmpHours}:#{minutes2}"
#     hoursMinutesA2 = "#{tmpHours}:#{minutes1}"
# end

