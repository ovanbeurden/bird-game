extends RigidBody2D

var nutscore = 20
@export var nut_data: NutData
@onready var sprite = $Walnut

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    sprite.texture = nut_data.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    sprite.rotate(delta)
