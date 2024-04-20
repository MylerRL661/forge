extends Node3D

@onready var outside_scene = $outside_world
@onready var inside_scene = $forge


# Called when the node enters the scene tree for the first time.
func _ready():
	outside_scene.visible = true
	inside_scene.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
