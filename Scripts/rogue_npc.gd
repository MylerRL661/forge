extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var _isPlayerInRange : bool = false
@export var _isCheering : bool = false
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var player_character = $"../Barbarian"
@onready var game_camera = $"../Barbarian/Camera3D"
@onready var camera_target = $CameraTarget
@onready var audio_player = $AudioStreamPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var original_cam_position
var orginal_cam_rotation

func _ready():
	anim_player.play("Idle")
	original_cam_position = game_camera.transform.origin
	orginal_cam_rotation = game_camera.rotation_degrees

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if _isCheering == false:
		anim_player.play("Idle")

	_sayHello()
	if anim_player.is_playing() == false:
		_isCheering = false


func _on_area_3d_body_entered(body):
	if body == player_character:
		_isPlayerInRange = true

func _sayHello():
	if _isPlayerInRange == true and player_character._hasInteracted == true:
		_camMove()
		_cheerAnimation()
		Dialogic.start('timeline1')
		print("hello")

func _on_area_3d_body_exited(body):
	if body == player_character:
		_isPlayerInRange = false
		_camReset()

func _cheerAnimation():
	_isCheering = true
	anim_player.play("Cheer")

func _camMove():
	game_camera.transform.origin = lerp(game_camera.transform.origin, camera_target.transform.origin, 1)
	game_camera.look_at($".".transform.origin)

func _camReset():
	game_camera.transform.origin = original_cam_position
	game_camera.rotation_degrees = orginal_cam_rotation # broken
