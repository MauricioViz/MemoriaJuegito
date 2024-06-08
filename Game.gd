extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var path = "res://Assets-Memorization/cards/card-4-10.png"

	var c = Card.new(4, 10)  # Instanciar la clase Card
	$Grid.add_child(c)  # Agregar la instancia al nodo Grid
	pass  # Reemplazar con el cuerpo de la función si es necesario
