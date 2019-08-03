"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                        Final Results to be Written                                    "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def finalResults(bandsArray)
    i = 0
    until i == bandsArray.length
        band = bandsArray[i]
        puts "==============================================================================================="
        puts "Results of first B7 (#{band.eventName}):"
        puts "-----------------------------------"
        puts "totalMemberCount: #{band.totalMemberCount}"
        puts "coachesCount: #{band.coachesCount}"
        puts "nruCount: #{band.nruCount}"
        puts "-----------------------------------"
        puts "==============================================================================================="

        puts "==============================================================================================="
        puts "Results of first B3 (#{band.eventName})"
        puts "-----------------------------------"
        puts "totalMemberCount: #{band.totalMemberCount}"
        puts "nruPercentage: #{band.nruPercentage}"
        puts "coachesCount: #{band.coachesCount}"
        puts "totalLeaderCount: #{band.totalLeaderCount}"
        puts "newLeaderCount: #{band.newLeaderCount}"
        puts "newGblCount: #{band.newGblCount}"
        puts "newLeaderPerc: #{band.newLeaderPerc}%"
        puts "newGblPerc: #{band.newGblPerc}%"
        puts "==============================================================================================="

        puts "==============================================================================================="
        puts "Results of A2 (#{band.eventName}):"
        puts "-----------------------------------"
        puts "band.activitySum = #{band.activitySum}"
        puts "band.uniqueUserActivity = #{band.uniqueUserActivity}"
        puts "band.sumTotalMemberAvg = #{band.sumTotalMemberAvg}" 
        puts "band.uniqueMemberavg = #{band.uniqueMemberavg}"
        puts "-----------------------------------"
        puts "==============================================================================================="

        puts "==============================================================================================="
        puts "Results of Second B7:"
        puts "-----------------------------------"
        puts "band.gblNru: #{band.gblNru}"
        puts "band.nruPerGbl: #{band.nruPerGbl}"
        puts "band.totalNru: #{band.totalNru}"
        puts "-----------------------------------"
        puts "==============================================================================================="
        i += 1
    end
    puts "Proceeding to writer2..."
end
