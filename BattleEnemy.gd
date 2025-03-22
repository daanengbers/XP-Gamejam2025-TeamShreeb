extends Node2D

var EnemyName = ""
var EnemySprite = Texture
var possibleAttacks = ["",""]
var HP = 0
var MAXHP = 0
var ATK = 0
var DEF = 0
var SPDEF = 0

@onready var party = await get_parent().get_parent().get_child(0)

@onready var Room = await get_parent().get_parent().get_parent().get_parent()

func initUI():
	print(str(Room))
	Room.updateEnemy(EnemySprite, EnemyName, MAXHP)
	pass
	#$NameLabel.set_text(str(EnemyName))
	#$HPLabel.set_text(str(HP))
	#$EnemySprite.texture = EnemySprite

func updateUI():
	Room.updateEnemyDuringBattle(HP)
	pass
	#$NameLabel.set_text(str(EnemyName))
	#$HPLabel.set_text(str(HP))
	#$EnemySprite.texture = EnemySprite
	
func checkDeath():
	if HP <= 0:
		queue_free()
		Global.global_isInBattle = false
		Global.global_enemiesDefeated += 1
		party.triggerVicory()
