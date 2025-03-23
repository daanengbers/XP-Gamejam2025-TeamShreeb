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

func _on_slot_1_button_pressed():
	if !Global.global_Char1Dead:
		slot1.get_child(0).queue_free()
		chosenCard.reparent(slot1)
		chosenCard.slotAssigned = 1
		chosenCard.position = Vector2(0,260)
		playFinishAnimationInRoom()
		Global.global_Char1IsOutOfOptions = false
		$".".queue_free()

func _on_slot_2_button_pressed():
	if !Global.global_Char2Dead:
		slot2.get_child(0).queue_free()
		chosenCard.reparent(slot2)
		chosenCard.slotAssigned = 2
		chosenCard.position = Vector2(0,260)
		playFinishAnimationInRoom()
		Global.global_Char2IsOutOfOptions = false
		$".".queue_free()

func _on_slot_3_button_pressed():
	if !Global.global_Char4Dead:
		slot4.get_child(0).queue_free()
		chosenCard.reparent(slot4)
		chosenCard.slotAssigned = 4
		chosenCard.position = Vector2(0,260)
		playFinishAnimationInRoom()
		Global.global_Char3IsOutOfOptions = false
		$".".queue_free()

func _on_slot_4_button_pressed():
	if !Global.global_Char3Dead:
		slot3.get_child(0).queue_free()
		chosenCard.reparent(slot3)
		chosenCard.slotAssigned = 3
		chosenCard.position = Vector2(0,260)
		playFinishAnimationInRoom()
		Global.global_Char4IsOutOfOptions = false
		$".".queue_free()

func playFinishAnimationInRoom():
	get_parent().get_parent().get_parent().get_parent().goToNextScene()
