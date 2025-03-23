extends Node2D

var smallAttack = preload("res://Scenes/Actions/smal_attack_action.tscn")
var Attack = preload("res://Scenes/Actions/AttackAction.tscn")
var Heal = preload("res://Scenes/Actions/heal_action.tscn")
var Fireball = preload("res://Scenes/Actions/Fireball_action.tscn")

@export var Actions = ["","",""]
var action1
var action2
var action3
var actionsInCard = []

var slotAssigned = 0

@export var ActionsUILocations = [Vector2(0,0), Vector2(0,0), Vector2(0,0)]

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass
	
func initUI():
	for i in range(3):
		match Actions[i]:
			"Attack":
				var attack = Attack.instantiate()
				self.add_child(attack)
				actionsInCard.append(attack)
			"smallAttack":
				var smallattack = smallAttack.instantiate()
				self.add_child(smallattack)
				actionsInCard.append(smallattack)
			"Heal":
				var heal = Heal.instantiate()
				self.add_child(heal)
				actionsInCard.append(heal)
			"Fireball":
				var fireball = Fireball.instantiate()
				self.add_child(fireball)
				actionsInCard.append(fireball)
			
	for l in range(3):
		actionsInCard[l].position = ActionsUILocations[l]

func cleanup():
	pass
