#MenuGameOver.gd
extends Control

## Atributos Export
export(String, FILE, "*.tscn") var menu_inicio = ""

export(String, FILE, "*.tscn") var nivel_actual = ""

## Atributos Onready
onready var musica: AudioStreamPlayer = $MusicaGameOver

## Metodos
func _ready():
	musica.play()

func _on_Salir_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().quit()

func _on_Menu_Principal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_actual)

func _on_Creditos_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_inicio)
