extends Node2D

@onready var slot1 = await get_node("Slot1")
@onready var slot2 = await get_node("Slot2")
@onready var slot3 = await get_node("Slot3")
@onready var slot4 = await get_node("Slot4")

@onready var Char1 = await get_node("Char1Data")

var slots = [slot1, slot2, slot3, slot4]

# Called when the node enters the scene tree for the first time.
func _ready():
	InitParty()
	print(slot1.HP)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func InitParty():
	## slot1 UI <- char1data
	slot1.HP = Char1.HP
	slot1.ATK = Char1.ATK
	slot1.InitUI()
	pass
	
	
