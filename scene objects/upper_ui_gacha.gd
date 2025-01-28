extends Control

signal spin_gacha_signal(many)

@onready var moedas = %label_moedas
@onready var dias = %label_dias

@onready var place_holder_new_frog = %label_new_frog

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
	moedas.text = tr("your_coins") % str(ammt)

func set_ui(coins : int, dia : int):
	moedas.text = tr("your_coins") % str(coins)
	#dias.text = "dia: " + str(dia)

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

#botão ir pro mercado
func _on_button_4_button_down() -> void:
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.MARKET]))

#botão ir pra coleção
func _on_button_3_button_down() -> void:
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.COLLECTION]))

#botão ir para proximo dia
func _on_button_2_button_down() -> void:
	GlobalSignals.advance_day.emit()

#spinned gacha
func _on_gacha_got_new_frog() -> void:
	spin_gacha()
