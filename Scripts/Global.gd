extends Node

var global_isPlayerTurn = true
var global_isInBattle = true

var global_enemiesDefeated = 0

var global_needsToIntNewEnemy = false

var global_Char1Dead = false
var global_Char2Dead = false
var global_Char3Dead = false
var global_Char4Dead = false

func _ready():
	randomize()

func CheckGameover():
	if global_Char1Dead && global_Char2Dead && global_Char3Dead && global_Char4Dead:
		get_tree().change_scene_to_file("res://Scenes/GameOverScene.tscn")
	pass

func resetGame():
	global_isPlayerTurn = true
	global_isInBattle = true
	
	global_enemiesDefeated = 0
	
	global_needsToIntNewEnemy = false
	
	global_Char1Dead = false
	global_Char2Dead = false
	global_Char3Dead = false
	global_Char4Dead = false
