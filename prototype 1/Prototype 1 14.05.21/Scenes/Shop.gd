extends Control

func _ready():
	$NotEnough.hide()
	Global.newHP = int(Global.userData[3])+2
	Global.newHP_cost = int(Global.newHP*1.5)


	Global.newAmmo = int(Global.userData[2])+3
	Global.newAmmo_cost = int(Global.newAmmo*1.5)

	Global.newMed = int(Global.userData[4])+1
	Global.newMed_cost = int(Global.newMed*1.5)

	Global.newAmmok = int(Global.userData[5])+7
	Global.newAmmok_cost = int(Global.newAmmok*1.5)



func _process(_delta):
	
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

func change(cost):
	Global.userData[1] = str(int(Global.userData[1])-cost)
	Global.save_changes()
	pass

func check(cost):
	print(Global.userData[1], cost)
	if int(Global.userData[1]) >= cost:
		return true
	else:
		return false

func notEnough():
	$NotEnough.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$NotEnough.hide()
	pass

func _on_AmmoMax_pressed():
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


func _on_Ammokit_pressed():
	var enoughCash = check(Global.newAmmok_cost)
	if enoughCash == true:
		Global.userData[5] = str(int(Global.userData[5])+3)
		change(Global.newAmmok_cost)
		Global.newAmmok = int(Global.userData[3])+5
		Global.newAmmok_cost = int(Global.newAmmok*1.5)
	else:
		notEnough()
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	var kit = "Upgrade Ammokit regen ammount, Currently:" + Global.userData[5] + ", upgraded:" + str(Global.newAmmok) +",upgrade cost:" + str(Global.newAmmok_cost)
	$Kit.text = str(kit)
	pass 


func _on_HP_pressed():
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


func _on_MedKit_pressed():
	var enoughCash = check(Global.newMed_cost)
	print("enough")
	print(enoughCash)
	if enoughCash == true:
		Global.userData[4] = str(int(Global.userData[4]) +5)
		change(Global.newMed_cost)
		Global.newHP = int(Global.userData[4])+1
		Global.newHP_cost = int(Global.newHP*2)
	else:
		notEnough()
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	var med =  "Upgrade Medkit regen ammount, Currently:" + Global.userData[4] +", upgraded:"+str(Global.newMed)+",upgrade cost:" + str(Global.newMed_cost)
	$Med.text = str(med)
	pass 

	
func _on_Menu_pressed():
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	pass # Replace with function body.
