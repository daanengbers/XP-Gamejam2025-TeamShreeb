extends Node2D

@onready var party = await get_node("Party")
@onready var BattleEnemy = await get_node("BattleEnemy")
@onready var Room = get_parent().get_parent()

var enemyChosenTarget

var friendlyCasterOfAction
var friendlyTargetForAction

############################################################################################################################

func _ready():
	randomize()
	pass # Replace with function body.

##############################################################

###Enemy combat functions###

##Enemy action handler##
func doEnemyAction():
	var hasDoneAction = false
	var animWait = 0.0
	randomize()
	var enemyInstance = get_node("BattleEnemy/EnemyInstance")
	var randomAbillity = enemyInstance.possibleAttacks.pick_random()
	match randomAbillity:
		"Attack":
			Room.enemyBasicAttack()
			animWait = 2
			await get_tree().create_timer(animWait).timeout
			enemyAttack("Random")
			animWait = 1.6
			await get_tree().create_timer(animWait).timeout
			hasDoneAction = true
		"BigAttack":
			Room.enemyBigAttack()
			animWait = 2.8
			await get_tree().create_timer(animWait).timeout
			enemyBigAttack("Random")
			animWait = 1.0
			await get_tree().create_timer(animWait).timeout
			hasDoneAction = true
		"Earthquake":
			Room.enemyEarthquake()
			animWait = 1.2
			await get_tree().create_timer(animWait).timeout
			enemyEarthquakeAttack("All")
			animWait = 2.2
			await get_tree().create_timer(animWait).timeout
			hasDoneAction = true
		"Heal":
			Room.enemyHeal()
			animWait = 1.4
			await get_tree().create_timer(animWait).timeout
			enemyHealAttack()
			animWait = 0.8
			await get_tree().create_timer(animWait).timeout
			hasDoneAction = true
	if hasDoneAction:
		endEnemyTurn()

################################

##Enemy abilities functions##
func enemyAttack(target):
	##Get the target and the caster
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	
	##Calculate damage dealt or health healed
	var damageDealt = casterOfAction.ATK * 2
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(casterOfAction.EnemyName) + " tackled " + str(enemyChosenTarget.charName) + " for " + str(damageDealt) + " damage!")
	
	##Handle the in game results of the ability
	enemyChosenTarget.HP -= damageDealt
	
	##Update UI and check death were applicable
	enemyChosenTarget.displayDamageHeal(damageDealt, "damage")
	enemyChosenTarget.checkDeath()
	enemyChosenTarget.updateUI()

func enemyBigAttack(target):
	##Get the target and the caster
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	
	##Calculate damage dealt or health healed
	var damageDealt = casterOfAction.ATK * 3
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(casterOfAction.EnemyName) + " tackled " + str(enemyChosenTarget.charName) + " for " + str(damageDealt) + " damage!")
	
	##Handle the in game results of the ability
	enemyChosenTarget.HP -= damageDealt
	
	##Update UI and check death were applicable
	enemyChosenTarget.displayDamageHeal(damageDealt, "damage")
	enemyChosenTarget.checkDeath()
	enemyChosenTarget.updateUI()

func enemyEarthquakeAttack(target):
	##Get the target and the caster
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	
	##Calculate damage dealt or health healed
	var damageDealt = round(casterOfAction.ATK * 0.5)
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(casterOfAction.EnemyName) + " caused an earthquake and hit everyone for " + str(damageDealt) + " damage!")
	
	##Handle the in game results of the ability
	for i in range(enemyChosenTarget.size()):
		enemyChosenTarget[i].HP -= damageDealt
		
		##Update UI and check death were applicable
		enemyChosenTarget[i].displayDamageHeal(damageDealt, "damage")
		enemyChosenTarget[i].checkDeath()
		enemyChosenTarget[i].updateUI()

func enemyHealAttack():
	##Get the target and the caster
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	var targetOfAction = casterOfAction
	
	##Calculate damage dealt or health healed
	var HealthHealed = round(casterOfAction.ATK * 1.5)
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(casterOfAction.EnemyName) + " recentered itself and healed " + str(HealthHealed) + " health!")
	
	##Handle the in game results of the ability
	targetOfAction.HP += HealthHealed
	if targetOfAction.HP >= targetOfAction.MAXHP:
		targetOfAction.HP = targetOfAction.MAXHP
	
	##Update UI and check death were applicable
	get_parent().get_parent().updateEnemyDuringBattle(targetOfAction.HP)

################################

##Enemy combat helpers##
func getEnemyTarget(whoToTarget):
	var slot1 = get_node("Party/Slot1")
	var slot2 = get_node("Party/Slot2")
	var slot3 = get_node("Party/Slot3")
	var slot4 = get_node("Party/Slot4")
	
	var allSlots = [slot1,slot2,slot3,slot4]
	
	if Global.global_Char1Dead:
		allSlots.erase(slot1)
	if Global.global_Char2Dead:
		allSlots.erase(slot2)
	if Global.global_Char3Dead:
		allSlots.erase(slot3)
	if Global.global_Char4Dead:
		allSlots.erase(slot4)
	
	var OwnTarget##change later
	match whoToTarget:
		"Random":
			randomize()
			enemyChosenTarget = allSlots.pick_random()
		"All":
			enemyChosenTarget = allSlots
			print(enemyChosenTarget)
	pass

##############################################################

###Friendly combat functions###

##Friendly action handler##
func doFriendlyAction(actionID, caster, target):
	
	##Init the action by creating variables needed and turning global var player turn off
	var hasDoneAction = false
	var animWait = 0.0
	Global.global_isPlayerTurn = false
	
	##Read the actionID to decide which ability needs to be cast
	match actionID:
		"Tackle":
			Room.attackSmall()
			animWait = 0.9
			await get_tree().create_timer(animWait).timeout
			friendlyTackleAttack(target, caster)
			animWait = 1.1
			await get_tree().create_timer(animWait).timeout
			friendlyTargetForAction.checkDeath()
			hasDoneAction = true
		"Big Slam Attack":
			Room.attackLargeSlam()
			animWait = 1.6
			await get_tree().create_timer(animWait).timeout
			friendlyBigSlamAttack(target, caster)
			animWait = 1.4
			await get_tree().create_timer(animWait).timeout
			friendlyTargetForAction.checkDeath()
			hasDoneAction = true
		"Heal self":
			Room.friendlyHeal()
			animWait = 1.0
			await get_tree().create_timer(animWait).timeout
			friendlyHealSelf(target,caster)
			animWait = 1.6
			await get_tree().create_timer(animWait).timeout
			hasDoneAction = true
		"Heal all":
			Room.friendlyHeal()
			animWait = 1.0
			await get_tree().create_timer(animWait).timeout
			friendlyHealAll(target,caster)
			animWait = 1.6
			await get_tree().create_timer(animWait).timeout
			hasDoneAction = true
		"Fireball":
			Room.attackShootFireball()
			animWait = 1.2
			await get_tree().create_timer(animWait).timeout
			friendlyFireballAttack(target, caster)
			animWait = 0.4
			await get_tree().create_timer(animWait).timeout
			friendlyTargetForAction.checkDeath()
			hasDoneAction = true
		"Ice Ball":
			Room.attackShootFrostball()
			animWait = 1.2
			await get_tree().create_timer(animWait).timeout
			friendlyIceballAttack(target, caster)
			animWait = 0.4
			await get_tree().create_timer(animWait).timeout
			friendlyTargetForAction.checkDeath()
			hasDoneAction = true
	Global.global_isPlayerTurn = false
	if hasDoneAction:
		endPlayerTurn()
	else:
		print("something went very wrong")

################################

##Friendly abilities functions##
func friendlyTackleAttack(target, caster):
	##Get target(s) and caster of ability
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	
	##Calculate damage dealt or health healed
	var damageDealt = friendlyCasterOfAction.ATK * 1
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " hit " + str(friendlyTargetForAction.EnemyName) + " for " + str(damageDealt) + " damage!")
	
	##Handle the in game results of the ability
	friendlyTargetForAction.HP -= damageDealt
	
	##Update UI and check death were applicable
	friendlyTargetForAction.updateUI() 

func friendlyBigSlamAttack(target, caster):
	##Get target(s) and caster of ability
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	
	##Calculate damage dealt or health healed
	var damageDealt = friendlyCasterOfAction.ATK * 2
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " slammed " + str(friendlyTargetForAction.EnemyName) + " for " + str(damageDealt) + " damage!")
	
	##Handle the in game results of the ability
	friendlyTargetForAction.HP -= damageDealt
	
	##Update UI and check death were applicable
	friendlyTargetForAction.updateUI() 

func friendlyFireballAttack(target, caster):
	##Get target(s) and caster of ability
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	
	##Calculate damage dealt or health healed
	var damageDealt = friendlyCasterOfAction.MG * 2
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " summoned a ball of pure fire and dealt " + str(damageDealt) + " damage to " + str(friendlyTargetForAction.EnemyName))
	
	##Handle the in game results of the ability
	friendlyTargetForAction.HP -= damageDealt
	
	##Update UI and check death were applicable
	friendlyTargetForAction.updateUI() 

func friendlyIceballAttack(target, caster):
	##Get target(s) and caster of ability
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	
	##Calculate damage dealt or health healed
	var damageDealt = round(friendlyCasterOfAction.MG * 2.5)
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " summoned a ball of pure ice and dealt " + str(damageDealt) + " damage to " + str(friendlyTargetForAction.EnemyName))
	
	##Handle the in game results of the ability
	friendlyTargetForAction.HP -= damageDealt
	
	##Update UI and check death were applicable
	friendlyTargetForAction.updateUI() 

func friendlyHealSelf(target, caster):
	##Get target(s) and caster of ability
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	
	##Calculate damage dealt or health healed
	var healthHealed = friendlyCasterOfAction.MG * 1
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " recentered itself and healed " + str(healthHealed) + " health!")
	
	##Handle the in game results of the ability
	friendlyTargetForAction.HP += healthHealed
	if friendlyTargetForAction.HP > friendlyTargetForAction.maxHP:
		friendlyTargetForAction.HP = friendlyTargetForAction.maxHP
	
	##Update UI and check death were applicable
	friendlyTargetForAction.displayDamageHeal(healthHealed, "heal")
	friendlyTargetForAction.updateUI() 

func friendlyHealAll(target, caster):
	##Get target(s) and caster of ability
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	
	##Calculate damage dealt or health healed
	var healthHealed = friendlyCasterOfAction.MG * 1
	
	##Display information on the textbox
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " thinked very hard itself and healed everyone for  " + str(healthHealed) + " health!")
	
	##Handle the in game results of the ability
	for i in range(friendlyTargetForAction.size()):
		friendlyTargetForAction[i].HP += healthHealed
		if friendlyTargetForAction[i].HP > friendlyTargetForAction[i].maxHP:
			friendlyTargetForAction[i].HP = friendlyTargetForAction[i].maxHP
		
		##Update UI and check death were applicable
		friendlyTargetForAction[i].displayDamageHeal(healthHealed, "heal")
		friendlyTargetForAction[i].updateUI() 

################################

##Friendly combat helpers##
func friendlyGetCaster(caster):
	match caster:
		1:
			friendlyCasterOfAction = get_node("Party/Slot1")
		2:
			friendlyCasterOfAction = get_node("Party/Slot2")
		3:
			friendlyCasterOfAction = get_node("Party/Slot3")
		4: 
			friendlyCasterOfAction = get_node("Party/Slot4")

func friendlyGetTarget(target):
	match target:
		"Enemy":
			friendlyTargetForAction = get_node("BattleEnemy/EnemyInstance")
		"self":
			friendlyTargetForAction = friendlyCasterOfAction
		"All":
			var caster1 = get_node("Party/Slot1")
			var caster2 = get_node("Party/Slot2")
			var caster3 = get_node("Party/Slot3")
			var caster4 = get_node("Party/Slot4")
			friendlyTargetForAction = [caster1, caster2 , caster3, caster4]
			if Global.global_Char1Dead:
				friendlyTargetForAction.erase(caster1)
			if Global.global_Char2Dead:
				friendlyTargetForAction.erase(caster2)
			if Global.global_Char3Dead:
				friendlyTargetForAction.erase(caster3)
			if Global.global_Char4Dead:
				friendlyTargetForAction.erase(caster4)

##############################################################

###Turn handlers###

func endPlayerTurn():
	if Global.global_isInBattle == true:
		Global.global_isPlayerTurn = false
		Global.checkOptionsLeftGameOver()
		if !Global.globalIsOutOfOptions:
			if Global.globalSomeoneIsOutOfOptions:
				await get_tree().create_timer(4.0).timeout
				Global.checkOptionsLeftGameOver()
				Global.globalSomeoneIsOutOfOptions = false
				doEnemyAction()
			else:
				doEnemyAction()

func endEnemyTurn():
	if Global.global_isInBattle == true:
		Global.global_isPlayerTurn = true
