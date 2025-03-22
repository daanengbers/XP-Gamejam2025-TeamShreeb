extends Node2D
@export var ActionID = ""
@export var Target = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.set_text(ActionID)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func Attack():
	##get casters attack - we can do this by getting the slot this is assigned to 
	##calculate damage to deal
	##get target
	##deal damgage
	pass

func _on_texture_button_pressed():
	if Global.global_isPlayerTurn == true:
		get_parent().get_parent().get_parent().get_parent().doFriendlyAction(ActionID, get_parent().slotAssigned, Target)
