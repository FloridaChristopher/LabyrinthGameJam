extends Node3D
class_name mazeroom

@export var spawnpoint: Node3D

var doors
var keys

# Called when the node enters the scene tree for the first time.
func _ready():
	doors = get_tree().get_nodes_in_group("DoorControl")
	keys = get_tree().get_nodes_in_group("Key")
	
	for dord in doors:
		dord.door_entered.connect(door_entrance)
		
func get_doornkeys():
	doors = get_tree().get_nodes_in_group("DoorControl")
	keys = get_tree().get_nodes_in_group("Key")

func door_entrance(targetroom:int,dor:int):
	print("Entered exit ",dor)
	var maze = get_tree().get_nodes_in_group("Control").pop_front()
	maze.load_room(targetroom,dor)

func place_player(door:int):
	var player = get_tree().get_nodes_in_group("Player").pop_front()
	if door == -1:
		player.global_position = Vector3.ZERO
		return
	#doors = get_tree().get_nodes_in_group("DoorControl")
	for dord in doors:
		if dord.exit == door:
			player.global_position = dord.spawnpoint.global_position
			player.origionalpos = dord.spawnpoint.global_position
	

func activate_doors():
	for dord in doors:
		dord.canWarp = true

func load_data(data:room_data):
	print("loading room data")
	get_doornkeys()
	for n in doors:
		if data.doors_unlocked.has(n.exit):
			n.fast_unlock()
		if not n.locked:
			n.fast_unlock()
	for n in keys:
		if data.keys_collected.has(n.id):
			n.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
