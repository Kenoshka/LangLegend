extends Control

var enemy_hp = 5:
	set(val):
		enemy_hp = val
		for i in range($Enemy/EnemyHP.get_child_count()):
			$Enemy/EnemyHP.get_child(i).set_status(val > i)

var player_hp = 4:
	set(val):
		player_hp = val
		for i in range($Player/PlayerHP.get_child_count()):
			$Player/PlayerHP.get_child(i).set_status(val > i)

var HP_Scene = preload("res://Source/HPBar.tscn")

var TestTask_Scene = preload("res://Source/TestTask.tscn")
var OrderTask_Scene = preload("res://Source/WordOrderTask.tscn")

var BACK_CHARS = [
	preload("res://Assets/Characters/1_back.png"),
	preload("res://Assets/Characters/2_back.png"),
	preload("res://Assets/Characters/3_back.png"),
	preload("res://Assets/Characters/4_back.png"),
]

var ENEMIES = [
	preload("res://Assets/Creatures/1.png"),
	preload("res://Assets/Creatures/2.png"),
	preload("res://Assets/Creatures/3.png"),
	preload("res://Assets/Creatures/4.png"),
]

var ATTACK_TOPICS = [1, 2, 4]
var DODGE_TOPICS = [1, 2, 4]

var ATTACK_TASKS = []
var DODGE_TASKS = []

var TASKS_BANK = []

var ATTACK_TOPIC = 1
var DODGE_TOPIC = 1

var current_task = null

var enemy_attacks = true:
	set(val):
		enemy_attacks = val
		$Enemy/Anger.visible = val

var player_attacks = false

var rights = 0
var wrongs = 0

var notify = preload("res://Source/NotifyWindow.tscn")

func _ready():
	if DataControl.DATA[DataControl.EXP] >= 300:
		ATTACK_TOPICS.append(3)
		DODGE_TOPICS.append(3)
	modulate.a = 0
	create_tween().tween_property(self, "modulate:a", 1.0, 1)
	$PlayerAnimation.play("RESET")
	$EnemyAnimation.play("RESET")
	$Player/PlayerTexture.texture = BACK_CHARS[DataControl.DATA[DataControl.AVATAR]]
	if FightHandler.IS_TRAIN:
		enemy_attacks = false
	if FightHandler.TYPE_CHOSEN != FightHandler.BLITZ:
		$Enemy/EnemyTexture.texture = ENEMIES[randi_range(0, ENEMIES.size() - 1)]
		if DataControl.DATA[DataControl.DIFFICULTY] > 0:
			enemy_hp = 6
		if FightHandler.IS_TRAIN:
			$Enemy/EnemyTexture.texture = load("res://Assets/Creatures/dummy.png")
			enemy_hp = 4
		for i in range(enemy_hp):
			$Enemy/EnemyHP.add_child(HP_Scene.instantiate())
		for i in range(player_hp):
			$Player/PlayerHP.add_child(HP_Scene.instantiate())
		if DataControl.DATA[DataControl.TUTOR_BATTLE] != true:
			var notify_scn = notify.instantiate()
			notify_scn.set_notify_text("Битвы",
			"Уворачивайтесь и атакуйте! Для победы вам нужно снизить здоровье врага до 0. Обратите внимание - враг атакует, когда возле него находится данная иконка.",
			load("res://Assets/Tutors/Fight.png"))
			add_child(notify_scn)
			DataControl.DATA[DataControl.TUTOR_BATTLE] = true
		await set_topics()
		start_turn()
	else:
		$Enemy.visible = false
		$BlitzUI.visible = true
		$ButtonsContainer.visible = false
		$Player.visible = false
		$BG.visible = false
		await set_tasks_bank()
		$BlitzTimer.start(60)
		$BlitzUI/TimerBG.value = 100
		create_tween().tween_property($BlitzUI/TimerBG, "value", 0.0, 60)
		start_blitz()



func start_blitz():
	if TASKS_BANK.size() < 1:
		await set_tasks_bank()
	var task_id = TASKS_BANK[randi_range(0, TASKS_BANK.size() - 1)]
	var task_scene
	if DbHandler.get_task_type(task_id) == 1:
		task_scene = TestTask_Scene.instantiate()
	elif DbHandler.get_task_type(task_id) == 2:
		task_scene = OrderTask_Scene.instantiate()
	task_scene.TASK_ID = task_id
	task_scene.TWEEN_TIME = 0.3
	TASKS_BANK.erase(task_id)
	add_child(task_scene)
	task_scene.AnswerGiven.connect(answer_handler)
	place_timer_above()

func place_timer_above():
	move_child($BlitzUI, get_child_count())

func _on_blitz_timer_timeout():
	if rights > 9:
		game_over(true)
	else:
		game_over(false)

func start_turn():
	if player_hp < 1:
		game_over(false)
	elif enemy_hp < 1:
		game_over(true)
	else:
		if ATTACK_TASKS.size() < 1:
			set_attack_bank()
		if DODGE_TASKS.size() < 1:
			set_evade_bank()
		if not FightHandler.IS_TRAIN:
			enemy_attacks = !enemy_attacks
		$ButtonsContainer/AttackButton.disabled = false
		$ButtonsContainer/DodgeButton.disabled = false


func game_over(win):
	if win:
		if FightHandler.IS_DAILY:
			DataControl.DATA[DataControl.EXP] += 50
			FightHandler.NOTIFY.append("Хорошая работа!")
			if FightHandler.TYPE_CHOSEN == FightHandler.USUAL:
				DataControl.DATA[DataControl.DAILY_USUAL] = Time.get_date_string_from_system()
				FightHandler.NOTIFY.append("Вы получаете 50 очков опыта.")
			if FightHandler.TYPE_CHOSEN == FightHandler.BLITZ:
				DataControl.DATA[DataControl.DAILY_BLITZ] = Time.get_date_string_from_system()
				FightHandler.NOTIFY.append("Вы ответили %s раз верно и %s раз неверно." % [rights, wrongs])
		else:
			DataControl.DATA[DataControl.EXP] += 10
			FightHandler.NOTIFY.append("Неплохо потренировались!")
			FightHandler.NOTIFY.append("Вы получаете 10 очков опыта.")
	else:
		FightHandler.NOTIFY.append("Как жаль...")
		FightHandler.NOTIFY.append("В следующий раз у вас всё получится!")
	DataControl.save_data()
	await create_tween().tween_property(self, "modulate:a", 0.0, 0.5).finished
	get_tree().change_scene_to_file("res://Source/Main.tscn")


func set_topics():
	ATTACK_TOPIC = ATTACK_TOPICS[randi_range(0, ATTACK_TOPICS.size() - 1)]
	DODGE_TOPICS.erase(ATTACK_TOPIC)
	DODGE_TOPIC = DODGE_TOPICS[randi_range(0, DODGE_TOPICS.size() - 1)]
	DbHandler.db.query_with_bindings("SELECT * FROM Topics where TopicId = ?", [ATTACK_TOPIC])
	$ButtonsContainer/AttackButton/AttackTopic.text = DbHandler.db.query_result[0]["TopicName"]
	DbHandler.db.query_with_bindings("SELECT * FROM Topics where TopicId = ?", [DODGE_TOPIC])
	$ButtonsContainer/DodgeButton/DodgeTopic.text = DbHandler.db.query_result[0]["TopicName"]
	set_attack_bank()
	set_evade_bank()


func set_attack_bank():
	DbHandler.db.query_with_bindings(
		"SELECT * FROM Tasks where TaskTopic = ? and TaskDiff = ?", [ATTACK_TOPIC, DataControl.DATA[DataControl.DIFFICULTY]]
	)
	for task in DbHandler.db.query_result:
		ATTACK_TASKS.append(task["TaskId"])

func set_evade_bank():
	DbHandler.db.query_with_bindings(
		"SELECT * FROM Tasks where TaskTopic = ? and TaskDiff = ?", [DODGE_TOPIC, DataControl.DATA[DataControl.DIFFICULTY]]
	)
	for task in DbHandler.db.query_result:
		DODGE_TASKS.append(task["TaskId"])

func set_tasks_bank():
	DbHandler.db.query_with_bindings(
		"SELECT * FROM Tasks where TaskTopic != 3 and TaskDiff = ?", [ATTACK_TOPIC, DataControl.DATA[DataControl.DIFFICULTY]]
	)
	for task in DbHandler.db.query_result:
		TASKS_BANK.append(task["TaskId"])


func _on_attack_button_pressed():
	player_attacks = true
	var task_id = ATTACK_TASKS[randi_range(0, ATTACK_TASKS.size() - 1)]
	var task_scene
	if DbHandler.get_task_type(task_id) == 1:
		task_scene = TestTask_Scene.instantiate()
	elif DbHandler.get_task_type(task_id) == 2:
		task_scene = OrderTask_Scene.instantiate()
	task_scene.TASK_ID = task_id
	ATTACK_TASKS.erase(task_id)
	add_child(task_scene)
	task_scene.AnswerGiven.connect(answer_handler)


func _on_dodge_button_pressed():
	player_attacks = false
	var task_id = DODGE_TASKS[randi_range(0, DODGE_TASKS.size() - 1)]
	var task_scene
	if DbHandler.get_task_type(task_id) == 1:
		task_scene = TestTask_Scene.instantiate()
	elif DbHandler.get_task_type(task_id) == 2:
		task_scene = OrderTask_Scene.instantiate()
	task_scene.TASK_ID = task_id
	DODGE_TASKS.erase(task_id)
	add_child(task_scene)
	task_scene.AnswerGiven.connect(answer_handler)


func answer_handler(is_true):
	if FightHandler.TYPE_CHOSEN != FightHandler.BLITZ:
		post_answer_actions(is_true)
	else:
		if is_true:
			rights += 1
		else:
			wrongs +=1
		$BlitzUI/Rights.text = str(rights)
		start_blitz()


func post_answer_actions(is_true):
	$ButtonsContainer/AttackButton.disabled = true
	$ButtonsContainer/DodgeButton.disabled = true
	if enemy_attacks:
		$EnemyAnimation.play("Attack")
		if not is_true:
			player_hp -= 1
	if player_attacks:
		if is_true:
			if enemy_attacks:
				await $EnemyAnimation.animation_finished
				player_hp -= 1
			$PlayerAnimation.play("Attack")
			enemy_hp -= 1
		else:
			$PlayerAnimation.play("Empty")
	else:
		if is_true:
			$PlayerAnimation.play("Evade")
		else:
			$PlayerAnimation.play("Empty")
	await $PlayerAnimation.animation_finished
	start_turn()

