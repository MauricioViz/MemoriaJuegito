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
	
	pass # Replace with function body.

func _init(v, t):
	type = t
	value = v
	#Carga la textura de la cara frontal de la carta
	faceCard = load("res://Assets/cards/Carta"+str(type)+"-"+str(value)+".jpg")
	#Carga la textura de la cara trasera de la carta desde un preload ubicado en el global GameManager
	backCard = ControlDificultad.cardBack
	texture_normal = backCard
	
	pass

func _pressed():
	var gameNode = get_node('/root/Game')
	
	if ControlDificultad.cardA == null:
		gameNode.eleccion_primera_carta(self)
		pass
		
	elif ControlDificultad.cardB == null:
		gameNode.eleccion_segunda_carta(self)
		pass
	
	#if ControlDificultad.card1 == null:
		#ControlDificultad.card1 = self 
		#self.flip()
		#ControlDificultad.card1.set_disabled(true)
	#
	#elif ControlDificultad.card2 == null:
		#ControlDificultad.card2 = self
		#self.flip()
		#ControlDificultad.card2.set_disabled(true)
		
	pass
	
func flip():
	if get_texture_normal() == backCard:
		texture_normal = faceCard
	else: 
		texture_normal = backCard
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
