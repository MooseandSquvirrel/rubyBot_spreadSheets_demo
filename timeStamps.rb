def timestampB71(bandsArray)
    band = bandsArray[0]
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    minutes2 = ((minutes1.to_i) + 1).to_s
    hours = (DateTime.now - (8.0/24.0))
    tmpHours = (hours.strftime '%H')
    band.hoursMinutesB71_backUp = "#{tmpHours}:#{minutes2}"
    hoursMinutesB71 = "#{tmpHours}:#{minutes1}"
end

def timestampB3(bandsArray)
    band = bandsArray[0]
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    minutes2 = ((minutes1.to_i) + 1).to_s
    hours = (DateTime.now - (8.0/24.0))
    tmpHours = (hours.strftime '%H')
    band.hoursMinutesB3_backUp = "#{tmpHours}:#{minutes2}"
    hoursMinutesB3 = "#{tmpHours}:#{minutes1}"
end

def timestampA2(bandsArray)
    band = bandsArray[0]
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    minutes2 = ((minutes1.to_i) + 1).to_s
    hours = (DateTime.now - (8.0/24.0))
    tmpHours = (hours.strftime '%H')
    band.hoursMinutesA2_backUp = "#{tmpHours}:#{minutes2}"
    hoursMinutesA2 = "#{tmpHours}:#{minutes1}"
end


def timestampB72(bandsArray)
    band = bandsArray[0]
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    minutes2 = ((minutes1.to_i) + 1).to_s
    minutes3 = ((minutes1.to_i) - 1).to_s
    hours = (DateTime.now - (8.0/24.0))
    tmpHours = (hours.strftime '%H')
    $_hoursMinutesB72_backUp = "#{tmpHours}:#{minutes2}"
    $_hoursMinutesB72_backUp2 = "#{tmpHours}:#{minutes3}"
    hoursMinutesB72 = "#{tmpHours}:#{minutes1}"
end
