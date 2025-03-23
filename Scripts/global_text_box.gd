extends CanvasLayer

var vischars = 0
var waitTime = 5.0

func activateTextbox(textboxtext):
	$Anim.play("RESET")
	$Anim.play("appear")
	$Textbar/Text.set_text(textboxtext)
	$ClearTimer.start()

func _on_clear_timer_timeout():
	$Anim.play("disappear")
