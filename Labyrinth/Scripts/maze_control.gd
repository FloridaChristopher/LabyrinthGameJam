extends Node3D


@export var roomsarray: Resource
var rooms: Array[Resource]

@export var currentscene: int = 0

var roomsData = []

# Called when the node enters the scene tree for the first time.
func _ready():
	rooms = roomsarray.arr
	for i in range(0,rooms.size()):
		roomsData.append(room_data.new())
	
	load_room(0,-1)
	
	pass # Replace with function body.

func load_room(id:int,door:int):
	currentscene = id
	for thing in get_tree().get_nodes_in_group("Room"):
		thing.queue_free()
	var currentroom = rooms[id].instantiate()
	add_child(currentroom)
	get_tree().get_nodes_in_group("Player").pop_front().global_position = Vector3.ZERO
	currentroom.place_player(door)
	currentroom.load_data(roomsData[id])

func got_key(id:int):
	roomsData[currentscene].keys_collected.append(id)

func opened_door(id:int):
	roomsData[currentscene].doors_unlocked.append(id)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func opened_chest():
	get_tree().get_nodes_in_group("UI").pop_front().show_final_time()
	load_room(rooms.size()-1,0)
	pass
