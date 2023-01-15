class_name Player
extends KinematicBody2D

enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}

export var velocidad:float = 400.0
export var vida:float = 10.0
export var cadencia_disparo:float = 0.6
export var velocidad_proyectil:int = 1000
export var danio_proyectil:float = 2

onready var particulas_danio:Particles2D = $Danio
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
	configurar_cetro()

func _exit_tree() -> void:
	DatosJuego.player_actual = null

func evolucionar() -> void:
	if nivel_evolucion < 6:
		var nivel = "Nivel" + str(nivel_evolucion)
		sprite.play(nivel)
		$RotacionCetro/Cetro/Sprite.play(nivel)
		if nivel_evolucion == 3 || nivel_evolucion == 5:
			Eventos.emit_signal("cambio_nivel_proyectil")

func configurar_cetro() -> void:
	cetro.cadencia_disparo = 0.7
	cetro.velocidad_proyectil = 800
	cetro.danio_proyectil = 2

func _process(_delta) -> void:
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
	
	if rotacionCetro.rotation_degrees > 360:
		rotacionCetro.rotation_degrees = 0
	elif rotacionCetro.rotation_degrees < 0:
		rotacionCetro.rotation_degrees = 360
	
	if rotacionCetro.rotation_degrees > 90 && rotacionCetro.rotation_degrees < 270:
		$RotacionCetro/Cetro/Sprite.flip_v = true
		cetro.rotacio_negativa = true
	else: 
		$RotacionCetro/Cetro/Sprite.flip_v = false
		cetro.rotacio_negativa = false
	
	#Movimiento Player
	#position += movimiento * delta
	move_and_slide(movimiento)

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
<<<<<<< HEAD
	DatosJuego.camara_actual.movimientoCamara(4,0.3)
	Eventos.emit_signal("danio_jugador")
	if danio > vida:
		#Borrar test
		get_tree().change_scene("res://Escenas/Menus/MenuGameOver/MenuGameOver.tscn")
=======
>>>>>>> fff1976ddd95566a3a3b5b283209256a38b6b8fc
	if vida > 0:
		vida -= danio
		animaciones.play("Danio")
		Eventos.emit_signal("camera_shake_requested")
		Eventos.emit_signal("cambio_vida", vida)
		#Borrar test
		print(vida)
		
	if danio > vida:
		#Borrar test
		get_tree().change_scene("res://Escenas/Menus/MenuGameOver/MenuGameOver.tscn")
