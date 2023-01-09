class_name Player
extends KinematicBody2D

export var velocidad:float = 400.0
export var vida:float = 10.0

onready var sprite:Sprite = $Sprite

func _ready() -> void:
	DatosJuego.player_actual = self

func _exit_tree() -> void:
	DatosJuego.player_actual = null

func _process(delta) -> void:
	var movimiento:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("Derecha"):
		movimiento.x += 1
	if Input.is_action_pressed("Izquierda"):
		movimiento.x -= 1
	if Input.is_action_pressed("Abajo"):
		movimiento.y += 1
	if Input.is_action_pressed("Arriba"):
		movimiento.y -= 1
	
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * velocidad
		#repoducir caminar/correr
	else:
		#Reproducir idle
		pass
	
	if movimiento.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	position += movimiento * delta

func recibir_danio(danio:float) -> void:
	if vida > 0:
		vida -= danio
		#Borrar test
		print(vida)
	else:
		#Borrar test
		get_tree().reload_current_scene()
