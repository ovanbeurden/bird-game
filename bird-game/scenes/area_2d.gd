extends Area2D

var dragging = false
var hovering := false
var drag_offset = Vector2.ZERO
@onready var drag_man = get_tree().get_root().get_node("BirdGame/DragMan")
@export var bird_data: BirdData = preload("res://resources/bluebird.tres")
@onready var player = $AudioStreamPlayer2D

func _ready() -> void:
    mouse_entered.connect(func(): hovering = true)
    mouse_exited.connect(func(): hovering = false)
    
func _input(event):
    
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed and hovering and drag_man.current_dragged_object == null:
            dragging = true
            drag_man.current_dragged_object = self
            player.play()
            
        elif drag_man.current_dragged_object == self:
            dragging = false
            drag_man.current_dragged_object = null

func _process(delta):
    pass
