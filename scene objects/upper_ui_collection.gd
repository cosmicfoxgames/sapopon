extends Control

@onready var valor_colec = %Label2
@onready var colec = %Label
@onready var scroll_container = %ScrollContainer
@onready var grid = %GridContainer
@onready var anim = %AnimationPlayer
@onready var frog_info = %frog_info_frame

@export var frog_icon : PackedScene

var previous_scroll_ammnt

func _ready() -> void:
	set_frog_grid()
	GlobalSignals.frog_icon_click.connect(_on_frog_icon_clicked)

func _process(delta: float) -> void:
	pass

func set_frog_grid():
	for i in PlayerData.current_collection:
		var new_frog_icon = frog_icon.instantiate()
		grid.add_child(new_frog_icon)
		new_frog_icon.set_itself(load(GameData.FROG_TEMPLATE_PATH % i))

func set_ui():
	if PlayerData.current_collection_value < 0: GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["ON_A_LOSS"]))
	valor_colec.text = tr("collection_value") % str(PlayerData.current_collection_value)
	
	var collect_txt = ""
	for i in PlayerData.current_collection:
		collect_txt = collect_txt + i + "\n"
	
	colec.text = collect_txt

#signals

func _on_frog_icon_clicked(frog : String):
	print("veio pro on frog clicked")
	previous_scroll_ammnt = scroll_container.scroll_vertical
	print("previous scroll ammnt: " + str(previous_scroll_ammnt))
	frog_info.set_frog(load(GameData.FROG_TEMPLATE_PATH % frog))
	anim.play("window_in")
	await anim.animation_finished
	grid.visible = false

#back from frog info window
func _on_frog_info_frame_back_click() -> void:
	grid.visible = true
	print("previous scroll ammnt: " + str(previous_scroll_ammnt))
	scroll_container.set_deferred("scroll_vertical", previous_scroll_ammnt)
	print(scroll_container.scroll_vertical)
	anim.play("window_out")

#teste do entarr sair dos sliders
func _on_scroll_container_focus_entered() -> void:
	GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.HAND)
func _on_scroll_container_focus_exited() -> void:
	GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.POINTER)
