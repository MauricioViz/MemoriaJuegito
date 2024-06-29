extends Node

@onready var Game = get_node('/root/Game/')

var deck = Array()

var card1 = null
var card2 = null

var matchTimer = Timer.new()
var flipTimer = Timer.new()

var score = 0
var pila = Pila.new()

enum State{
	INICIO_JUEGO, AÑADIR_CARTA, DESORDENAR_CARTAS,
	ELECCION_PRIMERA_CARTA, VOLTEAR_PRIMERA_CARTA,
	ELECCION_SEGUNDA_CARTA, VOLTEAR_SEGUNDA_CARTA,
	PROCESO_COMPARACION, DESACTIVAR_CARTAS, VOLTEAR_AMBAS_CARTAS,
}
var estado_actual = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	setupTimers()
	cambiar_estado(State.INICIO_JUEGO)
	pass # Replace with function body.
	
	
func setupTimers():
	flipTimer.connect("timeout", Callable(self, "turnOverCards"))
	flipTimer.set_one_shot(true)
	add_child(flipTimer)
	
	matchTimer.connect("timeout", Callable(self, "matchCardsAndScore"))
	matchTimer.set_one_shot(true)
	add_child(matchTimer)
	pass
	
func cambiar_estado(nuevo_estado):
	estado_actual = nuevo_estado
	match estado_actual:
		State.INICIO_JUEGO:
			iniciar_juego()
		State.AÑADIR_CARTA:
			añadir_carta()
		State.DESORDENAR_CARTAS:
			desordenar_cartas()
		State.ELECCION_PRIMERA_CARTA:
			eleccion_primera_carta(card1)
		State.VOLTEAR_PRIMERA_CARTA:
			voltear_primera_carta(card1)
		State.ELECCION_SEGUNDA_CARTA:
			eleccion_segunda_carta(card2)
		State.VOLTEAR_SEGUNDA_CARTA:
			voltear_segunda_carta(card2)
		State.PROCESO_COMPARACION:
			proceso_comparacion()
		State.DESACTIVAR_CARTAS:
			desactivar_cartas()
		State.VOLTEAR_AMBAS_CARTAS:
			voltear_ambas_cartas()
			
func iniciar_juego():
	print("Inicio juego")
	cambiar_estado(State.AÑADIR_CARTA)
	pass
	
func añadir_carta():
	print("Añadir carta")
	fillDeck()
	cambiar_estado(State.DESORDENAR_CARTAS)
	pass
	
func desordenar_cartas():
	print("Repartiendo y desordenando cartas")
	dealDeck()
	cambiar_estado(State.ELECCION_PRIMERA_CARTA)
	
	pass
	
func eleccion_primera_carta(card):
	print("Eleccion Primera Carta")
	ControlDificultad.cardA = card
	if ControlDificultad.cardA != null:
		card1 = card
		if card1 != null:
			cambiar_estado(State.VOLTEAR_PRIMERA_CARTA)
		pass
		
	#Esta función sirve para retener el programa de tomar alguna accion hasta que el jugador seleccione.
	#Esto debido a que la interaccion directa con la carta pertenece a la clase Card.gd.
	pass

func voltear_primera_carta(card):
	print("Volteando primera carta")
	card.flip()
	card.set_disabled(true)
	cambiar_estado(State.ELECCION_SEGUNDA_CARTA)
	pass
	
func eleccion_segunda_carta(card):
	print("Eleccion Segunda Carta")
	ControlDificultad.cardB = card
	if ControlDificultad.cardB != null:
		card2 = card
		if card2 != null:
			cambiar_estado(State.VOLTEAR_SEGUNDA_CARTA)
			pass
	
	#Esta función sirve para retener el programa de tomar alguna accion hasta que el jugador seleccione.
	#Esto debido a que la interaccion directa con la carta pertenece a la clase Card.gd.
	pass
	
func voltear_segunda_carta(card):
	print("Volteando segunda carta")
	card.flip()
	card.set_disabled(true)
	cambiar_estado(State.PROCESO_COMPARACION)
	pass
	
func proceso_comparacion():
	print("Comparando")
	if card1.value == card2.value:
		cambiar_estado(State.DESACTIVAR_CARTAS)
		
	else:
		cambiar_estado(State.VOLTEAR_AMBAS_CARTAS)

	pass
	
func desactivar_cartas():
	print("Iguales, desactivando")
	matchTimer.start(1)
	pass
	
func voltear_ambas_cartas():
	print("Distintos, volteando")
	flipTimer.start(1)
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
	ControlDificultad.cardA = null
	ControlDificultad.cardB = null
	
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
	ControlDificultad.cardA = null
	ControlDificultad.cardB = null
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
