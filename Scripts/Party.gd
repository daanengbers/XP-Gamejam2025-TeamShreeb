extends Node2D

@onready var victoryScreen = preload("res://Scenes/VictoryScreen.tscn")

@onready var charSlot1 = await get_node("Slot1")
@onready var charSlot2 = await get_node("Slot2")
@onready var charSlot3 = await get_node("Slot3")
@onready var charSlot4 = await get_node("Slot4")

@onready var cardSlot1 = await get_node("CardSlot1")
@onready var cardSlot2 = await get_node("CardSlot2")
@onready var cardSlot3 = await get_node("CardSlot3")
@onready var cardSlot4 = await get_node("CardSlot4")

@onready var charSlots = [charSlot1, charSlot2, charSlot3, charSlot4]
@onready var cardSlots = [cardSlot1, cardSlot2, cardSlot3, cardSlot4]
@onready var chars = get_tree().get_nodes_in_group("PartyMembers")
@onready var cards = get_tree().get_nodes_in_group("Cards")

var Card1 = preload("res://Scenes/Cards/card_1.tscn")
var Card2 = preload("res://Scenes/Cards/card_2.tscn")
var Card3 = preload("res://Scenes/Cards/card_3.tscn")
var Card4 = preload("res://Scenes/Cards/card_4.tscn")

# var cards2 = [Card1, Card2, Card3, Card4]

@export var cardOffset = 0
@export var beginingCardsIDs = ["","","",""]

# Called when the node enters the scene tree for the first time.
func _ready():
	InitParty()
	InitCards()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_0):
		InitCards()
	pass
	
func InitParty():
	for i in range(4):
		charSlots[i].maxHP = chars[i].MAX_HP
		charSlots[i].HP = chars[i].HP
		charSlots[i].ATK = chars[i].ATK
		charSlots[i].MG = chars[i].MG
		charSlots[i].charName = chars[i].charName
		charSlots[i].charSprite = chars[i].charSprite
		charSlots[i].InitUI()
	pass

func InitCards():
	for i in range(4):
		match beginingCardsIDs[i]:
			"Card1":
				var card1 = Card1.instantiate()
				card1.slotAssigned = i + 1
				cardSlots[i].add_child(card1)
				card1.position = Vector2(0,cardOffset)
				card1.initUI()
			"Card2":
				var card2 = Card2.instantiate()
				card2.slotAssigned = i + 1
				cardSlots[i].add_child(card2)
				card2.position = Vector2(0,cardOffset)
				card2.initUI()
			"Card3":
				var card3 = Card3.instantiate()
				card3.slotAssigned = i + 1
				cardSlots[i].add_child(card3)
				card3.position = Vector2(0,cardOffset)
				card3.initUI()
			"Card4":
				var card4 = Card4.instantiate()
				card4.slotAssigned = i + 1
				cardSlots[i].add_child(card4)
				card4.position = Vector2(0,cardOffset)
				card4.initUI()

func triggerVicory():
	var triggervictory = victoryScreen.instantiate()
	self.add_child(triggervictory)
	pass
	
func handlePlayerDeath(slotToKill):
	match slotToKill:
		1:
			for action in cardSlot1.get_child(0).get_children():
				action.queue_free()
			Global.global_Char1Dead = true
			Global.CheckGameover()
		2:
			for action in cardSlot2.get_child(0).get_children():
				action.queue_free()
			Global.global_Char2Dead = true
			Global.CheckGameover()
		3:
			for action in cardSlot3.get_child(0).get_children():
				action.queue_free()
			Global.global_Char3Dead = true
			Global.CheckGameover()
		4:
			for action in cardSlot4.get_child(0).get_children():
				action.queue_free()
			Global.global_Char4Dead = true
			Global.CheckGameover()
