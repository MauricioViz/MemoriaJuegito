extends Node
class_name Pila

var stack = []

func push(item):
	stack.append(item)

func pop():
	if not is_empty():
		return stack.pop_back()
	return null

func peek():
	if not is_empty():
		return stack[-1]
	return null

func is_empty():
	return stack.size() == 0

func size():
	return stack.size()
