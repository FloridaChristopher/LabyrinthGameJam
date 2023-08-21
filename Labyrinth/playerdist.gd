extends MeshInstance3D


var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")
	player = player[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_instance_shader_parameter("player_pos",player.global_position)
