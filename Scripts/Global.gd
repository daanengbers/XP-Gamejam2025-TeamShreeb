extends Node

var global_isPlayerTurn = true
var global_isInBattle = true

var global_enemiesDefeated = 0

var global_needsToIntNewEnemy = false

var global_Char1Dead = false
var global_Char2Dead = false
var global_Char3Dead = false
var global_Char4Dead = false

var global_Char1IsOutOfOptions = false
var global_Char2IsOutOfOptions = false
var global_Char3IsOutOfOptions = false
var global_Char4IsOutOfOptions = false

var globalIsOutOfOptions = false
var globalSomeoneIsOutOfOptions = false

func _ready():
	randomize()

func CheckGameover():
	if global_Char1Dead && global_Char2Dead && global_Char3Dead && global_Char4Dead:
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/GameOverScene.tscn")

func checkOptionsLeftGameOver():
	if global_Char1IsOutOfOptions && global_Char2IsOutOfOptions && global_Char3IsOutOfOptions && global_Char4IsOutOfOptions:
		globalIsOutOfOptions = true
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/out_of_options_screen.tscn")

func TriggerVictoryScreen():
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Scenes/victory_screen.tscn")

func resetGame():
	global_isPlayerTurn = true
	global_isInBattle = true
	
	global_enemiesDefeated = 0
	
	global_needsToIntNewEnemy = false
	
	global_Char1Dead = false
	global_Char2Dead = false
	global_Char3Dead = false
	global_Char4Dead = false
	
	global_Char1IsOutOfOptions = false
	global_Char2IsOutOfOptions = false
	global_Char3IsOutOfOptions = false
	global_Char4IsOutOfOptions = false
	
	globalIsOutOfOptions = false
