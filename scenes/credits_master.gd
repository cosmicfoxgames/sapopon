extends Control

@onready var credits = %Label
@onready var anim = %AnimationPlayer

const CREDITS = [
	"COSMIC FOX GAMES PRESENTS" \
	+ "\nA GAME MADE by VILLAIN ERA" \
	+ "\n\nSapopon: Non-fungible Toads",
	"Powered by Godot" \
	+ "\nMade under 48(ish) hours for the Global Game Jam 2025",
	"DIRECTION" \
	+ "\nThomas Lion Tournoys" \
	+ "\nVriska Luciferina",
	"PROGRAMMING & GAME DESIGN" \
	+ "\nIkras Faria Beraldo" \
	+ "\nMercúrio Lourdes de Oliverira" \
	+ "\nThomas Lion Tournoys",
	"ART" \
	+ "\nKauany Gomes Cardoso" \
	+ "\nPolariz27" \
	+ "\nThomas Lion Tournoys" \
	+ "\nVriska Luciferina" \
	+ "\nYves Bicudo",
	"MUSIC & SFX" \
	+ "\nOli Campos" \
	+ "\nPolariz27",
	"Thanks for playing the game!",
	"Exist, Resist, Persist!"
]

const WAIT_TIME = 8

func _ready() -> void:
	show_credits()

func _process(delta: float) -> void:
	pass

func show_credits():
	GlobalSignals.play_music.emit(GameResources.get_resource(GameResources.MUSICS["TITLE"]))
	
	for i in CREDITS:
		credits.text = i
		anim.play("in")
		await get_tree().create_timer(WAIT_TIME).timeout
		anim.play("out")
		await anim.animation_finished
	
	await get_tree().create_timer((WAIT_TIME / 2)).timeout
	
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.INTRO]))
