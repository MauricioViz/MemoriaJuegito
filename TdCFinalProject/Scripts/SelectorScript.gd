extends Control
var gameScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func iniciarJuego(level):
	#gameScene = preload("res://Scenes/EasyMatch.tscn").instance()
	#gameScene.initialize(level)
	#get_tree().change_scene_to_file("res://Scenes/EasyMatch.tscn")

func _on_EasyButton_pressed():
	ControlDificultad.dificultad = 1
	get_tree().change_scene_to_file("res://Scenes/EasyMatch.tscn")
	pass # Replace with function body.


func _on_NormalButton_pressed():
	ControlDificultad.dificultad = 2
	get_tree().change_scene_to_file("res://Scenes/NormalMatch.tscn")
	pass # Replace with function body.


func _on_HardButton_pressed():
	ControlDificultad.dificultad = 3
	get_tree().change_scene_to_file("res://Scenes/HardMatch.tscn")
	pass # Replace with function body.
