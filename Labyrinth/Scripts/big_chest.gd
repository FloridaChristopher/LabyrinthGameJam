extends Node3D

@export var requiredkeys: int = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player") and get_tree().get_nodes_in_group("UI"
	).pop_front().bigKeys >= requiredkeys:
		print("opened chest")
		get_tree().get_nodes_in_group("Control").pop_front().opened_chest()
		
	pass # Replace with function body.
