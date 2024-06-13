extends TextureButton
class_name Card

var type
var value
var faceCard
var backCard

# Called when the node enters the scene tree for the first time.
func _ready():
	set_h_size_flags(3)
	set_v_size_flags(3)
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)
	pass 

func _init(v, t):
	type = t
	value = v
	#Carga la textura de la cara frontal de la carta
	faceCard = load("res://Assets/cards/"+str(value)+"-"+str(type)+".png")
	#Carga la textura de la cara trasera de la carta desde un preload ubicado en el global GameManager
	backCard = GameManager.cardBack
	texture_normal = backCard
	pass
	
func _pressed():
	#flip()
	GameManager.chooseCard(self)
	pass

func flip():
	if get_texture_normal() == backCard:
		texture_normal = faceCard
	else:
		texture_normal = backCard
	pass
