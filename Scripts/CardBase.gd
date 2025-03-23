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

var optionsLeft = 3

var slotAssigned = 0

@export var ActionsUILocations = [Vector2(0,0), Vector2(0,0), Vector2(0,0)]

func _ready():
	print(get_parent())
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

func checkOptionsLeft():
	if optionsLeft == 0:
		var slot = get_parent().name
		match slot:
			"CardSlot1":
				Global.global_Char1IsOutOfOptions = true
				GlobalTextBox.activateTextbox("Thipps is out of options!")
				Global.globalSomeoneIsOutOfOptions = true
			"CardSlot2":
				Global.global_Char2IsOutOfOptions = true
				GlobalTextBox.activateTextbox("Aak'bo is out of options!")
				Global.globalSomeoneIsOutOfOptions = true
			"CardSlot3":
				Global.global_Char3IsOutOfOptions = true
				GlobalTextBox.activateTextbox("Holmund is out of options!")
				Global.globalSomeoneIsOutOfOptions = true
			"CardSlot4":
				Global.global_Char4IsOutOfOptions = true
				GlobalTextBox.activateTextbox("Clement is out of options!")
				Global.globalSomeoneIsOutOfOptions = true
				
		#get_parent()
