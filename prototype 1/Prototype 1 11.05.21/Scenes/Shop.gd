extends Control


func _ready(): # get the variable filled in
	$NotEnough.hide()
	Global.newHP = int(Global.userData[3])+2
	Global.newHP_cost = int(Global.newHP*1.5)
	Global.newAmmo = int(Global.userData[2])+3
	Global.newAmmo_cost = int(Global.newAmmo*1.5)
	Global.newMed = int(Global.userData[4])+1
	Global.newMed_cost = int(Global.newMed*1.5)
	Global.newAmmok = int(Global.userData[5])+7
	Global.newAmmok_cost = int(Global.newAmmok*1.5)



func _process(_delta): # keeps the text live
	
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	var hptext = "Currently:" + Global.userData[3] +", upgraded:"+ str(Global.newHP)+ ", upgarde cost:" + str(Global.newHP_cost)
	$Hp.text = str(hptext)
	var ammotext = "Upgrade Max Ammo, Currently:" + Global.userData[2] + ", upgraded:"+ str(Global.newAmmo)+ ", upgrade cost:" + str(Global.newAmmo_cost)
	$Ammo.text = str(ammotext)
	var med =  "Upgrade Medkit regen ammount, Currently:" + Global.userData[4] +", upgraded:"+str(Global.newMed)+",upgrade cost:" + str(Global.newMed_cost)
	$Med.text = str(med)
	var kit = "Upgrade Ammokit regen ammount, Currently:" + Global.userData[5] + ", upgraded:" + str(Global.newAmmok) +",upgrade cost:" + str(Global.newAmmok_cost)
	$Kit.text = str(kit)




#2345
#shellMax(20),HPMax(10),hpKitsize(2),ammokitSize(10)

func change(cost): # saves the changes
	Global.userData[1] = str(int(Global.userData[1])-cost)

	var file = File.new()
	file.open("res://userData.txt", file.READ)
	var content = file.get_as_text()
	content = content.split("\n",true)
	var replacing = Global.userData[0]+","+Global.userData[1]+","+Global.userData[2]+","+Global.userData[3]+","+Global.userData[4]+","+Global.userData[5]+","+Global.userData[6]+","+Global.userData[7]+","+Global.userData[8]+","+Global.userData[9]+","+Global.userData[10]+","+Global.userData[11]

	file.close()
	var counter = len(content)-1
	for i in len(content):
		var splitContent = content[i].split(",",true)
		if splitContent[0] == Global.userData[0]:
			
			content[i] = replacing
		counter = counter - 1
	
	file.open("res://userData.txt", file.WRITE)
	for g in len(content):
		file.store_line(content[g])
	file.close()
	Global.cleanup()
	pass

func check(cost): # see if they can afford it
	var newMoney = int(Global.userData[1])-cost
	if newMoney >= 0:
		return true
	else:
		return false

func notEnough(): # if they cannot afford item
	print("hi3")
	$NotEnough.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$NotEnough.hide()
	pass

func _on_AmmoMax_pressed(): # upgrades max ammo
	var enoughCash = check(Global.newAmmo_cost)
	if enoughCash == true:
		Global.userData[2] = str(int(Global.userData[2]) +5)
		change(Global.newAmmo_cost)
		Global.newAmmo = int(Global.userData[3])+5
		Global.newAmmo_cost = int(Global.newAmmo*1.5)
	else:
		notEnough()
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	var ammotext = "Upgrade Max Ammo, Currently:" + Global.userData[2] + ", upgraded:"+ str(Global.newAmmo)+ ", upgrade cost:" + str(Global.newAmmo_cost)
	$Ammo.text = str(ammotext)
	
	pass 


func _on_Ammokit_pressed():# upgrades max ammo regen from kit
	var enoughCash = check(Global.newAmmok_cost)
	if enoughCash == true:
		Global.userData[5] = str(int(Global.userData[5])+3)
		change(Global.newAmmok_cost)
		Global.newAmmok = int(Global.userData[3])+5
		Global.newAmmok_cost = int(Global.newAmmok*1.5)
	else:
		notEnough()
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	pass 


func _on_HP_pressed(): # upgrades max hp
	var enoughCash = check(Global.newHP_cost)
	if enoughCash == true:
		Global.userData[3] = str(int(Global.userData[3]) +5)
		change(Global.newHP_cost)
		Global.newHP = int(Global.userData[4])+2
		Global.newHP_cost = int(Global.newHP*1.5)
	else:
		notEnough()
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	var hptext = "Currently:" + Global.userData[3] +", upgraded:"+ str(Global.newHP)+ ", upgarde cost:" + str(Global.newHP_cost)
	$Hp.text = str(hptext)
	pass 


func _on_MedKit_pressed():# upgrades max hp regen from kit
	print("hi")
	var enoughCash = check(Global.newMed_cost)
	if enoughCash == true:
		print("hi")
		Global.userData[4] = str(int(Global.userData[4]) +5)
		change(Global.newMed_cost)
		Global.newHP = int(Global.userData[4])+1
		Global.newHP_cost = int(Global.newHP*2)
	else:
		notEnough()
		print("hi2")
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	var med =  "Upgrade Medkit regen ammount, Currently:" + Global.userData[4] +", upgraded:"+str(Global.newMed)+",upgrade cost:" + str(Global.newMed_cost)
	$Med.text = str(med)
	pass 

	
func _on_Menu_pressed():#loads up the menu
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	pass # Replace with function body.
