extends Control

signal back_click

@onready var frog_img = %frog_img
@onready var frog_name = %frog_name
@onready var frog_collection = %frog_collection
@onready var frog_rarity = %frog_rarity
@onready var frog_value = %value_today

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func set_frog(frog : FrogTemplate):
	frog_img.texture= frog.get_frog_img()
	frog_name.text = frog.id
	
	frog_collection.text = GameData.FROG_COLECTIONS.keys()[frog.colection]
	frog_rarity.text = FrogTemplate.RARITY.keys()[frog.frog_rarity]
	
	frog_value.text = tr("frog_today_value") + ": " + str(GameData.get_frog_influenced_value(frog))

#signals

func _on_game_button_button_click() -> void:
	back_click.emit()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	get_viewport().set_input_as_handled()
