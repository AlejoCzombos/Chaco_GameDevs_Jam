#MenuVictoria.gd
extends Control

## Atributos Export
export(String, FILE, "*.tscn") var menu_principal = ""
export(String, FILE, "*.tscn") var creditos = ""

## Atributos Onready
onready var musica: AudioStreamPlayer = $MusicaMenuVictoria

## Metodos
func _ready() -> void:
	musica.play()

## Señales Internas
func _on_Menu_Principal_pressed() -> void:
# warning-ignore:return_value_discarded
	MusicaJuego.play_boton()
	get_tree().change_scene(menu_principal)

func _on_Salir_pressed() -> void:
	MusicaJuego.play_boton()
	get_tree().quit()

func _on_Creditos_pressed() -> void:
# warning-ignore:return_value_discarded
	MusicaJuego.play_boton()
	get_tree().change_scene(creditos)
