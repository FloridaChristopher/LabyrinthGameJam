extends CharacterBody3D
class_name playerphys2

var origionalpos: Vector3
var input2

@export var accel_curve: Curve
@export var accel_force: int = 3
@export var drag_force: int = 3
@export var air_drag_force: int = 2
@export var jump_speed: int = 6
@export var fallgravity = 3
@export var speed_limit = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	origionalpos = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	input2 = read_input()
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity += Vector3.UP * jump_speed
	apply_gravity(delta)
	
	if acceleration_curve_value() > 0.5:
		velocity += Vector3(input2.x,0,input2.y) * delta * accel_force * acceleration_curve_value()
	else:
		velocity += Vector3(input2.x,0,input2.y) * delta * 10 * accel_force * acceleration_curve_value()
	
	if input2.length() < 0.01 and is_on_floor():
		velocity += -velocity * delta * drag_force
	if input2.length() < 0.01:
		velocity += -velocity * delta * air_drag_force
	move_and_slide()
	
	if XZ_velocity().length() > speed_limit:
		var newspeed = XZ_velocity().normalized() * speed_limit
		velocity = Vector3(newspeed.x,velocity.y,newspeed.y)


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

func acceleration_curve_value():
	
	var OldValue = XZ_velocity().dot(input2)
	pass
	var OldMin = -speed_limit
	var OldRange = speed_limit + speed_limit
	var NewRange = 1
	var NewMin = 0

	var NewValue = (((OldValue - OldMin) * NewRange) / OldRange) + NewMin
	return NewValue
