extends CanvasLayer

onready var cardImg1 = $HBoxContainer/NinePatchRect/VBoxContainer/MarcoImg/ImgCartaMejora
onready var cardImg2 = $HBoxContainer/NinePatchRect2/VBoxContainer/MarcoImg/ImgCartaMejora
onready var cardDesc1 = $HBoxContainer/NinePatchRect/VBoxContainer/Label
onready var cardDesc2 = $HBoxContainer/NinePatchRect2/VBoxContainer/Label


onready var raiz = $'.'
onready var desaparecer = $AnimationPlayer
var sacadas = 0
const mazoDeMejoras:Array = [0,1,2,3]

const mejoraImg:Array = [
	preload("res://Escenas/Menus/Assets_Stats/fireRatio_icon.png"), 		# Ratio de fuego
	preload("res://Escenas/Menus/Assets_Stats/poder_icon.png"),			# Daño
	preload("res://Escenas/Menus/Assets_Stats/hp_icon.png"),				# Vida
	preload("res://Escenas/Menus/Assets_Stats/velocidad_icon.png")		# Velocidad
]
 
const mejoraDescripcion:Array=[
	'Ratio\nmejorado', 		# Ratio de fuego
	'Daño\nmejorado',				# Daño
	'Vida\nmejorada',				# Vida
	'Velocidad\nmejorada' ]			# Velocidad

const cartas = [
	[mejoraImg[0], mejoraDescripcion[0]],	# Ratio de fuego
	[mejoraImg[1], mejoraDescripcion[1]],	# Daño
	[mejoraImg[2], mejoraDescripcion[2]],	# Vida
	[mejoraImg[3], mejoraDescripcion[3]],	# Velocidad	
]




########### Prueba #############
func _ready():
	randomize()
	mazoDeMejoras.shuffle()
	
	# 0 = Tario de fuego
	# 1 = Daño
	# 2 = Vida
	# 3 = Velocidad
##  (usar este metodo para setear las cartas)
################################3

func set_cards(tipoCarta1, tipoCarta2):
	# 0 = Tario de fuego
	# 1 = Daño
	# 2 = Vida
	# 3 = Velocidad
	
	var imagen 
	var descripcion 
	
	imagen = cartas[tipoCarta1][0]
	print(imagen)
	descripcion = cartas[tipoCarta1][1]
	print(descripcion)
	cardImg1.set_texture(imagen)
	cardDesc1.set_text(descripcion)
	
	imagen = cartas[tipoCarta2][0]
	print(imagen)
	descripcion = cartas[tipoCarta2][1]
	print(descripcion)
	cardImg2.set_texture(imagen)
	cardDesc2.set_text(descripcion)

func repartirCartas():
	
	if mazoDeMejoras.size() != sacadas + 1:
		set_cards(mazoDeMejoras[sacadas], mazoDeMejoras[sacadas+1])
		sacadas += 2
	else: 
		sacadas = 0
		set_cards(mazoDeMejoras[sacadas], mazoDeMejoras[sacadas+1])
	if not raiz.visible:
		raiz.visible = not raiz.visible
		
	desaparecer.play("Animación_desaparecer")
