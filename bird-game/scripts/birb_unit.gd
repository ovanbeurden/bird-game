extends Node2D

var dragging = false
var drag_offset = Vector2.ZERO
var gravity_factor = 10
var mass = 10
var down_speed = 0

func _input(mouse_input):
    if mouse_input is InputEventMouseButton:
        if mouse_input.button_index == MOUSE_BUTTON_LEFT:
            # Start dragging
            if mouse_input.pressed:
                var mouse_pos = get_global_mouse_position()

                # Optional simple hit test
                if $RigidBody2D/Sprite2D.get_rect().has_point(to_local(mouse_pos)):
                    dragging = true
                    drag_offset = global_position - mouse_pos

            # Stop dragging
            else:
                dragging = false

    elif mouse_input is InputEventMouseMotion and dragging:
        global_position = get_global_mouse_position() + drag_offset
        
func gravity() -> void:
    if dragging == false:
        if position.y < 0:
            down_speed += gravity_factor/mass
        else:
            position.y = 0
            down_speed = 0
        
        if position.y < down_speed:
            position.y += down_speed
        else:
            position.y = 0
    else:
        down_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    gravity()
    print(position.y)
    
