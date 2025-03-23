extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.set_text("You managed to defeat " + str(Global.global_enemiesDefeated) + " Enemies")

func _on_start_again_pressed():
	Global.resetGame()
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
