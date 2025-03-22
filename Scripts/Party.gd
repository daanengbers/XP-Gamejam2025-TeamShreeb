extends Node2D

@onready var slot1 = await get_node("Slot1")
@onready var slot2 = await get_node("Slot2")
@onready var slot3 = await get_node("Slot3")
@onready var slot4 = await get_node("Slot4")

@onready var char1 = await get_node("PartyMember1")
@onready var char2 = await get_node("PartyMember2")
@onready var char3 = await get_node("PartyMember3")
@onready var char4 = await get_node("PartyMember4")

@onready var slots = [slot1, slot2, slot3, slot4]
@onready var chars = [char1, char2, char3, char4]

# Called when the node enters the scene tree for the first time.
func _ready():
	InitParty()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func InitParty():
	## slot1 UI <- char1data
	for i in range(4):
		slots[i].HP = chars[i].HP
		slots[i].ATK = chars[i].ATK
		slots[i].MG = chars[i].MG
		slots[i].charName = chars[i].charName
		slots[i].charSprite = chars[i].charSprite
		slots[i].InitUI()
	pass
	
	
