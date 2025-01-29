extends Node

const MUSICS = {
	"INTRO" : "res://resources/musics/intro.mp3",
	"TITLE" : "res://resources/musics/FROG MENU 2.mp3",
	"GACHA" : "res://resources/musics/froggyv2.mp3",
	"COLLECTION" : "res://resources/musics/frog market.mp3",
	"MARKET" : "res://resources/musics/Bolsa de Valores.mp3"
}

const SFX = {
	"BOOTUP" : "res://resources/sfx/frogbootup.mp3",
	"GACHA_SPIN" : "res://resources/sfx/gachabuy.mp3",
	"FROG_SELL" : "res://resources/sfx/frogsell.mp3",
	"IMPACT" : "res://resources/sfx/undertaleimpact.mp3",
	"DAMP_CLICK" : "res://resources/sfx/waterclick.mp3",
	"BUBBLE_CLICK" : "res://resources/sfx/bubbleclick3.mp3"
}

const FROG_SFX = [
	"res://resources/sfx/ribbit1.mp3",
	"res://resources/sfx/ribbit2.mp3",
	"res://resources/sfx/ribbit3.mp3",
	"res://resources/sfx/ribbit4.mp3",
	"res://resources/sfx/ribbit5.mp3",
	"res://resources/sfx/ribbit6.mp3"
]

const FROG_COLLECTIONS_COLORS = {
	"LUCKY" : Color(1, 0.924, 0.24), #amarelo
	"HARD" : Color(0.4, 0.62, 1), #azul
	"STYLISH" : Color(1, 0.38, 0.762), #rosa
	"ADVENTURE" : Color(1, 0.18, 0.262), #vermelho
	"MYSTIC" : Color(0.581, 0.178, 0.89), #roxo
	"MATERIALS" : Color(0.47, 0.47, 0.47) #cinza
}

var frogs_by_ratitie = {
	"COMMOM" : [],
	"INCOMMOM" : [],
	"RARE" : [],
	"UNIQUE" : []
}

func get_resource(res):
	return(load(res))

func get_random_frog_ribbit():
	return(load(FROG_SFX.pick_random()))

func populate_frogs_by_raritie():
	print("populating frog by raritie list")
	for i in GameData.FROG_LIST:
		var frog_res : FrogTemplate = load(GameData.FROG_TEMPLATE_PATH % i)
		
		frogs_by_ratitie[frog_res.RARITY.keys()[frog_res.frog_rarity]].append(frog_res.id)
	
	print(frogs_by_ratitie)
