extends Area3D

var origionalPos

@export var thing: playerphys

# Called when the node enters the scene tree for the first time.
func _ready():
	origionalPos = thing.global_position
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("BottomlessPit"):
		thing.global_position = thing.origionalpos
	pass # Replace with function body.
