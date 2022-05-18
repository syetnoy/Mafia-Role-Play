// includes
#include <abc>
#include <a_samp>
#include <a_mysql>
#include <sscanf2>
#include <dc_cmd>
#include <a_actor>
//#include <mxINI>
//#include <zcmd>
//#include <string>
#include <streamer>
#include <foreach>
#include <forveh>
//#include <audio>

// plugins
//#define public::%0(%1)														forward public %0(%1); public %0(%1)

// constants
#define SQL_HOST                                                                "localhost"
#define SQL_USER                                                                "root"
#define SQL_DB                                                                  "bad mafia rp"
#define SQL_PASS                                                                ""

// info sevrver
#define SERVER_NAME 															"Mafia Role Play"
#define SERVER_VERSION 															"Role Play"
#define SERVER_MAP            										            "San Andreas"
#define SERVER_WEBSITE 															"mafia-rp.su"
#define SERVER_WEBSITE_DONATE       									        "mafia-rp.su/donate"
#define SERVER_FORUM                										    "forum.mafia-rp.su"
#define SERVER_GROUP                  										    "vk.com/mafiarpsamp"
#define SERVER_LANGUAGE                 										"Russian"

// types of dialog
#define DSM                                                                     DIALOG_STYLE_MSGBOX
#define DSL                                                                     DIALOG_STYLE_LIST
#define DSI                                                                     DIALOG_STYLE_INPUT
#define DSP                                                                     DIALOG_STYLE_PASSWORD
#define DST																		DIALOG_STYLE_TABLIST
#define DSTH																	DIALOG_STYLE_TABLIST_HEADERS

// colors
#define RED     															    0xFF0000FF
#define REDa                                                                    0xEB1D12CC
#define YELLOW    															    0xFFFF00FF
#define BLUE         															0x0000FFFF
#define GREEN    															    0x008000FF
#define AQUA        														    0x00FFFFFF
#define WHITE        															0xFFFFFFFF
#define GRAY         															0x80808088
#define LIGHT_GRAY                                                              0x6E7F8066
#define LIME     															    0x00FF00FF
#define BLACK        															0x000000FF
#define PINK                                                                    0xFFA2FFFF
#define ORANGE                                                                  0xF47721FF
#define ADMIN_COLOR                                                             0x65FF4DFF
#define PLAYER_COLOR                                                            0xEF2E2EFF

#define PINK1                                                                   0xFFA2FFFF
#define PINK2                                                                   0xFFA2FFDD
#define PINK3                                                                   0xFFA2FFBB
#define PINK4                                                                   0xFFA2FF99
#define PINK5                                                                   0xFFA2FF77

#define WHITE1                                                                  0xFFFFFFFF
#define WHITE2                                                                  0xFFFFFFDD
#define WHITE3                                                                  0xFFFFFFBB
#define WHITE4                                                                  0xFFFFFF99
#define WHITE5                                                                  0xFFFFFF77

// colors organizations
#define COLOR_NONE                    									   	    0xFFFFFF15
#define COLOR_GOVERN                 									        0x62A382FF
#define COLOR_POLICE                      										0x0000FFFF
#define COLOR_ARMY                      										0x996633FF
#define COLOR_HOSPITAL                  										0xFF6666FF
#define COLOR_NEWS                    										    0xFF6600FF
#define COLOR_MAFIA1                    			   							0xCCFFFFFF
#define COLOR_MAFIA2                    			   							0xCCFFFFFF
#define COLOR_MAFIA3                    			   							0xCCFFFFFF
#define COLOR_MAFIA4                    			   							0xCCFFFFFF
#define COLOR_MAFIA5                    			   							0xCCFFFFFF

#define COLOR_JOB                                                               0xF4DE6FFF
#define COLOR_NRP_CHAT                                                          0xF4DF94FF
#define COLOR_MASK                                                              0x687265FF

// admin - any player
#define AdmLime                                                                 !"[{65FF4D}ADM{FFFFFF}]"
#define AdmYellow                                                               !"[{FFF050}ADM{FFFFFF}]"
#define AdmRed                                                                  !"[{FF2424}ADM{FFFFFF}]"
#define AdmNotAuthorized                                                        !"[{FF2424}ADM{FFFFFF}] Вы не авторизованы! Используйте /alogin"
#define AdmPunishRemoved                                                        !"[{65FF4D}ADM{FFFFFF}] Наказание успешно снято!"
#define AdmNotAccess                                                            !"[{FF2424}ADM{FFFFFF}] У Вас нет доступа к этой команде!"
#define AdmPlayerInMute                                                         !"[{FF2424}ADM{FFFFFF}] Игрок уже в муте!"
#define AdmPlayerInJail                                                         !"[{FF2424}ADM{FFFFFF}] Игрок уже в деморгане!"
#define AdmPlayerInBan                                                          !"[{FF2424}ADM{FFFFFF}] Игрок уже заблокирован!"
#define AdmPlayerInBanIP                                                        !"[{FF2424}ADM{FFFFFF}] Игрок уже заблокирован по IP!"
#define AdmPlayerHasntPunish                                                    !"[{FF2424}ADM{FFFFFF}] У игрока отсутствует наказание!"
#define AdmPlayerOffline                                                        !"[{FF2424}ADM{FFFFFF}] Игрок не в сети!"
#define AdmPlayerNotAuthorized                                                  !"[{FF2424}ADM{FFFFFF}] Игрок не авторизован!"
#define AdmPlayerNotInOrg                                                       !"[{FF2424}ADM{FFFFFF}] Игрок не состоит в организации!"
#define AdmPlayerIsLeader                                                       !"[{FF2424}ADM{FFFFFF}] Игрок является лидером!"
#define AdmPlayerIsNotLeader                                                    !"[{FF2424}ADM{FFFFFF}] Игрок не является лидером!"
#define AdmPlayerIsAdm                                                          !"[{FF2424}ADM{FFFFFF}] Игрок является администратором!"
#define AdmPlayerIsNotAdm                                                       !"[{FF2424}ADM{FFFFFF}] Игрок не являестя администратором!"
#define AdmAccessTeleport                                                       !"[{65FF4D}ADM{FFFFFF}] Вы успешно телепортировались!"

// self - self
#define PlayerPrefix                                                            !"[{EF2E2E}Ошибка{FFFFFF}]"
#define NotAuthorized               	                                        !"[{EF2E2E}Ошибка{FFFFFF}] Вы не авторизовались!"
#define InMute                              	                                !"[{EF2E2E}Ошибка{FFFFFF}] Вы не можете говорить и использовать некоторые команды, пока находитесь в муте!"
#define NoSuchCommand                                                           !"[{EF2E2E}Ошибка{FFFFFF}] Такой команды нет!"
#define WrongCommand                                                            !"[{EF2E2E}Ошибка{FFFFFF}] Вы неправильно ввели команду!"
#define NotAccess                                                               !"[{EF2E2E}Ошибка{FFFFFF}] У Вас нет доступа к этой команде!"
#define CantUseOnThisPlayer                                                     !"[{EF2E2E}Ошибка{FFFFFF}] Вы не можете использовать эту команду на этом игроке"
#define NotInCar                                                                !"[{EF2E2E}Ошибка{FFFFFF}] Нельзя использовать в транспорте!"
#define CantUseOnSelf                                                           !"[{EF2E2E}Ошибка{FFFFFF}] Нельзя использовать на себе!"
#define NotInOrg                                                                !"[{EF2E2E}Ошибка{FFFFFF}] Вы не состоите в организации!"
#define NotWorking                                                              !"[{EF2E2E}Ошибка{FFFFFF}] Вы не на службе!"
#define NotInJob                                                                !"[{EF2E2E}Ошибка{FFFFFF}] Вы не устроены на работу!"
#define QuestComp                                                               !"[{EF2E2E}Ошибка{FFFFFF}] Это задание уже выполено!"
#define QuestNotComp                                                            !"[{EF2E2E}Ошибка{FFFFFF}] Это задание еще не выполнено!"
#define NotLvl                                                                  !"[{EF2E2E}Ошибка{FFFFFF}] У Вас недостаточно игрового уровня!"
#define NotCash                                                                 !"[{EF2E2E}Ошибка{FFFFFF}] У Вас недостаточно денег!"
#define HaveHome                                                                !"[{EF2E2E}Ошибка{FFFFFF}] У Вас уже есть дом!"
#define HaveHotel                                                               !"[{EF2E2E}Ошибка{FFFFFF}] У Вас уже есть комната в отеле!"
#define HaveCar                                                                 !"[{EF2E2E}Ошибка{FFFFFF}] У Вас уже есть машина!"
#define HaveBiz                                                                 !"[{EF2E2E}Ошибка{FFFFFF}] У Вас уже бизнес!"
#define HaventHome                                                              !"[{EF2E2E}Ошибка{FFFFFF}] У Вас отсутствует дом!"
#define HaventHotel                                                             !"[{EF2E2E}Ошибка{FFFFFF}] У Вас отсутствует комната в отеле!"
#define HaventCar                                                               !"[{EF2E2E}Ошибка{FFFFFF}] У Вас отсутствует машина!"
#define HaventBiz                                                               !"[{EF2E2E}Ошибка{FFFFFF}] У Вас отсутствует бизнес!"

// self - any player
#define PlayerOffline                                                           !"[{EF2E2E}Ошибка{FFFFFF}] Игрок не в сети!"
#define PlayerNotAuthorized                                                     !"[{EF2E2E}Ошибка{FFFFFF}] Игрок не авторизован!"
#define PlayerFarAway                                                           !"[{EF2E2E}Ошибка{FFFFFF}] Игрок слишком далеко от Вас!"

// orgs
#define NotInGovern                                                             !"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник Правительства!"
#define NotInPolice                                                             !"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник Полицейского департамента!"
#define NotInFBI                                                                !"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник ФБР!"
#define NotInArmy                                                               !"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник Национальной гвардии!"
#define NotInHospital                                                           !"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник Центральной больницы!"
#define NotInNews                                                               !"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник Радиоцентра!"
#define NotInDriveSchool                                                        !"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник Автошколы!"
#define NotInMafia                                                              !"[{EF2E2E}Ошибка{FFFFFF}] Вы не состоите в мафии!"

// hint
#define HintPrefix                                                              !"[{8BFFF3}Подсказка{FFFFFF}]"

// security
#define SecurityPrefix                                                          !"[{F46221}Безопасность{FFFFFF}]"

// commands
#define SCM                                              			            SendClientMessage
#define SCMtA                                                                   SendClientMessageToAll
#define SPD                                                                     ShowPlayerDialog

// other
#define MAX_FAMILY                                                              1000
#define MAX_HOUSES                                                              60
#define MAX_BUISNESSES                                                          60

// reg N log
#define RegAccount                                                              "Добро пожаловать на сервер Mafia Role Play!\n\
															                	Этот аккаунт не зарегистрирован.\n\n\
															                	Логин: %s\n\
															                    Введите пароль и нажмите \"Далее\".\n\n\
															                    Примечания:\n\
															            		- Пароль чувствительный к регистру.\n\
															                	- Длина пароля от 6 до 32 символов.\n\
															                	- В пароле можно использовать символы на кириллице и латинице.\n"

#define LogAccount                                                              "Добро пожаловать на сервер Mafia Role Play!\n\
														                        Этот аккаунт уже зарегистрирован.\n\n\
														                        Логин: %s\n\
														                        Введите пароль:"

#define Time                                                                    !"Время:\nЧас: %i\nМинут: %i\nСекунд: %i"

main(){}

forward LoadInfoServer();
forward Advertisement1();
forward Advertisement2();
forward UpdatePlayedTime();
forward DeacreasingFuel();
forward UpdateSpeed(playerid);

enum adminVariables
{
	aID,
	aName[MAX_PLAYER_NAME],
	aPassword[32],
	aLVL,
	aNameRank[24],
	aRating,
	aCountBan,
	aCountWarn,
	aCountJail,
	aCountMute,
	aCountKick,
	aCountReport,
	bool:aLogged,
	aWrongPassword,
	bool:aSpectating
}

enum playerVariables
{
    pID,                                                                        // -
    pName[MAX_PLAYER_NAME],                                                     // case 28, 29
    pPassword[32],                                                              // case 30
	pRegIP[16],                                                                 // -
	pNowIP[16],                                                                 // -
	pMail[319],                                                                 // case 31, 32
    pAdmin,                                                                     // stock
    pLVL,                                                                       // stock
	pEXP,                                                                       // stock
    pCash,                                                                      // stock
    pColorName[7],                                                              // case 50
    pSex[8],                                                                    // case 80 (смена пола в больничке)
    pSkinIDColor[8],                                                            // case 81 (смена цвета кожи в больничке)
    pSkinID,                                                                    // stock
	pSpawnPlace,                                                                // case 30
    pPhoneNumber[9],                                                            // stock
    
    Float:pHeal,                                                                // save account
    Float:pArmor,                                                               // save account
    Float:pSatiety,                                                             // save account
    
    pBan,                                                                       // case 40 (окно при бане)
    pWarn,                                                                      // case 41 (окно при варне)
    pJail,                                                                      // case 42 (окно при джаиле)
    pMute,                                                                      // case 43 (окно при муте)

    pOrgID,                                                                     // case 50
    pOrgName[24],                                                               // case 50 (вошел или вышел из орг)
    pOrgRank,                                                                   // case 50
    pOrgRankName[24],                                                           // case 50
    pOrgSkin,                                                                   // case 50
    bool:pOrgWorking,                                                           // -
    pOrgReprimands,
    
    pJobID,                                                                     // case 51
    pJobName[24],                                                               // case 51 (устроился или свалил с работы)
    bool:pJobWorking,                                                           // -
    
    pFam[24],
	pFamID,
	pFamRank,
	pFamNameRank,
	
    pSpouse[MAX_PLAYER_NAME],                                                   // case 54 (женился или развелся)
    pMask,                                                                      // case 75 (после покупки вылазит окно с благодарностью о покупке)
    pRepairs,                                                                   // case 75
    pDrugs,                                                                     // stock
    
    pSkillSDPistol,                                                             // stock
    pSkillDesertEagle,
    pSkillM4A1,
    pSkillAK47,
	pSkillShotGun,
	pSkillMP5,
	pSkillUZI,
	pSkillSniper,
	pStyleFight,
	pStyleWalking,
	
	pLicAuto,
	pLicShip,
	pLicAir,
	pLicMoto,
	pLicGun,
	pMedcard,
	
	pSearchLVL,
	pPrisonTime,
	pLaw,                                                                       // stock
    pFine,                                                                      // stock
    pDrugAddiction,
    
	bool:pBankHaveCard,                                                         // stock
	pBankPassword[12],                                                          // stock
	pBankCash,                                                                  // stock
	pBankDeposit,                                                               // stock
	pCharity,                                                                   // stock
	
	pStatus[12],                                                                // stock
	pDonat,                                                                     // stock
	pQuests,                                                                    // stock
	pGuns[56],                                                                  // save account
	pPlayedTime,                                                                // save account
    pWhereKnew,                                                                 // stock
    pPromocode[32],                                                             // stock
	pReferal[32],
    
	bool:pSettingsAdminAction,
	bool:pSettingsAdd,
	bool:pSettingsBroadcast,
	bool:pSettingsOrgChat,
	bool:pSettingsFamChat,
	bool:pSettingsJobChat,
	
    bool:pLogged,
    pWrongPassword,
	bool:pInMask,
    pAFK
}

enum familyVariables
{
	famID,
	famName[MAX_PLAYER_NAME],
	famLeader[MAX_PLAYER_NAME],
	famDeputy1[MAX_PLAYER_NAME],
	famDeputy2[MAX_PLAYER_NAME],
	famDeputy3[MAX_PLAYER_NAME],
	famSpawn,
	famCash,
	famDrugs
}

enum houseVariables
{
	hID,
	hType[32],
	hPrice,
	hOwner[MAX_PLAYER_NAME],
	hName[64],
	hPaying,
	bool:hGarage,
	hGarageCount,
	hGarageInterior,
	bool:hBasement,
	hBasementInterior,
	bool:hDoor,
	hDeputy[MAX_PLAYER_NAME],
	bool:hFamily,
	hFamilyName[MAX_PLAYER_NAME]
}

enum buisnessVariables
{
	bID,
	bType,
	bPrice,
	Float:bPosition,
	bOwner[MAX_PLAYER_NAME],
	bName[64],
	bPaying,
	bInterior,
	bPriceForEnter,
	bFamilyForSale,
	bDoor
}

enum orgVariables
{
	oID,
	oName[32],
	oLeader,
	oBalance,
	oProducts1,
	oProducts2,
	oProducts3,
	bool:oWarehouse // only for mafia
}

enum vehicleVariables
{
	bool:vEngine,
	bool:vLights,
	bool:vAlarm,
	bool:vDoors,
	bool:vBonnet,
	bool:vBoot,
	bool:vObjective,
	
	bool:vLock,
 	bool:vTurnLeft,
 	bool:vTurnRight,
 	vLeftID1,
 	vLeftID2,
 	vRightID1,
 	vRightID2,

	vFuel=80,
	vMilliage,
	Float:vX,
	Float:vY,
	Float:vZ
}

enum
{
	iPass,
	iAidKit,
	iRemKit,
	iPhone
}

enum Items
{
	objID,
	objName[16]
}

enum CityDistrictsInfo
{
    distName[50],
    Float:distPos[6]
}

new CityDistricts[][CityDistrictsInfo] =
{
	{"The Big Ear",                 {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

/*new Inventory[][Items] =
{
	{1581,"Паспорт"},
	{11738,"Аптечка"},
	{1650,"Канистра"},
	{18874,"Телефон"},
	{1854,"Фишка"}
};*/

/*
// jobs
new
	aTaxi[10],
	aBus[10],
	aMechanic[8],
	aTruck[6],
	
	aPizza[6],
	pizzaPoints[20][3] = {
	{1228.8202,2584.9231,10.8203},
	{1608.6163,2750.2510,10.8203},
	{1703.6362,2692.5605,10.8203},
	{1992.7838,2760.9783,10.8203},
	{2017.8778,2663.0161,10.8203},
	{2628.8142,2347.7148,10.6719},
	{2794.3611,2262.7261,10.8203},
	{2787.9570,2227.7034,14.6615},
	{2819.4719,2140.7395,10.8203},
	{2372.2632,2165.8560,10.8285},
	{2464.1101,2241.8542,10.8203},
	{2127.7043,2375.9675,10.8203},
	{1367.3596,2006.8068,11.4609},
	{1311.9127,1935.6104,11.4609},
	{1955.1624, 671.5222,14.2732},
	{1922.7615, 740.2113,10.8203},
	{2043.0139, 693.0547,11.4531},
	{2227.4226, 652.5236,11.4609},
	{2448.6462, 712.9528,11.4683},
	{2235.1638,1285.7783,10.8203}},
	
	aTracher[6];

// rent
new
	aRentCar[20];

// organizations
new
	aHospital[6],
	aPolice[6],
	aFBI[6],
	aArmy[6],
	aNews[6],
	aDriveSchool[6],
	aGovern[6],
	aMafia1[6],
	aMafia2[6],
	aMafia3[6],
	aMafia4[6],
	aMafia5[6];

*/
/*new
	orgGovernment[orgVariables],
	orgFBI[orgVariables],
	orgPolice[orgVariables],
	orgArmy[orgVariables],
	orgHospital[orgVariables];
*/
new Months[12][11] =
{
	{1,"january"},
	{2,"february"},
	{3,"march"},
	{4,"april"},
	{5,"may"},
	{6,"june"},
	{7,"jule"},
	{8,"august"},
	{9,"september"},
	{10,"october"},
	{11,"november"},
	{12,"december"}
};

/*new zones[3][6] =
{
	{"Mafia | Стоунхендж",-1348,2486,-1273,2562,0xFF0000FF},
	{"Mafia | Ухо",-406,1506,-277,1627,0xFF0000FF},
	{"Армия",-25,1677,443,2113,0x00FF00FF}
};*/
new playerVariable[MAX_PLAYERS][playerVariables];
new adminVariable[MAX_PLAYERS][adminVariables];
//new familyVariable[MAX_PLAYERS][familyVariables];
//new houseVariable[MAX_PLAYERS][houseVariables];
//new buisnessVariable[MAX_PLAYERS][buisnessVariables];
new vehicleVariable[MAX_VEHICLES][vehicleVariables];
//new itemVariable[MAX_PLAYERS][sizeof Inventory];
//new itemPlayerNow[MAX_PLAYERS][sizeof Inventory];





////////////////////////////////////////////////////////////////////////////////

// M Y   S Q L

////////////////////////////////////////////////////////////////////////////////

new MySQL:DATABASE,
    ServerName[32],
	ServerSite[32],
	ServerLangue[11],
	ServerNum[5],
	ServerClient[7],
	ServerMap[11];

////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////

//		T		R		A		N		S		P		O		R		T

////////////////////////////////////////////////////////////////////////////////

new VehGovern[10];
new VehKarts[10];




////////////////////////////////////////////////////////////////////////////////

// P R I C E S

////////////////////////////////////////////////////////////////////////////////

new orgSalary[9][10] =
{
	{0,0,0,0,0,0,0,0,0,0},														// None
	{5000,6000,7000,8000,9000,10000,11000,12000,13000,15000},                   // Government
	{8000,9000,10000,11000,12000,13000,14000,15000,16000,20000},                // FBI
	{7000,8000,9000,10000,11000,12000,13000,14000,15000,16000},                 // Police
	{5000,6000,7000,8000,9000,10000,11000,12000,13000,15000},                   // Army
	{5000,6000,7000,8000,9000,10000,11000,12000,13000,15000},                   // Hospital
	{5000,6000,7000,8000,9000,10000,11000,12000,13000,15000},                   // Radiocenter
	{5000,6000,7000,8000,9000,10000,11000,12000,13000,15000},                   // DriveSchool
	{5000,6000,7000,8000,9000,10000,11000,12000,13000,15000}                    // Mafia
};

#define FUEL_IN_CAR                                                             60

#define PRICE_TICKET_BUS                                                        500
#define PRICE_1KM_TAXI                                                          250
#define PRICE_1KG_TRASH                                                         400
#define PRICE_1_PIZZA                                                           350
#define PRICE_1_COLLECTOR                                                       2500

#define PRICE_ORG_FRENCH_FRIES                                                  500
#define PRICE_ORG_BURGER                                                        750
#define PRICE_ORG_PIZZA                                                         1000

#define PRICE_HEAL                                                              2000
#define PRICE_CURE_DRUG_ADDICTION                                               5000
#define PRICE_CHANGESEX                                                         30000
#define PRICE_MEDCARD                                                           1000

////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////

// O T H E R

////////////////////////////////////////////////////////////////////////////////

new bool:onCheckpoint[MAX_PLAYERS][10];
new PlayerText:PreviewIcon[MAX_PLAYERS];
new tmpobjid,rows;
new zone1,zone2,zone3;
new PICKUPS[100];
new string[256],query[128];

#define DISTANCE_BETWEEN_PLAYERS                                                10.0

new string_MENU[512] = "1. Статистика\n2. Навыки персонажа\n3. Помощь администрации\n4. Команды сервера\n5. Настройки";
new string_GPS[512] = "1. Важные места\n2. Государственные организации\n3. Нелегальные организации\n4. По работе\n5. Развлечения \
\n6. Поиск ближайшего магазина 24/7\n7. Поиск ближайшей АЗС\n8. Поиск ближайшей закусочной\n9. Поиск ближайшейшего отеля \
\n10. Поиск ближайшего терминала\n11. Выключить навигатор";
new string_DIR[128] = "1. О проекте\n2. Телефонная книга\n3. Важные номера\n4. Мои заметки\n5. Адвокаты";
new string_LMENU[128] = "1. Статистика организации\n2. Члены организации онлайн\n3. Члены организации оффлайн \
\n4. \n5. ";
new string_ORG_FOOD[64] = "1. Картошка фри\n2. Бургер\n3. Пицца";
new string_CMENU[256] = "Действие\tСтатус\n1. Завести/заглушить двигатель\t%b\n2. Открыть/закрыть капот\t%b \
\n3. Открыть/закрыть багажник\t%b\n4. Включить/выключить фары\t%b";
new string_FORM_UNPUT[128] = "Вы действительно хотите снять работчую форму?";
new string_FORM_PUT[128] = "Вы действительно хотите одеть рабочую форму?";

new Text:SBox;
new Text:SBox1;
new PlayerText:CarSpeed[MAX_PLAYERS];
new PlayerText:CarFuel[MAX_PLAYERS];
new PlayerText:CarMilliage[MAX_PLAYERS];
new PlayerText:CarLights[MAX_PLAYERS];
new PlayerText:CarEngine[MAX_PLAYERS];
new SpeedTimer[MAX_PLAYERS];

////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////

// F U N C T I O N S

////////////////////////////////////////////////////////////////////////////////

stock ConnectMySQL()
{
    mysql_connect(SQL_HOST,SQL_USER,SQL_DB,SQL_PASS);
    switch(mysql_ping())
    {
    	case 1: print("MySQL connected.");
     	case -1: print("MySQL did not connect.");
    }
   	return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock DisconnectMySQL()
{
	mysql_close();
    print("MySQL connection closed.");
}

////////////////////////////////////////////////////////////////////////////////

stock CheckMySQLConnection()
{
    if(mysql_ping() == -1) mysql_reconnect();
    print("MySQL reconnecting..");
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock CreateAccount(playerid,password[])
{
	print("CreateAccount - Начало создания аккаунта..");
    new IP[16];
	GetPlayerIp(playerid,IP,16);
	
    format(query,sizeof(query),"INSERT INTO `account` (`NickName`, `Password`, `RegIP`) VALUES ('%s', '%s', '%s')",
	playerVariable[playerid][pName],password,IP);
    mysql_tquery(MySQL:DATABASE,query);
	
    print("CreateAccount - Аккаунт добавлен в БД");
    format(query,sizeof(query),"SELECT * FROM `account` WHERE `NickName` = '%s' AND `Password` = '%s' LIMIT 1",playerVariable[playerid][pName],password);
    mysql_query(MySQL:DATABASE,query);
    cache_get_value_name_int(0,"ID",playerVariable[playerid][pID]);
    printf("%i",playerVariable[playerid][pID]);
    
    format(query,sizeof(query),"INSERT INTO `inventory` (`ID`, `NickName`) VALUES ('%i', '%s')",
	playerVariable[playerid][pID],playerVariable[playerid][pName]);
	mysql_tquery(MySQL:DATABASE,query);
	
    LoadPlayerVariables(playerid);
    new r = 1000+random(2000);
    playerVariable[playerid][pCash] = r;
    playerVariable[playerid][pLogged] = true;
    
    SetPlayerScore(playerid,playerVariable[playerid][pLVL]);
    GivePlayerMoney(playerid,playerVariable[playerid][pCash]);
    SetPlayerSkin(playerid,playerVariable[playerid][pSkinID]);
    SetPlayerColor(playerid,playerVariable[playerid][pColorName]);
    
    print("CreateAccount - Аккаунт создан!");
    print("CreateAccount - Игрок авторизован");
    SCM(playerid,WHITE,!"Вы успешно зарегестрировались!");
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock LoadAccount(playerid,password[])
{
	print("LoadAccount - Начало загрузки аккаунта..");
    new row_count,
		nowIP[16];
    format(query,sizeof(query),"SELECT * FROM `account` WHERE `ID` = '%i' AND `NickName` = '%s' AND `Password` = '%s'",
	playerVariable[playerid][pID],playerVariable[playerid][pName],password);
 	mysql_query(MySQL:DATABASE,query);
    print("LoadAccount - Запрос обработан");
    if(cache_get_row_count(row_count)==1)
	{
	    print("LoadAccount - Аккаунт найден!");
	    GetPlayerIp(playerid,nowIP,16);
        LoadPlayerVariables(playerid);
        playerVariable[playerid][pLogged] = true;
        strmid(playerVariable[playerid][pNowIP],nowIP,0,16,16);
        
        if(playerVariable[playerid][pAdmin]>0)
		{
		    new query2[128],
				row_count2;
		    format(query2,sizeof(query2),"SELECT * FROM `admins` WHERE `NickName` = '%s' LIMIT 1",playerVariable[playerid][pName]);
		    mysql_query(MySQL:DATABASE,query2);
		    if(cache_get_row_count(row_count2)==1) LoadAdminVariables(playerid);
		}
        SetPlayerScore(playerid,playerVariable[playerid][pLVL]);
        GivePlayerMoney(playerid,playerVariable[playerid][pCash]);
        SetPlayerSkin(playerid,playerVariable[playerid][pSkinID]);
        SetPlayerHealth(playerid,playerVariable[playerid][pHeal]);
        SetPlayerArmour(playerid,playerVariable[playerid][pArmor]);
        
        print("LoadAccount - Игрок авторизован");
        SCM(playerid,WHITE,!"Вы успешно авторизовались!");
        SCM(playerid,WHITE,!"Приятной игры на Mafia Role Play!");
        return 1;
    }
    else print("LoadAccount - Аккаунт не найден!");
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock SaveAccount(playerid)
{
	print("SaveAccount - Начало сохранения аккаунта..");
    if(playerVariable[playerid][pLogged]==true)
    {
        GetPlayerHealth(playerid,playerVariable[playerid][pHeal]);
        GetPlayerArmour(playerid,playerVariable[playerid][pArmor]);
        new guns[13][2];
        for(new i;i<13;i++) GetPlayerWeaponData(playerid,i,guns[i][0],guns[i][1]);
        print("SaveAccount - Игрок авторизован");
        format(query,sizeof(query),"UPDATE `account` SET `Heal` = '%i', `Armor` = '%i', `Satiety` = '%i', `PlayedTime` = `PlayedTime` + '%i', `Guns` = '%s' WHERE `ID` = '%i'",
		playerVariable[playerid][pHeal],playerVariable[playerid][pArmor],playerVariable[playerid][pSatiety],playerVariable[playerid][pPlayedTime],
		guns,playerVariable[playerid][pID]);
		mysql_tquery(MySQL:DATABASE,query);
        print("SaveAccount - Запрос на сохранения отправлен");
    }
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock RemovePlayerVariables(playerid)
{
	print("RemovePlayerVariables - Начало удаления переменных..");
 	playerVariable[playerid][pID] = 0;
    playerVariable[playerid][pWrongPassword] = 0;
    playerVariable[playerid][pLogged] = false;
	print("RemovePlayerVariables - Переменные удалены");
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock CheckAccount(playerid)
{
	print("CheckAccount - Начало получения глобального ИД игрока по нику..");
    new row_count = 0;
	printf("CheckAccount - Ник игрока %s",playerVariable[playerid][pName]);
    format(query,sizeof(query),"SELECT * FROM `account` WHERE `NickName` = '%s' LIMIT 1",playerVariable[playerid][pName]);
    mysql_query(MySQL:DATABASE,query);
    print("CheckAccount - Запрос отправлен");
    if(cache_get_row_count(row_count))
	{
	    format(query,sizeof(query),"SELECT * FROM `account` WHERE `NickName` = '%s' LIMIT 1",playerVariable[playerid][pName]);
	    mysql_tquery(MySQL:DATABASE,query);
	    cache_get_value_name_int(0,"ID",playerVariable[playerid][pID]);
	    cache_get_value_name(0,"Password",playerVariable[playerid][pPassword],32);
	    cache_get_value_name_int(0,"Admin",playerVariable[playerid][pAdmin]);
        printf("CheckAccount - Игрок получил свой глобальный ИД");
        return playerVariable[playerid][pID];
    }
	playerVariable[playerid][pID] = 0;
	playerVariable[playerid][pPassword] = EOS;
    printf("GET GLOBAL ID - АКК НЕ НАЙДЕН, %i",row_count);
    return 0;
}

////////////////////////////////////////////////////////////////////////////////

stock GetPlayerIDFromName(nameID[])
{
    foreach(new i:Player)
    {
        if(!IsPlayerConnected(i)) continue;
        new NickName[MAX_PLAYER_NAME];
        GetPlayerName(i,NickName,sizeof(NickName));
        if(strcmp(NickName,nameID,false)==0) return i;
    }
    return INVALID_PLAYER_ID;
}

////////////////////////////////////////////////////////////////////////////////

stock LoadPlayerVariables(playerid)
{
	new time_loadvar = GetTickCount();
	print("LoadVariables - Начало активации переменных..");
    cache_get_value_name_int(0,"ID",playerVariable[playerid][pID]);
    cache_get_value_name(0,"NickName",playerVariable[playerid][pName],24);
    cache_get_value_name(0,"Password",playerVariable[playerid][pPassword],32);
    cache_get_value_name(0,"RegIP",playerVariable[playerid][pRegIP],16);
    cache_get_value_name(0,"Mail",playerVariable[playerid][pMail],32);
    cache_get_value_name_int(0,"Admin",playerVariable[playerid][pAdmin]);
    cache_get_value_name_int(0,"LVL",playerVariable[playerid][pLVL]);
    cache_get_value_name_int(0,"EXP",playerVariable[playerid][pEXP]);
    cache_get_value_name_int(0,"Cash",playerVariable[playerid][pCash]);
    cache_get_value_name(0,"ColorName",playerVariable[playerid][pColorName],7);
    cache_get_value_name(0,"Sex",playerVariable[playerid][pSex],8);
    cache_get_value_name(0,"SkinColor",playerVariable[playerid][pSkinIDColor],8);
    cache_get_value_name_int(0,"Skin",playerVariable[playerid][pSkinID]);
    cache_get_value_name_int(0,"SpawnPoint",playerVariable[playerid][pSpawnPlace]);
    cache_get_value_name(0,"PhoneNumber",playerVariable[playerid][pPhoneNumber],12);
    cache_get_value_name_float(0,"Heal",playerVariable[playerid][pHeal]);
    cache_get_value_name_float(0,"Armor",playerVariable[playerid][pArmor]);
    cache_get_value_name_float(0,"Satiety",playerVariable[playerid][pSatiety]);
    cache_get_value_name_int(0,"Fine",playerVariable[playerid][pFine]);
    cache_get_value_name(0,"OrgName",playerVariable[playerid][pOrgName],24);
    cache_get_value_name_int(0,"OrgID",playerVariable[playerid][pOrgID]);
    cache_get_value_name(0,"RankName",playerVariable[playerid][pOrgRankName],24);
    cache_get_value_name_int(0,"Rank",playerVariable[playerid][pOrgRank]);
    cache_get_value_name_int(0,"OrgSkin",playerVariable[playerid][pOrgSkin]);
    cache_get_value_name_int(0,"JobID",playerVariable[playerid][pJobID]),
    cache_get_value_name(0,"Job",playerVariable[playerid][pJobName],24);
    cache_get_value_name(0,"Spouse",playerVariable[playerid][pSpouse],24);
    cache_get_value_name_int(0,"Mask",playerVariable[playerid][pMask]);
    cache_get_value_name_int(0,"Repairs",playerVariable[playerid][pRepairs]);
    cache_get_value_name_int(0,"Drugs",playerVariable[playerid][pDrugs]);
    cache_get_value_name_int(0,"SkillSDPistol",playerVariable[playerid][pSkillSDPistol]);
    cache_get_value_name_int(0,"SkillDesertEagle",playerVariable[playerid][pSkillDesertEagle]);
    cache_get_value_name_int(0,"SkillM4A1",playerVariable[playerid][pSkillM4A1]);
    cache_get_value_name_int(0,"SkillAK47",playerVariable[playerid][pSkillAK47]);
    cache_get_value_name_int(0,"SkillShotGun",playerVariable[playerid][pSkillShotGun]);
    cache_get_value_name_int(0,"SkillMP5",playerVariable[playerid][pSkillMP5]);
    cache_get_value_name_int(0,"SkillUZI",playerVariable[playerid][pSkillUZI]);
    cache_get_value_name_int(0,"SkillSniper",playerVariable[playerid][pSkillSniper]);
    cache_get_value_name(0,"LicAuto",playerVariable[playerid][pLicAuto],12);
    cache_get_value_name(0,"LicShip",playerVariable[playerid][pLicShip],12);
    cache_get_value_name(0,"LicAir",playerVariable[playerid][pLicAir],12);
    cache_get_value_name(0,"LicMoto",playerVariable[playerid][pLicMoto],12);
    cache_get_value_name(0,"LicGun",playerVariable[playerid][pLicGun],12);
    cache_get_value_name(0,"Medcard",playerVariable[playerid][pMedcard],12);
    cache_get_value_name_int(0,"Law",playerVariable[playerid][pLaw]);
    cache_get_value_name_bool(0,"BankHaveCard",playerVariable[playerid][pBankHaveCard]);
    cache_get_value_name(0,"BankPassword",playerVariable[playerid][pBankPassword],12);
    cache_get_value_name_int(0,"BankCash",playerVariable[playerid][pBankCash]);
    cache_get_value_name_int(0,"BankDeposit",playerVariable[playerid][pBankDeposit]);
    cache_get_value_name_int(0,"Charity",playerVariable[playerid][pCharity]);
    cache_get_value_name(0,"Status",playerVariable[playerid][pStatus],12);
    cache_get_value_name_int(0,"Donat",playerVariable[playerid][pDonat]);
    cache_get_value_name_int(0,"Quests",playerVariable[playerid][pQuests]);
    cache_get_value_name(0,"Guns",playerVariable[playerid][pGuns],56);
    cache_get_value_name_int(0,"PlayedTime",playerVariable[playerid][pPlayedTime]);
    cache_get_value_name_int(0,"WhereKnew",playerVariable[playerid][pWhereKnew]);
    cache_get_value_name(0,"Promocode",playerVariable[playerid][pPromocode],32);
    cache_get_value_name_bool(0,"SettingsAdminAction",playerVariable[playerid][pSettingsAdminAction]);
    cache_get_value_name_bool(0,"SettingsAdd",playerVariable[playerid][pSettingsAdd]);
    cache_get_value_name_bool(0,"SettingsBroadcast",playerVariable[playerid][pSettingsBroadcast]);
    cache_get_value_name_bool(0,"SettingsOrgChat",playerVariable[playerid][pSettingsOrgChat]);
    cache_get_value_name_bool(0,"SettingsOrgFam",playerVariable[playerid][pSettingsFamChat]);
    cache_get_value_name_bool(0,"SettingsJobChat",playerVariable[playerid][pSettingsJobChat]);
    cache_get_value_name(0,"Fam",playerVariable[playerid][pFam],24);
    cache_get_value_name_int(0,"FamID",playerVariable[playerid][pFamID]);
    cache_get_value_name_int(0,"FamRank",playerVariable[playerid][pFamRank]);
    cache_get_value_name(0,"FamNameRank",playerVariable[playerid][pFamNameRank],24);
    print("LoadVariables - Переменные загружены.");
    printf("Загрузка аккаунта: <%i> сек",GetTickCount()-time_loadvar);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock LoadAdminVariables(playerid)
{
	cache_get_value_name_int(0,"ID",adminVariable[playerid][aID]);
	cache_get_value_name(0,"NickName",adminVariable[playerid][aName],24);
	cache_get_value_name(0,"Password",adminVariable[playerid][aPassword],32);
	cache_get_value_name_int(0,"LVL",adminVariable[playerid][aLVL]);
	cache_get_value_name(0,"NameRank",adminVariable[playerid][aNameRank],24);
	cache_get_value_name_int(0,"Rating",adminVariable[playerid][aRating]);
	cache_get_value_name_int(0,"CountBan",adminVariable[playerid][aCountBan]);
	cache_get_value_name_int(0,"CountWarn",adminVariable[playerid][aCountWarn]);
	cache_get_value_name_int(0,"CountJail",adminVariable[playerid][aCountJail]);
	cache_get_value_name_int(0,"CountMute",adminVariable[playerid][aCountMute]);
	cache_get_value_name_int(0,"CountKick",adminVariable[playerid][aCountKick]);
	cache_get_value_name_int(0,"CountReport",adminVariable[playerid][aCountReport]);
}

////////////////////////////////////////////////////////////////////////////////
























////////////////////////////////////////////////////////////////////////////////

stock ProxDetector(playerid,Float:radius,str[],color1,color2,color3,color4,color5)
{
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(playerid,X,Y,Z);
    foreach(new i:Player)
    {
		if(GetPlayerVirtualWorld(playerid)==GetPlayerVirtualWorld(i))
		{
			new Float:position = GetPlayerDistanceFromPoint(i,X,Y,Z);
			if(position>radius) continue;
  			if(position<(radius/5)*1)
  			{
  				SCM(i,color1,str);
  				print("1");
			  	continue;
			}
			else if(position<(radius/5)*2)
			{
			  	SCM(i,color2,str);
			  	print("2");
			  	continue;
			}
			else if(position<(radius/5)*3)
			{
			  	SCM(i,color3,str);
			  	print("3");
			  	continue;
			}
			else if(position<(radius/5)*4)
			{
			  	SCM(i,color4,str);
			  	print("4");
			  	continue;
			}
			else if(position<(radius/5)*5)
			{
			  	SCM(i,color5,str);
			  	print("5");
			  	continue;
			}
		}
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock CreateGlobalTextDraws()
{
	SBox = TextDrawCreate(626.0,384.54,"usebox");
	TextDrawLetterSize(SBox,0.0,5.9);
	TextDrawTextSize(SBox,430.8,0.0);
	TextDrawAlignment(SBox,1);
	TextDrawColor(SBox,0);
	TextDrawUseBox(SBox,true);
	TextDrawBoxColor(SBox,102);
	TextDrawSetShadow(SBox,0);
	TextDrawSetOutline(SBox,0);
	TextDrawFont(SBox,0);

	SBox1 = TextDrawCreate(601.875,383.2,"LD_SPAC:white");
	TextDrawLetterSize(SBox1,0.0,0.0);
	TextDrawTextSize(SBox1,21.25,57.16);
	TextDrawAlignment(SBox1,1);
	TextDrawColor(SBox1,255);
	TextDrawSetShadow(SBox1,0);
	TextDrawSetOutline(SBox1,0);
	TextDrawFont(SBox1,4);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

stock CreatePlayersTextDraw(playerid)
{
    CarSpeed[playerid] = CreatePlayerTextDraw(playerid,442.4,386.026580,"SPEED: 100");
    PlayerTextDrawLetterSize(playerid,CarSpeed[playerid],0.401249,1.430832);
    PlayerTextDrawAlignment(playerid,CarSpeed[playerid],1);
    PlayerTextDrawColor(playerid,CarSpeed[playerid],-1);
    PlayerTextDrawSetShadow(playerid,CarSpeed[playerid],0);
    PlayerTextDrawSetOutline(playerid,CarSpeed[playerid],1);
    PlayerTextDrawBackgroundColor(playerid,CarSpeed[playerid],51);
    PlayerTextDrawFont(playerid,CarSpeed[playerid],1);
    PlayerTextDrawSetProportional(playerid,CarSpeed[playerid],1);

    CarFuel[playerid] = CreatePlayerTextDraw(playerid, 442.149963, 401.026672, "FUEL: 1000");
    PlayerTextDrawLetterSize(playerid,CarFuel[playerid],0.401249,1.430832);
    PlayerTextDrawAlignment(playerid,CarFuel[playerid],1);
    PlayerTextDrawColor(playerid,CarFuel[playerid],-1);
    PlayerTextDrawSetShadow(playerid,CarFuel[playerid],0);
    PlayerTextDrawSetOutline(playerid,CarFuel[playerid],1);
    PlayerTextDrawBackgroundColor(playerid,CarFuel[playerid],51);
    PlayerTextDrawFont(playerid,CarFuel[playerid],1);
    PlayerTextDrawSetProportional(playerid,CarFuel[playerid],1);

    CarMilliage[playerid] = CreatePlayerTextDraw(playerid,441.899963,416.610015,"MILLIAGE: 10000");
    PlayerTextDrawLetterSize(playerid,CarMilliage[playerid],0.401249,1.430832);
    PlayerTextDrawAlignment(playerid,CarMilliage[playerid],1);
    PlayerTextDrawColor(playerid,CarMilliage[playerid],-1);
    PlayerTextDrawSetShadow(playerid,CarMilliage[playerid],0);
    PlayerTextDrawSetOutline(playerid,CarMilliage[playerid],1);
    PlayerTextDrawBackgroundColor(playerid,CarMilliage[playerid],51);
    PlayerTextDrawFont(playerid,CarMilliage[playerid],1);
    PlayerTextDrawSetProportional(playerid,CarMilliage[playerid],1);

    CarLights[playerid] = CreatePlayerTextDraw(playerid,608.125000,386.166625,"L");
    PlayerTextDrawLetterSize(playerid,CarLights[playerid],0.449999,1.600000);
    PlayerTextDrawAlignment(playerid,CarLights[playerid],1);
    PlayerTextDrawColor(playerid,CarLights[playerid],-1);
    PlayerTextDrawSetShadow(playerid,CarLights[playerid],0);
    PlayerTextDrawSetOutline(playerid,CarLights[playerid],1);
    PlayerTextDrawBackgroundColor(playerid,CarLights[playerid],51);
    PlayerTextDrawFont(playerid,CarLights[playerid],1);
    PlayerTextDrawSetProportional(playerid,CarLights[playerid],1);

    CarEngine[playerid] = CreatePlayerTextDraw(playerid,609.125000,413.416778,"E");
    PlayerTextDrawLetterSize(playerid,CarEngine[playerid],0.449999,1.600000);
    PlayerTextDrawAlignment(playerid,CarEngine[playerid],1);
    PlayerTextDrawColor(playerid,CarEngine[playerid],-1);
    PlayerTextDrawSetShadow(playerid,CarEngine[playerid],0);
    PlayerTextDrawSetOutline(playerid,CarEngine[playerid],1);
    PlayerTextDrawBackgroundColor(playerid,CarEngine[playerid],51);
    PlayerTextDrawFont(playerid,CarEngine[playerid],1);
    PlayerTextDrawSetProportional(playerid,CarEngine[playerid],1);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock SpeedVehicle(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]),2.0)+floatpower(floatabs(ST[1]),2.0)+floatpower(floatabs(ST[2]),2.0))*100.3;
    return floatround(ST[3]);
}

////////////////////////////////////////////////////////////////////////////////

static stock ClearVehicle(vehicleid)
{
	vehicleVariable[vehicleid][vEngine]=false;
	vehicleVariable[vehicleid][vLights]=false;
	vehicleVariable[vehicleid][vAlarm]=false;
	vehicleVariable[vehicleid][vDoors]=false;
	vehicleVariable[vehicleid][vBonnet]=false;
	vehicleVariable[vehicleid][vBoot]=false;
	vehicleVariable[vehicleid][vObjective]=false;
	vehicleVariable[vehicleid][vFuel]=FUEL_IN_CAR;
	vehicleVariable[vehicleid][vTurnLeft]=false;
	vehicleVariable[vehicleid][vTurnRight]=false;
	vehicleVariable[vehicleid][vLeftID1]=EOS;
	vehicleVariable[vehicleid][vLeftID2]=EOS;
	vehicleVariable[vehicleid][vRightID1]=EOS;
	vehicleVariable[vehicleid][vRightID2]=EOS;
	SetVehicleParams(vehicleid);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock Float:SBetweenPlayers(playerid1,playerid2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid1,x1,y1,z1);
	GetPlayerPos(playerid2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

////////////////////////////////////////////////////////////////////////////////

static stock SaveVariableInteger(table[],column[],variable,ID)
{
	format(query,sizeof(query),"UPDATE `%s` SET `%s` = '%i' WHERE `ID` = '%i'",table,column,variable,ID);
	mysql_tquery(MySQL:DATABASE,query);
	printf("%s",query);
}

////////////////////////////////////////////////////////////////////////////////

static stock SaveVariableString(table[],column[],variable,ID)
{
	format(query,sizeof(query),"UPDATE `%s` SET `%s` = '%s' WHERE `ID` = '%i'",table,column,variable,ID);
	mysql_tquery(MySQL:DATABASE,query);
}

////////////////////////////////////////////////////////////////////////////////

static stock AdminAction(admin[],action[])
{
	format(query,sizeof(query),"INSERT INTO `logs_admin` (`Admin`, `Action`) VALUES ('%s', '%s')",admin,action);
	mysql_tquery(MySQL:DATABASE,query);
	printf("%s",query);
}

////////////////////////////////////////////////////////////////////////////////

static stock CheckString(string1[],string2[])
{
	return !strcmp(string1,string2,false);
}

////////////////////////////////////////////////////////////////////////////////

static stock StringReplace(inputvar[],const searchstring[],const replacestring[],bool:ignorecase=true,bool:replaceall=false)
{
	if(strfind(replacestring,searchstring,ignorecase)!=-1) return -1;
	new pos=strfind(inputvar,searchstring,ignorecase);
	if(pos==-1) return 0;
	if(replaceall==true)
	{
		while(strfind(inputvar,searchstring,ignorecase)!=-1)
		{
			pos = strfind(inputvar,searchstring,ignorecase);
			strdel(inputvar,pos,pos+strlen(searchstring));
			strins(inputvar,replacestring,pos,strlen(inputvar));
		}
	}
	else
	{
		strdel(inputvar,pos,pos+strlen(searchstring));
		strins(inputvar,replacestring,pos,strlen(inputvar));
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock GetEXP(playerid,plusEXP)
{
	format(string,sizeof(string),"Вы получили очков опыта: %i",plusEXP);
	SCM(playerid,WHITE,string);
	playerVariable[playerid][pEXP]+=plusEXP;
	SaveVariableInteger("account","EXP",playerVariable[playerid][pEXP],playerVariable[playerid][pID]);
	if(playerVariable[playerid][pEXP]>=((playerVariable[playerid][pLVL]+1)*2))
	{
	    playerVariable[playerid][pLVL]+=1;
	    playerVariable[playerid][pEXP]=0;
	    SaveVariableInteger("account","LVL",playerVariable[playerid][pLVL],playerVariable[playerid][pID]);
        SaveVariableInteger("account","EXP",0,playerVariable[playerid][pID]);
	    format(string,sizeof(string),"Поздравляем! Вы достигли нового %i-ого уровня!",playerVariable[playerid][pLVL]);
		SCM(playerid,WHITE,string);
		SetPlayerScore(playerid,playerVariable[playerid][pLVL]);
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////

static stock GetNow(what)
{
	if(what==1)
	{
	    new year,month,day,getnow_date[128];
	    getdate(year,month,day);
        format(getnow_date,sizeof(getnow_date),"%i %s 1972",day,Months[month - 1][1]);
        return getnow_date;
	}
 	else
	{
	    new hour,minut,second,getnow_time[128];
	    gettime(hour,minut,second);
        format(getnow_time,sizeof(getnow_time),"%i:%i:%i",hour,minut,second);
        return getnow_time;
	}
}

////////////////////////////////////////////////////////////////////////////////

static stock GetPlayerDistrict(playerid)
{
	if(!IsPlayerConnected(playerid)) return string;
	if(playerVariable[playerid][pLogged]==false) return string;
	//esli chel v inte return "[{EF2E2E}Ошибка{FFFFFF}] Игрок находится в интерьере!";
	//poluchaem place of player
	format(string,sizeof(string),"1");
	return string;
}

////////////////////////////////////////////////////////////////////////////////

static stock CheckSeniorAdm(playerid1,playerid2,const command[])
{
	if(playerVariable[playerid1][pAdmin]<=playerVariable[playerid2][pAdmin])
	{
		SCM(playerid1,WHITE,"[{FF2424}ADM{FFFFFF}] Администратор старше/равен Вам!");
		new str[128];
		format(str,sizeof(str),"[{F46221}Безопасность{FFFFFF}] Администратор %s[%i] попытался использовать команду %s на %s[%i]!",
		playerVariable[playerid1][pName],playerid1,command,playerVariable[playerid2][pName],playerid2);
		SendAdminChat(playerid1,WHITE,str,false);
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////

static stock SendToAllChatSettingAdminAction(string_color,const string_string[])
{
	foreach(new i:Player)
	{
		if(playerVariable[i][pSettingsAdminAction]==false) continue;
		SCM(i,string_color,string_string);
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock SendToAllChatSettingsAdd(string_color,const string_string1[],const string_string2[])
{
	foreach(new i:Player)
	{
		if(playerVariable[i][pSettingsAdd]==false) continue;
		SCM(i,string_color,string_string1);
		SCM(i,string_color,string_string2);
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock SendToAllChatSettingsBroadcast(string_color,const string_string[])
{
	foreach(new i:Player)
	{
		if(playerVariable[i][pSettingsBroadcast]==false) continue;
		SCM(i,string_color,string_string);
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock SendAdminChat(playerid,string_color,const string_string[],rank=1,self=true)
{
	foreach(new i:Player)
	{
		if(playerVariable[i][pAdmin]==0) continue;
		if(adminVariable[i][aLogged]==false) continue;
		if(playerVariable[i][pAdmin]<rank) continue;
		if(i==playerid && self) continue;
		SCM(i,string_color,string_string);
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock SendDepartamentChat(string_color,const string_string[])
{
	foreach(new i:Player)
	{
		if(playerVariable[i][pOrgID]==0) continue;
		if(playerVariable[i][pSettingsOrgChat]==false) continue;
		SCM(i,string_color,string_string);
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock SendOrgChat(orgID,string_color,const string_string[])
{
	foreach(new i: Player)
	{
		if(playerVariable[i][pOrgID]!=orgID) continue;
		if(playerVariable[i][pSettingsOrgChat]==false) continue;
		SCM(i,string_color,string_string);
	}
}

////////////////////////////////////////////////////////////////////////////////

static stock SendFamChat(fID,string_color,const string_string[])
{
	foreach(new i:Player)
	{
		if(playerVariable[i][pFamID]!=fID) continue;
		if(playerVaraible[i][pSettingsFamChat]==false) continue;
		SCM(i,string_color,string_string);
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock SendJobChat(jID,string_color,const string_string[])
{
	foreach(new i:Player)
	{
		if(playerVariable[i][pJobID]!=jID) continue;
		if(playerVariable[i][pSettingsJobChat]==false) continue;
		SCM(i,string_color,string_string);
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

static stock SetVehicleParams(carID)
{
	SetVehicleParamsEx(carID,vehicleVariable[carID][vEngine],vehicleVariable[carID][vLights],vehicleVariable[carID][vAlarm],
	vehicleVariable[carID][vDoors],vehicleVariable[carID][vBonnet],vehicleVariable[carID][vBoot],vehicleVariable[carID][vObjective]);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////



































////////////////////////////////////////////////////////////////////////////////

//              P       L       A       Y       E       R

////////////////////////////////////////////////////////////////////////////////

CMD:n(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pMute]>0) return SCM(playerid,WHITE,InMute);
	if(sscanf(params,"s[128]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /n [текст]");
	format(string,sizeof(string),"(( %s[%i]: %s ))",playerVariable[playerid][pName],playerVariable[playerid][pID],params[0]);
	return ProxDetector(playerid,30.0,string,COLOR_NRP_CHAT,COLOR_NRP_CHAT,COLOR_NRP_CHAT,COLOR_NRP_CHAT,COLOR_NRP_CHAT);
}
ALTX:n("/b");

////////////////////////////////////////////////////////////////////////////////

CMD:s(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pMute]>0) return SCM(playerid,WHITE,InMute);
	if(sscanf(params,"s[128]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /s [текст]");
	format(string,sizeof(string),"%s[%i] кричит: %s",playerVariable[playerid][pName],playerVariable[playerid][pID],params[0]);
	return ProxDetector(playerid,60.0,string,WHITE,WHITE,WHITE,WHITE,WHITE);
}
ALTX:s("/shout");

////////////////////////////////////////////////////////////////////////////////

CMD:w(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pMute]>0) return SCM(playerid,WHITE,InMute);
	if(sscanf(params,"s[128]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /w [текст]");
	format(string,sizeof(string),"%s[%i] шепчет: %s",playerVariable[playerid][pName],playerVariable[playerid][pID],params[0]);
	return ProxDetector(playerid,10.0,string,LIGHT_GRAY,LIGHT_GRAY,LIGHT_GRAY,LIGHT_GRAY,LIGHT_GRAY);
}
ALTX:w("/whisper");

////////////////////////////////////////////////////////////////////////////////

CMD:time(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	format(string,sizeof(string),"~y~%s~n~%s~n~~g~played time: ~w~%i minutes",GetNow(1),GetNow(2),playerVariable[playerid][pPlayedTime]);
	GameTextForPlayer(playerid,string,5000,1);
	return 1;
}
ALTX:time("/t");

////////////////////////////////////////////////////////////////////////////////

CMD:hi(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /hi [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(playerid==params[0]) return SCM(playerid,WHITE,CantUseOnSelf);
	if(SBetweenPlayers(playerid,params[0])>5.0) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок находится далеко от Вас!");
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid,WHITE,NotInCar);
	if(IsPlayerInAnyVehicle(params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок находится в транспорте!");
	format(string,70,"%s пожал(а) руку %s",playerVariable[playerid][pName],playerVariable[params[0]][pName]);
	ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0,1);
	ApplyAnimation(params[0],"GANGS","hndshkfa",4.0,0,0,0,0,0,1);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:me(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pMute]!=0) return SCM(playerid,WHITE,InMute);
    if(isnull(params)) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /me [текст]");
    format(string,170,"%s %s",playerVariable[playerid][pName],params);
    return ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
}

////////////////////////////////////////////////////////////////////////////////

CMD:do(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pMute]!=0) return SCM(playerid,WHITE,InMute);
    if(isnull(params)) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /do [текст]");
    format(string,170,"%s | %s",params,playerVariable[playerid][pName]);
    return ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
}

////////////////////////////////////////////////////////////////////////////////

CMD:try(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pMute]!=0) return SCM(playerid,WHITE,InMute);
    if(isnull(params)) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /try [текст]");
    new or = random(2);
    if(or==0) format(string,170,"%s %s | {00FF00}Удачно",playerVariable[playerid][pName],params);
    else format(string,170,"%s %s | {FF0000}Неудачно",playerVariable[playerid][pName],params);
    return ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
}

////////////////////////////////////////////////////////////////////////////////

CMD:id(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /id [ID]");
	if(sscanf(params,"u",params[0]))
	{
		if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
		if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
		format(string,sizeof(string),"%s[%i] | Ping: %i | AFK: %i",playerVariable[params[0]][pName],params[0],GetPlayerPing(params[0]),playerVariable[params[0]][pAFK]);
		SCM(playerid,WHITE,string);
	}
	else
	{
		new ids = 0;
		SCM(playerid,WHITE,"Игроки онлайн:");
	    foreach(new i:Player)
		{
			if(playerVariable[i][pLogged]==false) continue;
			if(strfind(playerVariable[i][pName],params[0],true)!=-1)
			{
				format(string,sizeof(string),"%s[%i] | Ping: %i | AFK: %i",playerVariable[params[0]][pName],params[0],GetPlayerPing(params[0]),playerVariable[params[0]][pAFK]);
			    SCM(playerid,WHITE,string);
			    ids++;
			}
		}
		if(ids==0) SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок не найден!");
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:mm(playerid)
{
	SPD(playerid,20,DSL,"Меню",string_MENU,"Выбрать","Закрыть");
	return 1;
}
ALTX:mm("/mn","/menu","/main","/mainmenu");

////////////////////////////////////////////////////////////////////////////////

CMD:setspawn(playerid,params[])
{
	SPD(playerid,30,DSL,"Выберите место спавна","1. Аэропорт\n2. Дом\n3. Организация\n4. Дом семьи\n5. Трейлер","Выбрать","Выход");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:settings(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:pass(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /pass [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] Вы желаете показать свой паспорт игроку %s[%i].",
	playerVariable[params[0]][pName],playerVariable[params[0]][pID]);
	SCM(playerid,WHITE,string);
	
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] Игрок %s[%i] желает показать Вам свой паспорт. Нажмите Y если Вы согласны. В ином случае нажмите N.",
	playerVariable[playerid][pName],playerVariable[playerid][pID]);
	SCM(params[0],WHITE,string);
	
	// if Y ()
	format(string,sizeof(string),"%s[%i] показал(а) %s[%i] свой паспорт",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
	ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	//SPD(params[0],);
	//else
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] Вы показали свой паспорт игроку %s[%i].",
	playerVariable[params[0]][pName],playerVariable[params[0]][pID]);
	SCM(playerid,WHITE,string);
	
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] Игрок %s[%i] показал Вам свой паспорт.",
	playerVariable[playerid][pName],playerVariable[playerid][pID]);
	SCM(params[0],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:lic(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /lic [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	new title[128];
	format(title,sizeof(title),"Лицензии игрока %s[%i]",playerVariable[playerid][pName],playerid);
	format(string,sizeof(string),
	"Лицензия на авто: \t\t%s\nЛицензия на мото: \t\t%s\nЛицензия на водный т/с: \t%s\nЛицензия на воздушный т/с: \t%s\nЛицензия на оружие: \t\t%s\n",
	playerVariable[playerid][pLicAuto],playerVariable[playerid][pLicMoto],playerVariable[playerid][pLicShip],playerVariable[playerid][pLicAir],
	playerVariable[playerid][pLicGun]);
	StringReplace(string,"1","имеется");
	StringReplace(string,"0","отсутствует");
	SPD(params[0],36,DSM,title,string,"Закрыть","");
	format(string,sizeof(string),"%s[%i] показал(а) %s[%i] свой пакет лицензий",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
	ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:joblist(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /joblist [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] Вы желаете показать свою трудовую книгу игроку %s[%i].",
	playerVariable[playerid][pName],playerid);
	SCM(playerid,WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:skill(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /skill [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок слишком далеко от Вас!");
	new title[128];
	format(title,sizeof(title),"Навыки %s[%i]",playerVariable[playerid][pName],playerid);
	format(string,sizeof(string),"Desert Eagle: \t\t%i/100%\nM4A1: \t\t\t%i/100%\nAK-47: \t\t\t%i/100%\nShotGun: \t\t%i/100%\nMP5: \t\t\t%i/100%\nSDPistol: \t\t%i/100%",
	playerVariable[playerid][pSkillDesertEagle],playerVariable[playerid][pSkillM4A1],playerVariable[playerid][pSkillAK47],
	playerVariable[playerid][pSkillShotGun],playerVariable[playerid][pSkillMP5],playerVariable[playerid][pSkillSDPistol]);
	SPD(params[0],38,DSM,title,string,"Закрыть","");
	format(string,sizeof(string),"%s[%i] показал(а) %s[%i] свои навыки владения оружием",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
	ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:gps(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	SPD(playerid,40,DSL,"Навигатор",string_GPS,"Выбрать","Закрыть");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:pay(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(sscanf(params,"ui",params[0],params[1])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /pay [ID] [сумма]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(playerid==params[0]) return SCM(playerid,WHITE,CantUseOnSelf);
	if(!(0<params[1]<=playerVariable[playerid][pCash])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У Вас нет столько денег!");
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	format(string,sizeof(string),"%s[%i] передал %i$ игроку %s[%i]",playerVariable[playerid][pName],playerVariable[playerid][pID],
	params[1],playerVariable[params[0]][pName],playerVariable[playerid][pID]);
	ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	playerVariable[playerid][pCash]-=params[1];
	playerVariable[params[0]][pCash]+=params[1];
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:dir(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	SPD(playerid,55,DSL,"Справочник",string_DIR,"Выбрать","Закрыть");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:anim(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	SPD(playerid,61,DSL,"Анимации","wdqefr","Выбрать","Закрыть");
	return 1;
}
ALTX:anim("/anims","/animation","/animations");

////////////////////////////////////////////////////////////////////////////////

CMD:radio(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	SPD(playerid,60,DSL,"Выберите радиостанцию","1. Mafia FM\n2. Radio Record\n3. Europa Plus\n4. DFM \
	\n5. Energy FM\n6. Хит FM\n7. Новое Радио\n8. Русское Радио\n9. Юмор FM\n10. Радио Мир\n11. Радио Монте-Карло \
	\n12. Милицейская Волна\n13. Like FM\n14. Ретро FM\n15. Авторадио\n16. Дорожное Радио\n17. Zaycev FM \
	\n18. Радио Шансон\n19. Вести FM\n20. Выключить радио","Выбрать","Закрыть");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:givegun(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	// proverka guns return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У Вас нет этого оружия");
 	if(sscanf(params,"ui",params[0],params[1])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /givegun [ID] [кол-во патрон]");
 	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
 	if(playerVariable[params[1]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
 	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
 	//if() return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У Вас нет столько патрон!");
	// obmen
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:healme(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pHeal]>=100) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы здоровы!");
	//if(itemVariable[playerid][iAidKid]<=0) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У Вас нет аптечки!");
	format(string,sizeof(string),"%s[%i] использовал аптечку",playerVariable[playerid][pName],playerid);
 	ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
 	//itemVariable[playerid][iAirKid]-=1;
	//ApplyAnimation(playerid,);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:mask(playerid)
{

}

////////////////////////////////////////////////////////////////////////////////

CMD:unmask(playerid)
{}

////////////////////////////////////////////////////////////////////////////////




























////////////////////////////////////////////////////////////////////////////////

//			L			E			A			D			E			R

////////////////////////////////////////////////////////////////////////////////

CMD:lmenu(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
    if(playerVariable[playerid][pOrgRank]<10) return SCM(playerid,WHITE,NotAccess);
    SPD(playerid,262,DSL,"Меню организации",string_LMENU,"Выбрать","Закрыть");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:invite(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
    if(playerVariable[playerid][pOrgRank]<9) return SCM(playerid,WHITE,NotAccess);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /invite [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(playerVariable[params[0]][pOrgID]!=0) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок уже состоит в организации!");
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок слишком далеко от Вас!");
	// Y/N
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:uninvite(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<9) return SCM(playerid,WHITE,NotAccess);
	if(sscanf(params,"us[64]",params[0],params[1])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /uninvite [ID] [причина]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(playerVariable[params[0]][pOrgID]!=playerVariable[playerid][pOrgID]) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок не состоит в вашей оргнизации!");
	if(playerVariable[params[0]][pOrgRank]>=playerVariable[playerid][pOrgRank]) return SCM(playerid,WHITE,CantUseOnThisPlayer);
	format(string,sizeof(string),"%s %s[%i] уволил %s[%i] из организации. Причина: %s.",
	playerVariable[playerid][pOrgRankName],playerVariable[playerid][pName],playerVariable[playerid][pID],playerVariable[params[0]][pName],playerVariable[params[0]][pID],params[1]);
	SendOrgChat(playerVariable[playerid][pOrgID],WHITE,string);
	SCM(params[0],WHITE,"Вы были уволены из организации.");
	playerVariable[params[0]][pOrgID]=0;
	playerVariable[params[0]][pOrgRank]=0;
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:offuninvite(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:fwarn(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unfwarn(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:giverank(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:giveskin(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<8) return SCM(playerid,WHITE,NotAccess);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /giveskin [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	SPD(playerid,261,DSL,"Выбор формы","","Выбрать","Закрыть");

	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:showblacklist(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:blacklist(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unblacklist(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:gov(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
    if(playerVariable[playerid][pOrgRank]!=10) return SCM(playerid,WHITE,NotAccess);
	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
	if(sscanf(params,"s[128]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /gov [текст]");
	format(string,sizeof(string),"[Гос.новости] %s[%i]: %s",playerVariable[playerid][pName],playerid,params[0]);
	SCMtA(BLUE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////













































////////////////////////////////////////////////////////////////////////////////

//D   	E   	P   	A   	R   	T   	A   	M   	E   	N      T

////////////////////////////////////////////////////////////////////////////////

CMD:r(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /r [текст]");
	format(string,sizeof(string),"[{65FF4D}R{FFFFFF}] %s %s[%i]: %s",adminVariable[playerid][aNameRank],playerVariable[playerid][pName],playerid,params[0]);
	SendOrgChat(playerVariable[playerid][pOrgID],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:rn(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /r [текст]");
	format(string,sizeof(string),"[{65FF4D}R{FFFFFF}] (( %s %s[%i]: %s ))",adminVariable[playerid][aNameRank],playerVariable[playerid][pName],playerid,params[0]);
	SendOrgChat(playerVariable[playerid][pOrgID],WHITE,string);
	return 1;
}
ALTX:rn("/rb");

////////////////////////////////////////////////////////////////////////////////

CMD:d(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
    if(playerVariable[playerid][pOrgRank]<5) return SCM(playerid,WHITE,NotAccess);
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /d [текст]");
	format(string,sizeof(string),"[{65FF4D}D{FFFFFF}] %s %s[%i]: %s",adminVariable[playerid][aNameRank],playerVariable[playerid][pName],playerid,params[0]);
	SendDepartamentChat(WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:udost(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:go(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]==2 || playerVariable[playerid][pOrgID]==3)
	{

	}
	else if(playerVariable[playerid][pOrgID]==5)
	{

	}
	else return SCM(playerid,WHITE,NotInOrg);
	
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:load(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:members(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]==0) return SCM(playerid,WHITE,NotInOrg);
	new list[512] = "Участник\tРанг\tВыговоры\n";
	foreach(new i:Player)
	{
		if(!IsPlayerConnected(i)) continue;
		if(playerVariable[i][pLogged]==false) continue;
		if(playerVariable[playerid][pOrgID]!=playerVariable[i][pOrgID]) continue;
		new person[64];
		format(person,sizeof(person),"%s[%i]\t%i\t%i\n",playerVariable[i][pName],playerVariable[i][pID],
		playerVariable[i][pOrgRank],playerVariable[i][pOrgReprimands]);
		strcat(list,person);
	}
	SPD(playerid,260,DSTH,"Сотрудники в сети",list,"Закрыть","");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////













////////////////////////////////////////////////////////////////////////////////

//     G       O       V       E       R       M       E       N		T

////////////////////////////////////////////////////////////////////////////////

CMD:gmenu(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:freedom(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]!=1) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<7) return SCM(playerid,WHITE,NotAccess);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /freedom [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(playerVariable[playerid][pPrisonTime]<1) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У игрока нет срока в тюрьме!");
	playerVariable[params[0]][pPrisonTime]=0;
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] %s %s[%i] выпустил Вас из тюрьмы!",playerVariable[playerid][pOrgRankName],
	playerVariable[playerid][pName],playerVariable[playerid][pID]);
	SCM(params[0],WHITE,string);
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] %s %s[%i] выпустил из тюрьмы игрока %s[%i].",playerVariable[playerid][pOrgRankName],
	playerVariable[playerid][pName],playerVariable[playerid][pID],playerVariable[playerid][pName],playerVariable[playerid][pID]);
	SendOrgChat(playerVariable[playerid][pOrgID],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:listdebtors(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:evict(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:fine(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////

//					F				B				I

////////////////////////////////////////////////////////////////////////////////

CMD:givepass(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]!=2) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /givepass [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(GetPVarInt(params[0],"fbi_key")==0)
	{
		SetPVarInt(params[0],"fbi_key",1);
		format(string,sizeof(string),"%s[%i] выдал пропуск %s[%i]",playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
		ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	}
	else SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У этого игрока уже есть пропуск!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:takepass(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]!=2) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /takepass [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(GetPVarInt(params[0],"fbi_key")==1)
	{
		SetPVarInt(params[0],"fbi_key",0);
		format(string,sizeof(string),"%s[%i] забрал пропуск у %s[%i]",playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
		ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	}
	else SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У игрока отсутствует пропуск!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:wiretap(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]!=2) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<2) return SCM(playerid,WHITE,NotAccess);
	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
	SPD(playerid,120,DSL,"Прослушка","1. Правительсто\n2. Полицейский департамент\n3. Национальная гвардия\n4. Центральная больница \
	\n5. Радиоцентр\n6. Автошкола\n7. \n8. Выключить","Выбарть","Закрыть");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////

//          	P       O       L       I       C       E

////////////////////////////////////////////////////////////////////////////////

CMD:ticket(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(!(playerVariable[playerid][pOrgID]==2 || playerVariable[playerid][pOrgID]==3)) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<2) return SCM(playerid,WHITE,NotAccess);
	if(sscanf(params,"uis[64]",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /ticket [ID] [штраф] [причина]");
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] Вы успешно выписали штраф игроку %s[%i] в размере %i. Причина: %s.",
	playerVariable[params[0]][pName],playerVariable[params[0]][pID],params[1],params[2]);
	SCM(playerid,WHITE,string);
	format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] Офицер %s[%i] выписал Вам штраф в размере %s. Причина: %s.",
	playerVariable[playerid][pName],playerVariable[playerid][pID],params[1],params[2]);
	SCM(params[0],WHITE,string);
	playerVariable[params[0]][pFine]+=params[1];
	SaveVariableInteger("account","Fine",playerVariable[params[0]][pFine],playerVariable[playerid][pID]);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:su(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:cuff(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:uncuff(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////

//                      A       R       M       Y

////////////////////////////////////////////////////////////////////////////////










////////////////////////////////////////////////////////////////////////////////

//			H       O       S       P       I       T       A       L

////////////////////////////////////////////////////////////////////////////////

CMD:heal(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]!=5) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<2) return SCM(playerid,WHITE,NotAccess);
	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
	// if(itemVariable[playerid][iPill]<=0) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У Вас недостаточно медикаментов!"); - проверка на таблеки
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /heal [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(playerVariable[params[0]][pHeal]>=100) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок здоров!");
	// Y/N
	playerVariable[playerid][pCash]+=PRICE_HEAL/2;
	SetPlayerHealth(params[0],100.0);
	playerVariable[params[0]][pHeal]=100.0;
	playerVariable[params[0]][pCash]-=PRICE_HEAL;
	SCM(params[0],WHITE,"[{8BFFF3}Подсказка{FFFFFF}] Вы успешно вылечились!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:healdrug(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]!=5) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<6) return SCM(playerid,WHITE,NotAccess);
	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /healdrug [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(playerVariable[playerid][pDrugAddiction]<1) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У игрока нет зависимости!");
	// Y/N
	playerVariable[playerid][pCash]+=PRICE_CURE_DRUG_ADDICTION/2;
	playerVariable[params[0]][pDrugAddiction]-=10;
	playerVariable[params[0]][pCash]-=PRICE_CURE_DRUG_ADDICTION;
	SCM(params[0],WHITE,"[{8BFFF3}Подсказка{FFFFFF}] Вы успешно вылечились от наркозависимости!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:changesex(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]!=5) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<7) return SCM(playerid,WHITE,NotAccess);
	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /changesex [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	// Y/N
	playerVariable[playerid][pCash]+=PRICE_CHANGESEX/2;
	if(playerVariable[params[0]][pSex]==0) playerVariable[params[0]][pSex]=1;
	else playerVariable[params[0]][pSex]=0;
	playerVariable[params[0]][pCash]-=PRICE_CHANGESEX;
	SCM(params[0],WHITE,"[{8BFFF3}Подсказка{FFFFFF}] Вы успешно сменили пол!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:givemedcard(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pOrgID]!=5) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]<3) return SCM(playerid,WHITE,NotAccess);
 	if(playerVariable[playerid][pOrgWorking]==false) return SCM(playerid,WHITE,NotWorking);
 	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /givemedcard [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(playerVariable[playerid][pMedcard]>0) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У игрока уже есть медицинская карточка!");
	
	playerVariable[playerid][pCash]+=PRICE_MEDCARD/2;
	playerVariable[params[0]][pMedcard]=7;
	playerVariable[params[0]][pCash]-=PRICE_MEDCARD;
	SCM(params[0],WHITE,"[{8BFFF3}Подсказка{FFFFFF}] Вы успешно получили медицинскую карточку на 7 дней!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////

//					S               M               I

////////////////////////////////////////////////////////////////////////////////

CMD:edit(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////






////////////////////////////////////////////////////////////////////////////////

//					D       R       I       V       E

////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////

//		              M       A       F       I       A

////////////////////////////////////////////////////////////////////////////////
/*/bizlist — Бизнесы под контролем.
/debtors — Узнать список должников онлайн.
/tie — Связать в машине.
/untie — Освободить.
/mafiabank — Положить деньги на счет.
/mafiawithdraw — Снять деньги со счета.
/mafiabalance — Баланс счета.
/setdebt [id] — Предложить крышу.
/getdebt [id] — Выбить долг.
/debtor [id] — Узнать информацию об игроке.
/repaydebt [id] — Вернуть деньги.
/mydebts — Узнать информацию о себе.
/warehouse — Количество материалов на складе семьи.
/getgun — Взять оружие со склада.
/materials buy — Купить материалы в Аммунацию, на склад мафии.
/hackbase [id] — Снять розыск.*/

CMD:f(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(!(8<=playerVariable[playerid][pOrgID]<=12)) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pMute]>0) return SCM(playerid,WHITE,InMute);
	if(sscanf(params,"s[128]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /f [текст]");
	format(string,sizeof(string),"[{65FF4D}F{FFFFFF}] %s[%i]: %s",playerVariable[playerid][pName],playerVariable[playerid][pID],params[0]);
	SendOrgChat(playerVariable[playerid][pOrgID],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:bizlist(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(!(8<=playerVariable[playerid][pOrgID]<=12)) return SCM(playerid,WHITE,NotInOrg);
	new list[2048];
	mysql_tquery(MySQL:DATABASE,query);
	SPD(playerid,240,DSTH,"Бизнесы под контролем","qdewfrthyjde","Выбрать","Закрыть");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:debtors(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:tie(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(!(8<=playerVariable[playerid][pOrgID]<=12)) return SCM(playerid,WHITE,NotInOrg);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /tie [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,PlayerOffline);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(GetPVarInt(params[0],"mafia_tie")==0)
	{
	    SetPVarInt(params[0],"mafia_tie",1);
	    TogglePlayerControllable(params[0],0);
	    format(string,sizeof(string),"%s[%i] связал %s[%i]",playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
		ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	}
	else SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок уже связан!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:untie(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(!(8<=playerVariable[playerid][pOrgID]<=12)) return SCM(playerid,WHITE,NotInOrg);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /untie [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,PlayerOffline);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(GetPVarInt(params[0],"mafia_tie")==1)
	{
	    SetPVarInt(params[0],"mafia_tie",0);
	    TogglePlayerControllable(params[0],1);
	    format(string,sizeof(string),"%s[%i] развязал %s[%i]",playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
		ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	}
	else SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок не связан!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:gag(playerid,params[])
{
 	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
 	if(!(8<=playerVariable[playerid][pOrgID]<=12)) return SCM(playerid,WHITE,NotInOrg);
 	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /gag [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,PlayerOffline);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(GetPVarInt(params[0],"mafia_gag")==0)
	{
		SetPVarInt(params[0],"mafia_gag",1);
		format(string,sizeof(string),"%s[%i] вставил кляп %s[%i]",playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
		ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	}
	else SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У игрока есть кляп!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:ungag(playerid,params[])
{
 	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
 	if(!(8<=playerVariable[playerid][pOrgID]<=12)) return SCM(playerid,WHITE,NotInOrg);
 	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /ungag [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,PlayerOffline);
	if(SBetweenPlayers(playerid,params[0])>DISTANCE_BETWEEN_PLAYERS) return SCM(playerid,WHITE,PlayerFarAway);
	if(GetPVarInt(params[0],"mafia_gag")==1)
	{
		SetPVarInt(params[0],"mafia_gag",0);
		format(string,sizeof(string),"%s[%i] вытащил кляп у %s[%i]",playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
		ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	}
	else SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] У игрока нет кляпа!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:creategun(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:sellgun(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:war(playerid,params[])
{
	GangZoneFlashForAll(zone1,0xFF0000FF);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:warehouse(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(!(8<=playerVariable[playerid][pOrgID]<=12)) return SCM(playerid,WHITE,NotInOrg);
	if(playerVariable[playerid][pOrgRank]!=10) return SCM(playerid,WHITE,NotAccess);
	// check
	return 1;
}

////////////////////////////////////////////////////////////////////////////////
























////////////////////////////////////////////////////////////////////////////////

//					J                   O                       B

////////////////////////////////////////////////////////////////////////////////

CMD:j(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pJobID]==0) return SCM(playerid,WHITE,NotInJob);
	if(playerVariable[playerid][pJobWorking]==false) return SCM(playerid,WHITE,NotWorking);
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /j [текст]");
	format(string,sizeof(string),"[{F4DE6F}J{FFFFFF}] %s[%i]: %s",playerVariable[playerid][pName],playerVariable[playerid][pID],string);
	SendJobChat(playerVariable[playerid][pJobID],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:jhelp(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:jlock(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:junrent(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

// T A X I

////////////////////////////////////////////////////////////////////////////////

CMD:acceptcall(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pJobID]==2)
	{
		if(playerVariable[playerid][pJobWorking]==false) return SCM(playerid,WHITE,NotWorking);
		//if(playerVariable[playerid][p]) esli ne v transporte return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не в рабочем транспорте!");
		if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /gotaxi [ID]");
		if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
		if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
		//if player vizval taxi i ego vizov ewe ne prinyali return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Игрок не вызывал такси либо его вызов уже приняли!");
		//stavitsya metka na igroka
		format(string,sizeof(string),"[{F4DE6F}Такси{FFFFFF}] Вы приняли вызов игрока %s[%i]. Он находится в районе %s.",
		playerVariable[params[0]][pName],playerVariable[playerid][pID],GetPlayerDistrict(params[0]));
		SCM(playerid,WHITE,string);
		format(string,sizeof(string),"[{F4DE6F}Такси{FFFFFF}] Таксист %s[%i] принял вызов игрока %s[%i].",
		playerVariable[playerid][pName],playerVariable[playerid][pID],playerVariable[params[0]][pName],playerVariable[params[0]][pID]);
		SendJobChat(playerVariable[playerid][pJobID],WHITE,string);
		format(string,sizeof(string),"[{8BFFF3}Подсказка{FFFFFF}] Таксист %s[%i] принял Ваш вызов. Он находится в районе %s.",
		playerVariable[playerid][pName],playerVariable[playerid][pID],GetPlayerDistrict(playerid));
		SCM(params[0],WHITE,string);
	}
	if(playerVariable[playerid][pJobID]==3)
	{

	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:cancelcall(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

// M E C H A N I C

////////////////////////////////////////////////////////////////////////////////

CMD:repaircar(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pJobID]!=3) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не работаете механиком!");
	if(playerVariable[playerid][pJobWorking]==false) SCM(playerid,WHITE,NotWorking);
	//if(playerVariable[playerid][p]) esli ne v transporte return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не в рабочем транспорте!");
	if(sscanf(params,"ui",params[0],params[1])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /repair [ID] [цена за ремонт]");
	if(!(500<params[1]<=5000)) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Цена за ремонт должна быть от 500 до 5000$!");
	// remont auto
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:fuelcar(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pJobID]!=3) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не работаете механиком!");
	if(playerVariable[playerid][pJobWorking]==false) SCM(playerid,WHITE,NotWorking);
	//if(playerVariable[playerid][p]) esli ne v transporte return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не в рабочем транспорте!");
	if(sscanf(params,"uii",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Используйте: /fuel [ID] [кол-во литров] [цена за литр]");
	if(!(0<params[1]<=100)) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Количество литров должно быть от 1 до 100!");
	if(!(500<params[2]<=5000)) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Цена за литр должна быть от 50 до 2000$!");
	// fuel auto
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

// T R A S H E R

////////////////////////////////////////////////////////////////////////////////

CMD:loadtrash(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pJobID]!=4) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не работаете мусорщиком!");
	if(playerVariable[playerid][pJobWorking]==false) SCM(playerid,WHITE,NotWorking);
	//if(playerVariable[playerid][p]) esli ne v transporte return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не в рабочем транспорте!");
	//if() poisk ryadom baka c govnom esli est to zagruzit' ego v car
	//ochistit' bak
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unloadtrash(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pJobID]!=4) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не работаете мусорщиком!");
	if(playerVariable[playerid][pJobWorking]==false) SCM(playerid,WHITE,NotWorking);
	//if(playerVariable[playerid][p]) esli ne v transporte return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не в рабочем транспорте!");
	//esli v oblasti kruga to razgruzka mysora + zp v payday
	return 1;
}

////////////////////////////////////////////////////////////////////////////////























////////////////////////////////////////////////////////////////////////////////

//			F			A			M			I			L			Y

////////////////////////////////////////////////////////////////////////////////

CMD:fam(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:fmembers(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:finvite(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:funinvite(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////























////////////////////////////////////////////////////////////////////////////////

// 			B		U		I		S		N		E		S		S

////////////////////////////////////////////////////////////////////////////////

CMD:bmenu(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:buybiz(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:sellbiz(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////
























////////////////////////////////////////////////////////////////////////////////

//				C						A						R

////////////////////////////////////////////////////////////////////////////////

CMD:cmenu(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не на месте водителя!");
	new carID = GetPlayerVehicleID(playerid);
	format(string,sizeof(string),string_CMENU,vehicleVariable[carID][vEngine],vehicleVariable[carID][vBonnet],
	vehicleVariable[carID][vBoot],vehicleVariable[carID][vLights]);
	SPD(playerid,62,DST,"Меню транспорта",string,"Выбрать","Закрыть");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:fuel(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(GetPlayerState(playerid)!=PLAYER_STATE_ONFOOT) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы должны находиться около транспорта!");
	//if() return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Рядом с Вами нет транспорта!");
	format(string,sizeof(string),"%s[%i] заправил транспорт",playerVariable[playerid][pName],playerid);
	ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
	//itemVariable[playerid][iCanister]-=1;
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

















////////////////////////////////////////////////////////////////////////////////

//					A		D		M		I		N

////////////////////////////////////////////////////////////////////////////////

CMD:alogin(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==true) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Вы уже авторизованы!");
    SPD(playerid,500,DSP,"Вход","Введите админ-пароль:","Далее","Закрыть");
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:ahelp(playerid)
{
	SPD(playerid,502,DSM,"Помощь","[ 1 ] /alogin, /a, /ahelp, /apanel, /re, /reoff, /slap, /goto, /gethere, /setskin, /sethp, /ans, /pm\n[ 2 ]\n[ 3 ]\n[ 4 ]","Назад","Выход");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:apanel(playerid)
{
	SPD(playerid,501,DSL,"Админ-меню","Статистика\nАдминистраторы онлайн\nРепорты\n\n\n\n\n\nРедактор МП\n","Выбрать","Выход");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:a(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /a [текст]");
	format(string,sizeof(string),"[{65FF4D}A{FFFFFF}] %s %s[%i]: %s",adminVariable[playerid][aNameRank],playerVariable[playerid][pName],playerid,params[0]);
	SendAdminChat(playerid,WHITE,string,false);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:az(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
 	if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
 	if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	SetPlayerPos(playerid,0.0,0.0,0.0);
	SCM(playerid,WHITE,"[{FFF050}ADM{FFFFFF}] Вы телепортировались в админ-зону.");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:re(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /re [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(playerid==params[0]) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Следить за собой нельзя!");
    if(GetPVarInt(playerid,"adm_re")!=0) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Вы уже следите!");
    new Float:pos_X,
		Float:pos_Y,
		Float:pos_Z,
		Float:pos_A;
    GetPlayerPos(playerid,pos_X,pos_Y,pos_Z);
    GetPlayerFacingAngle(playerid,pos_A);
    SetPVarFloat(playerid,"pos_X",pos_X);
    SetPVarFloat(playerid,"pos_Y",pos_Y);
    SetPVarFloat(playerid,"pos_Z",pos_Z);
    SetPVarFloat(playerid,"pos_A",pos_A);
    SetPVarInt(playerid,"re_int",GetPlayerInterior(params[0]));
    SetPVarInt(playerid,"re_virt",GetPlayerVirtualWorld(params[0]));
    
    TogglePlayerSpectating(playerid,true);
    SetPlayerInterior(playerid,GetPlayerInterior(params[0]));
    SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(params[0]));
    if(IsPlayerInAnyVehicle(playerid)) PlayerSpectateVehicle(playerid,GetPlayerVehicleID(params[0]),1);
    else PlayerSpectatePlayer(playerid,params[0],1);
    SetPVarInt(playerid,"adm_re",1);
    adminVariable[playerid][aSpectating] = true;
    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] %s[%i] начал следить за игроком %s[%i]",playerVariable[playerid][pName],playerid,
	playerVariable[params[0]][pName],params[0]);
    SendAdminChat(playerid,WHITE,string,false);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:reoff(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(GetPVarInt(playerid,"adm_re")==0) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Вы не следите!");
    adminVariable[playerid][aSpectating] = false;
    TogglePlayerSpectating(playerid,false);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:ans(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"us[144]",params[0],params[1])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /ans [ID] [текст]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(params[0]==playerid) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Нельзя отправить самому себе!");
	if(params[1]==EOS) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Нельзя отправить пустое сообщение!");
	format(string,200,"[{65FF4D}ADM{FFFFFF}] Вы сказали игроку %s: %s",playerVariable[params[0]][pName],params[1]);
	SCM(playerid,WHITE,string);
	format(string,200,"\n\nАдминистратор %s: %s\n\n",playerVariable[playerid][pName],params[1]);
	SPD(params[0],505,DSM,"Вам сказал администратор",string,"Закрыть","");
	format(string,WHITE,"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] сказал игроку %s[%]: %s",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0],params[1]);
	SendAdminChat(playerid,WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:pm(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"us[144]",params[0],params[1])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /pm [ID] [текст]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(params[0]==playerid) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Нельзя отправить самому себе!");
	if(params[1]==EOS) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Нельзя отправить пустое сообщение!");
	format(string,200,"[{65FF4D}ADM{FFFFFF}] Вы ответили игроку %s: %s",playerVariable[params[0]][pName],params[1]);
	SCM(playerid,WHITE,string);
	format(string,200,"Администратор %s ответил Вам: %s",playerVariable[playerid][pName],params[1]);
	SCM(params[0],WHITE,string);
	format(string,WHITE,"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] ответил игроку %s[%]: %s",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0],params[1]);
	SendAdminChat(playerid,WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:tp(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
	if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	SPD(playerid,506,DSL,"Телепорт","\n\n\n\n\n\n\n\n","Выбрать","Закрыть");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:setpos(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
 	if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"fff",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /setpos [X] [Y] [Z]");
	SetPlayerPos(playerid,params[0],params[1],params[2]);
	SCM(playerid,WHITE,AdmAccessTeleport);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:getpos(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
 	if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /getpos [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,PlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,PlayerNotAuthorized);
	new Float:posX,Float:posY,Float:posZ;
	GetPlayerPos(params[0],posX,posY,posZ);
	format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Координаты игрока %s[%i]: %f %f %f.",
	playerVariable[playerid][pName],playerid,posX,posY,posZ);
	SCM(playerid,WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:admins(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	SCM(playerid,WHITE,"[{FFF050}ADM{FFFFFF}] Администраторы в сети:");
    foreach(new i:Player)
    {
		if(playerVariable[i][pAdmin]==0) continue;
		if(adminVariable[i][aLogged]==true)
		{
			format(string,sizeof(string),"%s[%i] | Уровень: %i | {00FF00}Авторизован{FFFFFF} в систему администрирования",playerVariable[i][pName],i,adminVariable[i][aLVL]);
			SCM(playerid,WHITE,string);
		}
		else
		{
			format(string,sizeof(string),"%s[%i] | Уровень: %i | {FF0000}Не авторизован{FFFFFF} в систему администрирования",playerVariable[i][pName],i,adminVariable[i][aLVL]);
			SCM(playerid,WHITE,string);
		}
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:getstats(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"u",params[0],params[1])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /getstats [ID]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(params[0]==playerid) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Нельзя посмотреть у самого себя!");
	format(string,sizeof(string),"Ник: %s\nУровень: %i\nПол: %s\n\n\n\n\n\n",playerVariable[params[0]][pName],playerVariable[params[0]][pLVL],playerVariable[params[0]][pSex]);
	SPD(playerid,501,DSM,"Статистика",string,"Закрыть","");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:veh(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(GetPVarInt(playerid,!"adm_veh")) return SCM(playerid,WHITE,!"[{FF2424}ADM{FFFFFF}] Удалите предыдущий трансопорт!");
	if(sscanf(params,"iii",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /veh [ID] [цвет 1] [цвет 2]");
	if(params[0]<400 || params[0]>611) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] ID транспорта должен быть от 400 до 611");
	if(params[1]<0 || params[1]>255) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] ID первого цвета транспорта должен быть от 0 до 255");
	if(params[2]<0 || params[2]>255) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] ID второго цвета транспорта должен быть от 0 до 255");
	if((params[0]==594 || params[0]==592 || params[0]==590 || params[0]==584 || params[0]==577 || params[0]==570 ||
		params[0]==569 || params[0]==564 || params[0]==553 || params[0]==538 || params[0]==537 || params[0]==532 ||
		params[0]==520 || params[0]==501 ||	params[0]==464 || params[0]==449 || params[0]==441 || params[0]==432 ||
		params[0]==430 || params[0]==425 || params[0]==406) && adminVariable[playerid][aLVL] < 6)
	 	return SCM(playerid,WHITE,!"[{FF2424}ADM{FFFFFF}] Этот транспорт запрещен на сервере!");
	new	Float:pos_x_veh,
		Float:pos_y_veh,
		Float:pos_z_veh,
	 	Float:pos_a_veh;
    GetPlayerPos(playerid,pos_x_veh,pos_y_veh,pos_z_veh);
    GetPlayerFacingAngle(playerid,pos_a_veh);
    new carID = AddStaticVehicleEx(params[0],pos_x_veh,pos_y_veh,pos_z_veh,pos_a_veh,params[1],params[2],-1);
    vehicleVariable[carID][vFuel]=FUEL_IN_CAR;
    SetPVarInt(playerid,!"adm_veh",carID);
    PutPlayerInVehicle(playerid,GetPVarInt(playerid,!"adm_veh"),0);
	return SCM(playerid,WHITE,!"[{65FF4D}ADM{FFFFFF}] Вы успешно создали транспорт!");
}

////////////////////////////////////////////////////////////////////////////////

CMD:delveh(playerid)
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(GetPVarInt(playerid,!"adm_veh")==0) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Вы не создавали транспорт!");
    DestroyVehicle(GetPVarInt(playerid,!"adm_veh"));
    DeletePVar(playerid,!"adm_veh");
    return SCM(playerid,WHITE,!"[{65FF4D}ADM{FFFFFF}] Транспорт был успешно удален!");
}

////////////////////////////////////////////////////////////////////////////////

CMD:plveh(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:delplveh(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:fixveh(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(adminVariable[playerid][aLVL]<2) return SCM(playerid,WHITE,AdmNotAccess);
    if(sscanf(params,"i",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /fixveh [ID транспорта]");
	RepairVehicle(params[0]);
	SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Транспорт успешно отремонтирован!");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:spawn(playerid)
{
	SetPlayerPos(playerid,-1106.7,419.8,500.0);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:spplayer(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:spcar(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:sethp(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"ui",params[0],params[1])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /sethp [ID] [кол-во]");
	if(!(0<=params[1]<=100)) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Уровень здоровья должен быть от 0 до 100!");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	SetPlayerHealth(params[0],params[1]);
	format(string,100,"[{65FF4D}ADM{FFFFFF}] Вы установили игроку %s уровень здоровья: %i.",playerVariable[params[0]][pName],params[1]);
	SCM(playerid,WHITE,string);
	format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] установил игроку %s[%i] уровень здоровья: %i",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0],params[1]);
	SendAdminChat(playerid,WHITE,string,false);
	format(string,100,"Администратор %s установил вам уровень здоровья: %i.",playerVariable[playerid][pName],params[1]);
	SCM(params[0],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:setskin(playerid,params[0])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
	if(sscanf(params,"ui",params[0],params[1])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /setskin [ID игрока] [ID скина]");
	if(!(0<=params[1]<=311)) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] ID скина должен быть от 0 до 311!");
	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	SetPlayerSkin(params[0],params[1]);
	format(string,70,"[{65FF4D}ADM{FFFFFF}] Вы установили игроку %s скин: %i.",playerVariable[params[0]][pName],params[1]);
	SCM(playerid,WHITE,string);
	format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] установил игроку %s[%i] скин: %i",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0],params[1]);
	SendAdminChat(playerid,WHITE,string,false);
	format(string,70,"Администратор %s установил вам скин: %i.",playerVariable[playerid][pName],params[1]);
	SCM(params[0],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:freeze(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /freeze [ID]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(GetPVarInt(playerid,"adm_freeze")==0)
	{
	    SetPVarInt(playerid,"adm_freeze",1);
	    TogglePlayerControllable(params[0],0);
	    format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Вы заморозили игрока %s",playerVariable[params[0]][pName]);
	    SCM(playerid,WHITE,string);
	    format(string,sizeof(string),"Администратор %s заморозил Вас.",playerVariable[playerid][pName]);
	    SCM(params[0],WHITE,string);
	    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] заморозил игрока %s[%i].",
		playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
		SendAdminChat(playerid,WHITE,string,false);
	}
	else
	{
	    SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Игрок уже заморожен!");
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unfreeze(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /unfreeze [ID]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(GetPVarInt(playerid,"adm_freeze")==0)
	{
	    SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Игрок не заморожен!");
	}
	else
	{
	    SetPVarInt(playerid,"adm_freeze",0);
	    TogglePlayerControllable(params[0],1);
 		format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Вы разморозили игрока %s",playerVariable[params[0]][pName]);
	    SCM(playerid,WHITE,string);
	    format(string,sizeof(string),"Администратор %s разморозил Вас.",playerVariable[playerid][pName]);
	    SCM(params[0],WHITE,string);
	    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] разморозил игрока %s[%i].",
		playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
		SendAdminChat(playerid,WHITE,string,false);
	    
	}
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:freezeall(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unfreezeall(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:slap(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /slap [ID]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	new Float:pos_X,Float:pos_Y,Float:pos_Z;
	GetPlayerPos(params[0],pos_X,pos_Y,pos_Z);
	SetPlayerPos(params[0],pos_X,pos_Y,pos_Z+10);
	format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Вы дали пинка игроку %s[%i].",playerVariable[params[0]][pName],params[0]);
	SCM(playerid,WHITE,string);
    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] дал пинка игроку %s[%i].",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
    SendAdminChat(playerid,WHITE,string,false);
    format(string,sizeof(string),"Администратор %s[%i] дал Вам пинка.",playerVariable[playerid][pName],playerid);
    SCM(params[0],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:flip(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /flip [ID]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	new carID = GetPlayerVehicleID(playerid);
	if(carID==0) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Игрок не в транспорте!");
	new Float:pos_X,Float:pos_Y,Float:pos_Z,Float:pos_a;
	GetVehiclePos(carID,pos_X,pos_Y,pos_Z);
	GetVehicleZAngle(carID,pos_a);
	SetVehiclePos(carID,pos_X,pos_Y,pos_Z+10);
	SetVehicleZAngle(carID,pos_a);
 	RepairVehicle(carID);
 	SetVehicleParams(carID);
	format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Вы подкинули транспорт игрока %s[%i].",playerVariable[params[0]][pName],params[0]);
	SCM(playerid,WHITE,string);
    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] подкинул транспорт игрока %s[%i].",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
    SendAdminChat(playerid,WHITE,string,false);
    format(string,sizeof(string),"Администратор %s[%i] подкинул Ваш транспорт.",playerVariable[playerid][pName],playerid);
    SCM(params[0],WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:kick(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"us[32]",params[0],params[1])) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /kick [ID] [причина]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
    format(string,sizeof(string),"Администратор %s кикнул игрока %s. Причина: %s",playerVariable[params[0]][pName],playerVariable[playerid][pName],params[1]);
    SCMtA(WHITE,string);
    AdminAction(playerVariable[playerid][pName],string);
    format(string,sizeof(string),"Администратор %s кикнул Вас с сервера! Причина: %s",playerVariable[playerid][pName],params[1]);
    SCM(params[0],WHITE,string);
	SCM(params[0],WHITE,"Советуем Вам сделать скрин-шот наказания. Если Вы считаете, что администаротор не прав, то можете оставить жалобу на сайте mafia-rp.su");
	SPD(params[0],7,DSM,"Информация","Вы были кикнуты с сервера!","Выход","");
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:skick(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"us[32]",params[0],params[1])) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /skick [ID] [причина]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	format(string,sizeof(string),"Администратор %s тихо кикнул игрока %s с сервера! Причина: %s",playerVariable[playerid][pName],playerVariable[params[0]][pName],params[1]);
	AdminAction(playerVariable[playerid][pName],string);
    format(string,sizeof(string),"Администратор %s кикнул Вас с сервера! Причина: %s",playerVariable[playerid][pName],params[1]);
    SCM(params[0],WHITE,string);
	SCM(params[0],WHITE,"Советуем Вам сделать скрин-шот наказания. Если Вы считаете, что администаротор не прав, то можете оставить жалобу на сайте mafia-rp.su");
    Kick(params[0]);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:mute(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"uis[32]",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /mute [ID] [время] [причина]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(playerVariable[params[0]][pMute]!=0) return SCM(playerid,WHITE,AdmPlayerInMute);
    format(string,sizeof(string),"Администратор %s выдал мут игроку %s на %i минут. Причина: %s",playerVariable[playerid][pName],playerVariable[params[0]][pName],params[1],params[2]);
    SCMtA(WHITE,string);
    AdminAction(playerVariable[playerid][pName],string);
    format(string,sizeof(string),"Администратор %s выдал Вам мут на %i минут! Причина: %s",playerVariable[playerid][pName],params[1],params[2]);
    SCM(params[0],WHITE,string);
	SCM(params[0],WHITE,"Советуем Вам сделать скрин-шот наказания. Если Вы считаете, что администаротор не прав, то можете оставить жалобу на сайте mafia-rp.su");
	// timer start
	SaveVariableInteger("account","Mute",params[1],playerVariable[params[0]][pID]);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unmute(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"us[32]",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /unmute [ID] [причина]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(playerVariable[params[0]][pMute]==0) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] У игрока отсутствует мут!");
    format(string,sizeof(string),"Администратор %s снял мут игроку %s. Причина: %s",playerVariable[playerid][pName],playerVariable[params[0]][pName],params[1]);
    SCMtA(WHITE,string);
    AdminAction(playerVariable[playerid][pName],string);
    format(string,sizeof(string),"Администратор %s снял Вам мут! Причина: %s",playerVariable[playerid][pName],params[1]);
    SCM(params[0],WHITE,string);
	// timer stop
	SaveVariableInteger("account","Mute",0,playerVariable[params[0]][pID]);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:jail(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<3) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"uis[32]",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /jail [ID] [время] [причина]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
    format(string,sizeof(string),"Администратор %s посадил игрока %s в тюрьму на %i минут. Причина: %s",playerVariable[playerid][pName],playerVariable[params[0]][pName],params[1],params[2]);
    SCMtA(WHITE,string);
    AdminAction(playerVariable[playerid][pName],string);
    format(string,sizeof(string),"Администратор %s посадил Вас в тюрьму на %i минут! Причина: %s",playerVariable[playerid][pName],params[1],params[2]);
    SCM(params[0],WHITE,string);
	SCM(params[0],WHITE,"Советуем Вам сделать скрин-шот наказания. Если Вы считаете, что администаротор не прав, то можете оставить жалобу на сайте mafia-rp.su");
	// timer start
	SaveVariableInteger("account","Jail",params[1],playerVariable[params[0]][pID]);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unjail(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<2) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"us[32]",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /unjail [ID] [причина]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(playerVariable[params[0]][pMute]==0) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Игрок не находится в тюрьме!");
    format(string,sizeof(string),"Администратор %s выпустил из тюрьмы игрока %s. Причина: %s",playerVariable[playerid][pName],playerVariable[params[0]][pName],params[1]);
    SCMtA(WHITE,string);
    AdminAction(playerVariable[playerid][pName],string);
    format(string,sizeof(string),"Администратор %s выпустил Вас из тюрьмы! Причина: %s",playerVariable[playerid][pName],params[1]);
    SCM(params[0],WHITE,string);
	// timer stop
	SaveVariableInteger("account","Jail",0,playerVariable[params[0]][pID]);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:jailoff(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<3) return SCM(playerid,WHITE,NotAccess);
    new jailoff_name[25],jailoff_time,jailoff_resp[33];
    if(sscanf(params,"s[25]ds[33]",jailoff_name,jailoff_time,jailoff_resp)) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /jailoff [ник] [время] [причина]");
    if(IsPlayerConnected(GetPlayerIDFromName(jailoff_name))) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Игрок в сети! Используйте /jail");
    if(jailoff_time<0) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Ошибка! Время должно быть больше 0!");
	format(string,sizeof(string),"SELECT `ID`, `NickName` FROM `account` WHERE `NickName` = '%s' LIMIT 1",jailoff_name);
	mysql_query(MySQL:DATABASE,string);
	new name1[25],id1,row_count1;
	cache_get_row_count(row_count1);
	if(row_count1==0) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Ошибка! Такого аккаунта не существует!");
	cache_get_value_name(0,"NickName",name1,25);
	cache_get_value_name_int(0,"ID",id1);
    format(string,sizeof(string),"Администратор %s посадил игрока %s в тюрьму в оффлайне на %i минут. Причина: %s",playerVariable[playerid][pName],jailoff_name,jailoff_time,jailoff_resp);
    SendToAllChatSettingAdminAction(REDa,string);
    string = AdmYellow;
	strcat(string," ");
	strcat(string,string);
    SendAdminChat(playerid,WHITE,string);
	AdminAction(playerVariable[playerid][pName],string);
	SaveVariableInteger("account","Jail",jailoff_time,id1);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unjailoff(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<3) return SCM(playerid,WHITE,NotAccess);
    new jailoff_name[25],jailoff_resp[33];
    if(sscanf(params,"s[25]ds[33]",jailoff_name,jailoff_resp)) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /unjailoff [ник] [причина]");
    if(IsPlayerConnected(GetPlayerIDFromName(jailoff_name))) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Игрок в сети! Используйте /unjail!");
	format(string,sizeof(string),"SELECT `ID` FROM `account` WHERE `NickName` = '%s' LIMIT 1",jailoff_name);
	mysql_query(MySQL:DATABASE,string);
	new id1,row_count1;
	cache_get_row_count(row_count1);
	if(row_count1==0) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Ошибка! Такого аккаунта не существует!");
	cache_get_value_name_int(0,"ID",id1);
    format(string,sizeof(string),"Администратор %s выпустил игрока %s из тюрьмы в оффлайне. Причина: %s",playerVariable[playerid][pName],jailoff_name,jailoff_resp);
    SendToAllChatSettingAdminAction(REDa,string);
    string = AdmYellow;
	strcat(string," ");
	strcat(string,string);
    SendAdminChat(playerid,WHITE,string);
	AdminAction(playerVariable[playerid][pName],string);
	SaveVariableInteger("account","Jail",0,id1);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:warn(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unwarn(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:warnoff(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unwarnoff(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:ban(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<4) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"uis[32]",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /ban [ID] [кол-во дней] [причина]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(params[1]>30 || params[1]<1) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Забанить можно только на 1-30 дней!");
 	format(string,sizeof(string),"Администратор %s заблокировал игрока %s на %i дней. Причина: %s",playerVariable[playerid][pName],playerVariable[params[0]][pName],params[1],params[2]);
    SCMtA(WHITE,string);
    AdminAction(playerVariable[playerid][pName],string);
    SaveVariableInteger("account","Ban",params[1],playerVariable[params[0]][pID]);
    format(string,sizeof(string),"Администратор %s заблокировал Ваш аккаунт на %i дней! Причина: %s",playerVariable[playerid][pName],params[1],params[2]);
    SCM(params[0],WHITE,string);
	SCM(params[0],WHITE,"Советуем Вам сделать скрин-шот наказания. Если Вы считаете, что администаротор не прав, то можете оставить жалобу на сайте mafia-rp.su");
    Ban(params[0]);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unban(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:sban(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:fakeban(playerid,params[])
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<4) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"uis[32]",params[0],params[1],params[2])) return SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Используйте: /ban [ID] [кол-во дней] [причина]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
 	format(string,sizeof(string),"Администратор %s заблокировал игрока %s на %i дней. Причина: %s",playerVariable[playerid][pName],playerVariable[params[0]][pName],params[1],params[2]);
    SCMtA(WHITE,string);
    AdminAction(playerVariable[playerid][pName],string);
    format(string,sizeof(string),"Администратор %s заблокировал Ваш аккаунт на %i дней! Причина: %s",playerVariable[playerid][pName],params[1],params[2]);
    SCM(params[0],WHITE,string);
	SCM(params[0],WHITE,"Советуем Вам сделать скрин-шот наказания. Если Вы считаете, что администаротор не прав, то можете оставить жалобу на сайте mafia-rp.su");
    Kick(params[0]);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:banoff(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unbanoff(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:banip(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:unbanip(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////


CMD:goto(playerid,params[])
{
	new Float:x,Float:y,Float:z,
    	interiorID;
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /goto [ID]");
   	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
    GetPlayerPos(params[0],x,y,z);
    interiorID = GetPlayerInterior(params[0]);
    SetPlayerInterior(playerid,interiorID);
    SetPlayerPos(playerid,x+2,y,z);
    format(string,70,"Администратор %s телепортировался к Вам.",playerVariable[playerid][pName]);
    SCM(params[0],WHITE,string);
    format(string,70,"[{65FF4D}ADM{FFFFFF}] Вы телепортировались к игроку %s.",playerVariable[params[0]][pName]);
    SCM(playerid,WHITE,string);
    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %[%i] телепортировался к игроку %[%i].",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
	SendAdminChat(playerid,WHITE,string,false);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:gethere(playerid,params[])
{
	new Float:x,Float:y,Float:z,
    	interiorID;
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /gethere [ID]");
   	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
    GetPlayerPos(playerid,x,y,z);
    interiorID = GetPlayerInterior(playerid);
    SetPlayerInterior(params[0],interiorID);
    SetPlayerPos(params[0],x+2,y,z);
    format(string,70,"Администратор %s телепортировал Вас к себе.",playerVariable[playerid][pName]);
    SCM(params[0],WHITE,string);
    format(string,70,"[{65FF4D}ADM{FFFFFF}] Вы телепортировали к себе %s.",playerVariable[params[0]][pName]);
    SCM(playerid,WHITE,string);
    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] телепортировал к себе игрока %s[%i].",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
	SendAdminChat(playerid,WHITE,string,false);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:gotocar(playerid,params[])
{
	new Float:x,Float:y,Float:z;
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /gotocar [ID]");
    GetVehiclePos(params[0],x,y,z);
    SetPlayerPos(playerid,x+2,y,z);
    format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Вы телепортировались к транспорту ID:%i.",params[0]);
    SCM(playerid,WHITE,string);
    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] телепортировался к транспорту ID:%i.",
	playerVariable[playerid][pName],playerid,params[0]);
	SendAdminChat(playerid,WHITE,string,false);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:getherecar(playerid,params[])
{
	new Float:x,Float:y,Float:z;
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /getherecar [ID]");
    GetPlayerPos(playerid,x,y,z);
    SetVehiclePos(params[0],x+2,y,z);
    format(string,70,"[{65FF4D}ADM{FFFFFF}] Вы телепортировали к себе транспорт ID:%i.",params[0]);
    SCM(playerid,WHITE,string);
    format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] телепортировал к себе транспорт ID:%i.",
	playerVariable[playerid][pName],playerid,params[0]);
	SendAdminChat(playerid,WHITE,string,false);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:string(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<3) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"s[144]",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /string [текст]");
    format(string,sizeof(string),"[Всем игрокам] %s %s[%i]: %s",adminVariable[playerid][aNameRank],playerVariable[playerid][pName],playerid,params[0]);
    SCMtA(WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:mp(playerid)
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:smp(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:cc(playerid)
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<4) return SCM(playerid,WHITE,NotAccess);
	foreach(new i:Player)
	{
		if(playerVariable[i][pAdmin]!=0) continue;
		for(new j=0;j<100;j++)
		{
			SCM(j,WHITE,"");
		}
	}
	format(string,sizeof(string),"Администратор %s[%i] очистил чат.",playerVariable[playerid][pName],playerid);
	SCMtA(WHITE,string);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:getip(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:checkip(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:makeleader(playerid,params[])
{
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:makeadmin(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<6) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"u",params[0])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /makeadmin [ID]");
    if(playerid==params[0]) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Нельзя использовать команду на себе!");
   	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
    if(CheckSeniorAdm(playerid,params[0],"/makeadmin")==1) return 1;
	playerVariable[params[0]][pAdmin] = 1;
	new row_count;
	format(query,sizeof(query),"INSERT INTO `admins` (`ID`, `NickName`, `Password`) VALUES (%i, %s, %s)",playerVariable[params[0]][pID],
	playerVariable[params[0]][pName],"changeme");
	mysql_tquery(MySQL:DATABASE,query);
	SaveVariableInteger("account","Admin",1,playerVariable[params[0]][pID]);
	format(query,sizeof(query),"SELECT * FROM `admins` WHERE `ID` = '%i' AND `NickName` = '%s' LIMIT 1",playerVariable[params[0]][pID],playerVariable[params[0]][pName]);
	mysql_query(MySQL:DATABASE,query);
	if(cache_get_row_count(row_count)==1) LoadAdminVariables(params[0]);
	format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Вы назначили игрока %s на пост администратора!",playerVariable[params[0]][pName]);
	SCM(playerid,WHITE,string);
	format(string,sizeof(string),"Администратор %s назначил Вас на пост администратора!",playerVariable[playerid][pName]);
	SCM(params[0],WHITE,string);
	format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] назначил игрока %s[%i] на пост администратора!",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0]);
	SendAdminChat(playerid,WHITE,string,false);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:agiverank(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<6) return SCM(playerid,WHITE,NotAccess);
    if(sscanf(params,"ui",params[0],params[1])) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Используйте: /agiverank [ID] [уровень]");
    if(playerid==params[0]) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Нельзя использовать команду на себе!");
   	if(!IsPlayerConnected(params[0])) return SCM(playerid,WHITE,AdmPlayerOffline);
	if(playerVariable[params[0]][pLogged]==false) return SCM(playerid,WHITE,AdmPlayerNotAuthorized);
	if(CheckSeniorAdm(playerid,params[0],"/agiverank")==1) return 1;
	if(!(playerVariable[playerid][pAdmin]>params[1]>=0)) return SCM(playerid,WHITE,"[{FF2424}ADM{FFFFFF}] Выдаваемый уровень администрирования должен быть от 0 до Вашего уровня!");
	playerVariable[params[0]][pAdmin] = params[1];
	SaveVariableInteger("account","Admin",params[1],playerVariable[params[0]][pID]);
	format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Вы назначили администратора %s на %i уровень!",playerVariable[params[0]][pName],params[1]);
	SCM(playerid,WHITE,string);
	format(string,sizeof(string),"Администратор %s назначил Вас на пост администратора %i уровня!",playerVariable[playerid][pName],params[1]);
	SCM(params[0],WHITE,string);
	format(string,sizeof(string),"[{FFF050}ADM{FFFFFF}] Администратор %s[%i] назначил администратора %s[%i] на %i уровень!",
	playerVariable[playerid][pName],playerid,playerVariable[params[0]][pName],params[0],params[1]);
	SendAdminChat(playerid,WHITE,string,false);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

CMD:payday(playerid,params[])
{
    if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
    if(playerVariable[playerid][pAdmin]==0) return SCM(playerid,WHITE,NoSuchCommand);
    if(adminVariable[playerid][aLogged]==false) return SCM(playerid,WHITE,AdmNotAuthorized);
    if(playerVariable[playerid][pAdmin]<7) return SCM(playerid,WHITE,NotAccess);
    PayDay();
	format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] Администратор %s[%i] активировал PayDay.",
	playerVariable[playerid][pName],playerVariable[playerid][pID]);
	SendAdminChat(playerid,WHITE,string,false);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////





















////////////////////////////////////////////////////////////////////////////////

public OnGameModeInit()															// server starts
{
	// MySQL
	new MySQLOpt:options = mysql_init_options();
	mysql_set_option(options,POOL_SIZE,3);
	DATABASE = mysql_connect(SQL_HOST,SQL_USER,SQL_PASS,SQL_DB,options);
	mysql_set_charset("cp1251",DATABASE);
	mysql_tquery(DATABASE,!"SET NAMES 'cp1251'","","");
	mysql_tquery(DATABASE,"SELECT * FROM `info_server`","LoadInfoServer","");
	
	// Timers
	SetTimer("Advertisement",1000*60,true);
	SetTimer("UpdatePlayedTime",1000*60,true);
	SetTimer("PayDay",1000*120,true);
	SetTimer("DeacreasingFuel",1000*30,true);
	
	// other
	PICKUPS[0] = CreatePickup(1318,23,1037.7410,1015.1852,11.0000,-1);//
	PICKUPS[1] = CreatePickup(1318,23,1057.0551,1006.4174,27.1511,-1);//
	PICKUPS[2] = CreatePickup(1318,23,390.3137,173.7907,1008.3828,-1);//
	PICKUPS[3] = CreatePickup(1318,23,344.6231,178.3591,1014.1875,-1);//
	PICKUPS[4] = CreatePickup(2663,23,371.6222,177.5902,1019.9844,-1);//
	PICKUPS[5] = CreatePickup(1239,23,362.1928,173.7070,1008.3828,-1);//
	PICKUPS[6] = CreatePickup(1242,23,349.2532,158.6264,1014.1875,-1);//
	PICKUPS[7] = CreatePickup(334,23,349.4174,160.8898,1014.1875,-1);
	PICKUPS[8] = CreatePickup(2663,23,361.5557,159.4771,1008.3828,-1);//
	PICKUPS[9] = CreatePickup(1275,23,372.9504,171.3146,1019.9844,-1);//
	PICKUPS[10] = CreatePickup(1241,23,349.6003,161.2835,1019.9912,-1);//
	
	PICKUPS[5] = CreatePickup(1318,23,2296.8699,2451.4722,10.8203,-1); // police1 garage
	PICKUPS[4] = CreatePickup(1318,23,2290.1265,2431.2390,10.8203,-1); // police2 office
	PICKUPS[6] = CreatePickup(1318,23,2258.5505,2453.9263,38.6837,-1); // police3 roof
	
	//PICKUPS[3] = CreatePickup(1318,23,2388.3030,2466.0745,10.8203,-1); // court1
	PICKUPS[4] = CreatePickup(1318,23,2446.8689,2376.2734,12.1635,-1); // fbi off
	PICKUPS[5] = CreatePickup(1318,23,2488.2971,2397.2900,4.21090,-1); // fbi garage
	
	// army
	
	PICKUPS[20] = CreatePickup(1318,23,1607.3688,1816.1871,10.8203,-1); // hosp off
	PICKUPS[22] = CreatePickup(1318,23,1617.9523,1787.5884,30.4688,-1); // hosp roof
	PICKUPS[21] = CreatePickup(1318,23,1604.4855,1722.8733,10.8203,-1); // hosp back
	
	PICKUPS[9] = CreatePickup(1318,23,2645.2778,1184.5973,10.8203,-1); // news

	AddPlayerClass(45,1686.2433,1447.7115,10.7694,270.4224,24,500,31,1000,0,0);
	CreateActor(185,1696.7897,1456.7030,11.0000,180);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	ManualVehicleEngineAndLights(); // for auto
	CreateGlobalTextDraws();
	
    zone1 = GangZoneCreate(-1350,2480,-1269,2565); // mafia - stonehenge
	zone2 = GangZoneCreate(-406,1500,-277,1630); // mafia - uho
	zone3 = GangZoneCreate(-25,1677,443,2113); // army
	
	// audio
	//Audio_SetPack("default_pack",true,true);
	
	// mapping
	CreateObject(1419,1704.65637,1453.87769,10.4,0,0,73);
	CreateObject(994,1720.42590,1540.66028,10.5,0,0,104);
	CreateObject(994,1721.72156,1533.93909,10.5,0,0,98);
	CreateObject(19126,1720.68982,1537.21484,10.5,0,0,0);
	
	CreateDynamicObject(19373,-1100.0,416.0,500.0,0.0,0.0,0.0);
	CreateDynamicObject(19373,-1100.0,419.0,500.0,0.0,0.0,0.0);
	CreateDynamicObject(19373,-1100.0,413.0,500.0,0.0,0.0,0.0);
	CreateDynamicObject(19373,-1101.7,420.0,500.0,0.0,0.0,90.0);
	CreateDynamicObject(19373,-1104.7,420.0,500.0,0.0,0.0,90.0);
	CreateDynamicObject(19373,-1107.7,420.0,500.0,0.0,0.0,90.0);
	CreateDynamicObject(19373,-1101.7,412.0,500.0,0.0,0.0,90.0);
	CreateDynamicObject(19373,-1104.7,412.0,500.0,0.0,0.0,90.0);
	CreateDynamicObject(19373,-1107.7,412.0,500.0,0.0,0.0,90.0);
	CreateDynamicObject(19373,-1109.3,413.0,500.0,0.0,0.0,0.0);
	CreateDynamicObject(19373,-1109.3,416.0,500.0,0.0,0.0,0.0);
	CreateDynamicObject(19373,-1109.3,419.0,500.0,0.0,0.0,0.0);
	CreateObject(19379,-1105.31860,416.76840,498.38,0.0,90.0,0.0);
	
	CreateDynamicObject(4639,1114.8934,1725.3459,11.5146,0.0,0.0,-90.0);
	
	// govern
	AddStaticVehicleEx(409,981.8,1084.0570,10.6166,270.0,1,1,600);
	AddStaticVehicleEx(409,981.8,1080.2649,10.6113,270.0,1,1,600);
	AddStaticVehicleEx(405,981.45,1070.4845,10.6919,270.0,1,1,600);
	AddStaticVehicleEx(405,981.45,1074.7042,10.6879,270.0,1,1,600);
	AddStaticVehicleEx(579,982.2,1101.7059,10.7526,270.0,1,1,600);
	AddStaticVehicleEx(579,982.2,1105.9347,10.7502,270.0,1,1,600);
	AddStaticVehicleEx(580,981.82,1111.5883,10.6164,270.0,1,1,600);
	AddStaticVehicleEx(580,981.82,1116.2754,10.6165,270.0,1,1,600);
	AddStaticVehicleEx(487,1094.0,982.0,27.1,10.0,1,1,600);
	AddStaticVehicleEx(487,1112.0,987.0,27.1,27.0,1,1,600);

	// fbi
	AddStaticVehicleEx(490,2542.15,2381.7017,4.3386,90.0,0,0,600);
	AddStaticVehicleEx(490,2542.15,2377.2114,4.3387,90.0,0,0,600);
	AddStaticVehicleEx(490,2542.15,2372.4856,4.3394,90.0,0,0,600);
	AddStaticVehicleEx(490,2542.15,2367.9807,4.3384,90.0,0,0,600);
	AddStaticVehicleEx(490,2542.15,2363.2751,4.3383,90.0,0,0,600);
	new aFBIsultan1 = AddStaticVehicleEx(560,2515.3,2363.4065,3.9237,90.0,0,0,600);
	new aFBIsultan2 = AddStaticVehicleEx(560,2515.3,2368.2422,3.9232,90.0,0,0,600);
	new aFBIsultan3 = AddStaticVehicleEx(560,2515.3,2372.9734,3.9162,90.0,0,0,600);
	AddStaticVehicleEx(579,2525.4,2363.2813,4.1483,270.0,0,0,600);
	AddStaticVehicleEx(579,2525.4,2368.0686,4.1406,270.0,0,0,600);
	new aFBIcheetah1 = AddStaticVehicleEx(415,2515.45,2377.0808,5.9828,90.0166,0,0,600);
	new aFBIcheetah2 = AddStaticVehicleEx(415,2515.45,2381.6326,5.9821,90.1267,0,0,600);
	AddStaticVehicleEx(409,2542.3818,2397.3,4.0109,180.0,0,0,600);
	AddStaticVehicleEx(409,2537.7524,2397.3,4.0109,180.0,0,0,600);
	AddStaticVehicleEx(580,2524.7,2377.0769,4.0071,270.0,0,0,600);
	AddStaticVehicleEx(580,2524.7,2381.5398,4.0071,270.0,0,0,600);
	AddStaticVehicleEx(482,2510.5793,2397.8850,4.3366,180.0,0,0,600);
	AddStaticVehicleEx(487,2471.4229,2391.1145,71.2135,90.0,0,0,600);
	AddStaticVehicleEx(487,2471.0979,2368.8740,71.2254,90.0,0,0,600);
	new flashLight1 = CreateObject(19620,0.0,0.0,0.0,0.0,0.0,0.0);
	new flashLight2 = CreateObject(19620,0.0,0.0,0.0,0.0,0.0,0.0);
	new flashLight3 = CreateObject(19620,0.0,0.0,0.0,0.0,0.0,0.0);
	new flashLight4 = CreateObject(19620,0.0,0.0,0.0,0.0,0.0,0.0);
	new flashLight5 = CreateObject(19620,0.0,0.0,0.0,0.0,0.0,0.0);
	AttachObjectToVehicle(flashLight1,aFBIsultan1,0.0,-0.2,0.85,0.0,0.0,0.0);
	AttachObjectToVehicle(flashLight2,aFBIsultan2,0.0,-0.2,0.85,0.0,0.0,0.0);
	AttachObjectToVehicle(flashLight3,aFBIsultan3,0.0,-0.2,0.85,0.0,0.0,0.0);
	AttachObjectToVehicle(flashLight4,aFBIcheetah1,0.0,-0.35,0.6,0.0,0.0,0.0);
	AttachObjectToVehicle(flashLight5,aFBIcheetah2,0.0,-0.35,0.6,0.0,0.0,0.0);
	
	// police
	AddStaticVehicleEx(598,2282.0662,2442.7,10.5662,360.0,205,1,600);
	AddStaticVehicleEx(598,2277.7825,2442.7,10.5658,360.0,205,1,600);
	AddStaticVehicleEx(598,2273.6155,2442.7,10.5658,360.0,205,1,600);
	AddStaticVehicleEx(598,2269.2285,2442.7,10.5665,360.0,205,1,600);
	AddStaticVehicleEx(598,2260.4468,2442.7,10.5654,360.0,205,1,600);
	AddStaticVehicleEx(598,2256.1523,2442.7,10.5667,360.0,205,1,600);
	AddStaticVehicleEx(598,2251.7607,2442.7,10.5666,360.0,205,1,600);
	AddStaticVehicleEx(599,2260.4744,2477.8,11.0118,180.0,205,1,600);
	AddStaticVehicleEx(599,2256.0583,2477.8,11.0080,180.0,205,1,600);
	AddStaticVehicleEx(599,2251.9363,2477.8,11.0091,180.0,205,1,600);
	AddStaticVehicleEx(601,2277.7905,2477.5,10.5791,180.0,1,1,600);
	AddStaticVehicleEx(601,2273.5916,2477.5,10.5791,180.0,1,1,600);
	AddStaticVehicleEx(525,2282.2229,2459.75,10.9,180.0,53,79,600);
	AddStaticVehicleEx(525,2278.0208,2459.75,10.9,180.0,53,79,600);
	AddStaticVehicleEx(525,2273.8210,2459.75,10.9,180.0,53,79,600);
	AddStaticVehicleEx(427,2295.1699,2443.6919,10.9,360.0,205,1,600);
	AddStaticVehicleEx(427,2291.2080,2443.6152,10.9,360.0,205,1,600);
	AddStaticVehicleEx(497,2265.2483,2471.55,38.8604,360.0,205,1,600);
	AddStaticVehicleEx(497,2280.9624,2471.55,38.8626,360.0,205,1,600);
	AddStaticVehicleEx(523,2260.2388,2457.8,10.3850,180.0,0,0,600);
	AddStaticVehicleEx(523,2256.3967,2457.8,10.3871,180.0,0,0,600);
	AddStaticVehicleEx(523,2251.9214,2457.8,10.3896,180.0,0,0,600);
	AddStaticVehicleEx(523,2260.2883,2461.6,10.3907,360.0,0,0,600);
	AddStaticVehicleEx(523,2256.4072,2461.6,10.3906,360.0,0,0,600);
	AddStaticVehicleEx(523,2251.9211,2461.6,10.3903,360.0,0,0,600);
	
	// army
	
	// hospital
	AddStaticVehicleEx(416,1590.6499,1849.1,10.9697,180.0,1,3,600);
	AddStaticVehicleEx(416,1594.8217,1849.1,10.9695,180.0,1,3,600);
	AddStaticVehicleEx(416,1599.0747,1849.1,10.9694,180.0,1,3,600);
	AddStaticVehicleEx(416,1603.3191,1849.1,10.9695,180.0,1,3,600);
	AddStaticVehicleEx(487,1612.0781,1802.2,30.6406,360.0,3,1,600);
	AddStaticVehicleEx(487,1599.0455,1802.2,30.6457,360.0,3,1,600);
	AddStaticVehicleEx(499,1620.1934,1849.1,10.9141,180.0,3,1,600);
	AddStaticVehicleEx(426,1607.5404,1850.1730,10.5633,180.0,3,3,600);
	AddStaticVehicleEx(426,1611.7750,1850.2308,10.5633,180.0,3,3,600);
	AddStaticVehicleEx(426,1615.9801,1850.1042,10.5634,180.0,3,3,600);
	AddStaticVehicle(462,1706.8568,1465.2981,10.4079,289.0,163,163);
	AddStaticVehicle(462,1706.3885,1463.6250,10.4096,292.0,163,163);
	AddStaticVehicle(462,1705.8033,1461.8351,10.4097,300.0,163,163);
	AddStaticVehicle(462,1705.2404,1460.1781,10.4089,295.0,163,163);
	AddStaticVehicle(462,1704.8307,1458.5776,10.4090,292.0,163,163);
	
	// faggio - hospital
	AddStaticVehicleEx(462,1593.6302,1832.6196,10.42,180.0,163,163,600);
	AddStaticVehicleEx(462,1595.8481,1832.6899,10.42,180.0,163,163,600);
	AddStaticVehicleEx(462,1597.9888,1832.7008,10.42,180.0,163,163,600);
	AddStaticVehicleEx(462,1600.0680,1832.6942,10.42,180.0,163,163,600);
	AddStaticVehicleEx(462,1602.2068,1832.6854,10.42,180.0,163,163,600);
	AddStaticVehicleEx(462,1604.3335,1832.6678,10.42,180.0,163,163,600);
	
	// taxi
	AddStaticVehicleEx(420,2464.90,1345.61,10.6026,360.0,6,1,600);
	AddStaticVehicleEx(420,2458.47,1345.61,10.6011,360.0,6,1,600);
	AddStaticVehicleEx(420,2452.09,1345.61,10.5990,360.0,6,1,600);
	AddStaticVehicleEx(438,2452.09,1336.50,10.5998,180.0,6,1,600);
	AddStaticVehicleEx(438,2458.47,1336.50,10.6001,180.0,6,1,600);
	AddStaticVehicleEx(438,2464.90,1336.50,10.6003,180.0,6,1,600);
	
	// bus
	AddStaticVehicleEx(437,2767.6133,1265.5289,10.8833,270.0,226,229,600);
	AddStaticVehicle(437,2767.6299,1271.9460,10.8833,270.0,226,229);
	AddStaticVehicle(437,2767.5881,1278.3071,10.8833,270.0,226,229);
	AddStaticVehicle(437,2767.5754,1284.7698,10.8833,270.0,226,229);
	AddStaticVehicle(437,2767.4978,1291.1041,10.8833,270.0,226,229);
	AddStaticVehicle(437,2767.4824,1296.7198,10.8833,270.0,226,229);
	
	// mechanic
	AddStaticVehicle(525,2100.7144,1409.1077,10.6922,360.0,43,17);
	AddStaticVehicle(525,2107.1392,1409.1051,10.6989,360.0,43,17);
	AddStaticVehicle(525,2113.6013,1409.0767,10.7006,360.0,43,17);
	AddStaticVehicle(525,2119.9688,1409.0902,10.6850,360.0,43,17);
	AddStaticVehicle(525,2126.3979,1409.1039,10.7001,360.0,43,17);
	AddStaticVehicle(525,2132.7322,1409.0400,10.6986,360.0,43,17);
	
	// pizzaboy
	AddStaticVehicle(448,2372.2688,2022.4340,10.4196,140.0,175,6);
	AddStaticVehicle(448,2374.2349,2022.3234,10.4192,140.0,175,6);
	AddStaticVehicle(448,2376.2944,2022.3685,10.4188,140.0,175,6);
	AddStaticVehicle(448,2378.6189,2022.3756,10.4195,140.0,175,6);
	AddStaticVehicle(448,2380.8914,2022.3195,10.4189,140.0,175,6);
	AddStaticVehicle(448,2382.9519,2022.2837,10.4188,140.0,175,6);
	
	// trasher
	AddStaticVehicle(408,2295.7302,2738.3870,11.3750,270.0,26,26);
	AddStaticVehicle(408,2295.8091,2747.9150,11.3761,270.0,26,26);
	AddStaticVehicle(408,2295.6865,2754.5466,11.3649,270.0,26,26);
	AddStaticVehicle(408,2295.7483,2763.9771,11.3711,270.0,26,26);
	AddStaticVehicle(408,2295.8491,2770.4812,11.3565,270.0,26,26);
	AddStaticVehicle(408,2295.6516,2780.0242,11.3646,279.0,26,26);
	
	// news
	VehKarts[0] = AddStaticVehicleEx(488,2653.9497,1213.6,27.1,180.0,158,49,600);
	AddStaticVehicleEx(488,2635.8530,1213.6,27.1,180.0,158,49,600);
	AddStaticVehicleEx(426,2662.6108,1167.3,10.8,360.0,158,158,600);
	AddStaticVehicleEx(426,2657.5613,1167.3,10.8,360.0,158,158,600);
	AddStaticVehicleEx(426,2652.3071,1167.3,10.8,360.0,158,158,600);
	AddStaticVehicleEx(582,2647.5701,1167.9,10.8,360.0,158,49,600);
	AddStaticVehicleEx(582,2642.5776,1167.9,10.8,360.0,158,49,600);
	AddStaticVehicleEx(582,2637.3284,1167.9,10.8,360.0,158,49,600);
	
	// drive school
	
	// mafia1


	// mafia2
	
	
	// mafia3


	// mafia4


	// mafia5
	
	// rent cheap
	AddStaticVehicleEx(421,2247.0,2034.6324,10.5634,270.0,60,1,300);
	AddStaticVehicleEx(421,2247.0,2042.5090,10.5630,270.0,60,1,300);
	AddStaticVehicleEx(421,2247.0,2050.2695,10.5633,270.0,60,1,300);
	AddStaticVehicleEx(516,2234.8,2050.3049,10.5639,90.0,60,1,300);
	AddStaticVehicleEx(516,2234.8,2042.4319,10.5633,90.0,60,1,300);
	AddStaticVehicleEx(516,2234.8,2034.6493,10.5637,90.0,60,1,300);
	
	//karts
	AddStaticVehicleEx(571,1115.0,1729.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1731.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1733.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1735.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1737.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1739.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1741.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1743.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1745.0,10.15,90.0,0,0,600);
	AddStaticVehicleEx(571,1115.0,1747.0,10.15,90.0,0,0,600);
	
    printf("%i",heapspace());
	return 1;
}

public OnGameModeExit()															// server finishes
{
	//Audio_DestroyTCPServer();
	DisconnectMySQL();
	return 1;
}

public OnPlayerRequestClass(playerid,classid)									// Игрок увидел кнопки SPAWN, <<, >>
{
	SetPlayerWeather(playerid,17);
	SetPlayerTime(playerid,3,0);
	SetPlayerFacingAngle(playerid,0);
	SetPlayerCameraPos(playerid,2385.4634,2144.1248,23.5843);
	SetPlayerCameraLookAt(playerid,2065.4634,2144.1248,20.5843,2);
	PlayerTextDrawShow(playerid,PreviewIcon[playerid]);
	PlayerPlaySound(playerid,0,0.0,0.0,0.0);
	return 1;
}

public OnPlayerConnect(playerid)                                                // player connects
{
	new query1[128],
	    query2[128],
		IP[16],
		row_count;
	
	print("1. Старт сессии..");
	print("2. Очистка переменных..");
	RemovePlayerVariables(playerid);
	GetPlayerName(playerid,playerVariable[playerid][pName],MAX_PLAYER_NAME);
	GetPlayerIp(playerid,IP,16);
	format(query1,sizeof(query1),"SELECT * FROM `banip` WHERE `BannedIP` = '%s'",IP);
	mysql_query(MySQL:DATABASE,query1);
	cache_get_row_count(row_count);
	if(row_count>0)
	{
		SCM(playerid,WHITE,"Этот IP-адрес заблокирован!");
		print("2.1 ИП забанен!");
		Kick(playerid);
	}
	print("3. Получен ник аккаунта.");
	new globalID = CheckAccount(playerid);
	
	//new Float:log_pos_x,Float:log_pos_y,Float:log_pos_z;
    //GetPlayerPos(playerid,log_pos_x,log_pos_y,log_pos_z);
    //PlayerPlaySound(playerid,1183,log_pos_x,log_pos_y,log_pos_z);
    
 	if(globalID!=0)
	{
	    printf("4.1. Аккаунт найден! Его глобальный ИД - %i",globalID);
        new dialog[128+MAX_PLAYER_NAME];
   		format(query2,sizeof(query2),"SELECT * FROM `bans` WHERE `PlayerID` = '%i'",globalID);
		mysql_query(MySQL:DATABASE,query2);
		if(cache_get_row_count(row_count))
		{
			new BanString[128],
			    BanAdmin[24],
			    BanDays,
			    BanReason[32];
			cache_get_value_name(0,"AdminNickName",BanAdmin,24);
			cache_get_value_name_int(0,"Days",BanDays);
			cache_get_value_name(0,"Reason",BanReason,32);
			format(BanString,sizeof(BanString),"Ваш аккаунт заблокирован!\n\nАдминистратор: %s\nОсталось дней: %i\nПричина: %s",BanAdmin,BanDays,BanReason);
			SPD(playerid,12,DSM,"Оповещение",BanString,"Выход","");
		}
        format(dialog,sizeof(dialog),LogAccount,playerVariable[playerid][pName]);
        SPD(playerid,2,DSP,"Авторизация",dialog,"Далее","Отмена");
    }
    else
	{
		print("4.2 Аккаунт не найден!");
        new dialog[344+MAX_PLAYER_NAME];
        format(dialog,sizeof(dialog),RegAccount,playerVariable[playerid][pName]);
        SPD(playerid,1,DSI,"Регистрация",dialog,"Далее","Отмена");
    }
	print("5. Приветствие..");
	printf("6. Информация об аккаунте:\n\tID: %i\n\tNickName: %s\n\tPassword: %s",playerVariable[playerid][pID],
	playerVariable[playerid][pName],playerVariable[playerid][pPassword]);
    
    CreatePlayer3DTextLabel(playerid,"{DDDDDD}Джереми\n\n{60F339}Квестовый персонаж\n{CCCCCC}Нажмите [ ALT ]",WHITE,1696.7897,1456.7030,11.0000,10,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);

    CreatePlayer3DTextLabel(playerid,"Правительство",COLOR_GOVERN,1037.7410,1015.1852,11.0000,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    CreatePlayer3DTextLabel(playerid,"Вход №2",COLOR_GOVERN,1057.0551,1006.4174,27.1511,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    CreatePlayer3DTextLabel(playerid,"Выход",COLOR_GOVERN,390.3137,173.7907,1008.3828,DISTANCE_BETWEEN_PLAYERS,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    CreatePlayer3DTextLabel(playerid,"Выход на крышу",COLOR_GOVERN,344.6231,178.3591,1014.1875,DISTANCE_BETWEEN_PLAYERS,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);

	CreatePlayer3DTextLabel(playerid,"Полицейский департамент",COLOR_POLICE,2290.1265,2431.2390,10.8203,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    CreatePlayer3DTextLabel(playerid,"Вход №2",COLOR_POLICE,2296.8699,2451.4722,10.8203,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    CreatePlayer3DTextLabel(playerid,"Вход №3",COLOR_POLICE,2258.5505,2453.9263,38.6837,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    
	CreatePlayer3DTextLabel(playerid,"Министерство Юстиции",WHITE,2388.3030,2466.0745,10.8203,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
	
    CreatePlayer3DTextLabel(playerid,"Федеральное Бюро Расследований",COLOR_POLICE,2446.8689,2376.2734,12.1635,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    CreatePlayer3DTextLabel(playerid,"Вход №2",COLOR_POLICE,2488.2971,2397.2900,4.2109,15,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    
    // army
    
    CreatePlayer3DTextLabel(playerid,"Центральная больнца",COLOR_HOSPITAL,1607.3688,1816.1871,10.8203,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    CreatePlayer3DTextLabel(playerid,"Вход №2",COLOR_HOSPITAL,1617.9523,1787.5884,30.4688,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
    CreatePlayer3DTextLabel(playerid,"Вход №3",COLOR_HOSPITAL,1604.4855,1722.8733,10.8203,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);

	CreatePlayer3DTextLabel(playerid,"Радиоцентр",COLOR_NEWS,2645.2778,1184.5973,10.8203,DISTANCE_BETWEEN_PLAYERS*2,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
	
	// drive school
	
	PreviewIcon[playerid] = CreatePlayerTextDraw(playerid,540,8,"M A F I A");
	print("7. Конец входа.");
	TogglePlayerSpectating(playerid,false);
	CreatePlayersTextDraw(playerid);
	
	SetPlayerMapIcon(playerid,10,1158.5143,2072.2415,11.0625,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,11,1873.1842,2071.8477,11.0625,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,12,2170.1443,2795.8250,10.8203,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,13,2366.1816,2071.0344,10.8203,10,0,MAPICON_LOCAL);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

public OnPlayerDisconnect(playerid,reason)										// player disconnects
{
	SaveAccount(playerid);
	RemovePlayerVariables(playerid);
	print("N. Переменные очищены.");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

public OnPlayerSpawn(playerid)													// Игрок спавнится
{
	GangZoneShowForAll(zone1,0xFF0000AA);
	GangZoneShowForAll(zone2,0xFF0000AA);
	GangZoneShowForAll(zone3,0xFF0000AA);
	SetPlayerCheckpoint(playerid,1696.7897,1456.7030,10.7616,1);
	onCheckpoint[playerid] = true;
	PlayerPlaySound(playerid,1186,0.0,0.0,0.0);
	return 1;
}

public OnPlayerDeath(playerid,killerid,reason)								    // Игрок умирает
{
	return 1;
}

public OnVehicleSpawn(vehicleid)												// Машина спавнтся
{
	ClearVehicle(vehicleid);
	return 1;
}

public OnVehicleDeath(vehicleid,killerid)										// Игрок взорвал машину
{
	ClearVehicle(vehicleid);
	return 1;
}

////////////////////////////////////////////////////////////////////////////////

public OnPlayerText(playerid,text[])											// Игрок пишет в чат
{
	if(playerVariable[playerid][pLogged]==false) return SCM(playerid,WHITE,NotAuthorized);
	if(playerVariable[playerid][pMute]!=0)
	{
		SCM(playerid,WHITE,InMute);
		SetPlayerChatBubble(playerid,"Что-то мямлит",WHITE,30.0,5000);
		return 0;
	}
	else if(CheckString(text,")") || CheckString(text,":)") || CheckString(text,":-)"))
	{
	    new say[36];
	    format(say,sizeof(say),"%s улыбается",playerVariable[playerid][pName]);
	    ProxDetector(playerid,30.0,say,PINK1,PINK2,PINK3,PINK4,PINK5);
	    return 0;
	}
	else if(CheckString(text,"(") || CheckString(text,":(") || CheckString(text,":-("))
	{
	    new say[36];
	    format(say,sizeof(say),"%s грустит",playerVariable[playerid][pName]);
	    ProxDetector(playerid,30.0,say,PINK1,PINK2,PINK3,PINK4,PINK5);
	    return 0;
	}
	else if(CheckString(text,"))") || CheckString(text,":D"))
	{
	    new say[36];
	    format(say,sizeof(say),"%s смеётся",playerVariable[playerid][pName]);
	    ProxDetector(playerid,30.0,say,PINK1,PINK2,PINK3,PINK4,PINK5);
	    return 0;
	}
	else if(CheckString(text,"(("))
	{
	    new say[50];
	    format(say,sizeof(say),"%s сильно расстроился",playerVariable[playerid][pName]);
	    ProxDetector(playerid,30.0,say,PINK1,PINK2,PINK3,PINK4,PINK5);
	    return 0;
	}
	else if(CheckString(text,"xD"))
	{
	    new say[50];
	    format(say,sizeof(say),"%s хохочет во весь голос",playerVariable[playerid][pName]);
	    ProxDetector(playerid,30.0,say,PINK1,PINK2,PINK3,PINK4,PINK5);
	    return 0;
	}
	else if(CheckString(text,":P"))
	{
	    new say[38];
	    format(say,sizeof(say),"%s показал(а) язык",playerVariable[playerid][pName]);
	    ProxDetector(playerid,30.0,say,PINK1,PINK2,PINK3,PINK4,PINK5);
	    return 0;
	}
	else if(CheckString(text,":O"))
	{
	    new say[38];
	    format(say,sizeof(say),"%s удивился(лась)",playerVariable[playerid][pName]);
	    ProxDetector(playerid,30.0,say,PINK1,PINK2,PINK3,PINK4,PINK5);
	    return 0;
	}
	else if(CheckString(text,"q"))
	{
		if(playerVariable[playerid][pAdmin]>0)
		{
			new say[68];
			format(say,sizeof(say),"%s показал(а) распальцовку {65FF4D}AdminsTeam",playerVariable[playerid][pName]);
			ProxDetector(playerid,30.0,say,PINK1,PINK2,PINK3,PINK4,PINK5);
			ApplyAnimation(playerid,"GHANDS","gsign1LH",4.1,0,0,0,0,0,1);
			return 0;
		}
	}
	new say[144],
		dop[56];
	format(dop,sizeof(dop), " - {EDE3FF}%s[%i]",playerVariable[playerid][pName],playerid);
	strcat(say," ");
	strcat(say,text);
	strcat(say,dop);
	ProxDetector(playerid,30.0,say,WHITE1,WHITE2,WHITE3,WHITE4,WHITE5);
	return 0;
}

public OnPlayerCommandText(playerid,cmdtext[])									// Игрок использовал команду
{
    return SCM(playerid,WHITE,NoSuchCommand);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)					// Игрок входит в авто (двигатель, фары, сигнализация, замок, топливо)
{
	if(ispassenger==0)
	{
		if(vehicleVariable[vehicleid][vLock]==false)
		{
			GameTextForPlayer(playerid,"vehicle is closed",3000,4);
			return 1;
		}
	}
	if(2<=vehicleid<=8) { if(playerVariable[playerid][pOrgID]!=1) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник Правительства!"); }
	if(10<=vehicleid<=26) { if(playerVariable[playerid][pOrgID]!=2) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник ФБР!"); }
	if(29<=vehicleid<=53) { if(playerVariable[playerid][pOrgID]!=3) return SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не сотрудник Полицейского Департамента!"); }
	
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)									// Игрок выходит из авто
{
	return 1;
}

public OnPlayerStateChange(playerid,newstate,oldstate)				      		// Игрок сменил статус (пасажир,пешеход,водитель)
{
	if(newstate==PLAYER_STATE_WASTED)
	{
		if(playerVariable[playerid][pCash]>0)
		{
			GivePlayerMoney(playerid,100);
			playerVariable[playerid][pCash]+=100;
			return 1;
		}
		return 1;
	}
	if(newstate==PLAYER_STATE_DRIVER)
	{
        new carID = GetPlayerVehicleID(playerid);
        GetPlayerPos(playerid,vehicleVariable[carID][vX],vehicleVariable[carID][vY],vehicleVariable[carID][vZ]);
        TextDrawShowForPlayer(playerid,SBox);
        TextDrawShowForPlayer(playerid,SBox1);
        PlayerTextDrawShow(playerid,CarSpeed[playerid]);
        PlayerTextDrawShow(playerid,CarFuel[playerid]);
        PlayerTextDrawShow(playerid,CarMilliage[playerid]);
        PlayerTextDrawShow(playerid,CarLights[playerid]);
        PlayerTextDrawShow(playerid,CarEngine[playerid]);
        SpeedTimer[playerid] = SetTimerEx("UpdateSpeed",200,1,"d",playerid);
		SCM(playerid,WHITE,"[{8BFFF3}Подсказка{FFFFFF}] Используйте /cmenu для управления транспортом");
		return 1;
	}
	if(oldstate==PLAYER_STATE_DRIVER)
	{
	    TextDrawHideForPlayer(playerid,SBox);
	    TextDrawHideForPlayer(playerid,SBox1);
	    PlayerTextDrawHide(playerid,CarSpeed[playerid]);
	    PlayerTextDrawHide(playerid,CarFuel[playerid]);
	    PlayerTextDrawHide(playerid,CarMilliage[playerid]);
	    PlayerTextDrawHide(playerid,CarLights[playerid]);
	    PlayerTextDrawHide(playerid,CarEngine[playerid]);
	    KillTimer(SpeedTimer[playerid]);
	    return 1;
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)										// Игрок вошёл в чекпоинт
{
	if(onCheckpoint[playerid][0])
	{
	    SPD(playerid,555,DSL,"{FFD700}Квесты","{FFD700}1. {FFFFFF}Паспорт\n{FFD700}2. {FFFFFF}Грузчики\n{FFD700}3. \
		  {FFFFFF}Вод.права\n{FFD700}4. {FFFFFF}Такси\n{FFD700}5. {FFFFFF}Автобус\n{FFD700}6. \
		  {FFFFFF}Одежда\n{FFD700}7. {FFFFFF}Дом","Выбрать","Закрыть");
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)										// Игрок покинул чекпоинт
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)									// Игрок вошёл в гоночный чекпоинт
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)									// Игрок покинул гоночный чекпоинт
{
	return 1;
}

public OnRconCommand(cmd[])														// Использование RCON команд
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)											// Игрок изменил спавн
{
	return 1;
}

public OnObjectMoved(objectid)													// Объект движется
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)									// Объект игрока движется
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)									// Игрок наступил на пикап
{
	if(pickupid==PICKUPS[0])
	{
		SetPlayerPos(playerid,384.808624,173.804992,1008.3828);
		SetPlayerFacingAngle(playerid,90.0);
		SetPlayerInterior(playerid,3);
		SetPlayerVirtualWorld(playerid,1);
		SetCameraBehindPlayer(playerid);
	}
	else if(pickupid==PICKUPS[1])
	{
		SetPlayerPos(playerid,344.6306,176.5382,1014.1875);
		SetPlayerFacingAngle(playerid,180.0);
		SetPlayerInterior(playerid,3);
		SetPlayerVirtualWorld(playerid,1);
		SetCameraBehindPlayer(playerid);
	}
	else if(pickupid==PICKUPS[2])
	{
		SetPlayerPos(playerid,1039.0498,1017.2746,11.0000);
		SetPlayerFacingAngle(playerid,0.0);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		SetCameraBehindPlayer(playerid);
	}
	else if(pickupid==PICKUPS[3])
	{
		SetPlayerPos(playerid,1059.2025,1005.6715,27.1568);
		SetPlayerFacingAngle(playerid,-90.0);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		SetCameraBehindPlayer(playerid);
	}
	else if(pickupid==PICKUPS[4] || pickupid==PICKUPS[8]) SPD(playerid,270,DSL,"Продукты на складе Правительства",string_ORG_FOOD,"Выбрать","Закрыть");
	else if(pickupid==PICKUPS[5]) SPD(playerid,100,DSM,"Информация","wefrerthyj","Закрыть","");
	else if(pickupid==PICKUPS[6])
	{
		if(playerVariable[playerid][pOrgID]!=1) return SCM(playerid,WHITE,NotInGovern);
		SetPlayerArmour(playerid,100.0);
		playerVariable[playerid][pArmor]=100.0;
	}
	else if(pickupid==PICKUPS[7])
	{
		if(playerVariable[playerid][pOrgID]!=1) return SCM(playerid,WHITE,NotInGovern);
		SPD(playerid,101,DSL,"Выберите оружие","1. Дубинка\n2. Пистолет Desert Eagle","Выбрать","Закрыть");
	}
	else if(pickupid==PICKUPS[9])
	{
		if(playerVariable[playerid][pOrgID]!=1) return SCM(playerid,WHITE,NotInGovern);
		if(playerVariable[playerid][pOrgWorking]==true) SPD(playerid,102,DSM,"Переодеться",string_FORM_UNPUT,"Снять","Закрыть");
		else SPD(playerid,103,DSM,"Переодеться",string_FORM_PUT,"Одеть","Закрыть");
	}
	else if(pickupid==PICKUPS[10])
	{
		if(playerVariable[playerid][pOrgID]!=1) return SCM(playerid,WHITE,NotInGovern);
		if(playerVariable[playerid][pHeal]>=100) return SCM(playerid,WHITE,"[{8BFFF3}Подсказка{FFFFFF}] Вы здоровы!");
		SPD(playerid,104,DSM,"Лечение","Вы действительно хотите пройти лечение?","Начать","Закрыть");
	}
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)							// Смена наклеек
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)						// Перекраска (тюнинг)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)					// Перекраска (тюнинг)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)									// Происходит действие в меню
{
	return 1;
}

public OnPlayerExitedMenu(playerid)												// Происходит сокрытие меню
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)			// Игрок сменил интерьер
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)						// Игрок нажал на кнопку
{
	if(newkeys==KEY_ACTION)
	{
		if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
			new carID = GetPlayerVehicleID(playerid);
			switch(vehicleVariable[carID][vEngine])
			{
				case false:
				{
				    vehicleVariable[carID][vEngine]=true;
				    SetVehicleParams(carID);
					format(string,sizeof(string),"%s[%i] завел двигатель",playerVariable[playerid][pName],playerid);
					ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					return 1;
				}
				case true:
				{
				    vehicleVariable[carID][vEngine]=false;
					SetVehicleParams(carID);
					format(string,sizeof(string),"%s[%i] заглушил двигатель",playerVariable[playerid][pName],playerid);
					ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					return 1;
				}
			}
		}
	}
	else if(newkeys==KEY_FIRE)
	{
        if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
        {
			new carID = GetPlayerVehicleID(playerid);
			switch(vehicleVariable[carID][vLights])
			{
				case false:
				{
					vehicleVariable[carID][vLights]=true;
					SetVehicleParams(carID);
					format(string,sizeof(string),"%s[%i] включил фары",playerVariable[playerid][pName],playerid);
					ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					return 1;
				}
				case true:
				{
					vehicleVariable[carID][vLights]=false;
					SetVehicleParams(carID);
					format(string,sizeof(string),"%s[%i] выключил фары",playerVariable[playerid][pName],playerid);
					ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					return 1;
				}
			}
		}
	}
	else if(newkeys==KEY_ANALOG_LEFT)
	{
		if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
			new carID = GetPlayerVehicleID(playerid);
			switch(vehicleVariable[carID][vTurnLeft])
			{
				case false:
				{
					vehicleVariable[carID][vTurnLeft]=true;
					new light1 = CreateObject(19294,0.0,0.0,0.0,0.0,0.0,0.0);
					new light2 = CreateObject(19294,0.0,0.0,0.0,0.0,0.0,0.0);
					vehicleVariable[carID][vLeftID1]=light1;
					vehicleVariable[carID][vLeftID2]=light2;
					AttachObjectToVehicle(light1,carID,0.0,0.0,0.0,0.0,0.0,0.0);
					AttachObjectToVehicle(light2,carID,0.0,0.0,0.0,0.0,0.0,0.0);
					return 1;
				}
				case true:
				{
					vehicleVariable[carID][vTurnLeft]=false;
					DestroyObject(vehicleVariable[carID][vLeftID1]);
					DestroyObject(vehicleVariable[carID][vLeftID2]);
					vehicleVariable[carID][vLeftID1]=EOS;
					vehicleVariable[carID][vLeftID2]=EOS;
					return 1;
				}
			}
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)							// Вызывается при RCON логине
{
	return 1;
}

public OnPlayerUpdate(playerid)													// Таймер который не работает только при АФК через ESC
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)							// Игрок кликнул на глобальный текстдрав
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)			// Игрок кликнул на свой текстдрав
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)									// Один игрок увидел иного
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)									// Один игрок перестал видеть иного
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)								// Один игрок увидел авто
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)								// Один игрок перестал видеть авто
{
	return 1;
}

public OnPlayerCommandPerformed(playerid,cmdtext[],success)
{
	if(success==-1) return SCM(playerid,WHITE,NoSuchCommand);
	return 1;
}

public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
    switch(dialogid)
	{
		case 1:
		{
            if(!response)
			{
                SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Введите /q(uit), чтобы выйти из игры.");
                Kick(playerid);
                return 1;
			}
   			if(!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 32)
   			{
                new dialog[380+24+10];
                format(dialog,sizeof(dialog),RegAccount,playerVariable[playerid][pName]);
                SPD(playerid,1,DSI,"Регистрация.",dialog,"Далее","Отмена");
                return 1;
			}
			CreateAccount(playerid,inputtext);
			SpawnPlayer(playerid);
    	}
        case 2:
		{
            if(!response || strlen(inputtext)==0)
			{
                SCM(playerid,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Введите /q(uit), чтобы выйти из игры.");
                Kick(playerid);
                return 1;
			}
			if(playerVariable[playerid][pWrongPassword]==2 && strcmp(playerVariable[playerid][pPassword],inputtext,true))
			{
				SPD(playerid,3,DSM,"Ошибка авторизации!",
				"Вы использовали 3 попытки для авторизации, за что были кикнуты!\n\n\nС уважением, команда Mafia Role Play!","Выйти","");
				Kick(playerid);
				return 1;
			}
      		if(!strcmp(playerVariable[playerid][pPassword],inputtext,true)) LoadAccount(playerid,inputtext);
      		else
      		{
				playerVariable[playerid][pWrongPassword]++;
	            new dialog[140+MAX_PLAYER_NAME];
             	format(dialog,sizeof(dialog),LogAccount,playerVariable[playerid][pName]);
                SPD(playerid,2,DSP,"Авторизация",dialog,"Войти","Отмена");
                return 1;
      		}
      		SpawnPlayer(playerid);
      		format(string,sizeof(string),"~w~welcome~n~~r~%s",playerVariable[playerid][pName]);
			GameTextForPlayer(playerid,string,5000,1);
        }
        case 3:
        {
            if(!response || listitem==0) strmid(playerVariable[playerid][pSex],"мужской",0,8,8);
			else strmid(playerVariable[playerid][pSex],"женский",0,8,8);
			SaveVariableString("account","Sex",playerVariable[playerid][pSex],playerVariable[playerid][pID]);
			return 1;
		}
		case 4:
		{
			if(!response || listitem==0) strmid(playerVariable[playerid][pSkinIDColor],"светлый",0,8,8);
			else strmid(playerVariable[playerid][pSkinIDColor],"темный",0,8,8);
			SaveVariableString("account","SkinColor",playerVariable[playerid][pSkinIDColor],playerVariable[playerid][pID]);
			return 1;
		}
		case 5:
		{
			if(!response) playerVariable[playerid][pWhereKnew] = 0;
			else playerVariable[playerid][pWhereKnew] = listitem+1;
			SaveVariableString("account","WhereKnew",playerVariable[playerid][pWhereKnew],playerVariable[playerid][pID]);
			return 1;
		}
		case 6:
		{
			if(!response)
			{
                strmid(playerVariable[playerid][pPromocode],"",0,24,24);
				return 1;
			}
			strmid(playerVariable[playerid][pPromocode],inputtext,0,24,24);
			SaveVariableString("account","Promocode",playerVariable[playerid][pPromocode],playerVariable[playerid][pID]);
			return 1;
		}
		case 7:
		{
            Kick(playerid);
            return 1;
		}
		case 8:
		{
		    return 1;
		}
		case 9:
		{
			return 1;
		}
		case 10:
		{
			Kick(playerid);
			return 1;
		}
		case 11:
		{
			Kick(playerid);
			return 1;
		}
		case 12:
		{
			Kick(playerid);
			return 1;
		}
		case 13:
		{
		    return 1;
		}
		case 17:
		{
			if(response) return SPD(playerid,55,DSL,"Справочник",string_DIR,"Выбрать","Закрыть");
			else return 1;
		}
		case 20:
		{
		    if(response)
		    {
				if(listitem==0)
				{
					new list[512];
					format(list,sizeof(list),"Имя:\t\t\t%s\nУровень:\t\t%i\nОпыт:\t\t\t%i из %i\nПол:\t\t\t%s\nНомер телефона:\t\t%i\nСупруг(а):\t\t%s\n\n\n\n\n\n\n\n\n\n\n",
					playerVariable[playerid][pName],playerVariable[playerid][pLVL],playerVariable[playerid][pEXP],(playerVariable[playerid][pLVL]+1)*2,
					playerVariable[playerid][pSex],playerVariable[playerid][pPhoneNumber],playerVariable[playerid][pSpouse]);
					SPD(playerid,21,DSM,"Статистика аккаунта",list,"Назад","Выход");
				}
				if(listitem==1)
				{

				}
			}
			else return 1;
		}
		case 21:
		{
			if(response)
			{

			}
			else return SPD(playerid,20,DSL,"Меню",string_MENU,"Выбрать","Закрыть");
		}
		case 22:
		{
			return 1;
		}
		case 23:
		{
			return 1;
		}
		case 24:
		{
			return 1;
		}
		case 25:
		{
			return 1;
		}
		case 30:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: return 1;
					case 1: return 1;
				}
			}
			else return 1;
			return 1;
		}
		case 33:
		{
			return 1;
		}
		case 35:
		{
			return 1;
		}
		case 36:
		{
			return 1;
		}
		case 37:
		{
		    return 1;
		}
		case 38:
		{
			return 1;
		}
		case 39:
		{
			return 1;
		}
		case 40:
		{
		    if(response)
		    {
				if(listitem==0) return SPD(playerid,41,DSL,"Важные места","1. \n2. \3. n\4. n\5. n\6. n\7. n\8. n\n\n\n\n\n\n\n\n\n\n","Выбрать","Закрыть");
				if(listitem==1) return SPD(playerid,42,DSL,"Государственные организации","1. Правительство\n2. Офис ФБР\n3. Полицейский департамент\n4. Национальная армия\n5. Центральная больница\n6. Радиоцентр\n7. Автошкола","Выбрать","Назад");
				if(listitem==2) return SPD(playerid,43,DSL,"Нелегальные организации","1. Семья X\n2. Семья Y\n3. Семья Z\n4. Семья W\n5. Семья V","Выбрать","Назад");
				if(listitem==3) return SPD(playerid,44,DSL,"По работе","1. ","Выбрать","Назад");
				if(listitem==4) return SPD(playerid,45,DSL,"Развлечения","1. 2. 3. 4.","Выбрать","Назад");
			}
			else return 1;
		}
		case 41:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
	 				case 0: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 1: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 2: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 3: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 4: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 5: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 6: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 7: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 8: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 9: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 10: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 11: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 12: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 13: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 14: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 15: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 16: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
					case 17: return SetPlayerCheckpoint(playerid,0.0,0.0,0.0,5);
				}
			}
			else return SPD(playerid,40,DSL,"Навигатор",string_GPS,"Выбрать","Закрыть");
		}
		case 42:
		{
			if(response)
			{
				if(listitem==0) return SetPlayerCheckpoint(playerid,2386.4734,2465.9463,10.8203,5); // + gover
				if(listitem==1) return SetPlayerCheckpoint(playerid,2444.8689,2376.2734,12.1635,5); // + fbi
				if(listitem==2) return SetPlayerCheckpoint(playerid,2290.1265,2431.2390,10.8203,5); // + police
				if(listitem==3) return SetPlayerCheckpoint(playerid,2444.8689,2376.2734,12.1635,5); // army
				if(listitem==4) return SetPlayerCheckpoint(playerid,1607.2726,1819.1359,10.8280,5); // + hosp
				if(listitem==5) return SetPlayerCheckpoint(playerid,2444.8689,2376.2734,12.1635,5); // smi
				if(listitem==6) return SetPlayerCheckpoint(playerid,2444.8689,2376.2734,12.1635,5); // drive
			}
			else return SPD(playerid,40,DSL,"Навигатор",string_GPS,"Выбрать","Закрыть");
		}
		case 43:
		{
			if(response)
			{
				if(listitem==0) return SetPlayerCheckpoint(playerid,938.5411,1733.1899,8.851600,5); // irish
				if(listitem==1) return SetPlayerCheckpoint(playerid,1457.9207,2773.5466,10.8203,5); // yakuza
				if(listitem==2) return SetPlayerCheckpoint(playerid,1880.2577,2339.4983,10.9799,5); // center
				if(listitem==3) return SetPlayerCheckpoint(playerid,1532.3008,751.0519,11.02340,5); // lcn
				if(listitem==4) return SetPlayerCheckpoint(playerid,2632.8416,1824.2480,11.0234,5); // chine town
			}
			else return SPD(playerid,DSL,40,"Навигатор",string_GPS,"Выбрать","Закрыть");
		}
		case 44:
		{
		    if(response)
		    {
				if(listitem==0) return 1;
				if(listitem==1) return 1;
				if(listitem==2) return 1;
			}
			else return SPD(playerid,DSL,40,"Навигатор",string_GPS,"Выбрать","Закрыть");
		}
		case 45:
		{
			if(response)
			{
				if(listitem==0) return 1;
			}
			else return SPD(playerid,DSL,40,"Навигатор",string_GPS,"Выбрать","Закрыть");
		}
		case 55:
		{
			if(response)
			{
			    if(listitem==0) return SPD(playerid,17,DSM,"О проекте","Mafia Role Play - игровой проект в SAMP индустрии.....События проходят в 1972 году. В это время мафиозные семьи ....","Назад","Закрыть");
			    if(listitem==1) return SPD(playerid,17,DSTH,"Телефонная книга","Имя\tНомер\n1\t1","Назад","Закрыть");
			    if(listitem==2) return SPD(playerid,17,DSTH,"Важные номера","Организация\tНомер\nСлужба спасения\t911\nПравительство\t800\nРадиоцентр\t222\nТакси\t500\nБаланс\t100","Назад","Закрыть");
			    if(listitem==3)
			    {
			        new list[2560];
			        format(query,sizeof(query),"SELECT * FROM `Notes` WHERE `ID` = %i",playerVariable[playerid][pID]);
			        mysql_query(MySQL:DATABASE,query);
			        for(new i=1;i<11;i++)
			        {
						new note[258],title[7];
						format(title,sizeof(title),"Note%i",i);
						cache_get_value_name(0,title,note,256);
						format(note,sizeof(list),"%s\n",note);
						strcat(list,note);
					}
					return SPD(playerid,56,DSL,"Заметки",list,"Изменить","Назад");
				}
			    if(listitem==4)
				{
				    new list[512] = "Имя\tНомер\n";
				    foreach(new i:Player)
				    {
				        if(!IsPlayerConnected(i)) continue;
						if(playerVariable[i][pLogged]==false) continue;
				        if(playerVariable[i][pJobID]!=8) continue;
				        new person[64];
				        format(person,sizeof(person),"%s\t%i\n",playerVariable[i][pName],playerVariable[i][pPhoneNumber]);
				        strcat(list,person);
					}
					return SPD(playerid,17,DSTH,"Адвокаты",list,"Назад","Закрыть");
				}
			}
			else return 1;
		}
		case 56:
		{
			if(response)
			{
			    new note[256],note2[300],title[7];
			    format(title,sizeof(title),"Note%i",listitem+1);
			    format(query,sizeof(query),"SELECT `%s` FROM `Notes` WHERE `ID` = %i",title,playerVariable[playerid][pID]);
			    mysql_query(MySQL:DATABASE,query);
			    cache_get_value_name(0,title,note,256);
			    format(note2,sizeof(note2),"Ваша заметка: %s",note);
			    return SPD(playerid,57,DSI,"Измение заметки",note2,"Сохранить","Назад");
			}
			else return SPD(playerid,55,DSL,"Справочник",string_DIR,"Выбрать","Закрыть");
		}
		case 57:
		{
			if(response)
			{

			}
			else return SPD(playerid,55,DSL,"Справочник",string_DIR,"Выбрать","Закрыть");
		}
		case 60:
		{
			if(response)
			{
	   			switch(listitem)
	   			{
					case 0: PlayAudioStreamForPlayer(playerid,""); // mafia
					case 1: PlayAudioStreamForPlayer(playerid,"http://air.radiorecord.ru:8101/rr_320"); // record
					case 2: PlayAudioStreamForPlayer(playerid,""); // europa
					case 3: PlayAudioStreamForPlayer(playerid,"http://icecast.radiodfm.cdnvideo.ru/dfm.mp3"); // dfm
					case 4: PlayAudioStreamForPlayer(playerid,""); // energy
					case 5: PlayAudioStreamForPlayer(playerid,"");
					case 6: PlayAudioStreamForPlayer(playerid,"");
					case 7: PlayAudioStreamForPlayer(playerid,"");
					case 8: PlayAudioStreamForPlayer(playerid,"");
					case 9: PlayAudioStreamForPlayer(playerid,"");
					case 10: PlayAudioStreamForPlayer(playerid,"");
					case 11: PlayAudioStreamForPlayer(playerid,"");
					case 12: PlayAudioStreamForPlayer(playerid,"");
					case 13: PlayAudioStreamForPlayer(playerid,"");
					case 14: PlayAudioStreamForPlayer(playerid,"");
					case 15: PlayAudioStreamForPlayer(playerid,"");
					case 16: PlayAudioStreamForPlayer(playerid,"");
					case 17: PlayAudioStreamForPlayer(playerid,"");
					case 18: PlayAudioStreamForPlayer(playerid,"");
					case 19: StopAudioStreamForPlayer(playerid);
				}
				return 1;
			}
			else return 1;
		}
		case 62:
		{
			if(response)
			{
			    new carID = GetPlayerVehicleID(playerid);
			    if(listitem==1)
			    {
					if(vehicleVariable[carID][vEngine]==true)
					{
						vehicleVariable[carID][vEngine]=false;
						format(string,sizeof(string),"%s[%i] завел двигатель",playerVariable[playerid][pName],playerid);
						ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					}
					else
					{
						vehicleVariable[carID][vEngine]=true;
						format(string,sizeof(string),"%s[%i] заглушил двигатель",playerVariable[playerid][pName],playerid);
						ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					}
				}
				if(listitem==2)
				{
					if(vehicleVariable[carID][vBonnet]==true)
					{
						vehicleVariable[carID][vBonnet]=false;
						format(string,sizeof(string),"%s[%i] закрыл капот",playerVariable[playerid][pName],playerid);
						ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					}
					else
					{
						vehicleVariable[carID][vBonnet]=true;
						format(string,sizeof(string),"%s[%i] открыл капот",playerVariable[playerid][pName],playerid);
						ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					}
				}
				if(listitem==3)
				{
					if(vehicleVariable[carID][vBoot]==true)
					{
						vehicleVariable[carID][vBoot]=false;
						format(string,sizeof(string),"%s[%i] закрыл багажник",playerVariable[playerid][pName],playerid);
						ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					}
					else
					{
						vehicleVariable[carID][vBoot]=true;
						format(string,sizeof(string),"%s[%i] открыл багажник",playerVariable[playerid][pName],playerid);
						ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					}
				}
				if(listitem==4)
				{
				    if(vehicleVariable[carID][vLights]==true)
					{
						vehicleVariable[carID][vLights]=false;
						format(string,sizeof(string),"%s[%i] включил фары",playerVariable[playerid][pName],playerid);
						ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					}
				    else
					{
						vehicleVariable[carID][vLights]=true;
						format(string,sizeof(string),"%s[%i] выключил фары",playerVariable[playerid][pName],playerid);
						ProxDetector(playerid,30.0,string,PINK1,PINK2,PINK3,PINK4,PINK5);
					}
				}
				SetVehicleParams(carID);
				format(string,sizeof(string),string_CMENU,vehicleVariable[carID][vEngine],vehicleVariable[carID][vBonnet],
				vehicleVariable[carID][vBoot],vehicleVariable[carID][vLights]);
				return SPD(playerid,62,DST,"Меню транспорта",string,"Выбрать","Закрыть");
			}
			else return 1;
		}
		case 113:
		{
			return 1;
		}
		case 240:
		{
			if(response)
			{
				return 1;
			}
			else return 1;
		}
		case 260:
		{
			return 1;
		}
		case 262:
		{
			if(response)
			{
				if(listitem==0) return SPD(playerid,263,DSM,"Статистика организации","йцуакпуекрнеогн","Назад","Закрыть");
				if(listitem==1) return SPD(playerid,263,DSTH,"Члены организации онлайн","werty","Назад","Закрыть");
				if(listitem==2) return SPD(playerid,263,DSTH,"Члены организации оффлайн","wdergty","Назад","Закрыть");
			}
			else return 1;
		}
		case 263:
		{
			if(response) return SPD(playerid,262,DSL,"Меню организации",string_LMENU,"Выбрать","Закрыть");
			else return 1;
		}
		case 270:
		{
			if(response)
			{
				return 1;
			}
			else return 1;
		}
		case 500:
		{
		    if(response)
		    {
				if(!strcmp(inputtext,adminVariable[playerid][aPassword],false))
				{
					SCM(playerid,WHITE,"[{65FF4D}ADM{FFFFFF}] Вы успешно авторизовались!");
					adminVariable[playerid][aLogged]=true;
					format(string,sizeof(string),"[{65FF4D}ADM{FFFFFF}] %s авторизовался как администратор!",playerVariable[playerid][pName]);
					SendAdminChat(playerid,WHITE,string,false);
				}
				else
				{
					adminVariable[playerid][aWrongPassword]++;
					if(adminVariable[playerid][aWrongPassword]==3)
					{
					    format(string,sizeof(string),"[{F46221}Безопасность{FFFFFF}] Администратор %s ввёл 3 раза неправильно свой админ-пароль!",playerVariable[playerid][pName]);
						SendAdminChat(playerid,WHITE,string);
						Kick(playerid);
					}
				}
			}
			else return 1;
		}
    }
	return 1;
}

public OnPlayerClickPlayer(playerid,clickedplayerid,source)				     	// Кликнули на игрока в TAB-e
{
	return 1;
}

public Advertisement1()
{
	SCMtA(WHITE,"Сервер находится в активной разработке! Разработчик: Gino Mangano");
	SCMtA(WHITE,"Планируемая дата открытия сервера - 01.01.2023!");
}

public Advertisement2()
{
	SCMtA(WHITE,"На офф.сайте нашего сервера есть ");
}

public UpdatePlayedTime()
{
	foreach(new i:Player)
	{
	    if(playerVariable[i][pPlayedTime]<60)
		{
			playerVariable[i][pPlayedTime] += 1;
			SaveVariableInteger("account","PlayedTime",playerVariable[i][pPlayedTime],playerVariable[i][pID]);
		}
	}
	new hour,minut,second;
	gettime(hour,minut,second);
	if(minut==0) PayDay();
	return 1;
}

static stock PayDay()
{
	new Float:pd_pos_x,Float:pd_pos_y,Float:pd_pos_z,
	    pd_str[128],pd_date[128],pd_time[128];
	strmid(pd_date,GetNow(1),0,128,128);
	strmid(pd_time,GetNow(2),0,128,128);
	foreach(new i:Player)
	{
	    if(playerVariable[i][pPlayedTime]>=15)
	    {
		    GetPlayerPos(i,pd_pos_x,pd_pos_y,pd_pos_z);
		    PlayerPlaySound(i,5203,pd_pos_x,pd_pos_y,pd_pos_z);
			SCM(i,WHITE,"=================== P A Y   D A Y ====================");
			SCM(i,WHITE,pd_date);
			SCM(i,WHITE,pd_time);
			if(orgSalary[playerVariable[i][pOrgID]][playerVariable[i][pOrgRank]]>0)
			{
				format(pd_str,sizeof(pd_str),"Зарплата: %i",orgSalary[playerVariable[i][pOrgID]][playerVariable[i][pOrgRank]]);
				SCM(i,WHITE,pd_str);
				playerVariable[i][pBankCash]+=orgSalary[playerVariable[i][pOrgID]][playerVariable[i][pOrgRank]];
			}
			format(pd_str,sizeof(pd_str),"Банковский счёт: %i",playerVariable[i][pBankCash]);
			SCM(i,WHITE,pd_str);
			if(playerVariable[i][pBankDeposit]>0)
			{
				format(pd_str,sizeof(pd_str),"Процент депозита: ",playerVariable[i][pBankDeposit]*0.001);
				SCM(i,WHITE,pd_str);
				playerVariable[i][pBankDeposit]+=playerVariable[i][pBankDeposit]*0.001;
				format(pd_str,sizeof(pd_str),"Депозит: %i",playerVariable[i][pBankDeposit]);
				SCM(i,WHITE,pd_str);
			}
			if(playerVariable[i][pFine]>0)
			{
				format(pd_str,sizeof(pd_str),"Штраф: %i",playerVariable[i][pFine]);
				SCM(i,WHITE,pd_str);
			}
			if(GetEXP(i,1)==0)
			{
			    format(pd_str,sizeof(pd_str),"Ваш уровень: %i\nВаш опыт: %i/%i",playerVariable[i][pLVL],playerVariable[i][pEXP],(playerVariable[i][pLVL]+1)*2);
				SCM(i,WHITE,pd_str);
			}
			SCM(i,WHITE,"==================================================");

			playerVariable[i][pPlayedTime]=0;
			SaveVariableInteger("account","PlayedTime",0,playerVariable[i][pID]);
			SaveVariableInteger("account","LVL",playerVariable[i][pLVL],playerVariable[i][pID]);
			SaveVariableInteger("account","EXP",playerVariable[i][pEXP],playerVariable[i][pID]);
			
			SaveVariableInteger("account","BankCash",playerVariable[i][pBankCash],playerVariable[i][pID]);
			SaveVariableInteger("account","BankDeposit",playerVariable[i][pBankDeposit],playerVariable[i][pID]);
		}
		else SCM(i,WHITE,"[{EF2E2E}Ошибка{FFFFFF}] Вы не получили зарплату, так как не отыграли на сервере 15 минут!");
	}
	return 1;
}

public DeacreasingFuel()
{
	forveh(i)
	{
		if(vehicleVariable[i][vEngine]==false) continue;
		if(vehicleVariable[i][vFuel]>0) vehicleVariable[i][vFuel]-=1;
	}
	return 1;
}

public UpdateSpeed(playerid)
{
	new carID = GetPlayerVehicleID(playerid);
	format(string,sizeof(string),"SPEED: %d",SpeedVehicle(playerid));
	PlayerTextDrawSetString(playerid,CarSpeed[playerid],string);
	format(string,sizeof(string),"FUEL: %d",vehicleVariable[carID][vFuel]);
	PlayerTextDrawSetString(playerid,CarFuel[playerid],string);
	format(string,sizeof(string),"MILLIAGE: %d",vehicleVariable[carID][vMilliage]);
	PlayerTextDrawSetString(playerid,CarMilliage[playerid],string);
	
	if(vehicleVariable[carID][vLights]==true) PlayerTextDrawSetString(playerid,CarLights[playerid],"~b~L");
	else PlayerTextDrawSetString(playerid,CarLights[playerid],"~w~L");
	
	if(vehicleVariable[carID][vEngine]==true) PlayerTextDrawSetString(playerid,CarEngine[playerid],"~b~E");
	else PlayerTextDrawSetString(playerid,CarEngine[playerid],"~w~E");
	
	if(vehicleVariable[carID][vFuel]<=0)
	{
	    vehicleVariable[carID][vEngine]=false;
	    vehicleVariable[carID][vFuel]=0;
	    SetVehicleParams(carID);
	}
	if(GetPlayerDistanceFromPoint(playerid,vehicleVariable[carID][vX],vehicleVariable[carID][vY],vehicleVariable[carID][vZ])>500.0)
	{
	    vehicleVariable[carID][vMilliage]+=1;
	    GetPlayerPos(playerid,vehicleVariable[carID][vX],vehicleVariable[carID][vY],vehicleVariable[carID][vZ]);
	}
	return 1;
}

public LoadInfoServer()
{
	tmpobjid = GetTickCount();
	cache_get_row_count(rows);
	if(rows)
	{
		cache_get_value_name(0,"NameServer",ServerName,32);
		cache_get_value_name(0,"SiteServer",ServerSite,32);
		cache_get_value_name(0,"LangueServer",ServerLangue,11);
		cache_get_value_name(0,"NumServer",ServerNum,5);
		cache_get_value_name(0,"ClientServer",ServerClient,7);
		cache_get_value_name(0,"MapServer",ServerMap,12);
	}
	string[0] = EOS;
	format(string,72,"hostname %s | Year: %s",ServerName,ServerNum);
	SendRconCommand(string);
	string[0] = EOS;
	format(string,20,"mapname %s",ServerMap);
	SendRconCommand(string);
	string[0] = EOS;
	format(string,18,"language %s",ServerLangue);
	SendRconCommand(string);
	string[0] = EOS;
	format(string,39,"weburl %s",ServerSite);
	SendRconCommand(string);
	SetGameModeText("Role Play");
	printf("[Загружена информация]: <->. Потрачено: <%i мс>",GetTickCount()-tmpobjid);
	return true;
}

/*public Audio_OnClientConnect(playerid)
{
	Audio_TransferPack(playerid);
	return 1;
}*/

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// 369.1738,173.6454,1019.9844 spawn point in govern
