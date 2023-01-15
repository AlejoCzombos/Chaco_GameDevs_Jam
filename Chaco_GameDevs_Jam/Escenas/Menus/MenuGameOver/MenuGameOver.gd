#MenuGameOver.gd
extends Control

## Atributos
var nivel_actual: String = ""

## Atributos Export
export(String, FILE, "*.tscn") var menu_inicio = ""

## Atributos Onready
onready var musica: AudioStreamPlayer = $MusicaGameOver

## Metodos
func _ready():
	nivel_actual = DatosJuego.nivel_actual
	musica.play()

## Señales Internas
func _on_MenuPrincipal_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_inicio)

func _on_Reintentar_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_actual)

func _on_Salir_pressed() -> void:
	get_tree().quit()
