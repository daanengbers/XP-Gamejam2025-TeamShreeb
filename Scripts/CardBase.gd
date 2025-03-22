extends Node2D

@onready var Test1Action = await get_node("Test1")
@onready var Test2Action = await get_node("Test2")
@onready var Test3Action = await get_node("Test3")
@onready var Test4Action = await get_node("Test4")
@onready var Test5Action = await get_node("Test5")

@export var Actions = ["","",""]
var action1
var action2
var action3
var actionsInCard = [action1,action2,action3]

@export var ActionsUILocations = [Vector2(0,0), Vector2(0,0), Vector2(0,0)]

func _ready():
	initUI()
	pass # Replace with function body.


func _process(delta):
	pass
	
func initUI():
	for i in range(3):
		match Actions[i]:
			"Test1":
				actionsInCard[i] = Test1Action
				Test1Action.remove_from_group("Unused")
			"Test2":
				actionsInCard[i] = Test2Action
				Test2Action.remove_from_group("Unused")
			"Test3":
				actionsInCard[i] = Test3Action
				Test3Action.remove_from_group("Unused")
			"Test4":
				actionsInCard[i] = Test4Action
				Test4Action.remove_from_group("Unused")
			"Test5":
				actionsInCard[i] = Test5Action
				Test5Action.remove_from_group("Unused")
	var unusedActions = get_tree().get_nodes_in_group("Unused")
	for u in range(unusedActions.size()):
		unusedActions[u].queue_free()
	for l in range(3):
		actionsInCard[l].position = ActionsUILocations[l]
