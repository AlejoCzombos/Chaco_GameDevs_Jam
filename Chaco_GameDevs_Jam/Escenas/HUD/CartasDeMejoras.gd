extends Control

onready var cardImg1 = $HBoxContainer/NinePatchRect/VBoxContainer/MarcoImg/ImgCartaMejora
onready var cardImg2 = $HBoxContainer/NinePatchRect2/VBoxContainer/MarcoImg/ImgCartaMejora
onready var cardDesc1 = $HBoxContainer/NinePatchRect/VBoxContainer/Label
onready var cardDesc2 = $HBoxContainer/NinePatchRect2/VBoxContainer/Label

onready var carta1 = $HBoxContainer/NinePatchRect
onready var carta2 = $HBoxContainer/NinePatchRect2

onready var tween_In:Tween = $Tween_In
onready var tween_Out:Tween = $Tween_Out

const mejoraImg:Array = [
	preload("res://Escenas/Menus/Assets_Stats/poder_icon.png"),			# Daño
	preload("res://Escenas/Menus/Assets_Stats/fireRatio_icon.png"), 		# Ratio de fuego
	preload("res://Escenas/Menus/Assets_Stats/hp_icon.png"),				# Vida
	preload("res://Escenas/Menus/Assets_Stats/velocidad_icon.png")		# Velocidad
]
 
const mejoraDescripcion:Array=[
	'Daño\nmejorado',				# Daño
	'Ratio\nmejorado', 		# Ratio de fuego
	'Vida\nmejorada',				# Vida
	'Velocidad\nmejorada' ]			# Velocidad

const cartas = [
	[mejoraImg[0], mejoraDescripcion[0]],	# Daño
	[mejoraImg[1], mejoraDescripcion[1]],	# Ratio de fuego
	[mejoraImg[2], mejoraDescripcion[2]],	# Vida
	[mejoraImg[3], mejoraDescripcion[3]],	# Velocidad	
]

var carta1_seleccionada:bool = false
var carta2_seleccionada:bool = false

var numeroRandom = RandomNumberGenerator.new()

var mejoras_danio:int = 4
var mejoras_vida:int = 5
var mejoras_velocidad:int = 4
var mejoras_disparo:int = 5

var numero1:int
var numero2:int

func _process(delta):
	if Input.is_action_just_pressed("Disparar"):
		if carta1_seleccionada:
			print("carta 1 seleccionada")
			Eventos.emit_signal("mejoraSeleccionada", numero1)
			carta1_seleccionada = false
		elif carta2_seleccionada:
			print("carta 2 seleccionada")
			Eventos.emit_signal("mejoraSeleccionada", numero2)
			carta2_seleccionada = false

########### Prueba #############
func _ready():
	self.visible = false
	numeroRandom.randomize()
	definir_cartas()
	# 0 = Daño
	# 1 = Tario de fuego
	# 2 = Vida
	# 3 = Velocidad
##  (usar este metodo para setear las cartas)
################################3

func definir_cartas() -> void:
	if mejoras_danio > 0:
		numero1 = numeroRandom.randi_range(0,3)
		numero2 = numeroRandom.randi_range(0,3)
		while numero1 == numero2:
			numero2 = numeroRandom.randi_range(0,3)
		set_cards(numero1, numero2)
		if numero1 == 0 || numero2 == 0:
			mejoras_danio -= 1
	else:
		numero1 = numeroRandom.randi_range(1,3)
		numero2 = numeroRandom.randi_range(1,3)
		while numero1 == numero2:
			numero2 = numeroRandom.randi_range(1,3)
		set_cards(numero1, numero2)

func set_cards(tipoCarta1, tipoCarta2):
	# 0 = Daño
	# 1 = Tario de fuego
	# 2 = Vida
	# 3 = Velocidad
	
	var imagen 
	var descripcion 
	
	imagen = cartas[tipoCarta1][0]
	descripcion = cartas[tipoCarta1][1]
	cardImg1.set_texture(imagen)
	cardDesc1.set_text(descripcion)
	
	imagen = cartas[tipoCarta2][0]
	descripcion = cartas[tipoCarta2][1]
	cardImg2.set_texture(imagen)
	cardDesc2.set_text(descripcion)

func _on_NinePatchRect2_mouse_entered():
	carta2_seleccionada = true
	#tween_In.interpolate_property(carta2, "rect_position", carta2.rect_position,  Vector2(230, -10), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	#tween_In.start()
	carta2.modulate = Color("8a8a8a")

func _on_NinePatchRect2_mouse_exited():
	carta2_seleccionada = false
	#tween_Out.interpolate_property(carta2, "rect_position", carta2.rect_position,  Vector2(230, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	#tween_Out.start()
	carta2.modulate = Color.white

func _on_NinePatchRect_mouse_entered():
	carta1_seleccionada = true
#	tween_In.interpolate_property(carta1, "rect_position", carta1.rect_position,  Vector2(0, -10), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	tween_In.start()
	carta1.modulate = Color("8a8a8a")

func _on_NinePatchRect_mouse_exited():
	carta1_seleccionada = false
#	tween_Out.interpolate_property(carta1, "rect_position", carta1.rect_position,  Vector2(0, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	tween_Out.start()
	carta1.modulate = Color.white
