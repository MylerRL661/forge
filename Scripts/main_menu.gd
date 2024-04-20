extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	SceneManager.change_scene("res://Scenes/game.tscn", SceneManager.Transitions.FADE)

func _on_quit_button_pressed():
	get_tree().quit()
