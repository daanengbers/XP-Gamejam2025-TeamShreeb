extends Node2D

@export var arrowPositionArray = [Vector2(1,1)]
@export var maxOptions = 3
@export var isInMenu = true

var currentSelected = 1
var isCurrentlySwitching = false
@export var waitTime = 0.1

func _ready():
	setArrowPos(currentSelected)

func _process(delta):
	if isCurrentlySwitching == false:
		if Input.is_key_pressed(KEY_DOWN) && currentSelected < maxOptions && isInMenu :
			isCurrentlySwitching = true
			currentSelected += 1
			setArrowPos(currentSelected)
			await get_tree().create_timer(waitTime).timeout
			isCurrentlySwitching = false
		if Input.is_key_pressed(KEY_UP) && currentSelected > 1 && isInMenu:
			isCurrentlySwitching = true
			currentSelected -= 1
			setArrowPos(currentSelected)
			await get_tree().create_timer(waitTime).timeout
			isCurrentlySwitching = false
	if Input.is_key_pressed(KEY_ENTER) && isInMenu:
		selectOption(currentSelected)

func setArrowPos(posToSet):
	$TestArrow.position = Vector2(arrowPositionArray[posToSet - 1]) #-1 because of array

func selectOption(OptionSelected):
	match OptionSelected:
		1:
			pass
		2:
			pass
		3:
			pass
