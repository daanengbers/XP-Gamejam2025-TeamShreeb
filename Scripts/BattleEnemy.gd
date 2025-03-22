extends Node2D

@onready var enemies = get_tree().get_nodes_in_group("Enemies")
@onready var enemyInstance = await get_node("EnemyInstance")

var enemyChosen = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Init()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Init():
	enemyInstance.EnemyName = enemies[enemyChosen].EnemyName
	enemyInstance.EnemySprite = enemies[enemyChosen].EnemySprite
	enemyInstance.HP = enemies[enemyChosen].HP
	enemyInstance.ATK = enemies[enemyChosen].ATK
	enemyInstance.DEF = enemies[enemyChosen].DEF
	enemyInstance.SPDEF = enemies[enemyChosen].SPDEF
	enemyInstance.initUI()
	
	
	
	
