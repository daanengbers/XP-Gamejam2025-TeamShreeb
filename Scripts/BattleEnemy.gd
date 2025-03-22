extends Node2D

@onready var enemies = get_tree().get_nodes_in_group("Enemies")
#@onready var enemyInstance = await get_node("EnemyInstance")

var enemyInstance = preload("res://Scenes/EnemyInstance.tscn")

var enemyChosen = 0

var currentEnemyInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	Init()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Init():
	var enemyinstance = enemyInstance.instantiate()
	self.add_child(enemyinstance)
	enemyinstance.EnemyName = enemies[enemyChosen].EnemyName
	enemyinstance.EnemySprite = enemies[enemyChosen].EnemySprite
	enemyinstance.possibleAttacks = enemies[enemyChosen].possibleAttacks
	enemyinstance.MAXHP = enemies[enemyChosen].MAXHP
	enemyinstance.HP = enemies[enemyChosen].HP
	enemyinstance.ATK = enemies[enemyChosen].ATK
	enemyinstance.DEF = enemies[enemyChosen].DEF
	enemyinstance.SPDEF = enemies[enemyChosen].SPDEF
	enemyinstance.initUI()
	
	
	
	
