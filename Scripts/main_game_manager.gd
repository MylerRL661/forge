extends Node3D

@onready var outside_scene = $outside_world
@onready var rogue = $outside_world/Rogue
@onready var knight = $outside_world/Knight
@onready var witch = $outside_world/Mage
@onready var audio = $AudioStreamPlayer

var _isPlayerInRange : bool = false
var gameStarted : bool = false
@export var talkedToVillagers : bool = false
@export var talkedToRogue : bool = false
@export var talkedToKnight: bool = false
@export var talkedToWitch : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	gameStarted = true
	audio.play()
	Dialogic.start('talk_to_everyone_first')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_enterForge()
	
	if rogue.talked == true:
		talkedToRogue = true
	
	if knight.talked == true:
		talkedToKnight = true
	
	if witch.talked == true:
		talkedToWitch = true
	
	if talkedToKnight and talkedToRogue and talkedToWitch:
		talkedToVillagers = true

#forge entrance
func _on_area_3d_body_entered(body):
	if body.name == 'Barbarian':
		print('forge area entered')
		_isPlayerInRange = true

func _on_area_3d_body_exited(body):
	if body.name == 'Barbarian':
		print('forge area exited')
		_isPlayerInRange = false

func _enterForge():
	if _isPlayerInRange and Input.is_action_just_pressed("interact") and not talkedToVillagers:
		Dialogic.start('talk_to_everyone_first')
	
	if _isPlayerInRange and Input.is_action_just_pressed("interact") and talkedToVillagers:
		SceneManager.change_scene("res://Scenes/forge_indoor.tscn", SceneManager.Transitions.FADE)
