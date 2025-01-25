extends Control

signal spin_gacha_signal(many)

@onready var moedas = %label_moedas
@onready var dias = %label_dias

@onready var console  = %console

func _ready() -> void:
	connect_all_signals()

func _process(delta: float) -> void:
	pass

func connect_all_signals():
	GlobalSignals.print_to_console.connect(_on_print_to_console)

func print_to_console(txt : String):
	console.text = ""
	console.text = txt

func change_coin_ammount(ammt : int):
	moedas.text = "moedas: " + str(ammt)

func set_ui(coins : int, dia : int):
	moedas.text = "moedas: " + str(coins)
	dias.text = "dia: " + str(dia)

func spin_gacha(how_many : int = 1):
	if PlayerData.withdraw_money(how_many) != false:
		spin_gacha_signal.emit(how_many)
		change_coin_ammount(PlayerData.current_money)
	else: pass#fazer alguma coisa pra mostrar pro player q ele n tem dinheiro o suficente

func advance_to_next_day():
	pass

#signals

#botão de pegar gacha
func _on_button_button_down() -> void:
	spin_gacha()

func _on_print_to_console(txt):
	print_to_console(txt)
