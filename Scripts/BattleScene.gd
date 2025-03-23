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
			enemyAttack("Random")
			animWait = 3.6
			Room.enemyBasicAttack()
			hasDoneAction = true
		"BigAttack":
			enemyBigAttack("Random")
			animWait = 3.8
			Room.enemyBigAttack()
			hasDoneAction = true
		"Earthquake":
			enemyEarthquakeAttack("All")
			animWait = 3.4
			Room.enemyEarthquake()
			hasDoneAction = true
		"Heal":
			print(randomAbillity)
			hasDoneAction = true
		"smallAttack(":
			print(randomAbillity)
			hasDoneAction = true
		"Fireball":
			print(randomAbillity)
			hasDoneAction = true
	if animWait != null:
		await get_tree().create_timer(animWait).timeout
	if hasDoneAction:
		endEnemyTurn()

func enemyAttack(target):
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	var damageDealt = casterOfAction.ATK * 2
	enemyChosenTarget.HP -= damageDealt
	enemyChosenTarget.checkDeath()
	enemyChosenTarget.updateUI()
	pass

func enemyBigAttack(target):
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	var damageDealt = casterOfAction.ATK * 3
	enemyChosenTarget.HP -= damageDealt
	enemyChosenTarget.updateUI()
	pass

func enemyEarthquakeAttack(target):
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	var damageDealt = casterOfAction.ATK * 1
	print(enemyChosenTarget)
	for i in range(enemyChosenTarget.size()):
		#print(enemyChosenTarget[i])
		enemyChosenTarget[i].HP -= damageDealt
		enemyChosenTarget[i].updateUI()
	pass

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

func enemyFireball():
	pass

func enemyHeal():
	pass

func doFriendlyAction(actionID, caster, target):
	var hasDoneAction = false
	var animWait = 0.0
	match actionID:
		"Tackle":
			smallAttack(target, caster)
			animWait = 2.0
			Room.attackSmall()
			hasDoneAction = true
		"Big Slam Attack":
			print("attack")
			hasDoneAction = true
		"Heal":
			heal(target,caster)
			hasDoneAction = true
		"Fireball":
			fireballAttack(target, caster)
			animWait = 2.0
			Room.attackShootFireball()
			hasDoneAction = true
	Global.global_isPlayerTurn = false
	await get_tree().create_timer(animWait).timeout
	if hasDoneAction:
		endPlayerTurn()
	else:
		print("something went very wrong")

func smallAttack(target, caster):
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	var damageDealt = friendlyCasterOfAction.ATK * 1
	friendlyTargetForAction.HP -= damageDealt
	friendlyTargetForAction.updateUI() 
	friendlyTargetForAction.checkDeath()

func fireballAttack(target, caster):
	friendlyGetCaster(caster)
	friendlyGetTarget(target)
	var damageDealt = friendlyCasterOfAction.MG * 1
	friendlyTargetForAction.HP -= damageDealt
	friendlyTargetForAction.updateUI() 
	friendlyTargetForAction.checkDeath()



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

func heal(target, caster):
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
	targetForAction.HP += healthHealed
	if targetForAction.HP > targetForAction.maxHP:
		targetForAction.HP = targetForAction.maxHP
	targetForAction.updateUI() 
	pass

func endPlayerTurn():
	if Global.global_isInBattle == true:
		Global.global_isPlayerTurn = false
		doEnemyAction()

func endEnemyTurn():
	if Global.global_isInBattle == true:
		Global.global_isPlayerTurn = true
