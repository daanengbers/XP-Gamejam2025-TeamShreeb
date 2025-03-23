extends Node2D

@onready var party = await get_node("Party")
@onready var BattleEnemy = await get_node("BattleEnemy")
@onready var Room = get_parent().get_parent()

var enemyChosenTarget
var friendlyCasterOfAction
var friendlyTargetForAction

func _ready():
	randomize()
	pass # Replace with function body.

func _process(delta):
	pass

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

func enemyAttack(target):
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	var damageDealt = casterOfAction.ATK * 2
	enemyChosenTarget.HP -= damageDealt
	GlobalTextBox.activateTextbox(str(casterOfAction.EnemyName) + " tackled " + str(enemyChosenTarget.charName) + " for " + str(damageDealt) + " damage!")
	enemyChosenTarget.checkDeath()
	enemyChosenTarget.updateUI()
	pass

func enemyBigAttack(target):
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	var damageDealt = casterOfAction.ATK * 3
	GlobalTextBox.activateTextbox(str(casterOfAction.EnemyName) + " tackled " + str(enemyChosenTarget.charName) + " for " + str(damageDealt) + " damage!")
	enemyChosenTarget.HP -= damageDealt
	enemyChosenTarget.checkDeath()
	enemyChosenTarget.updateUI()
	pass

func enemyEarthquakeAttack(target):
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	var damageDealt = round(casterOfAction.ATK * 0.5)
	GlobalTextBox.activateTextbox(str(casterOfAction.EnemyName) + " caused an earthquake and hit everyone for " + str(damageDealt) + " damage!")
	for i in range(enemyChosenTarget.size()):
		#getEnemyTarget(target)
		enemyChosenTarget[i].HP -= damageDealt
		enemyChosenTarget[i].checkDeath()
		enemyChosenTarget[i].updateUI()
	pass
	
func enemyHealAttack():
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	var targetOfAction = casterOfAction
	var HealthHealed = casterOfAction.ATK * 4
	GlobalTextBox.activateTextbox(str(casterOfAction.EnemyName) + " recentered itself and healed " + str(HealthHealed) + " health!")
	targetOfAction.HP += HealthHealed
	if targetOfAction.HP >= targetOfAction.MAXHP:
		targetOfAction.HP = targetOfAction.MAXHP
	get_parent().get_parent().updateEnemyDuringBattle(targetOfAction.HP)

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


func doFriendlyAction(actionID, caster, target):
	var hasDoneAction = false
	var animWait = 0.0
	match actionID:
		"Tackle":
			Room.attackSmall()
			animWait = 0.9
			await get_tree().create_timer(animWait).timeout
			tackleAttack(target, caster)
			animWait = 1.1
			await get_tree().create_timer(animWait).timeout
			friendlyTargetForAction.checkDeath()
			hasDoneAction = true
		"Big Slam Attack":
			Room.attackLargeSlam()
			animWait = 1.6
			await get_tree().create_timer(animWait).timeout
			bigSlamAttack(target, caster)
			animWait = 1.4
			await get_tree().create_timer(animWait).timeout
			friendlyTargetForAction.checkDeath()
			hasDoneAction = true
		"Heal self":
			Room.friendlyHeal()
			animWait = 1.0
			await get_tree().create_timer(animWait).timeout
			healSelf(target,caster)
			animWait = 1.6
			await get_tree().create_timer(animWait).timeout
			hasDoneAction = true
		"Heal all":
			Room.friendlyHeal()
			animWait = 1.0
			await get_tree().create_timer(animWait).timeout
			healAll(target,caster)
			animWait = 1.6
			await get_tree().create_timer(animWait).timeout
			hasDoneAction = true
		"Fireball":
			Room.attackShootFireball()
			animWait = 1.2
			await get_tree().create_timer(animWait).timeout
			fireballAttack(target, caster)
			animWait = 0.4
			await get_tree().create_timer(animWait).timeout
			friendlyTargetForAction.checkDeath()
			hasDoneAction = true
	Global.global_isPlayerTurn = false
	if hasDoneAction:
		endPlayerTurn()
	else:
		print("something went very wrong")

func tackleAttack(target, caster):
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	var damageDealt = friendlyCasterOfAction.ATK * 1
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " hit " + str(friendlyTargetForAction.EnemyName) + " for " + str(damageDealt) + " damage!")
	friendlyTargetForAction.HP -= damageDealt
	friendlyTargetForAction.updateUI() 
	#friendlyTargetForAction.checkDeath()
	
func bigSlamAttack(target, caster):
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	var damageDealt = friendlyCasterOfAction.ATK * 2
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " slammed " + str(friendlyTargetForAction.EnemyName) + " for " + str(damageDealt) + " damage!")
	friendlyTargetForAction.HP -= damageDealt
	friendlyTargetForAction.updateUI() 
	#friendlyTargetForAction.checkDeath()

func fireballAttack(target, caster):
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	var damageDealt = friendlyCasterOfAction.MG * 1
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " summoned a ball of pure fire and dealt " + str(damageDealt) + " damage to " + str(friendlyTargetForAction.EnemyName))
	friendlyTargetForAction.HP -= damageDealt
	friendlyTargetForAction.updateUI() 
	#friendlyTargetForAction.checkDeath()

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

func healSelf(target, caster):
	var targetForAction
	var casterOfAction
	match caster:
		1:
			casterOfAction = get_node("Party/Slot1")
		2:
			casterOfAction = get_node("Party/Slot2")
		3:
			casterOfAction = get_node("Party/Slot3")
		4: 
			casterOfAction = get_node("Party/Slot4")
	match target:
		"Enemy":
			targetForAction = get_node("BattleEnemy/EnemyInstance")
		"self":
			targetForAction = casterOfAction
	var healthHealed = casterOfAction.MG * 1
	GlobalTextBox.activateTextbox(str(casterOfAction.charName) + " recentered itself and healed " + str(healthHealed) + " health!")
	targetForAction.HP += healthHealed
	if targetForAction.HP > targetForAction.maxHP:
		targetForAction.HP = targetForAction.maxHP
	targetForAction.updateUI() 
	pass

func healAll(target, caster):
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	print(friendlyTargetForAction)
	var healthHealed = friendlyCasterOfAction.MG * 1
	GlobalTextBox.activateTextbox(str(friendlyCasterOfAction.charName) + " thinked very hard itself and healed everyone for  " + str(healthHealed) + " health!")
	for i in range(friendlyTargetForAction.size()):
		friendlyTargetForAction[i].HP += healthHealed
		if friendlyTargetForAction[i].HP > friendlyTargetForAction[i].maxHP:
			friendlyTargetForAction[i].HP = friendlyTargetForAction[i].maxHP
		friendlyTargetForAction[i].updateUI() 
	
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
