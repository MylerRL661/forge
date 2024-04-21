extends Node3D

@onready var audio = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	audio.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	SceneManager.change_scene("res://Scenes/game.tscn", SceneManager.Transitions.FADE)

func _on_quit_button_pressed():
	get_tree().quit()
