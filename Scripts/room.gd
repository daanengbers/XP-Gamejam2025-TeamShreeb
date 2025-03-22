extends Node

var roomnumber = 0

var room_finished = false

func _process(delta):
	if Input.is_action_just_pressed("test1"):
		screenShakeMild()
	if Input.is_action_just_pressed("test2"):
		screenZoomAttack()
	if Input.is_action_just_pressed("test3"):
		screenSuperAttack()

func screenShakeMild():
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("RESET")
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("shake")
	pass

func screenZoomAttack():
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("RESET")
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("zoom_out_and_attack")
	pass

func screenSuperAttack():
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("RESET")
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("ultra_physical_attack")
	pass

func goToNextScene():
	pass


