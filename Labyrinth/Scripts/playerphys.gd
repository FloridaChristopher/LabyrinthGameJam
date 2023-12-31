extends RigidBody3D
class_name playerphys

@export var walkAcceleration: float = 2
@export var walkSpeed: float = 2
@export var jumpForce: float = 5
@export var dragForce: float = 3

@export var grnd_ray: RayCast3D
@export var jmpbuffertimer: Timer
@export var coyoteTimer: Timer
var origparent

var origionalpos: Vector3
var direction: Vector2 = Vector2.ZERO
var jump: bool = false
var canCoyote: bool = false
var coyoteTime: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	origionalpos = global_position
	origparent = get_parent()

func _process(delta):
	direction = read_input()
	
	if is_grounded():
		canCoyote = true
	else: if canCoyote:
		coyoteTimer.start()
		canCoyote = false
		coyoteTime = true
	
	if Input.is_action_just_pressed("Jump"):
		jmpbuffertimer.start()
		print("started timer")
	
	
	if jmpbuffertimer.time_left > 0:
		if is_grounded() or coyoteTime:
			jump = true
			jmpbuffertimer.stop()
	else:
		jump = false


func is_grounded():
	if grnd_ray.is_colliding():
		return true
	else:
		return false

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	accelerate_to( Vector3(direction.x,0,direction.y) )
	
	if direction.length() < 0.1:
		apply_force( Vector3(-XZ_velocity().normalized().x,0,-XZ_velocity().normalized().y) * dragForce )
	
	if jump:
		apply_impulse(Vector3(0,jumpForce,0))
		pass
		
func XZ_velocity():
	return Vector2(linear_velocity.x,linear_velocity.z)

func accelerate_to(direction:Vector3):
	#if XZ_velocity() < direction.length():
	apply_force(direction * walkAcceleration)
	linear_velocity = Vector3(XZ_velocity().limit_length(walkSpeed).x,linear_velocity.y,XZ_velocity().limit_length(walkSpeed).y)



func _on_coyote_time_timeout():
	coyoteTime = false
	pass # Replace with function body.
