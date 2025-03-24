extends Node2D

var buttonpressed = false


func _on_texture_button_pressed():
	if buttonpressed == false:
		buttonpressed = true
		$Black/FadeAnim.play("new_animation")

func loadCorrectScene():
	MusicManager.setSongNumber(0)
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
