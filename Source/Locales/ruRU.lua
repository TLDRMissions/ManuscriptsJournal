local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU")
if not L then return end
-- Russian translation by ZamestoTV
-- Misc strings
L["MANUSCRIPTS_PROGRESS_FORMAT"] = "%d/%d"
L["Rare Spawns"] = "Редкий Монстр"
L["ADDON_NAME"] = "Манускрипты"
L["Source:"] = "Источник:"
L["Grand Hunts"] = "Великая охота"
L["Required Rank:"] = "Ранг:"
L["Various in:"] = "Различные в:"
L["Various"] = "Различный"
L["Bugged"] = "Из-за ошибки это может быть недоступно."
L["Dragon Racing Container"] = "Драконьи гонки "..AUCTION_CATEGORY_CONTAINERS
L["Dragon Racing Achievement"] = "Драконьи гонки "..BATTLE_PET_SOURCE_6
L["Treasure Chest"] = "Сундук"
L["PvP Seasonal"] = "PvP сезонный"

L["Time Rifts"] = QuestUtils_GetQuestName(76984)
QuestEventListener:AddCallback(76984, function()
	L["Time Rifts"] = QuestUtils_GetQuestName(76984)
end)

-- Reputation and Friendship ranks
L["Friend"] = "Друг"
L["True Friend"] = "Настоящий друг"
L["Maximum"] = "Максимальный"
L["High"] = "Высокий"
L["Medium"] = "Средний"
L["Low"] = "Низкий"

-- Vendors
L["Kraxxus"] = "Краксус"
L["Meiz"] = "Мейз"
L["Ponzo"] = "Понзо"
L["Maztha"] = "Мазта"
L["Cravitz Lorent"] = "Кравиц Лоран"
L["Flamesmith Lanying"] = "Огненный кузнец Лань Цзинь"
L["Endora Moorehead"] = "Эндора Мурхед"
L["Imp Mother Dyala"] = "Мать бесов Дьяла"
L["Vi'el"] = "Ви'ел"
L["Aridormi"] = "Аридорми"
L["Cupri"] = "Купри"
L["Gigi Gigavoid"] = "Гиги Гигабездна"

-- Rare spawns
L["Gethdazr"] = "Гетдазр"
L["Corrupted Proto-Dragon"] = "Оскверненный протодракон"
L["Diluu"] = "Дилуу"
L["Treasure-Mad Trambladd"] = "Златолюбец Зацепий"
L["Shadeslash Trakken"] = "Траккен Шрам Тени"
L["Tikarr Frostclaw"] = "Тикарр Морозный Коготь"
L["Sparkspitter Vrak"] = "Искроплюй Врак"
L["Phleep"] = "Флюп"
L["Sandana the Tempest"] = "Сандана Живой Ураган"
L["Innumerable Ruination"] = "Беспредельное разорение"
L["Lord Epochbrgl"] = "Лорд Эпохбргл"
L["Researcher Sneakwing"] = "Исследовательница Незримое Крыло"
L["Razk'vex the Untamed"] = "Разк'векс Неукрощенный"
L["Ancient Hornswog"] = "Древний рогоплав"
L["Acrosoth"] = "Акросот"
L["Tomnu"] = "Томну"
L["Nulltheria the Void Gazer"] = "Нултерия Глядящая в Бездну"
L["Shade of Grief"] = "Тень горя"
L["Blightpaw the Depraved"] = "Чумолап Гниющий"
L["High Shaman Rotknuckle"] = "Верховный шаман Гнилапа"
L["Blightfur"] = "Гниломех"
L["Klozicc the Ascended"] = "Клозикк Вознесенный"
L["Beogoka"] = "Беогока"
L["Notfar the Unbearable"] = "Нотфар Невыносимый"
L["Graniteclaw"] = "Гранитный Коготь"
L["O'nank Shorescour"] = "О'нанк Пескорой"
L["Brackle"] = "Бракл"
L["Gorjo the Crab Shackler"] = "Горджо Ловец Крабов"
L["Skewersnout"] = "Шилонос"
L["Swog'ranka"] = "Рого'ранка"
L["Massive Magmashell"] = "Гигантский магмапанцирь"
L["Loot Specialist"] = "Специалист по добыче"
L["Fisherman Tinnak"] = "Рыболов Тиннак"
L["Forgotten Gryphon"] = "Забытый грифон"
L["Sharpfang"] = "Остроклык"
L["Mange the Outcast"] = "Чесун Изгой"
L["Snarglebone"] = "Кривокост"
L["Scav Notail"] = "Скав Бесхвостый"
L["Dragonhunter Igordan"] = "Охотник на драконов Игордан"	
L["Rohzor Forgesmash"] = "Розор Кузнекрушитель"
L["Cauldronbearer Blakor"] = "Блакор Хозяйка Котла"
L["Rasnar the War Ender"] = "Раснар Миротворец"			
L["Dragonhunter Gorund"] = "Охотник на драконов Горунд"	
L["Captain Lancer"] = "Капитан Копьеносица"
L["Anhydros the Tidetaker"] = "Ангидрос Покоритель Волн"
L["Gushgut the Beaksinker"] = "Плескобрюх Птицегубитель"
L["Cascade"] = "Каскад"	
L["Snufflegust"] = "Хрипожабр"
L["Astray Splasher"] = "Блуждающий всплеск"
L["Seereel, the Spring"] = "Сирил Первоцвет"	
L["Spellwrought Snowman"] = "Магический снеговик"
L["Seeker Teryx"] = "Искательница Терикс"
L["Salkii"] = "Салкии"
L["Disoriented Watcher"] = "Дезориентированный дозорный"
L["Forgotten Creation"] = "Забытое творение"
L["Ancient Protector"] = "Древняя заступница"
L["Broodweaver Araznae"] = "Ткач Гнезда Аразна"
L["Phenran"] = "Фенран"
L["Unstable Arcanogolem"] = "Нестабильный чароголем"
L["Srivantor"] = "Шриванта"
L["Oshigol"] = "Ошигол"
L["Magmaton"] = "Магматон"
L["Mahg the Trampler"] = "Махг Тяжелая Поступь"
L["Spellforged Brute"] = "Магический громила"
L["Skag the Thrower"] = "Скаг Метатель"
L["Tenmod"] = "Тенмод"
L["Honmor"] = "Хонмор"
L["Liskheszaera"] = "Лискесзера"
L["Trilvarus Loreweaver"] = "Трилвара Ткач Легенд"
L["Motivator Krathos"] = "Мотиватор Кратий"
L["Grand Artificer Zeerak"] = "Главная изобретательница Зирак"
L["Gnarls"] = "Дупляк"
L["Azra's Prized Peony"] = "Любимый пион Азры"
L["Morlash"] = "Морлаш"
L["Spellforged Destroyer"] = "Магический разрушитель"
L["Arkhuu"] = "Аркхуу"
L["Overseer Stonetongue"] = "Надзирательница Камнеречь"
L["Overloading Defense Matrix"] = "Перегруженная защитная матрица"
L["Harkyn Grymstone"] = "Харкин Мрачноскал"
L["Umbrelskul"] = "Мраскул"
L["Erkhart Stormvein"] = "Эркхарт Кровь Бури"
L["Firava the Rekindler"] = "Фирава Воспламенитель"
L["Summoned Destroyer"] = "Призванный разрушитель"
L["Bisquius"] = "Бульонник"
L["Qalashi War Mammoth"] = "Боевой мамонт куалаши"
L["Battlehorn Pyrhus"] = "Пирхус Боевой Рог"
L["Lookout Mordren"] = "Караульный Мордрен"
L["Worldcarver A'tir"] = "Резчик А'тир"
L["Moskhoi"] = "Москхой"
L["Smogswog the Firebreather"] = "Рогожог Огнедышащий"
L["Death's Shadow"] = "Тень Смерти"
L["Gamgus"] = "Гамг"
L["Galnmor"] = "Галнмор"
L["Infernum"] = "Инферн"
L["Kain Firebrand"] = "Кайн Жгучее Клеймо"
L["Zenet Avis"] = "Зенет Авис"
L["Prozela Galeshot"] = "Процела Удар Урагана"
L["Ty'foon the Ascended"] = "Тай'фун Перерожденный"
L["Terillod the Devout"] = "Териллод Фанатичный"
L["Mikrin of the Raging Winds"] = "Микрин Дитя Вихрей"
L["Tempestrian"] = "Бурестриан"
L["Gaelzion"] = "Шторморон"
L["Pipspark Thundersnap"] = "Искрописк Громошлепс"
L["Karantun"] = "Карантун"
L["Voraazka"] = "Вораазка"
L["Wyrmslayer Angvardi"] = "Ангварди Убийца Змеев"
L["Ookbeard"] = "Укобород"
L["Volcanakk"] = "Вулканакк"
L["Lady Shaz'ra"] = "Леди Шаз'ра"
L["Blue Terror"] = "Синий Ужас"
L["Pyrachniss"] = "Пирахнисс"
L["Shardwing"] = "Шипокрыл"
            
L["Elemental Storms"] = "Буря Стихии"

-- 10.1 rare spawns
L["Alcanon"] = "Алканон"
L["Colossian"] = "Колоссиан"
L["Flowfy"] = "Жарик"
L["Karokta"] = "Карокта"
L["Kob'rok"] = "Коб'рок"
L["Viridian King"] = "Изумрудный король"
L["Invoq"] = "Инвок"
L["Emberdusk"] = "Углемрак"
L["Skornak"] = "Скорнак"
L["Dinn"] = "Динн"
L["General Zskorro"] = "Генерал Зкорро"
L["Subterrax"] = "Подземарк"
L["Spinmarrow"] = "Костеплет"
L["Kapraku"] = "Капраку"
L["Magtembo"] = "Магтембо"
L["Goopal"] = "Жижек"
L["Professor Gastrinax"] = "Профессор Гастринакс"

-- 10.2 rares
L["Matriarch Keevah"] = "Матриарх Кива"
L["Ristar the Rabid"] = "Ристар Бешеный"
L["Keen-eyed Cian"] = "Зоркий Циан"
L["Moragh the Slothful"] = "Морагх Ленивец"
L["Talthonei Ashwhisper"] = "Талтоней Шепот Пепла"
L["Mosa Umbramane"] = "Моза Темношкурый"

-- bosses
-- [Automatically datamined from Encounter Journal in enus.lua]

-- dungeon / raid trash
L["Pusillin"] = "Пузиллин"
L["Hellblaze Temptress"] = "Искусительница адского огня"

-- containers
L["Obsidian Grand Cache"] = "Великий обсидиановый тайник"
L["Forgotten Dragon Treasure"] = "Забытое сокровище драконов"
L["Decay Tainted Chest"] = "Тронутый гнилью сундук"
L["Waterlogged Bundle"] = "Промокшая котомка"
L["Smelly Trash Pile"] = "Пахучая куча мусора"
L["Somnut"] = "Снорех"
L["Pollenfused Bristlebruin Fur Sample"] = "Образец шерсти опыленного лохматого косолапа"
L["Singed Grimoire"] = "Обугленный гримуар"
L["Torn Page"] = "Оторванная страница"

-- Fyrakk
L["Disciples of Fyrakk"] = QuestUtils_GetQuestName(74775).."; "..QuestUtils_GetQuestName(75239)
QuestEventListener:AddCallback(74775, function()
	L["Disciples of Fyrakk"] = QuestUtils_GetQuestName(74775).."; "..QuestUtils_GetQuestName(75239)
end)
QuestEventListener:AddCallback(75239, function()
	L["Disciples of Fyrakk"] = QuestUtils_GetQuestName(74775).."; "..QuestUtils_GetQuestName(75239)
end)
L["Secured Shipment"] = "Защищенные ресурсы"
