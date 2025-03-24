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

@onready var damageHealthIndicator = get_node("Damage_Health_Incidator_Text")

func InitUI():
	$NameLabel.set_text(str(charName))
	$HPLabel.set_text(str(HP))
	$ATKLabel.set_text(str(ATK))
	$MGLabel.set_text(str(MG))
	$CharSprite.texture = charSprite
	$Damage_Health_Incidator_Text.visible_characters = 0

func updateUI():
	$HPLabel.set_text(str(HP))
	$ATKLabel.set_text(str(ATK))
	$MGLabel.set_text(str(MG))
	
func displayDamageHeal(damageHealth, damageOrHeal):
	var color = damageHealthIndicator.get("theme_override_colors/font_color")
	if damageOrHeal == "damage":
		damageHealthIndicator.modulate = Color(1,0,0,1)
		damageHealthIndicator.set_text("-" + str(damageHealth))
	if damageOrHeal == "heal":
		damageHealthIndicator.modulate = Color(0,1,0,1)
		damageHealthIndicator.set_text("+" + str(damageHealth))
	damageHealthIndicator.visible_characters = damageHealthIndicator.get_total_character_count()
	await get_tree().create_timer(1.0).timeout
	damageHealthIndicator.visible_characters = 0

func checkDeath():
	if HP <= 0:
		HP = 0
		ATK = 0
		MG = 0
		get_parent().handlePlayerDeath(slotNumber)
