extends Control



#files in userData saved in format of username,cash,shellMax(20),HPMax(10),hpKitsize(2),ammokitSize(10),normal_sensativity(1),highscore1,highscore2,highscore3,highscore4,highscore5\n


func _ready():
	$Label1.hide()
	$Label2.hide()
	Global.cleanup()
	var file = File.new()
	var count = 0
	file.open("res://userData.txt", file.READ)
	var content = file.get_as_text()
	file.close()
	var arrcontent = content.split("\n")
	for n in len(arrcontent):
		count += 1
	
	if count >= 11:
		$Label1.show()
		$Reg.hide()
		$Userbox.hide()
		$Passbox.hide()
		$ConPassbox.hide()
	pass # Replace with function body.




func searchUser(user): # see if given username matches one in file
	var file = File.new()
	file.open("res://userData.txt", file.READ)
	var content = file.get_as_text()
	file.close()
	var users = content.split("\n",true)
	var userline = users[0]
	for i in len(users):
		userline = users[i]
		userline = userline.split(",",true)
		if  userline[0] == user:
			return false
		if  userline[0] == "":
			return true
		if  userline[0] == " ":
			return true
	return true

func passCheck(passw):
	if passw == "del":
		return false
	if passw == " ":
		return false
	if passw == "":
		return false
	return true
	
func addLogin(user, passw):
	var file = File.new()
	file.open("res://userData.txt", file.READ)
	var content = file.get_as_text()
	file.close()

	var file2 = File.new()
	file2.open("res://userData.txt", file.WRITE)
	var add = content+"\n"+user +","+"0"+","+"20"+","+"10"+","+"2"+","+"10"+","+"1"+","+"0"+","+"0"+","+"0"+","+"0"+","+"0"
	file2.store_line(add)
	file2.close()

	var loco = Global.hashedLocation(user)
	var hashed = passw.sha256_text()

	var file3 = File.new()
	file3.open("res://HashPass.txt", file.READ)
	var content2 = file3.get_as_text()
	content2 = content2.split("\n", true)
	
	file3.close()


	var file4 = File.new()
	file4.open("res://HashPass.txt", file.WRITE)
	content2[loco] = hashed
	for i in len(content2)-1:
		file4.store_line(str(content2[i]))
	file4.close()

func wrong():
	$Label2.visible = visible
	yield(get_tree().create_timer(2.0), "timeout")
	$Label2.visible = !visible

func _on_Reg_pressed():
	var user = $Userbox.text
	var passw = $Passbox.text
	var findu = searchUser(user)
	if $Passbox.text == $ConPassbox.text:
		if findu == false:

			wrong()
			pass
		if findu == true:
			var findp = passCheck(passw)
			if findp == false:
				wrong()
				pass
			else:
				addLogin(user,passw)
				Global.cleanup()	
				Global.rege = 0
				Global.logopen = false
				self.queue_free()
	else:
		wrong()
		pass
	
	


func _on_Back_pressed():
	Global.rege = 0
	Global.logopen = false
	self.queue_free()

