#MenuInicio.gd
extends Control

## Atributos Export
export(String, FILE, "*.tscn") var nivel_inicial = ""
export(String, FILE, "*.tscn") var creditos = ""

## Señales Internas
func _on_Jugar_pressed() -> void:
# warning-ignore:return_value_discarded
	MusicaJuego.play_boton()
	get_tree().change_scene(nivel_inicial) 

func _on_Creditos_pressed() -> void:
# warning-ignore:return_value_discarded
	MusicaJuego.play_boton()
	get_tree().change_scene(creditos)

func _on_Salir_pressed() -> void:
	MusicaJuego.play_boton()
	get_tree().quit()
