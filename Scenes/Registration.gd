extends Control

var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
var types = [false,false,false,false,true]
#getting the flags ready to check password with

func _ready():
    $Max.hide()
    $Back.disabled = false
    $Quit.disabled = false
    $Reg.disabled = false
    $Userbox.editable = true
    $Passbox.editable = true
    $ConPassbox.editable = true
    #to reset nodes when instanced or failed
    #registration
    Global.cleanup()
    var file = File.new()
    var count = 0
    file.open("res://userData.dat", file.READ)
    var content = file.get_as_text()
    file.close()
    var arrcontent = content.split("\n")
    for n in len(arrcontent):
        count += 1
    #counts the number of users on current 
    #software
    if count >= 11:
        $Max.show()
        $Reg.hide()
        $Userbox.hide()
        $Passbox.hide()
        $ConPassbox.hide()
    #if it is >=11 than 11 it disables
    #registartion
    pass

func searchUser(user):
    var file = File.new()
    file.open("res://userData.dat", file.READ)
    var content = file.get_as_text()
    file.close()
    var users = content.split("\n",true)
    var userline = users[0]
    for i in len(users):
        userline = users[i]
        userline = userline.split(",",true)
        if  userline[0] == user:
            wrong(1)
            return false
        if  userline[0] == "":
            return true
        if  userline[0] == " ":
            return true
    return true
    #checks if that username already exists

func letterCheck(list):
    var flag = false
    for i in range(0, 26):
        if list.has(alphabet[i]) == true:
            flag = true
            break
    types[1] = flag
    #checks if password has normal
    #characters
    
func symbolCheck(list):
    var listSymbols = ["`","¬","!","£","$","%","^","&","*","(",")","_","-","+","=","{","[","}","]",";","@","~","#","<",",",">",".","?","/",":","|"]
    var flag = false
    for i in len(listSymbols)-1:
        if list.has(listSymbols[i].to_upper()) == true:
            flag = true
            break
    types[3] = flag
    #checks to see if password has symbols

func capLetterCheck(list):
    var flag = false
    for i in len(alphabet)-1:
        if list.has(alphabet[i].to_upper()) == true:
            flag = true
            break
    types[2] = flag
    #checks to see if password has capital characters

func number(list):
    var flag = false
    for i in range(0,10):
        if list.has(str(i)) == true:
            flag = true
            break
    types[0] = flag
    #checks to see if password has
    #a number

func passCheck(passw):
    types[0] = false
    types[1] = false
    types[2] = false
    types[3] = false
    types[4] = true
    #resets flags for password
    var list =[]
    for g in len(passw):
        list.append(str(passw[g]))
        if passw[g] == "'":
            wrong(2)
            return false
        elif passw[g] == '"':
            wrong(2)
            return false
        elif passw[g] == ',':
            wrong(2)
            return false
    #checks password if it has 
    #'", and tells that they are illegal
    number(list)
    letterCheck(list)
    capLetterCheck(list)
    symbolCheck(list)
    #does all checks
    if len(list) <= 5:
        types[4] = false 
    #checks if password is longer
    #than 5 characters             
    for i in len(types):
        if types[i] == false:
            wrong(5)
            return false
    return true
    #checks to see if all flags are
    #true 

func addLogin(user, passw):
    var file = File.new()
    file.open("res://userData.dat", file.READ)
    var content = file.get_as_text()
    file.close()
    #gets all data on userdata
    var file2 = File.new()
    file2.open("res://userData.dat", file.WRITE)
    var add = content+"\n"+user +",0,20,10,2,10,1,0.501187,0,0,0,0,0,3,1,1,0,1"
    file2.store_line(add)
    file2.close()
    #adds user to userdata with basic info
    var loco = Global.hashedLocation(user)
    #finds location to store password
    var hashed = passw.sha256_text()
    #gets hashed password
    var file3 = File.new()
    file3.open("res://HashPass.dat", file.READ)
    var content2 = file3.get_as_text()
    content2 = content2.split("\n", true)
    file3.close()
    #gets all data on HashPass
    var file4 = File.new()
    file4.open("res://HashPass.dat", file.WRITE)
    content2[loco] = hashed
    for i in len(content2)-1:
        file4.store_line(str(content2[i]))
    file4.close()
    #writes update to HashPass to include
    #new password of new user

func wrong(type):
    if type == 1:
        $Wrong.set_text("Username already in use")
        $Wrong.popup()
    elif type == 2:
        var text = 'Password is illegal, cannot have the characters " or ' + "'" 
        $Wrong.set_text(text)
        $Wrong.popup()
    elif type == 3:
        $Wrong.set_text("Passwords do not match")
        $Wrong.popup()
    elif type == 4:
        var text = 'Username is illegal, cannot have the characters " or' + "' or , "
        $Wrong.set_text(text)
        $Wrong.popup()
    elif type == 5:
        var text = "Password is not complex enough, must have at least: "
        if types[0] == false:
            text = text + "a number, "
        if types[1] == false:
            text = text + "a letter, "
        if types[2] == false:
            text = text + "a capital letter, "
        if types[3] == false:
            text = text + "a symbol, "
        if types[4] == false:
            text = text + "at least 6 characters long, "
        $Wrong.set_text(text)
        $Wrong.popup()
    #opens dialog and tells the error of current registration data

func _on_Wrong_popup_hide():
    _on_Wrong_confirmed()
    #if you click out of the dialog
    #it counts as a confirmed

func _on_Wrong_confirmed():
    yield(get_tree().create_timer(0.5), "timeout")
    _ready()
    #resets data when input for 
    #registration fails

func userCheck(userName):
    var list = []
    for g in len(userName):
        list.append(str(userName[g]))
    for i in len(list)-1:
        if ord(list[i]) == ord("'"):
            wrong(4)
            return false
        if ord(list[i]) == ord('"'):
            wrong(4)
            return false
        if ord(list[i]) == ord(","):
            wrong(4)
            return false
    #checks if username has any illegal
    #characters
    if len(list) < 3:
        wrong(4)
        return false
    else:
        return true
    #checks if username
    #is longer than 3
    #letters

func _on_Reg_pressed():
    $Back.disabled = true
    $Quit.disabled = true
    $Reg.disabled = true
    $Userbox.editable = false
    $Passbox.editable = false
    $ConPassbox.editable = false
    #blocks all editable nodes
    Global.button = true
    #makes the button sfx to play
    var user = $Userbox.text
    var goodUser = userCheck(user)
    #gets username from node and
    #checks if it valid
    var passw = $Passbox.text
    #gets password from node
    if goodUser == true:
        var findu = searchUser(user)
        if $Passbox.text == $ConPassbox.text:
            #makes sure passwords match between
            #password node and confirmed password
            #node
            if findu == false:
                pass
            #sees if username if already there
            if findu == true:
                var findp = passCheck(passw)
                if findp == false:
                    pass
                #checks if password is valid
                if findp == true:
                    addLogin(user,passw)
                    Global.cleanup()    
                    Global.rege = 0
                    Global.logopen = false
                    self.queue_free()    
                    #adds new user and causes 
                    #login scene to load       
        else:
            wrong(3)
            pass
            #if passwords don't match it makes
            #dialog load 

func _on_Back_pressed():
    Global.button = true
    Global.rege = 0
    Global.logopen = false
    self.queue_free()
    #if they want to go back
    #to login this runs
    #make button sfx load
    #and loads login scene

func _on_Quit_pressed():
    Global.button = true
    get_tree().quit()
    #closes app if quit pressed