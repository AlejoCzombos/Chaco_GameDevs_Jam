extends Control

var mouseAdentro = false

export var menuScene = "res://Escenas/Menus/MenuInicio.tscn"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	MusicaJuego.play_boton()
	get_tree().change_scene(menuScene)




func _on_Button_focus_entered():
	if !mouseAdentro:
		$Paper/Button.rect_scale.x += .5
		$Paper/Button.rect_scale.y += .5
		mouseAdentro = true
func _on_Button_focus_exited():
	if mouseAdentro:
		$Paper/Button.rect_scale.x -= .5
		$Paper/Button.rect_scale.y -= .5
		mouseAdentro = false
func _on_Button_mouse_entered():
	if !mouseAdentro:
		$Paper/Button.rect_scale.x += .5
		$Paper/Button.rect_scale.y += .5
		mouseAdentro = true
func _on_Button_mouse_exited():
	if mouseAdentro:
		$Paper/Button.rect_scale.x -= .5
		$Paper/Button.rect_scale.y -= .5
		mouseAdentro = false
