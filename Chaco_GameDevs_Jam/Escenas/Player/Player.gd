class_name Player
extends KinematicBody2D

enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}

export var velocidad:float = 400.0
export var vida:float = 10.0

onready var sprite:AnimatedSprite = $AnimatedSprite
onready var animaciones:AnimationPlayer = $AnimationPlayer
onready var cetro = $RotacionCetro/Cetro
onready var colisionador:CollisionShape2D = $CollisionShape2D
onready var rotacionCetro:CollisionShape2D = $RotacionCetro

var nivel_evolucion:int = 1
var estadoActual:int = ESTADO.VIVO

func _ready() -> void:
	DatosJuego.player_actual = self
	controladorEstado(estadoActual)

func _exit_tree() -> void:
	DatosJuego.player_actual = null

func evolucionar() -> void:
	if nivel_evolucion < 6:
		var nivel = "Nivel" + str(nivel_evolucion)
		sprite.play(nivel)

func _process(delta) -> void:
	#MOVIMIENTO----------------------
	var movimiento:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("Derecha"):
		movimiento.x += 1
	if Input.is_action_pressed("Izquierda"):
		movimiento.x -= 1
	if Input.is_action_pressed("Abajo"):
		movimiento.y += 1
	if Input.is_action_pressed("Arriba"):
		movimiento.y -= 1
	
	#DISPARO-----------------------------
	if Input.is_action_pressed("Disparar"):
		cetro.set_esta_disparando(true)
	elif Input.is_action_just_released("Disparar"):
		cetro.set_esta_disparando(false)
	
	if Input.is_action_just_pressed("Pausa"):
		#Borrar test
		nivel_evolucion += 1
		evolucionar()
	
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * velocidad
		animaciones.play("Correr")
	else:
		if !animaciones.is_playing():
			animaciones.play("Idle")
	
	if movimiento.x < 0:
		sprite.flip_h = true
	elif movimiento.x > 0 :
		sprite.flip_h = false
	
	#Rotacion del Cetro
	rotacionCetro.look_at(get_global_mouse_position())
	print(rotacionCetro.rotation_degrees)
	
	if rotacionCetro.rotation_degrees > 360:
		rotacionCetro.rotation_degrees = 0
	elif rotacionCetro.rotation_degrees < 0:
		rotacionCetro.rotation_degrees = 360
	
	if rotacionCetro.rotation_degrees > 90 && rotacionCetro.rotation_degrees < 270:
		$RotacionCetro/Cetro/Sprite.flip_v = true
	else: 
		$RotacionCetro/Cetro/Sprite.flip_v = false
	
	#Movimiento Player
	position += movimiento * delta

func controladorEstado(nuevoEstado: int) -> void:
	match nuevoEstado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disabled", true)
			cetro.set_puede_disparar(false)
		ESTADO.VIVO:
			colisionador.set_deferred("disabled", false)
			cetro.set_puede_disparar(true)
		ESTADO.INVENCIBLE:
			colisionador.set_deferred("disabled", true)
		ESTADO.MUERTO:
			colisionador.set_deferred("disabled", true)
			cetro.set_puede_disparar(false)
			queue_free()
		_:
			printerr("Error estados")
	estadoActual = nuevoEstado

func recibir_danio(danio:float) -> void:
	if vida > 0:
		vida -= danio
		#Borrar test
		print(vida)
	else:
		#Borrar test
		get_tree().reload_current_scene()
