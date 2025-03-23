extends Node2D

@onready var slot1 = await get_node("../CardSlot1")
@onready var slot2 = await get_node("../CardSlot2")
@onready var slot3 = await get_node("../CardSlot3")
@onready var slot4 = await get_node("../CardSlot4")

var card1 = preload("res://Scenes/Cards/card_1.tscn")
var card2 = preload("res://Scenes/Cards/card_2.tscn")
var card3 = preload("res://Scenes/Cards/card_3.tscn")
var card4 = preload("res://Scenes/Cards/card_4.tscn")
var card5 = preload("res://Scenes/Cards/card_5.tscn")
var card6 = preload("res://Scenes/Cards/card_6.tscn")

var availableCards = []

var chosenCard
var chosencard

func _ready():
	randomize()
	match Global.global_enemiesDefeated:
		0:
			availableCards = [card1, card2, card3]
		1:
			availableCards = [card1, card2, card3]
		2:
			availableCards = [card1, card2, card3]
		3:
			availableCards = [card1, card2, card3, card4]
		4:
			availableCards = [card1, card2, card3, card4]
		5:
			availableCards = [card1, card2, card3, card4, card5]
		6:
			availableCards = [card1, card2, card3, card4, card5]
		7:
			availableCards = [card1, card2, card3, card4, card5, card6]
		8:
			availableCards = [card1, card2, card3, card4, card5, card6]
		9:
			availableCards = [card1, card2, card3, card4, card5, card6]
		10:
			availableCards = [card1, card2, card3, card4, card5, card6]
	chosenCard = availableCards.pick_random()
	chosencard = chosenCard.instantiate()
	$AwardedCardSlot.add_child(chosencard)
	chosencard.initUI()
	chosencard.position = Vector2(0,0)
	print(chosencard.position)
	$Flashbuttons.play("flashcolors")

func _on_slot_1_button_pressed():
	if !Global.global_Char1Dead:
		slot1.get_child(0).queue_free()
		chosencard.reparent(slot1)
		chosencard.slotAssigned = 1
		chosencard.position = Vector2(0,260)
		playFinishAnimationInRoom()
		Global.global_Char1IsOutOfOptions = false
		$".".queue_free()

func _on_slot_2_button_pressed():
	if !Global.global_Char2Dead:
		slot2.get_child(0).queue_free()
		chosencard.reparent(slot2)
		chosencard.slotAssigned = 2
		chosencard.position = Vector2(0,260)
		playFinishAnimationInRoom()
		Global.global_Char2IsOutOfOptions = false
		$".".queue_free()

func _on_slot_3_button_pressed():
	if !Global.global_Char4Dead:
		slot4.get_child(0).queue_free()
		chosencard.reparent(slot4)
		chosencard.slotAssigned = 4
		chosencard.position = Vector2(0,260)
		playFinishAnimationInRoom()
		Global.global_Char3IsOutOfOptions = false
		$".".queue_free()

func _on_slot_4_button_pressed():
	if !Global.global_Char3Dead:
		slot3.get_child(0).queue_free()
		chosencard.reparent(slot3)
		chosencard.slotAssigned = 3
		chosencard.position = Vector2(0,260)
		playFinishAnimationInRoom()
		Global.global_Char4IsOutOfOptions = false
		$".".queue_free()

func playFinishAnimationInRoom():
	get_parent().get_parent().get_parent().get_parent().goToNextScene()
