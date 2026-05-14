extends Area2D

@export var explosion: PackedScene = preload("res://scenes/explosion.tscn")
@onready var main = get_tree().get_root().get_node("BirdGame")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed t$AnimatedSprite2D.play("idle")since the previous frame.
func _process(delta: float) -> void:
    area_entered.connect(_on_area_2d_area_entered)


func _on_area_2d_area_entered(area: Area2D) -> void:
    if area is not Nut:
        return
    
    var explosion_instance = explosion.instantiate() as Node2D
    explosion_instance.global_position = global_position
    get_parent().add_child(explosion_instance)
    main.global_score -= 100

    print("YOU DIED BITCH")
    #$Area2D/Sprite2D.texture = bird_data.texture_close
    # TODO: play explosion animation and sound, remove after explosion
    # Remove score

    area.queue_free()
    queue_free() # Remove the bomb itself
