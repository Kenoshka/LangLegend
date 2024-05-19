extends Node

var db : SQLite = SQLite.new()

func _ready():
	db.foreign_keys = true
	if FileAccess.file_exists("user://EnglishDatabase.db"):
		DirAccess.remove_absolute("user://EnglishDatabase.db")
	db.path = "user://EnglishDatabase.db"
	db.open_db()
	database_setup()

func database_setup():
	var Types = {
		"TypeId": {
			"data_type": "int",
			"primary_key": true,
			"auto_increment": true
		},
		"TypeName":  {
			"data_type": "text"
		}
	}
	var Difficulties = {
		"DiffId": {
			"data_type": "int",
			"primary_key": true
		}
	}
	var Topics = {
		"TopicId": {
			"data_type": "int",
			"primary_key": true,
			"auto_increment": true
		},
		"TopicName":  {
			"data_type": "text"
		}
	}
	var Tasks = {
		"TaskId": {
			"data_type": "int",
			"primary_key": true,
			"auto_increment": true
		},
		"TaskDiff":{
			"data_type": "int",
			"foreign_key": "Difficulties.DiffId"
		},
		"TaskTopic":{
			"data_type": "int",
			"foreign_key": "Topics.TopicId"
		},
		"TaskType":{
			"data_type": "int",
			"foreign_key": "Types.TypeId"
		},
		"TaskQuestion":{
			"data_type": "text"
		},
		"TaskText":{
			"data_type": "text"
		},
		"TaskAnswers":{
			"data_type": "text"
		},
		"TaskRightAnswer":{
			"data_type": "text"
		},
	}
	db.create_table("Types", Types)
	db.create_table("Difficulties", Difficulties)
	db.create_table("Topics", Topics)
	db.create_table("Tasks", Tasks)

	await insert_data()
	print(db.error_message)
	db.export_to_json("user://EnglishDatabaseExport")

func insert_data():
	db.insert_row("Types", {"TypeName":"Test"}) # 1
	db.insert_row("Types", {"TypeName":"Order"}) # 2

	db.insert_row("Difficulties", {"DiffId":0})
	db.insert_row("Difficulties", {"DiffId":1})

	db.insert_row("Topics", {"TopicName":"Фразовые глаголы"}) # 1
	db.insert_row("Topics", {"TopicName":"Синонимы"}) # 2
	db.insert_row("Topics", {"TopicName":"Построение предложений"}) # 3
	db.insert_row("Topics", {"TopicName":"Грамматика"}) # 4

	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"I don't like Alice. She ___ about difficulties of life all the time.",
		"TaskAnswers":"has complained_complaining_has been complaining_complains",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Zeta has sent me two letters; neither of which ___.",
		"TaskAnswers":"has arrived_arrive_have arrived_is arriving",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Their car is as good as new though they ___ it for a number of years.",
		"TaskAnswers":"are having_have_have had_have been having",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"My cousin Jake has got a lot of books, most of which he ___.",
		"TaskAnswers":"isn't reading_hasn't read_hasn't been reading_doesn't read",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"I looked everywhere for my car keys and then I remembered that my son ___ the car to work.",
		"TaskAnswers":"was taking_had taken_took_had been taking",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"While I ___ the dishes last night, I dropped a plate and broke it.",
		"TaskAnswers":"washed_had washed_was washing_had been washing",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"When I first ___ to England in 1938, I thought I knew English fairly well.",
		"TaskAnswers":"had been coming_had come_came_was coming",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"The two boys came into the house. One had a black eye and the other a cut lip. They ___.",
		"TaskAnswers":"fought_were fighting_had fought_had been fighting",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Carol and I are old friends. I ___ her since we studied in high school together.",
		"TaskAnswers":"have known_have been knowing_know_are knowing",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"A strong wind ___ and I decided to put on a warm coat.",
		"TaskAnswers":"had blown_blew_had been blowing_was blowing",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"By the time Mother comes home Peter ___ all the ice-cream.",
		"TaskAnswers":"will be eating_will eat_will have been eating_will have eaten",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"She is in the country now and she ___ there for another week.",
		"TaskAnswers":"will be staying_will have been staying_will stay_will have stayed",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"It's too late to telephone Tom now. I think I ___ him in the morning.",
		"TaskAnswers":"will call_am going to call_will have called_will be calling",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"I don't know his address, but I ___ it for you, if you want it.",
		"TaskAnswers":"am getting_will get_will be getting_will have got",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Where ___ work after you graduate from the University?",
		"TaskAnswers":"are you going to_will you_you will_you are going to",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"If I ___ George tomorrow, I will tell him to come and see you.",
		"TaskAnswers":"am going to meet_will be meeting_meet_will meet",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Sara, my next door neighbour, has a car, but she ___ it very often.",
		"TaskAnswers":"doesn't use_hasn't been using_hasn't used_isn't using",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"We ___ TV for ten minutes when the electricity went off.",
		"TaskAnswers":"watched_were watching_had been watching_had watched",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"When Mary came back, she looked very red from the sun. She ___ in the sun too long.",
		"TaskAnswers":"had laing_had been lying_was lying_lay",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"I will be back soon. I hope you ___ your translation by the time I come.",
		"TaskAnswers":"will finish_will have been finishing_will be finishing_will have finished",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"___ their luggage by the next time taxi comes?",
		"TaskAnswers":"Will they pack_Will they be packing_Will they have packed_They will pack",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Don't switch off the light. The child is afraid ___ in the dark.",
		"TaskAnswers":"sleeping_of sleeping_to sleep_sleep",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Look at your face and hands. If only your mother ___ you now!",
		"TaskAnswers":"could see_could have seen_would see_could seen",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"She started to sob and it looked as if her heart ___.",
		"TaskAnswers":"will break_broke_would break_had broken",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"By the time you come home you ___ everything I have told you.",
		"TaskAnswers":"will forget_will be forgetting_have forgotten_will have forgotten",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Do you think ___ here in a few years' time?",
		"TaskAnswers":"you will still be working_will you still work_you are still working_will you still be working",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Jack Strom has been a postman all his life; he ___ mail to homes and offices to the people of the town.",
		"TaskAnswers":"has been delivering_delivers_has delivered_is delivering",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"Alan ___ out almost every day last year, but now he can't afford it.",
		"TaskAnswers":"ate_had eaten_was eating_used to eat",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"While I ___ the dishes last night, I dropped a plate and broke it.",
		"TaskAnswers":"washed_had been washing_was washing_had washed",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"My room has been in a mess for days. So tomorrow afternoon I ___ clean it.",
		"TaskAnswers":"am cleaning_am going to clean_will clean_will have cleaned",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"By the first of December this year I ___ here for fifteen years already.",
		"TaskAnswers":"will work_will be working_will have been working_will have worked",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"I don't know when Professor Johnson ___ to his office, but when he comes, I'll speak to him about it.",
		"TaskAnswers":"comes_will have come_will come_is coming",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"A new book ___ by that company next year.",
		"TaskAnswers":"will be published_is publishing_will publish_will been published",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"I saw Paul at the airport. He ___ for his brother's plane to arrive from Canada.",
		"TaskAnswers":"had been waiting_waited_had waited_was waiting",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"You don’t have to wait for me, I’ll come home late. I ___ out with my friend.",
		"TaskAnswers":"am dining_will dine_will dining_will have been dining",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"By the end of the next month, she ___ for twenty years.",
		"TaskAnswers":"will teach_is teaching_will have been teaching_will have taught",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":4,
		"TaskType":1,
		"TaskQuestion":"Выберите правильное слово",
		"TaskText":"You don’t have to call Cindy. I ___ her later, so I’ll pass the message on.",
		"TaskAnswers":"will see_will be seeing_will have seen_will have been seeing",
		"TaskRightAnswer":"1"}
	)


	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to adore",
		"TaskAnswers":"to love_to desire",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to affect",
		"TaskAnswers":"to improve_to influence",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to amuse",
		"TaskAnswers":"to entertain_to exaggerate",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to occur",
		"TaskAnswers":"to accept_to happen",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to obtain",
		"TaskAnswers":"to skip_to get",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to deceive",
		"TaskAnswers":"to persuade_to confuse",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"efforts",
		"TaskAnswers":"complaints_remarks_attempts_orders",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to conceal",
		"TaskAnswers":"to hide_to count_to reveal_to send",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"annual",
		"TaskAnswers":"every day_every week_every month_every year",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to convince",
		"TaskAnswers":"to regret_to persuade",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to earn",
		"TaskAnswers":"to gain_to grow",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"wealthy",
		"TaskAnswers":"insane_rich",
		"TaskRightAnswer":""}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"filthy",
		"TaskAnswers":"messy_funny",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"vanished",
		"TaskAnswers":"cleaned_disappeared_swept_cleared",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"leap",
		"TaskAnswers":"run_jump",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"precise",
		"TaskAnswers":"terrible_amazing_accurate_dear",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"enormous",
		"TaskAnswers":"annoying_huge",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"neat",
		"TaskAnswers":"careful_careless",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":0,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"grateful",
		"TaskAnswers":"scared_thankful_graceful_rude",
		"TaskRightAnswer":"1"}
	)

	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to astonish",
		"TaskAnswers":"to surprise_to pretend_to love_to disturb",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"to weep",
		"TaskAnswers":"to whisper_to cry_to admire_to crawl",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"sincere",
		"TaskAnswers":"useful_obvious_harmful_frank",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"instantly",
		"TaskAnswers":"obviously_immediately_frequently_mainly",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"arrogant",
		"TaskAnswers":"kind_official_self-conscious_egoistical",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"sullen",
		"TaskAnswers":"gloomy_carefree_tired_lucky",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"regarding",
		"TaskAnswers":"stating_pointing_concerning_reading",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"submitted",
		"TaskAnswers":"chosen_presented_signed_fulfilled",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"compulsory",
		"TaskAnswers":"preferable_rapid_impossible_obligatory",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"substituted",
		"TaskAnswers":"received_broke_caught_changed",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"assent",
		"TaskAnswers":"consent_absence_help_wish",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"dedicated",
		"TaskAnswers":"separated_loyal_terrific_irritated",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"quantity",
		"TaskAnswers":"qualification_capacity_amount_quality",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"abhorrent",
		"TaskAnswers":"horrifying_disgusting_caring_thin",
		"TaskRightAnswer":"1"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"alluring",
		"TaskAnswers":"nervous_calming_attractive_runny",
		"TaskRightAnswer":"2"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"soothing",
		"TaskAnswers":"swimming_abundant_calming_fussing",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"hilarious",
		"TaskAnswers":"tiny_tremendous_sweet_amusing",
		"TaskRightAnswer":"3"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"possession",
		"TaskAnswers":"ownership_obsession_regeneration_attraction",
		"TaskRightAnswer":"0"}
	)
	db.insert_row("Tasks", {
		"TaskDiff":1,
		"TaskTopic":2,
		"TaskType":1,
		"TaskQuestion":"Подберите синоним",
		"TaskText":"soggy",
		"TaskAnswers":"hot_disgusting_wet_blank",
		"TaskRightAnswer":"2"}
	)

