extends Node3D

@export var trackedObj: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	position.z = trackedObj.global_position.z
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.z = trackedObj.global_position.z
	pass
