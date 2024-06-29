extends Node

@onready var Game = get_node('/root/Game/')

var deck = Array()

var card1 = null
var card2 = null

var matchTimer = Timer.new()
var flipTimer = Timer.new()

var score = 0
var pila = Pila.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(ControlDificultad.dificultad)
	fillDeck()
	dealDeck()
	setupTimers()
	pass # Replace with function body.
	
enum State{
	INICIO_JUEGO, AÑADIR_CARTA, DESORDENAR_CARTAS,
	ELECCION_PRIMERA_CARTA, VOLTEAR_PRIMERA_CARTA,
	ELECCION_SEGUNDA_CARTA, VOLTEAR_SEGUNDA_CARTA,
	PROCESO_COMPARACION, DESACTIVAR_CARTAS, VOLTEAR_AMBAS_CARTAS,
}
var estado_actual = State.INICIO_JUEGO
	
func setupTimers():
	flipTimer.connect("timeout", Callable(self, "turnOverCards"))
	flipTimer.set_one_shot(true)
	add_child(flipTimer)
	
	matchTimer.connect("timeout", Callable(self, "matchCardsAndScore"))
	matchTimer.set_one_shot(true)
	add_child(matchTimer)
	pass

func fillDeck():
	#Si se eligio dificultad facil
	if ControlDificultad.dificultad == 1:
		for t in [1, 2]:
			for v in range(1, 6):
				deck.append(Card.new(v,t))
	#Si se eligio dificultad media
	if ControlDificultad.dificultad == 2:
		for t in [1, 2]:
			for v in range(1, 11):
				deck.append(Card.new(v,t))
	#Si se eligio dificultad dificil
	if ControlDificultad.dificultad == 3:
		for t in [1, 2]:
			for v in range(1, 16):
				deck.append(Card.new(v,t))
	
	pass
	
func dealDeck():
	deck.shuffle()
	for i in deck.size():
		Game.get_node('CardsTable').add_child(deck[i])
	pass
	
func chooseCard(card):
	if card1 == null:
		card1 = card
		card1.flip()
		card1.set_disabled(true)
	elif card2 == null:
		card2 = card
		card2.flip()
		card2.set_disabled(true)
		checkCards()
	pass
	
func checkCards():
	if card1.value == card2.value: #Si el número de las 2 cartas elegidas son iguales
		matchTimer.start(1)
		#Una vez pase un segundo, llamara a la funcion matchCardsAndScore
	else: #En caso que el número de las 2 cartas seleccionadas no sean iguales
		flipTimer.start(1)
		#Una vez pase un segundo, llamara a la funcion turnOverCards que está declarada en la línea 20
	pass

func matchCardsAndScore():
	score = score + 1
	#Se pintan de un color que pueda distinguirse del resto de cartas y se quedan así por el resto de la partida
	card1.set_modulate(Color(0.6,0.6,0.6,0.5))
	card2.set_modulate(Color(0.6,0.6,0.6,0.5))
	#card1 y card2 se regresan a null para poder volver a seleccionar 2 cartas
	card1 = null
	card2 = null
	pass

func turnOverCards():
	#Ambas cartas se vuelven a voltear y se les quita el bloqueo de movimiento
	card1.flip()
	card1.set_disabled(false)
	card2.flip()
	card2.set_disabled(false)
	#card1 y card2 se regresan a null para poder volver a seleccionar 2 cartas
	card1 = null
	card2 = null 
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
