extends Control

var playbutton

func_ready():
    get_tree().set pause(true)

    playButton = $CenterContainer/Panel/VboxContainer/Button

    playButton.connect("pressed", self, "newGame")
    pass

func newGame():
    get_tree().set_pause(false)
    queue_free()
    pass
