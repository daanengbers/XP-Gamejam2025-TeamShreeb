extends Node

func _ready():
	setSongNumber(1)

var songnr = 0

func setSongNumber(nmbr):
	songnr = nmbr
	if songnr == 0:
		$MainTheme/Intro.stop()
		$MainTheme/Main.stop()
	if songnr == 1:
		$MainTheme/Intro.play()
	if songnr == 2:
		$MainTheme/Main.play()

func _on_intro_finished():
	setSongNumber(2)
