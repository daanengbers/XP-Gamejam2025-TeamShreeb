extends Node2D

@export var slotNumber = 1

##Backend stats of the battle units, this is what keeps track of the actual stats in battle
var charName = "Name"
var charSprite = Texture
var maxHP = 0
var HP = 0
var ATK = 0
var MG = 0
var isDead = false

func InitUI():
	$NameLabel.set_text(str(charName))
	$HPLabel.set_text(str(HP))
	$ATKLabel.set_text(str(ATK))
	$MGLabel.set_text(str(MG))
	$CharSprite.texture = charSprite

func updateUI():
	$HPLabel.set_text(str(HP))
