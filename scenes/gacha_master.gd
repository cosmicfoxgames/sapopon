extends Control

@onready var upper_ui = %upper_ui_gacha

func _ready() -> void:
	upper_ui.set_ui(PlayerData.current_money, PlayerData.currnt_day)

func _process(delta: float) -> void:
	pass

func get_new_frog():
	var new_frog = GameData.pick_new_random_frog_from_gacha()
	GlobalSignals.print_to_console.emit("GOT A NEW FROG!\nIt is: " + new_frog.id + ", from the " + GameData.FROG_COLECTIONS.keys()[new_frog.colection] + " collesction, and it is the rarity of " + str(new_frog.frog_rarity))

#signals

func _on_upper_ui_gacha_spin_gacha_signal(many: Variant) -> void:
	get_new_frog()
