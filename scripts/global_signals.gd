extends Node

signal print_to_console(txt : String)

signal change_scene(scene : PackedScene)
signal fade_scene(scene : PackedScene)
#signal advance_day()
signal got_new_frog(frog : FrogTemplate)

signal play_music(which)
signal stop_music()
signal play_sfx(which)

signal show_warning(warning : String)
