extends RichTextLabel


@export var keys: int = 0
@export var bigKeys: int = 0
var time: float = 0

@export var pos: Node2D
@export var bigkeyprefab: Resource
@export var timertext: RichTextLabel
@export var finaltimetext: RichTextLabel

@export var main: Node2D
@export var final: Node2D


func add_keys(num:int,isbigkey:bool):
	if isbigkey:
		bigKeys += num
	else:
		keys += num
	
	draw_keys()

func draw_keys():
	for n in pos.get_children():
		n.queue_free()
	var i = 0
	while i < bigKeys:
		var k = bigkeyprefab.instantiate()
		pos.add_child(k)
		k.global_position = pos.global_position + Vector2(i * 60,0)
		i += 1
		pass
	
func spend_key():
	keys -= 1


func ready():
	final.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Keys: " + str(keys)
	time += delta
	timertext.text = "Time " + str(snapped(time,0.01))
	pass

func show_final_time():
	print("Final time is: ",time)
	main.visible = false
	final.visible = true
	finaltimetext.text = str(snapped(time,0.01))
	pass
