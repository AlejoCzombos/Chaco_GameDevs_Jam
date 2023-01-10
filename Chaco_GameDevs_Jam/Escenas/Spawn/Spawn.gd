class_name Spawn
extends Path2D

export var rango_max:int = 0

onready var camino:PathFollow2D = $PathFollow2D
onready var posicion_spawn:Position2D = $PathFollow2D/Position2D

func _ready() -> void:
	randomize()

func _on_Timer_timeout():
	var random = RandomNumberGenerator.new()
	random.randomize()
	camino.offset = random.randi_range(0,rango_max)
	
	Eventos.emit_signal("instanciarEnemigo", posicion_spawn.global_position)
