extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().get_nodes_in_group("UI").pop_front().add_keys(1)
		queue_free()
	pass # Replace with function body.
