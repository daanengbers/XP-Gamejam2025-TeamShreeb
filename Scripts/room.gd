extends Node

var IMPACT_1 = preload("res://Scenes/Effects/impact_effect_1.tscn")
var IMPACT_2 = preload("res://Scenes/Effects/impact_effect_2.tscn")


var roomnumber = 0

var room_finished = false

func _process(delta):
	if Input.is_action_just_pressed("test1"):
		screenShakeMild()
	if Input.is_action_just_pressed("test2"):
		screenZoomAttack()
	if Input.is_action_just_pressed("test3"):
		screenSuperAttack()
	if Input.is_action_just_pressed("test4"):
		spawnImpactEffect1()

func screenShakeMild():
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("RESET")
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("shake")

func screenZoomAttack():
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("RESET")
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("zoom_out_and_attack")

func screenSuperAttack():
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("RESET")
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("ultra_physical_attack")

func screenShootFireball():
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("RESET")
	$ThreeD_View/ThreeD/Main_Camera/CamAnim.play("fireball_throw")

func goToNextScene():
	pass



# Spawn effects

func spawnImpactEffect1():
	var eff = IMPACT_1.instantiate()
	get_parent().add_child.call_deferred(eff)

func spawnImpactEffect2():
	var eff = IMPACT_2.instantiate()
	get_parent().add_child.call_deferred(eff)
