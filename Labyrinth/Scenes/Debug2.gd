extends RichTextLabel

@export var player: playerphys2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var txt = "Debug:\n"
	txt += " " + str(player.acceleration_curve_value())
	text = txt
	pass
