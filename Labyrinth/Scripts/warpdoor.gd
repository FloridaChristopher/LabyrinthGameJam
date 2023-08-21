extends Node3D

@export var exit: int = 0
signal door_entered(exit:int)

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		print("Player entered door.")
		door_entered.emit(exit)
