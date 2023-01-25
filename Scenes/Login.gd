extends Control

func _ready():
	$Incorrect.hide()
	$LoggedIn.hide()
	$Userbox.editable = true
	$Passbox.editable = true
	$Log.disabled = false
	$Quit.disabled = false
	$Reg.disabled = false
	$Passbox.text = ""
	$Userbox.text = ""
	pass 
	#resets login

func _on_Log_pressed():
	Global.button = true
	$Userbox.editable = false
	$Passbox.editable = false
	$Log.disabled = true
	$Quit.disabled = true
	$Reg.disabled = true
	#disable boxes to make sure no errors occur
	var user = $Userbox.text
	var find = searchUser(user)
	#checks to see if such a username exists
	if find == false:
		$Incorrect.show()
		yield(get_tree().create_timer(2.0), "timeout")
		_ready()
		return
	#if username is not found it shows there is an error
	var passw = $Passbox.text
	var hashed = passw.sha256_text()
	var listUser = []
	for g in len(user):
		listUser.append(user[g])
	var num = 0
	for i in len(listUser):
		num = num + ord(listUser[i])
	while num > 32:
		num = num /32
	#hashes password and finds the index 
	var file = File.new()
	file.open("res://HashPass.dat", file.READ)
	var content = []
	content = file.get_as_text().split("\n",true)
	file.close()
	#copy and splits by line the passwords
	var count = 0
	var loop = true
	while loop == true:
		if num >= 32:
			num = 0
		count = count + 1
		if content[num] == hashed:
			Global.logged = true
			break
		elif content[num] == "":
			break
		elif content[num] == " ":
			break
		elif content[num] == "end":
			num = 0
		if count > 10:
			return false
		num = num +1
	#loops to find the password
	if Global.logged == true:
		$LoggedIn.show()
		yield(get_tree().create_timer(0.5), "timeout")
		Global.rege = 2
		Global.logopen = false
		self.queue_free()
	#tells the program the user was found
	else:
		$Incorrect.show()
		yield(get_tree().create_timer(2.0), "timeout")
		_ready()	
	#tells program that user wasn't found so resets and
	#tells user incorrect passwords

func searchUser(user): # see if given username matches one in file
	var file = File.new()
	file.open("res://userData.dat", file.READ)
	var content = file.get_as_text()
	file.close()
	var users = content.split("\n",true)
	#copys the file and splits by line
	var userline = users[0]
	for i in len(users):
		userline = users[i]
		userline = userline.split(",",true)
		if  userline[0] == "":
			return false
		if  userline[0] == " ":
			return false
		if  userline[0] == user:
			Global.userInfo = Global.user.new(userline)
			return true
	return true
	#tries to find if the user exits in database

func _on_Reg_pressed():
	Global.button = true
	Global.rege = 1
	Global.logopen = false
	self.queue_free()
	#makes the button make button noise
	#makes main load registration scene
	#self terminates this scene

func _on_Quit_pressed():
	get_tree().quit()
	#closes whole program

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_Log_pressed()
	#if enter is pressed
	#it tries to login