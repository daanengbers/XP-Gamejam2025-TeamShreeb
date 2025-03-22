extends Node2D

@onready var party = await get_node("Party")
@onready var BattleEnemy = await get_node("BattleEnemy")

var enemyChosenTarget

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_1):
		doEnemyAction()
	pass

func doEnemyAction():
	var hasDoneAction = false
	randomize()
	var enemyInstance = get_node("BattleEnemy/EnemyInstance")
	var randomAbillity = enemyInstance.possibleAttacks.pick_random()
	match randomAbillity:
		"Attack":
			enemyAttack("Random")
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
	if hasDoneAction:
		endEnemyTurn()

func enemyAttack(target):
	var casterOfAction = get_node("BattleEnemy/EnemyInstance")
	getEnemyTarget(target)
	var damageDealt = casterOfAction.ATK * 2
	enemyChosenTarget.HP -= damageDealt
	enemyChosenTarget.updateUI()
	pass

func getEnemyTarget(whoToTarget):
	var slot1 = get_node("Party/Slot1")
	var slot2 = get_node("Party/Slot2")
	var slot3 = get_node("Party/Slot3")
	var slot4 = get_node("Party/Slot4")
	var allSlots = [slot1,slot2,slot3,slot4]
	
	var OwnTarget##change later
	match whoToTarget:
		"Random":
			randomize()
			enemyChosenTarget = allSlots.pick_random()
	pass

func enemyFireball():
	pass

func enemyHeal():
	pass

func doFriendlyAction(actionID, caster, target):
	var hasDoneAction = false
	match actionID:
		"smallAttack":
			smallAttack(target, caster)
			hasDoneAction = true
		"Attack":
			print("attack")
			hasDoneAction = true
		"Heal":
			heal(target,caster)
			hasDoneAction = true
	if hasDoneAction:
		endPlayerTurn()
	else:
		print("something went very wrong")

func smallAttack(target, caster):
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
	var damageDealt = casterOfAction.ATK * 1
	targetForAction.HP -= damageDealt
	targetForAction.updateUI() 
	
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
	Global.global_isPlayerTurn = false
	doEnemyAction()

func endEnemyTurn():
	Global.global_isPlayerTurn = true
