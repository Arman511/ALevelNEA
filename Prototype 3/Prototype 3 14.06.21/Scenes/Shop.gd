extends Control

var newHP = int(Global.userData[3])+2
var newHP_cost = int(newHP*2)
var newAmmo = int(Global.userData[2])+3
var newAmmo_cost = int(newAmmo*1.5)
var newMed = int(Global.userData[4])+1
var newMed_cost = int(newMed*2)
var newAmmok = int(Global.userData[5])+7
var newAmmok_cost = int(newAmmok*1.5)



func ready():
	$NotEnough.hide()
	newHP = int(Global.userData[3])+2
	newHP_cost = int(newHP*3)
	newAmmo = int(Global.userData[2])+3
	newAmmo_cost = int(newAmmo*1.5)
	newMed = int(Global.userData[4])+1
	newMed_cost = int(newMed*2)
	newAmmok = int(Global.userData[5])+5
	newAmmok_cost = int(newAmmok*1.5)



func _process(_delta):
	
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	var hptext = "Currently:" + Global.userData[3] +", upgraded:"+ str(newHP)+ ", upgarde cost:" + str(newHP_cost)
	$Hp.text = str(hptext)
	var ammotext = "Upgrade Max Ammo, Currently:" + Global.userData[2] + ", upgraded:"+ str(newAmmo)+ ", upgrade cost:" + str(newAmmo_cost)
	$Ammo.text = str(ammotext)
	var med =  "Upgrade Medkit regen ammount, Currently:" + Global.userData[4] +", upgraded:"+str(newMed)+",upgrade cost:" + str(newMed_cost)
	$Med.text = str(med)
	var kit = "Upgrade Ammokit regen ammount, Currently:" + Global.userData[5] + ", upgraded:" + str(newAmmok) +",upgrade cost:" + str(newAmmok_cost)
	$Kit.text = str(kit)




#2345
#shellMax(20),HPMax(10),hpKitsize(2),ammokitSize(10)

func change(cost):
	Global.userData[1] = str(int(Global.userData[1])-cost)
	Global.save_changes()
	pass

func check(cost):
	
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
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	var enoughCash = check(newAmmo_cost)
	if enoughCash == true:
		Global.userData[2] = str(int(Global.userData[2]) +5)
		change(newAmmo_cost)
		ready()
	else:
		notEnough()
	pass 


func _on_Ammokit_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	var enoughCash = check(newAmmok_cost)
	if enoughCash == true:
		Global.userData[5] = str(int(Global.userData[5])+3)
		change(newAmmok_cost)
		ready()
	else:
		notEnough()
	pass 


func _on_HP_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	var enoughCash = check(newHP_cost)
	if enoughCash == true:
		Global.userData[3] = str(int(Global.userData[3]) +2)
		change(newHP_cost)
		ready()
	else:
		notEnough()
	pass 


func _on_MedKit_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	var enoughCash = check(newMed_cost)
	if enoughCash == true:
		Global.userData[4] = str(int(Global.userData[4]) +1)
		change(newMed_cost)
		ready()
	else:
		notEnough()
	pass 

	
func _on_Menu_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	pass # Replace with function body.
