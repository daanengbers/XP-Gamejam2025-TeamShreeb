extends Node2D

var EnemyName = ""
var EnemySprite = Texture
var possibleAttacks = ["",""]
var HP = 0
var ATK = 0
var DEF = 0
var SPDEF = 0

func initUI():
	$NameLabel.set_text(str(EnemyName))
	$HPLabel.set_text(str(HP))
	$EnemySprite.texture = EnemySprite

func updateUI():
	$NameLabel.set_text(str(EnemyName))
	$HPLabel.set_text(str(HP))
	$EnemySprite.texture = EnemySprite
