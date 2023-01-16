extends Camera2D

onready var timer : Timer = $TimerCameraShake
 
var esta_moviendose = false
var intensidad_movimiento = 0

func _ready():
	DatosJuego.camara_actual = self

func _exit_tree():
	DatosJuego.camara_actual = null

# warning-ignore:unused_argument
func _process(delta):
	zoom = lerp(zoom, Vector2(1,1), 0.3)
	
	if esta_moviendose:
		global_position += Vector2(rand_range(-intensidad_movimiento, intensidad_movimiento),rand_range(-intensidad_movimiento, intensidad_movimiento) )
	else:
		global_position = lerp(global_position, DatosJuego.player_actual.global_position, 0.3)
func movimientoCamara(intensidad, tiempo):
	zoom = Vector2(1,1) - Vector2(intensidad *0.03 , intensidad * 0.03)
	intensidad_movimiento = intensidad
	timer.wait_time = tiempo
	timer.start()
	esta_moviendose = true

func _on_TimerCameraShake_timeout():
	esta_moviendose = false
