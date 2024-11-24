extends StaticBody2D

var tv_dialogue

func _ready():
	tv_dialogue = $TVDialogue
	tv_dialogue.connect("dialogue_start_activate", Callable(self, "_on_tv_start_activate"))

func _on_tv_start_activate():
	$TVDialogue.dialogue_start = "tv_new_start"
