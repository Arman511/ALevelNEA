extends Node

var logopen = false
#tells if a scene is currently open
var rege = 0
#tells what scene is currently loaded and what scene to load
var logged = false
#tlls if a user is logged in
var pause = 0 
#tells if game is paused right now
# if 1 means pause game play, if 0 means let gameplay continue
var game = 0 # 0 means no game, 1 means currently playing
var hp = 1
#tells current hp for player for game loop
var ammo = 1
#tells current ammo for player for game loop
var cash = 0
#tells cash a person got in a single game loop
var score = 0
#tells score of a person got in 1 game loop
var newGame = 0
#tells if user wants to play again
var firing = 0
#tells is user is currently firing
var zombieNum = 0
#tells the num of zombies on screen
export (float) var ticks = 0
#tells the number of ingame ticks since
#game loop has started
var hook = 0
#tells if user is currently firing hook
var mKit = 0
#tells if a med kit is loaded
var aKit = 0
#tells if a ammokit is loaded
var button = false 
#tells if a button is pressed
var typeShot = 1
#tells what type of ammo is currently loaded
# 1-normal 2-incendiary 3 large-Normal
var userInfo
#object 
var boss = false
#tells if a boss if currently loaded

func cleanup():
	var file = File.new()
	file.open("res://userData.dat", file.READ)
	var content = file.get_as_text()
	content = content.split("\n",true)
	file.close()
	var counter = len(content)-1
	for i in len(content):
		if content[counter] == "":
			content.remove(counter)
		elif content[counter] == " ":
			content.remove(counter)
		counter = counter - 1
	file.open("res://userData.dat", file.WRITE)
	for g in len(content):
		file.store_line(content[g])
	file.close()
	#cleans up userdata file to remove gaps

class user:
	#the class that used to 
	#instance a users data
	var name 
	var cash
	var maxShell
	var maxHP
	var kitHP
	var kitAmmo
	var sens
	var volume
	var h1
	var h2
	var h3 
	var h4
	var h5
	var hudType
	var rotateType
	var fireType
	var colour
	var hook
	#all attributes of a user
	func _init(data):
		name = data[0]
		cash = data[1]
		maxShell = data[2]
		maxHP = data[3]
		kitHP = data[4]
		kitAmmo = data[5]
		sens = data[6]
		volume = data[7]
		h1 = data[8]
		h2 = data[9]
		h3 = data[10] 
		h4 = data[11]
		h5 = data[12]
		hudType = data[13]
		rotateType =data[14]
		fireType = data[15]
		colour = data[16]
		hook = data[17]
	#initalising all attributs of a user
	func getName():
		return name
	func getCash():
		return int(cash)
	func setCash(new):
		cash = new
	func getMaxShell():
		return int(maxShell)
	func setMaxShell(new):
		maxShell = new
	func getMaxHP():
		return int(maxHP)
	func setMaxHP(new):
		maxHP = new
	func getkitHP():
		return int(kitHP)
	func setkitHP(new):
		kitHP = new
	func getkitAmmo():
		return int(kitAmmo)
	func setkitAmmo(new):
		kitAmmo = new
	func getSens():
		return int(sens)
	func setSens(new):
		sens = new
	func getVolume():
		return int(volume)
	func setVolume(new):
		volume = new 
	func getH1():
		return h1
	func setH1(new):
		h1 = new
	func getH2():
		return h2
	func setH2(new):
		h2 = new
	func getH3():
		return h3 
	func setH3(new):
		h3 = new
	func getH4():
		return h4
	func setH4(new):
		h4 = new
	func getH5():
		return h5
	func setH5(new):
		h5 = new
	func getHud():
		return int(hudType)
	func setHud(new):
		hudType = new
	func getRotate():
		return int(rotateType)
	func setRotate(new):
		rotateType = new
	func getFire():
		return int(fireType)
	func setFire(new):
		fireType = new
	func getColour():
		return int(colour)
	func setColour(new):
		colour = new
	func getHook():
		return int(hook)
	func setHook(new):
		hook = new
	#getters and setters for all 
	#attributes
	func getALL():
		var string =  str(name)+","+str(cash)+","+str(maxShell)+","+str(maxHP)+","+str(kitHP)+","+str(kitAmmo)+","+str(sens)+","+str(volume)+","+str(h1)+","+str(h2)+","+str(h3)+","+str(h4)+","+str(h5)+","+str(hudType)+","+str(rotateType)+","+str(fireType)+","+str(colour)+","+str(hook)
		return string
	#to get all user's data as  string

func hashedLocation(user):
	var file = File.new()
	file.open("res://HashPass.dat", file.READ)
	var content = []
	content = file.get_as_text().split("\n",true)
	file.close()
	var listUser = []
	for g in len(user):
		listUser.append(user[g])
	var num = 0
	for i in len(listUser):
		num = num + ord(listUser[i])
	while num > 32:
		num = num /32
	var count = 0
	var loop = true
	while loop == true:
		if num >= 32:
			num = 0
		count = count + 1
		if content[num] == "del":
			return num
		elif content[num] == "":
			return num
		elif content[num] == " ":
			return num
		elif content[num] == "end":
			num = 0
		elif count > 10:
			return false
		num = num +1
	#gives where a password is stored
	#in hash table

func save_changes():
	Global.userInfo.setCash(Global.userInfo.getCash()+Global.cash)
	var file = File.new()
	file.open("res://userData.dat", file.READ)
	var content = file.get_as_text()
	content = content.split("\n",true)
	var replacing = userInfo.getALL()
	file.close()
	var counter = len(content)-1
	for i in len(content):
		var splitContent = content[i].split(",",true)
		if splitContent[0] == userInfo.getName():
			content[i] = replacing
		counter = counter - 1
	file.open("res://userData.dat", file.WRITE)
	for g in len(content):
		file.store_line(content[g])
	file.close()
	cleanup()
	#saves all changes
