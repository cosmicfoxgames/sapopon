extends Control

@onready var sapo_img = %Sapo
@onready var label = %Label

var is_hovering = false

func _ready() -> void:
	set_itself(load("res://resources/frog_resources/frog_low_poly.tres"))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_click") and is_hovering == true:
		print("clicou no sapo!")

func set_itself(frog : FrogTemplate):
	label.text = frog.id
	sapo_img.modulate = GameResources.FROG_COLLECTIONS_COLORS[GameData.FROG_COLECTIONS.keys()[frog.colection]]

#signals

func _on_area_2d_mouse_entered() -> void:
	is_hovering = true
func _on_area_2d_mouse_exited() -> void:
	is_hovering = false
