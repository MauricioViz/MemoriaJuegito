extends Node

@onready var Game = get_node('/root/Game/')
var cardBack = preload("res://Assets/cards/backCard.png")
var deck = Array()

var card1
var card2

var matchTimer = Timer.new()
var flipTimer = Timer.new()

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	fillDeck()
	dealDeck()
	setupTimers()
	pass # Replace with function body.

func setupTimers():
	flipTimer.connect("timeout", Callable(self, "turnOverCards"))
	flipTimer.set_one_shot(true)
	add_child(flipTimer)
	
	matchTimer.connect("timeout", Callable(self, "matchCardsAndScore"))
	matchTimer.set_one_shot(true)
	add_child(matchTimer)
	pass
	
func fillDeck():
	#deck.append(Card.new(1,"A"))
	#Primero se insertan las cartas de tipo A
	var t
	var v
	t = "A"
	while t == "A":
		v = 1
		while v < 11:
			deck.append(Card.new(v, t))
			v = v + 1
		break
	#Una vez se inserten todas las cartas de tipo A, se hace lo mismo con los de tipo B
	t = "B"
	while t == "B":
		v = 1
		while v < 11:
			deck.append(Card.new(v,t))
			v = v + 1
		break
	pass
	
func dealDeck():
	deck.shuffle()
	#Game.get_node('Grid').add_child(deck[0])
	for i in deck.size():
		Game.get_node('Grid').add_child(deck[i])
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
