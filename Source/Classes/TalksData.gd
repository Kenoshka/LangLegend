extends Node

enum {
	ENG,
	RUS
}

var PHRASES = [
	[
		["Congratulations on finishing the marathon!", "Поздравляю с завершением марафона!"],
		["Thanks! I can’t believe I [color=yellow]pulled it off[/color].", "Спасибо! Не могу поверить, что я [color=yellow]справился с этим[/color]!"]
	],
	[
		["You look fantastic! Have you been working out?", "Ты выглядишь великолепно! Ты тренировалась?"],
		["Yes, actually I’ve [color=yellow]taken up[/color] yoga.", "Да, вообще-то я [color=yellow]начала заниматься[/color] йогой."]
	],
	[
		["Guess who I [color=yellow]ran into[/color] at the store.", "Угадай, на кого я [color=yellow]наткнулся[/color] в магазине."],
		["[color=yellow]No idea[/color]. Who?", "[color=yellow]Без понятия[/color]. На кого?"],
		["Do you remember the guy who works at the coffee shop down the road? It was him.", "Помнишь парня, который работает в кафе вниз по улице? Это был он."],
	],
	[
		["How’s it going? You look busy.", "Как дела? Ты выглядишь занятым."],
		["I just need to finish off this report. [color=yellow]Take a seat[/color].", "Мне просто нужно закончить этот отчет. [color=yellow]Присаживайся[/color]."]
	],
	[
		["Is there any deadline for this task?", "Есть ли какой-либо крайний срок для этой задачи?"],
		["Not at all, [color=yellow]take your time[/color].", "Вовсе нет, [color=yellow]не торопись[/color]."]
	],
	[
		["We were leaving when it began to rain.", "Мы уходили, когда начался дождь."],
		["Did you go home?", "Вы пошли домой?"],
		["No, we stayed in and ordered [color=yellow]take out[/color]. We tried English food.", "Нет, мы остались и заказали [color=yellow]еду на вынос[/color]. Мы попробовали английскую еду."],
	],
	[
		["How was your dinner at a Chinese restaurant?", "Как прошел твой ужин в китайском ресторане?"],
		["It was OK, but the menu was in Chinese so we couldn’t [color=yellow]make it out[/color].", "Неплохо, но меню было на китайском, поэтому мы не могли его [color=yellow]разобрать[/color]."],
	],
	[
		["I [color=yellow]can't stand[/color] waking up early every morning!", "[color=yellow]Терпеть не могу[/color] просыпаться рано каждое утро!"],
		["Maybe you should try going to sleep earlier.", "Возможно, тебе стоит попробовать ложиться спать пораньше."],
	],
	[
		["Did you [color=yellow]end up[/color] fixing your car?", "Ты [color=yellow]закончил[/color] с починкой своей машины?"],
		["Yeah, I took it to the mechanic, and they [color=yellow]sorted out[/color] the problem.", "Да, я отвёз её механикам и они [color=yellow]устранили[/color] проблему."],
	],
	[
		["John is quite a naughty student, you know.", "Джон достаточно непослушный студент, знаешь ли."],
		["Yes, it is almost impossible to [color=yellow]put up[/color] with his impolite behavior.", "Да, с его невежливым поведением [color=yellow]смириться[/color] практически невозможно."],
	],
	[
		["Did you [color=yellow]come across[/color] any interesting articles in the magazine?", "[color=yellow]Попались[/color] ли тебе в журнале какие-нибудь интересные статьи?"],
		["Yeah, there was one about travel tips that [color=yellow]caught my eye[/color].", "Да, был один совет о путешествии который [color=yellow]привлек мое внимание[/color]."],
	],
	[
		["What do you thing about our new teacher?", "Что ты думаешь о нашем новом учителе?"],
		["I think he tries to [color=yellow]come across[/color] as a strict person.", "Я думаю, он пытается [color=yellow]произвести впечатление[/color] строгого человека."],
	],
	[
		["Did you see Ryan at our office?", "Ты видел Райана в нашем офисе?"],
		["He didn't show up for several days.", "Он не появлялся несколько дней."],
		["Hm, I can suppose he was [color=yellow]laid off[/color].", "Хм, я могу предположить, что его [color=yellow]уволили[/color]."],
	],
	[
		["Hello, is my article ready for publication?", "Здравствуйте, готова ли моя статья к публикации?"],
		["Some editorial work was [color=yellow]carried out[/color], your article will be published next week.", "Была [color=yellow]проведена[/color] некоторая редакционная правка, ваша статья будет опубликована на следующей неделе."],
	],
	[
		["Are you prepared for the exam next week?", "Готова ли ты к экзамену на следующей неделе?"],
		["Not really, I need to [color=yellow]brush up[/color] on my notes.", "Не совсем, мне нужно [color=yellow]освежить знание[/color] своих конспектов."],
	],
	[
		["What happened during the interrogation?", "Что произошло во время допроса?"],
		["The suspect [color=yellow]clammed up[/color] and refused to answer any more questions without a lawyer present.", "Подозреваемый [color=yellow]замолкнул[/color] и отказался отвечать на дальнейшие вопросы без присутствия адвоката."],
	],
	[
		["Have you heard about the new cafe that opened down the street?", "Ты слышал о новом кафе, открывшемся дальше по улице?"],
		["Yes, I must say, the food there really lives up to the expectations!", "Да, могу сказать, что еда там действительно оправдывает ожидания."],
	],
	[
		["Have you thought about asking for a raise at work yet?", "Ты задумывался о том, чтобы попросить повышение на работе?"],
		["I've been [color=yellow]putting it off[/color] because I'm afraid of how my boss might react.", "Я [color=yellow]откладывал это[/color], потому что боялся реакции моего босса."],
		["You should [color=yellow]bring it up[/color] during your next meeting.", "Тебе следует [color=yellow]поднять этот вопрос[/color] во время следующего совещания."],
		["I know, but I [color=yellow]tend to clam up[/color] whenever I have to talk about money.", "Я знаю, но я [color=yellow]склонен молчать[/color], когда мне приходится говорить о деньгах."]
	]
]
