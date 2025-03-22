extends Node2D

@onready var party = await get_node("Party")
@onready var BattleEnemy = await get_node("BattleEnemy")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func doFriendlyAction(actionID, caster, target):
	match actionID:
		"smallAttack":
			smallAttack(target, caster)
		"Attack":
			print(actionID)
		"Heal":
			print(actionID)
	pass

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
	
