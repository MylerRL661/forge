extends Node3D

#arrows
var down_arrow_scene = preload("res://Prefabs/arrows/area_3d_down.tscn")
var right_arrow_scene = preload("res://Prefabs/arrows/area_3d_right.tscn")
var up_arrow_scene = preload("res://Prefabs/arrows/area_3d_up.tscn")
var left_arrow_scene = preload("res://Prefabs/arrows/area_3d_left.tscn")

@onready var arrow_spawner = $arrow_spawner
@onready var arrow_timer = $arrow_timer

var score = 0
var currentDownArea
var currentRightArea
var currentUpArea
var currentLeftArea

var downInArea : bool = false
var rightInArea : bool = false
var upInArea : bool = false
var leftInArea : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("jump"):
		#_instantiate_arrow('down')
		_round_start()
	
	#successful hits for each arrow
	if Input.is_action_just_pressed("backward") and downInArea:
		score += 1
		print('Score: ', score)
		currentDownArea.queue_free()
	
	if Input.is_action_just_pressed("right") and rightInArea:
		score += 1
		print('Score: ', score)
		currentRightArea.queue_free()
	
	if Input.is_action_just_pressed("forward") and upInArea:
		score += 1
		print('Score: ', score)
		currentUpArea.queue_free()
	
	if Input.is_action_just_pressed("left") and leftInArea:
		score += 1
		print('Score: ', score)
		currentLeftArea.queue_free()
	
	#unsuccesful hits for each arrow
	if Input.is_action_just_pressed("backward") and not downInArea:
			score -= 1
			print('Score: ', score)
	
	if Input.is_action_just_pressed("right") and not rightInArea:
			score -= 1
			print('Score: ', score)
	
	if Input.is_action_just_pressed("forward") and not upInArea:
			score -= 1
			print('Score: ', score)
	
	if Input.is_action_just_pressed("left") and not leftInArea:
			score -= 1
			print('Score: ', score)

func _on_killbox_area_entered(area):
	if area.is_in_group('arrows'):
		area.queue_free()

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


func _on_area_3d_hit_box_area_entered(area):
	if area.is_in_group('area_down'):
		currentDownArea = area
		downInArea = true
		print("down arrow in hitbox")
	
	if area.is_in_group('area_right'):
		currentRightArea = area
		rightInArea = true
		print("right arrow in hitbox")
	
	if area.is_in_group('area_up'):
		currentUpArea = area
		upInArea = true
		print("up arrow in hitbox")
	
	if area.is_in_group('area_left'):
		currentLeftArea = area
		leftInArea = true
		print("left arrow in hitbox")

func _on_area_3d_hit_box_area_exited(area):
	if area.is_in_group('area_down'):
		downInArea = false
		print('down area outside hitbox')
	
	if area.is_in_group('area_right'):
		rightInArea = false
		print('right area outside hitbox')
	
	if area.is_in_group('area_up'):
		upInArea = false
		print('up area outside hitbox')
	
	if area.is_in_group('area_left'):
		leftInArea = false
		print('left area outside hitbox')
