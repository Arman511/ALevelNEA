extends Control

func _ready():
	$Incorrect.hide()
	#hide it

func _on_Settings_pressed():
	Global.button = true
	Global.rege = 5
	Global.logopen = false
	self.queue_free()
	#loads settings 

func searchUser(user): # see if given username matches one in file
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
			return true
	return false
	#checks if such a username exists

func incorrectLogin():
	$Incorrect.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$Incorrect.hide()
	$Userbox.text = ""
	$Passbox.text = ""
	#load incorrect

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_Settings_pressed()
	#loads settings

func _on_Delete_pressed():
	$Del.set_text("Are you sure you want to delete your account")
	$Del.popup()		
	#loads popup for confirmation 

func _on_Del_confirmed():
	Global.button = true
	var userName = $Userbox.text
	var passWord = $Passbox.text
	var foundUser = searchUser(userName)
	if foundUser == false:
		incorrectLogin()
		pass
	#checks if username exists
	elif userName != Global.userInfo.getName():
		incorrectLogin()
		pass
	#checks if username matches current users name
	else:
		var foundPass = realPass(userName, passWord)
		if foundPass == -1:
			incorrectLogin()
			pass
		#checks if password is found
		else:
			var file = File.new()
			file.open("res://userData.dat", file.READ)
			var content = file.get_as_text()
			content = content.split("\n",true)
			#gets all userData and split by line to make list
			file.close()
			var counter = len(content)-1
			for i in len(content):
				var splitContent = content[i].split(",",true)
				if splitContent[0] == userName:
					content[i] = ""
				counter = counter - 1
			#finds index of user in userdata and expunges it
			file.open("res://userData.dat", file.WRITE)
			for g in len(content):
				file.store_line(content[g])
			file.close()
			Global.cleanup()
			#saves and cleans userdata
			file.open("res://HashPass.dat", file.READ)
			content = []
			content = file.get_as_text().split("\n",true)
			file.close()
			#gets all data in HashPass and split by line
			content[foundPass] = "del"
			#deletes current user password
			file.open("res://HashPass.dat", file.WRITE)
			for i in len(content)-1:
				file.store_line(str(content[i]))
			#saves updated HashPass
			file.close()
			Global.rege = 0
			Global.logopen = false
			Global.logged = false
			self.queue_free()
			#loads login scene

func realPass(user ,passw):
	var hashed = passw.sha256_text()
	var listUser = []
	for g in len(user):
		listUser.append(user[g])
	var num = 0
	for i in len(listUser):
		num = num + ord(listUser[i])
	while num > 32:
		num = num /32
	var file = File.new()
	file.open("res://HashPass.dat", file.READ)
	var content = []
	content = file.get_as_text().split("\n",true)
	file.close()
	var count = 0
	var loop = true
	while loop == true:
		if num >= 32:
			num = 0
		count = count + 1
		if content[num] == hashed:
			return  num
		elif content[num] == "":
			return -1
		elif content[num] == " ":
			return -1
		elif content[num] == "end":
			num = 0
		if count > 10:
			return -1
		num = num +1
#finds where password is stored in hash table
