extends TextureButton
class_name Card

var suit # representa la categoría a la que pertenece la carta
var value # valor de carta entre 1 a 3
var face # textura parte frontal de la carta
var back # textura parte trasera de la carta

# Definimos parámetros del constructor
func _init(s, v):
	suit = s
	value = v
	
	# Cargar la textura de la cara de la carta
	var face_path = "res://Assets-Memorization/cards/card-" + str(suit) + "-" + str(value) + ".png"
	print("Cargando textura de la cara desde: ", face_path)
	face = load(face_path)
	
	if face == null:
		print("Error: No se pudo cargar la textura de la cara.")
	else:
		print("Textura de la cara cargada exitosamente.")
	
	# Cargar la textura de la parte trasera de la carta desde GameManager
	back = GameManager.cardBack
	
	if back == null:
		print("Error: GameManager.cardBack es null.")
	
	# Asegurarse de que face sea una textura válida antes de establecerla
	if face != null:
		texture_normal = face
	else:
		print("Error: La variable 'face' no es una textura válida.")
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Reemplazar con el cuerpo de la función si es necesario
