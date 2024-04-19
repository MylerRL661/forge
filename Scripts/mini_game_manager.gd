extends Node3D

#arrows
var down_arrow_scene = preload("res://Prefabs/arrows/area_3d_down.tscn")
var right_arrow_scene = preload("res://Prefabs/arrows/area_3d_right.tscn")
var up_arrow_scene = preload("res://Prefabs/arrows/area_3d_up.tscn")
var left_arrow_scene = preload("res://Prefabs/arrows/area_3d_left.tscn")

@onready var arrow_spawner = $arrow_spawner
@onready var arrow_timer = $arrow_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("jump"):
		#_instantiate_arrow('down')
		_round_start()


func _on_killbox_area_entered(area):
	if area.is_in_group('arrows'):
		area.queue_free()

func _activate_down():
	pass

func _instantiate_arrow(arrowInstance: String):
	if arrowInstance == 'down':
		var down_arrow_instance = down_arrow_scene.instantiate()
		arrow_spawner.add_child(down_arrow_instance)
	
	if arrowInstance == 'right':
		var right_arrow_instance = right_arrow_scene.instantiate()
		arrow_spawner.add_child(right_arrow_instance)
	
	if arrowInstance == 'up':
		var up_arrow_instance = up_arrow_scene.instantiate()
		arrow_spawner.add_child(up_arrow_instance)
	
	if arrowInstance == 'left':
		var left_arrow_instance = left_arrow_scene.instantiate()
		arrow_spawner.add_child(left_arrow_instance)

func _round_start():
	arrow_timer.start()
	#print('timer started')


func _on_arrow_timer_timeout():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var randNum = random.randi_range(0, 3)
	print(randNum)
	
	if randNum == 0:
		_instantiate_arrow('down')
	if randNum == 1:
		_instantiate_arrow('right')
	if randNum == 2:
		_instantiate_arrow('up')
	if randNum == 3:
		_instantiate_arrow('left')
