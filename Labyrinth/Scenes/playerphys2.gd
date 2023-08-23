extends CharacterBody3D
class_name playerphys2

var origionalpos: Vector3
var input2

@export var fallgravity = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	origionalpos = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	input2 = read_input()
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity += Vector3.UP * 5
	apply_gravity(delta)
	velocity += Vector3(input2.x,0,input2.y) * delta
	
	if input2.length() < 0.01:
		velocity += -velocity * delta
	move_and_slide()
	pass


func apply_gravity(delta):
	if Input.is_action_pressed("Jump"):
		velocity += Vector3.DOWN * delta * 9.81
	else:
		velocity += Vector3.DOWN * delta * 9.81 * fallgravity

func read_input():
	var input = Vector2.ZERO
	if Input.is_action_pressed("Left"):
		input += Vector2(-1,0)
	if Input.is_action_pressed("Right"):
		input += Vector2(1,0)
	if Input.is_action_pressed("Forward"):
		input += Vector2(0,-1)
	if Input.is_action_pressed("Backward"):
		input += Vector2(0,1)
	input = input.normalized()
	return input

func XZ_velocity():
	return Vector2(velocity.x,velocity.z)
