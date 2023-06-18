extends Control

onready var newHP
onready var newHP_cost
onready var newAmmo
onready var newAmmo_cost
onready var newMed
onready var newMed_cost
onready var newAmmok
onready var newAmmok_cost
#loads all variable for scene

func _ready():
	newHP = Global.userInfo.getMaxHP()+2
	newHP_cost = int(newHP*2)
	newAmmo = Global.userInfo.getMaxShell()+3
	newAmmo_cost = int(newAmmo*1.5)
	newMed = Global.userInfo.getkitHP()+1
	newMed_cost = int(newMed*2)
	newAmmok = Global.userInfo.getkitAmmo()+7
	newAmmok_cost = int(newAmmok*1.5)	
	#calculates upgrade costs
	$Money.text = "Total Cash:" + str(Global.userInfo.getCash())
	var hptext = "Upgrade Max HP Currently:" + str(Global.userInfo.getMaxHP()) +", upgraded:"+ str(newHP)+ ", upgarde cost:" + str(newHP_cost)
	$Hp.text = str(hptext)
	var ammotext = "Upgrade Max Ammo, Currently:" + str(Global.userInfo.getMaxShell()) + ", upgraded:"+ str(newAmmo)+ ", upgrade cost:" + str(newAmmo_cost)
	$Ammo.text = str(ammotext)
	var med =  "Upgrade Medkit regen amount, Currently:" + str(Global.userInfo.getkitHP()) +", upgraded:"+str(newMed)+",upgrade cost:" + str(newMed_cost)
	$Med.text = str(med)
	var kit = "Upgrade Ammokit regen amount, Currently:" + str(Global.userInfo.getkitAmmo()) + ", upgraded:" + str(newAmmok) +",upgrade cost:" + str(newAmmok_cost)
	$Kit.text = str(kit)
	#loads text for all buttons

func change(cost):
	Global.userInfo.setCash(Global.userInfo.getCash()-cost)
	Global.save_changes()
	_ready()
	pass
	#saves changes

func check(cost):
	if Global.userInfo.getCash() >= cost:
		return true
	else:
		return false
	#checks uf user has enough cash
	#to do purchase

func notEnough():
	$NotEnough.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$NotEnough.hide()
	pass
	#loads node if the user has not enough cash

func _on_AmmoMax_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.01), "timeout")
	var enoughCash = check(newAmmo_cost)
	if enoughCash == true:
		Global.userInfo.setMaxShell(Global.userInfo.getMaxShell()+3)
		change(newAmmo_cost)
	else:
		notEnough()
	pass 
	#changes max ammo of user

func _on_Ammokit_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.01), "timeout")
	var enoughCash = check(newAmmok_cost)
	if enoughCash == true:
		Global.userInfo.setkitAmmo(Global.userInfo.getkitAmmo()+7)
		change(newAmmok_cost)
	else:
		notEnough()
	pass 
	#changes ammo kit size of user

func _on_HP_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.01), "timeout")
	var enoughCash = check(newHP_cost)
	if enoughCash == true:
		Global.userInfo.setMaxHP(Global.userInfo.getMaxHP()+2)
		change(newHP_cost)
	else:
		notEnough()
	pass 
	#changes max hp of user

func _on_MedKit_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.01), "timeout")
	var enoughCash = check(newMed_cost)
	if enoughCash == true:
		Global.userInfo.setkitHP(Global.userInfo.getkitHP()+1)
		change(newMed_cost)
	else:
		notEnough()
	pass 
	#changes size of medkit

func _on_Menu_pressed():
	Global.button = true
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	#makes menu load

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_Menu_pressed()
	if event.is_action_pressed("ui_cancel"):
		_on_Menu_pressed()
	#if enter or esc pressed it loads menu