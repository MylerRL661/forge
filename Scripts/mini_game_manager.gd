extends Node3D

#arrow scenes for instantiation
var down_arrow_scene = preload("res://Prefabs/arrows/area_3d_down.tscn")
var right_arrow_scene = preload("res://Prefabs/arrows/area_3d_right.tscn")
var up_arrow_scene = preload("res://Prefabs/arrows/area_3d_up.tscn")
var left_arrow_scene = preload("res://Prefabs/arrows/area_3d_left.tscn")

#onreadys
@onready var hitboxGreen = $Area3D_hitBox/hitBox_green
@onready var hitboxWhite = $Area3D_hitBox/hitBox
@onready var hitboxRed = $Area3D_hitBox/hitBox_red
@onready var arrow_spawner = $arrow_spawner
@onready var arrow_timer = $arrow_timer
@onready var barb_anims = $"../Barbarian/AnimationPlayer"
@onready var forge_buttons = $"../Control/CanvasLayer/Forge Buttons"

var score = 0
var arrowsNeeded = 0
var arrowSpawned : int
var roundStarted : bool = false

#areas currently in hitbox for animating/ deleting 
var currentDownArea
var currentRightArea
var currentUpArea
var currentLeftArea

#bools to check which icon is currently in area
var downInArea : bool = false
var rightInArea : bool = false
var upInArea : bool = false
var leftInArea : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if arrowSpawned == arrowsNeeded:
		arrow_timer.stop()
		#print('timer stopped')
	
	if Input.is_action_just_pressed("jump"):
		#_instantiate_arrow('down')
		_round_start(2)
	
	#successful hits for each arrow
	if Input.is_action_just_pressed("backward") and downInArea and roundStarted:
		score += 1
		barb_anims.play('1H_Melee_Attack_Chop')
		print('Score: ', score)
		currentDownArea.queue_free()
	
	if Input.is_action_just_pressed("right") and rightInArea and roundStarted:
		score += 1
		barb_anims.play('1H_Melee_Attack_Chop')
		print('Score: ', score)
		currentRightArea.queue_free()
	
	if Input.is_action_just_pressed("forward") and upInArea and roundStarted:
		score += 1
		barb_anims.play('1H_Melee_Attack_Chop')
		print('Score: ', score)
		currentUpArea.queue_free()
	
	if Input.is_action_just_pressed("left") and leftInArea and roundStarted:
		score += 1
		barb_anims.play('1H_Melee_Attack_Chop')
		print('Score: ', score)
		currentLeftArea.queue_free()
	
	#unsuccesful hits for each arrow
	if Input.is_action_just_pressed("backward") and not downInArea and roundStarted:
		score -= 1
		barb_anims.play('Hit_B')
		hitboxRed.visible = true
		hitboxWhite.visible = false
		print('Score: ', score)
	
	if Input.is_action_just_pressed("right") and not rightInArea and roundStarted:
		score -= 1
		barb_anims.play('Hit_B')
		hitboxRed.visible = true
		hitboxWhite.visible = false
		print('Score: ', score)
	
	if Input.is_action_just_pressed("forward") and not upInArea and roundStarted:
		score -= 1
		barb_anims.play('Hit_B')
		hitboxRed.visible = true
		hitboxWhite.visible = false
		print('Score: ', score)
	
	if Input.is_action_just_pressed("left") and not leftInArea and roundStarted:
		score -= 1
		barb_anims.play('Hit_B')
		hitboxRed.visible = true
		hitboxWhite.visible = false
		print('Score: ', score)
	
	if arrow_spawner.get_child_count() == 0:
		roundStarted = false

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

func _round_start(arrows_needed_for_round : int):
	arrowsNeeded = arrows_needed_for_round
	arrow_timer.start()
	print('timer started')

func _on_arrow_timer_timeout():
	roundStarted = true
	var random = RandomNumberGenerator.new()
	random.randomize()
	var randNum = random.randi_range(0, 3)
	print(randNum)
	
	if randNum == 0:
		_instantiate_arrow('down')
		arrowSpawned += 1
	if randNum == 1:
		_instantiate_arrow('right')
		arrowSpawned += 1
	if randNum == 2:
		_instantiate_arrow('up')
		arrowSpawned += 1
	if randNum == 3:
		_instantiate_arrow('left')
		arrowSpawned += 1


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
		hitboxRed.visible = false
		hitboxWhite.visible = true
		print('down area outside hitbox')
	
	if area.is_in_group('area_right'):
		rightInArea = false
		hitboxRed.visible = false
		hitboxWhite.visible = true
		print('right area outside hitbox')
	
	if area.is_in_group('area_up'):
		upInArea = false
		hitboxRed.visible = false
		hitboxWhite.visible = true
		print('up area outside hitbox')
	
	if area.is_in_group('area_left'):
		leftInArea = false
		hitboxRed.visible = false
		hitboxWhite.visible = true
		print('left area outside hitbox')


func _on_bow_button_pressed():
	_round_start(5)
	forge_buttons.visible = false


func _on_sword_button_pressed():
	_round_start(8)
	forge_buttons.visible = false


func _on_staff_button_pressed():
	_round_start(12)
	forge_buttons.visible = false
