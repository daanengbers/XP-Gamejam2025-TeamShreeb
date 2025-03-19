extends Node2D

@onready var label = $DailogueText

@export var dialogueArray = ["", ""]
@export var tweenWaitTime = 1

var isInDailogue = false
var dialogueNumber = 0

var isDisplayingNewLine = true

func _ready():
	beginDailogue()

func _process(delta):
	if isInDailogue == true:
		if Input.is_key_pressed(KEY_ENTER) or Input.is_key_pressed(KEY_SPACE):
			if isDisplayingNewLine == false:
				if dialogueNumber + 1 < dialogueArray.size():
					isDisplayingNewLine = true
					dialogueNumber +=1
					$DailogueText.text = dialogueArray[dialogueNumber]
					progressDailogue()
				else:
					afterDialogue()
	pass

func beginDailogue():
	isInDailogue = true
	label.text = dialogueArray[0]
	label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property(label, "visible_characters" , label.get_total_character_count(), tweenWaitTime)
	await get_tree().create_timer(tweenWaitTime).timeout
	isDisplayingNewLine = false
	pass

func progressDailogue():
	label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property(label, "visible_characters" , label.get_total_character_count(), tweenWaitTime)
	await get_tree().create_timer(tweenWaitTime).timeout
	isDisplayingNewLine = false
	pass

func afterDialogue():
	$DailogueText.visible_characters = 0
	isInDailogue = false
	pass
