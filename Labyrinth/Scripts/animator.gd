extends Node3D

@export var thing: playerphys

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if thing.XZ_velocity().length() > 0.1:
		rotation = Vector3(0,-thing.XZ_velocity().angle() + deg_to_rad(90),0)
	pass
