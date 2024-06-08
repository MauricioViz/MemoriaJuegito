extends Node

var Game
var cardBack = preload("res://Assets-Memorization/cards/cardBack_blue2.png")
var deck = Array() # Ahora deck es una variable miembro de la clase

func _ready():
	Game = get_node('/root/Game')
	fillDeck()
	dealDeck()

func fillDeck():
	#deck.append(Card.new(1, 1))
	var s = 1
	var v = 1
	
	while s < 5:
		v = 1
		while v < 14:
			deck.append(Card.new(s,v))
			v = v + 1
		
		s += 1
	pass
	
func dealDeck():
	#if deck.size() > 0:
		#Game.get_node('Grid').add_child(deck[0])
	#else:
		#print("Error: No hay cartas en el mazo.")
	for i in deck.size():
		Game.get_node('Grid').add_child(deck[i])
	pass
