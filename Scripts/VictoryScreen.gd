extends Node2D

@onready var slot1 = await get_node("../CardSlot1")
@onready var slot2 = await get_node("../CardSlot2")
@onready var slot3 = await get_node("../CardSlot3")
@onready var slot4 = await get_node("../CardSlot4")

var card1 = preload("res://Scenes/Cards/card_1.tscn")
var card2 = preload("res://Scenes/Cards/card_1.tscn")
var card3 = preload("res://Scenes/Cards/card_1.tscn")

var chosenCard

func _ready():
	chosenCard = card1.instantiate()
	$AwardedCardSlot.add_child(chosenCard)
	chosenCard.initUI()
	chosenCard.position = Vector2(0,0)
	print(chosenCard.position)

func _process(delta):
	pass


func _on_slot_1_button_pressed():
	slot1.get_child(0).queue_free()
	chosenCard.reparent(slot1)
	chosenCard.slotAssigned = 1
	chosenCard.position = Vector2(0,10)
	chosenCard.initUI()

func _on_slot_2_button_pressed():
	slot2.get_child(0).queue_free()
	chosenCard.reparent(slot2)
	chosenCard.slotAssigned = 2
	chosenCard.position = Vector2(0,10)
	chosenCard.initUI()

func _on_slot_3_button_pressed():
	slot4.get_child(0).queue_free()
	chosenCard.reparent(slot4)
	chosenCard.slotAssigned = 4
	chosenCard.position = Vector2(0,10)
	chosenCard.initUI()

func _on_slot_4_button_pressed():
	slot3.get_child(0).queue_free()
	chosenCard.reparent(slot3)
	chosenCard.slotAssigned = 3
	chosenCard.position = Vector2(0,10)
	chosenCard.initUI()
