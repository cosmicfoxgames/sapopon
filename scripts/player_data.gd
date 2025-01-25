extends Node

const START_COINS = 10

var current_money  = 0
var current_collection = []
var currnt_day = 1

func withdraw_money(ammt):
	if (current_money - ammt) >= 0: current_money -= ammt
	else:
		GlobalSignals.print_to_console.emit("não tem dinheiro pra isso")
		return(false)

func add_new_frog_to_collection(frog : FrogTemplate):
	current_collection.append(frog.id)
