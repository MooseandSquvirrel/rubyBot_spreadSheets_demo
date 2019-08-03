def b10_a2_Driver(bandsLength, bandsArray, initialCellTimeStampArray)
        "-------------------- b7_1Driver -----------------------" 
        b7_1Driver(bandsLength, bandsArray)
        initialCellTimeStampArray << timestampB71(bandsArray)
        clickit()
        alert_clickit()

        "==================== a2 ========================="         
        a2_Driver(bandsLength, bandsArray)
        initialCellTimeStampArray << timestampA2(bandsArray)
        clickit()
        # alert_clickit() TWICE TO COVER BOTH ALERT POP-UPS
        alert_clickit()
        alert_clickit()
end