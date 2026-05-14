extends Area2D

var dragging = false
var hovering := false
var drag_offset = Vector2.ZERO
@onready var drag_man = get_tree().get_root().get_node("BirdGame/DragMan")
@onready var bird = get_parent() as CharacterBody2D

func _ready() -> void:
    mouse_entered.connect(func(): hovering = true)
    mouse_exited.connect(func(): hovering = false)
    
func _input(event):
    
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed and hovering and drag_man.current_dragged_object == null:
            dragging = true
            drag_man.current_dragged_object = self
            bird.play_grab_sound()
            
        elif drag_man.current_dragged_object == self:
            dragging = false
            drag_man.current_dragged_object = null
