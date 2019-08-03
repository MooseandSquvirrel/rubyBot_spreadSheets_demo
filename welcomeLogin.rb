def helloMessage()
    puts "-- .xlsx files from your ~/Downloads Folder have been moved to \nOLD_XLSX_DATA Folder on your Desktop. --"
    print "\n\nThis program will continue until 'exit' is entered on the command line.\nIf exited, 'Up Arrow' then 'Enter' will restart.\n\n"
    print "\n**** AGAIN, MAKE SURE BEFORE YOU BEGIN TO CONNECT TO --VPN PULSE SECURE-- ****\n\n"
end

# TWILIO TEXT MESSAGE OPTION (COLLECT usrNumber)
def textMessage()
    answer_check = ""
    while answer_check != 'y' || answer_check != "exit"
        puts "Before beginning, would you like to receive an alert on your phone when Fixit is done?"
        puts "'y' for yes, 'n' for no."
        yORn = gets.strip
        if yORn == 'exit'
            return
        end
        if yORn == 'y'
            puts "Please type your full phone number ( ex. 925-123-4567 = 9251234567 )"
            usrNumber = gets.strip
        end
        if yORn == 'n'
            break
        end
        if yORn != 'y' && yORn != 'n'
            puts "-------------------------------------------------------------------"
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "-------------------------------------------------------------------"
            puts "\n"
            redo
        end
        puts "\n"
        puts "Is '#{usrNumber}' the correct number?"
        answer_check = gets.strip
        if answer_check == "exit"
            return
        elsif answer_check == 'y' 
            return usrNumber
        elsif answer_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the correct cell number and press 'Enter':"
            redo
        else
            puts "-------------------------------------------------------------------"
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "-------------------------------------------------------------------"
            puts "\n"
            redo
        end
    end
end

# USERNAME AND PASSWORD ENTERING WITH HIDDEN INPUT AND TOKENIZATION
# USERAME
def userName()
    userName_check = ""
    while userName_check != 'y' || userName_check != "exit"
        puts "Begin by entering your backend Username (employee i.d.):"
        userName = gets.strip
        if userName == 'exit'
            return
        end
        puts "\n"
        puts "Is '#{userName}' the correct user name?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
        userName_check = gets.strip
        if userName_check == "exit"
            return
        end
        if userName_check == 'y'
            $_userNameVar = userName 
            break
        end
        if userName_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the correct user name and press 'Enter':"
            redo
        end
        if userName_check != 'y' || userName_check != 'n'
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "\n"
            puts "**** Now Re-Enter the correct user name and hit 'Enter'. ****"
            redo
        end
    end
end

# PASSWORD
def pwd()
    pwd_check = ""
    while pwd_check != 'y' || pwd_check != "exit"
        print "Enter backend password -- TEXT WILL BE INVISIBLE, AFTER TYPING PASSWORD HIT ENTER TWICE:\n"
        pwd = gets.strip
        if pwd == 'exit'
            return
        end
        puts "\n"
        puts "Did you enter the correct password? (Even though it is invisible :) ....)\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
        pwd_check = gets.strip
        if pwd_check == "exit"
            return
        end
        if pwd_check == 'y'
            $_pwd = pwd
            break
        end
        if pwd_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the correct password and press 'Enter':"
            redo
        end
        if pwd_check != 'y' || pwd_check != 'n'
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "\n"
            puts "**** Now Re-Enter the correct password and hit 'Enter'. ****"
            redo
        end
    end
end
