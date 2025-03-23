extends Node

@onready var effectanim = $ThreeD_View/ThreeD/EffectAnimations

var IMPACT_1 = preload("res://Scenes/Effects/impact_effect_1.tscn")
var IMPACT_2 = preload("res://Scenes/Effects/impact_effect_2.tscn")
var IMPACT_FROST = preload("res://Scenes/Effects/impact_effect_frost.tscn")

var roomnumber = 0

var room_finished = false

var current_enemy = ""
var local_enemyHP = 0

var randomroom = 1

func _ready():
	$WorldEnvironment/Fog_anim.play("brown")
	randomize()

func _process(_delta):
	pass

func goToNextScene():
	effectanim.play("continue_to_next_room")

func reloadRoom():
	effectanim.play("fade_in")
	$MineLevel.visible = false
	$SwampLevel.visible = false
	if Global.global_enemiesDefeated < 10:
		pickRandomStage()
	elif Global.global_enemiesDefeated == 10:
		pickBossRoom()
	elif Global.global_enemiesDefeated > 10:
		pass # fuction to end game
	Global.global_isInBattle = true
	Global.global_isPlayerTurn = true
	Global.global_needsToIntNewEnemy = true
	
	

func pickRandomStage():
	randomroom = randi()%2 + 1
	if randomroom == 1:
		$MineLevel.visible = true
		$WorldEnvironment/Fog_anim.play("brown")
	elif randomroom == 2:
		$SwampLevel.visible = true
		$WorldEnvironment/Fog_anim.play("blue")
	#$Sounds/Doorclose.play()

func pickBossRoom():
	pass # for now because there is no boss room yet

func updateEnemy(SpriteTex, EnemName, EnemMaxHP):
	$ThreeD_View/ThreeD/EnemySprite.texture = SpriteTex
	$TwoD_View/EnemyHB_Name.set_text(str(EnemName))
	current_enemy = EnemName
	$TwoD_View/EnemyHealthBar.max_value = EnemMaxHP
	$TwoD_View/EnemyHealthBar.value = EnemMaxHP
	local_enemyHP = EnemMaxHP
	$ThreeD_View/ThreeD/EnemySprite.modulate = Color(1,1,1,1)

func updateEnemyDuringBattle(HP_left):
	local_enemyHP = HP_left
	updateEnemyHealthbar()
	#$TwoD_View/EnemyHealthBar.value = HP_left

func updateEnemyHealthbar():
	$TwoD_View/EnemyHealthBar.value = local_enemyHP

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

func enemyBigAttack():
	effectanim.play("RESET")
	effectanim.play("enemy_big_attack")

func enemyEarthquake():
	effectanim.play("RESET")
	effectanim.play("enemy_earthquake")

func enemyHeal():
	effectanim.play("RESET")
	effectanim.play("enemy_heal")
	
func enemyDeath():
	effectanim.play("RESET")
	effectanim.play("enemy_death")


# Animatable sound effect functions

func soundHitEffect():
	$MonsterSFXsystem/Hit.play()

func soundStompEffect():
	$MonsterSFXsystem/Stomp.play()

func soundBattleCry():
	if current_enemy == "Bungle":
		$MonsterSFXsystem/Bug/battlecry.play()
	if current_enemy == "Ruin Walker":
		$MonsterSFXsystem/Ruinwalker/battlecry.play()
	

func soundAttackCry():
	if current_enemy == "Bungle":
		$MonsterSFXsystem/Bug/attack.play()
	if current_enemy == "Ruin Walker":
		$MonsterSFXsystem/Ruinwalker/attack.play()
	

func soundGetHurtEnemy():
	if current_enemy == "Bungle":
		$MonsterSFXsystem/Bug/hurt.play()
	if current_enemy == "Ruin Walker":
		$MonsterSFXsystem/Ruinwalker/hurt.play()
	


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

# Play sound effects

func playDoorOpenSFX():
	$Sounds/Dooropen.play()
