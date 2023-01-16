#MenuPresentacion.gd
tool
extends Control

## Atributos Export
export(String, FILE, "*.tscn") var menu_inicial = ""

func reproducirMusica():
	MusicaJuego.play_musica_menu()

## Metodos
func _get_configuration_warning() -> String:
	if menu_inicial == "":
		return "No Hay Menu Inicial Asignado"
	return ""

## Metodos Custom
func cargar_menu() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_inicial)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "presentacion":
		cargar_menu()
