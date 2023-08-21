extends RichTextLabel


var keys: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_keys(num:int):
	keys += num

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Keys: " + str(keys)
	pass
