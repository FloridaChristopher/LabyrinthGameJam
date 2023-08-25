extends Node3D

@export var locked: bool = false
@export var exit: int = 0
@export var connectedRoom: int = 0
@export var spawnpoint: Node3D
signal door_entered(targetroom:int,exit:int)
@export var gate: Node3D
var canWarp: bool = false

func ready():
	if not locked:
		fast_unlock()

func _on_area_3d_body_entered(body):
	if not canWarp: return
	if not body.is_in_group("Player"): return
	if not locked:
		print("Player entered door.")
		door_entered.emit(connectedRoom,exit)
		return
	if get_tree().get_nodes_in_group("UI").pop_front().keys > 0:
		get_tree().get_nodes_in_group("UI").pop_front().spend_key()
		get_tree().get_nodes_in_group("Control").pop_front().opened_door(exit)
		unlock_door()

func unlock_door():
	locked = false
	fast_unlock()
	pass

func fast_unlock():
	print("fast unlock")
	locked = false
	gate.position = Vector3(global_position.x,-1000,global_position.z)


func _on_timer_timeout():
	print("timer out")
	canWarp = true
	pass # Replace with function body.
