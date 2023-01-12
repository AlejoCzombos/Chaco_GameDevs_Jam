extends Camera2D

var esta_moviendose:bool = false
var intensidad_movimiento:int = 0

func _ready() -> void:
	DatosJuego.camara = self

func _exit_tree() -> void:
	DatosJuego.camara = null

func _process(delta) -> void:
	zoom = lerp(zoom, Vector2(1,1), 0.3)
	
	if esta_moviendose:
		global_position += Vector2(rand_range(-intensidad_movimiento, intensidad_movimiento), rand_range(-intensidad_movimiento, intensidad_movimiento)) * delta
	else:
		global_position = lerp(global_position, Vector2(DatosJuego.player_actual.global_position.x,DatosJuego.player_actual.global_position.y), 0.3)

func mover_camara(intensidad:float, tiempo:float):
	zoom = Vector2(1,1) - Vector2(intensidad * 0.002, intensidad * 0.002)
	intensidad_movimiento = intensidad
	$TiempoMovimientoCamara.wait_time = tiempo
	$TiempoMovimientoCamara.start()
	esta_moviendose = true

func _on_TiempoMovimientoCamara_timeout():
	esta_moviendose = false
