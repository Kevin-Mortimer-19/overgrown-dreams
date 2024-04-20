class_name HeroActor extends Actor

var skills: Skillset

func _init(st: Stats, sk: Skillset, b: Button):
	skills = sk
	super(st, b)
