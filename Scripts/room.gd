extends Node

@onready var effectanim = $ThreeD_View/ThreeD/EffectAnimations

var IMPACT_1 = preload("res://Scenes/Effects/impact_effect_1.tscn")
var IMPACT_2 = preload("res://Scenes/Effects/impact_effect_2.tscn")
var IMPACT_FROST = preload("res://Scenes/Effects/impact_effect_frost.tscn")

var roomnumber = 0

var room_finished = false

func _process(_delta):
	if Input.is_action_just_pressed("test1"):
		getHit()
	if Input.is_action_just_pressed("test2"):
		attackSmall()
	if Input.is_action_just_pressed("test3"):
		attackLargeSlam()
	if Input.is_action_just_pressed("test4"):
		attackShootFireball()
	if Input.is_action_just_pressed("test5"):
		enemyHeal()
	if Input.is_action_just_pressed("test6"):
		enemyBasicAttack()

func updateEnemy(SpriteTex, EnemName, EnemMaxHP):
	$ThreeD_View/ThreeD/EnemySprite.texture = SpriteTex
	$TwoD_View/EnemyHB_Name.set_text(str(EnemName))
	$TwoD_View/EnemyHealthBar.max_value = EnemMaxHP
	$TwoD_View/EnemyHealthBar.value = EnemMaxHP

func updateEnemyDuringBattle(HP_left):
	$TwoD_View/EnemyHealthBar.value = HP_left

func getHit():
	effectanim.play("RESET")
	effectanim.play("shake")

func attackSmall():
	effectanim.play("RESET")
	effectanim.play("attack_tackle")

func attackLargeSlam():
	effectanim.play("RESET")
	effectanim.play("ultra_physical_attack")

func attackShootFireball():
	effectanim.play("RESET")
	effectanim.play("fireball_throw")

func attackShootFrostball():
	effectanim.play("RESET")
	effectanim.play("frostball_throw")


func enemyBasicAttack():
	effectanim.play("RESET")
	effectanim.play("enemy_basic_attack")

func enemyHeal():
	effectanim.play("RESET")
	effectanim.play("enemy_heal")

func goToNextScene():
	pass



# Spawn effects

func spawnImpactEffect1():
	var eff = IMPACT_1.instantiate()
	get_parent().add_child.call_deferred(eff)

func spawnImpactEffect2():
	var eff = IMPACT_2.instantiate()
	get_parent().add_child.call_deferred(eff)

func spawnImpactEffectFrost():
	var eff = IMPACT_FROST.instantiate()
	get_parent().add_child.call_deferred(eff)
