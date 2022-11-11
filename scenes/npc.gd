extends Sprite


onready var dialogue = $Dialogue

func say(text: String):
	dialogue.show()
	dialogue.text = text
	yield(get_tree().create_timer(1), "timeout")
	dialogue.hide()
