extends Node2D


#@onready var enemyInstance = await get_node("EnemyInstance")

@onready var enemies = []

@onready var bungle = get_node("Bungle")
@onready var ruinwalker = get_node("RuinWalker")
@onready var cosmeow = get_node("Cosmeow")

var enemyInstance = preload("res://Scenes/EnemyInstance.tscn")

var enemyChosen = 0

var currentEnemyInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	match Global.global_enemiesDefeated:
		0:
			enemies.append(bungle)
		1:
			enemies.append(ruinwalker)
		4:
			enemies.append(cosmeow)
	Init()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.global_needsToIntNewEnemy:
		Init()
		Global.global_needsToIntNewEnemy = false
	pass

func Init():
	match Global.global_enemiesDefeated:
		0:
			enemies.append(bungle)
		1:
			enemies.append(ruinwalker)
		4:
			enemies.append(cosmeow)
	var chosenEnemy = enemies.pick_random()
	var enemyinstance = enemyInstance.instantiate()
	self.add_child(enemyinstance)
	enemyinstance.EnemyName = chosenEnemy.EnemyName
	enemyinstance.EnemySprite = chosenEnemy.EnemySprite
	enemyinstance.possibleAttacks = chosenEnemy.possibleAttacks
	enemyinstance.MAXHP = chosenEnemy.MAXHP
	enemyinstance.HP = chosenEnemy.HP
	enemyinstance.ATK = chosenEnemy.ATK
	enemyinstance.DEF = chosenEnemy.DEF
	enemyinstance.SPDEF = chosenEnemy.SPDEF
	enemyinstance.initUI()
	
	
	
	
