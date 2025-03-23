extends Node

var pressedstart = false
var pressedactualstart = false

func _on_start_game_pressed():
	pressedstart = true
	$UI/TutorialLayer/Tutorialfade.play("fade")
	$UI/StartGame.visible = false
	$UI/Options.visible = false

func goToNextScene():
	get_tree().change_scene_to_file("res://Scenes/room.tscn")


func _on_options_pressed():
	GlobalTextBox.activateTextbox("Did you forget the theme of the Jam?")

func _on_actual_start_game_pressed():
	if pressedactualstart == false:
		$FadeBlack/ColorRect/FadeBlackAnim.play("fadeblack")
		pressedactualstart = true
