extends Node3D

@export var rooms: Array[Resource]

@export var currentscene: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_room(0,-1)
	pass # Replace with function body.

func load_room(id:int,door:int):
	for thing in get_tree().get_nodes_in_group("Room"):
		thing.queue_free()
	var currentroom = rooms[id].instantiate()
	add_child(currentroom)
	currentroom.place_player(door)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
