//Hive box names
const settingBox = "settings";
const userDetailsBox = "userDetails";

//settings box keys
const settingThemeKey = "theme";
const showIntroSliderKey = "showIntroSlider";

//UserBox Keys
const nameBoxKey = "name";
const userIdBoxKey = "userId";
const profileAvatarBoxKey = "profileAvatar";
const coinsBoxKey = "coins";
const allTimeRankKey = "rankKey";

final Map<String, List<Map<String, String>>> categoriesEN = {
  "Regional Dialects": [
    {
      "name": "Morocco",
      "image": "assets/images/countries/Morocco.png",
    },
    {
      "name": "Egypt",
      "image": "assets/images/countries/Egypt.png",
    },
    {
      "name": "Saudi",
      "image": "assets/images/countries/Saudi.png",
    },
    {
      "name": "Syria",
      "image": "assets/images/countries/Syria.png",
    },
  ],
  "Common Phrases": [
    {
      "name": "Greetings",
      "image": "assets/images/categories/greetings.png",
    },
    {
      "name": "Expressions of Gratitude",
      "image": "assets/images/categories/gratitude.png",
    },
    {
      "name": "Apologies",
      "image": "assets/images/categories/apology.png",
    },
    {
      "name": "Numbers and Counting",
      "image": "assets/images/categories/numbering.png",
    },
    {
      "name": "Directions and Locations",
      "image": "assets/images/categories/directions.png",
    },
  ],
  "Challenge Levels": [
    {
      "name": "Beginner",
      "image": "assets/images/categories/beginner.png",
    },
    {
      "name": "Intermediate",
      "image": "assets/images/categories/intermediate.png",
    },
    {
      "name": "Advanced",
      "image": "assets/images/categories/advanced.png",
    },
    {
      "name": "Expert",
      "image": "assets/images/categories/expert.png",
    },
    {
      "name": "Master",
      "image": "assets/images/categories/master.png",
    },
  ],
  "Cultural Context": [
    {
      "name": "Traditional Festivals and Celebrations",
      "image": "assets/images/categories/festival.png",
    },
    {
      "name": "Social Etiquette and Customs",
      "image": "assets/images/categories/etiq.png",
    },
    {
      "name": "Famous Proverbs and Sayings",
      "image": "assets/images/categories/saying.png",
    },
    {
      "name": "Historical Figures and Events",
      "image": "assets/images/categories/history.png",
    },
    {
      "name": "Modern Trends and Influences",
      "image": "assets/images/categories/trend.png",
    },
  ],
  "Everyday Vocabulary": [
    {
      "name": "Food and Drink",
      "image": "assets/images/categories/food.png",
    },
    {
      "name": "Clothing and Fashion",
      "image": "assets/images/categories/clothing.png",
    },
    {
      "name": "Transportation",
      "image": "assets/images/categories/transportation.png",
    },
    {
      "name": "Family and Relationships",
      "image": "assets/images/categories/family.png",
    },
    {
      "name": "Occupations and Professions",
      "image": "assets/images/categories/occupation.png",
    },
  ],
};

final Map<String, List<Map<String, String>>> categoriesAR = {
  "اللهجات المحلية": [
    {
      "name": "المغرب",
      "image": "assets/images/countries/Morocco.png",
    },
    {
      "name": "مصر",
      "image": "assets/images/countries/Egypt.png",
    },
    {
      "name": "السعودية",
      "image": "assets/images/countries/Saudi.png",
    },
    {
      "name": "سوريا",
      "image": "assets/images/countries/Syria.png",
    },
  ],
  "عبارات شائعة": [
    {
      "name": "التّحيات",
      "image": "assets/images/categories/greetings.png",
    },
    {
      "name": "عبارات الشّكر",
      "image": "assets/images/categories/gratitude.png",
    },
    {
      "name": "الاعتذارات",
      "image": "assets/images/categories/apology.png",
    },
    {
      "name": "الأرقام والأعداد",
      "image": "assets/images/categories/numbering.png",
    },
    {
      "name": "الأماكن والاتّجاهات",
      "image": "assets/images/categories/directions.png",
    },
  ],
  "مستويات التّحدي": [
    {
      "name": "مبتدئ",
      "image": "assets/images/categories/beginner.png",
    },
    {
      "name": "متوسّط",
      "image": "assets/images/categories/intermediate.png",
    },
    {
      "name": "متقدّم",
      "image": "assets/images/categories/advanced.png",
    },
    {
      "name": "خبير",
      "image": "assets/images/categories/expert.png",
    },
    {
      "name": "محترف",
      "image": "assets/images/categories/master.png",
    },
  ],
  "السّياق الثقافي": [
    {
      "name": "المناسبات والاحتفالات الشّعبية",
      "image": "assets/images/categories/festival.png",
    },
    {
      "name": "الآداب العامّة",
      "image": "assets/images/categories/etiq.png",
    },
    {
      "name": "مقولات مشهورة",
      "image": "assets/images/categories/saying.png",
    },
    {
      "name": "شخصيات وأحداث تاريخية",
      "image": "assets/images/categories/history.png",
    },
    {
      "name": "الترند الحديث والتأثير",
      "image": "assets/images/categories/trend.png",
    },
  ],
  "مصطلحات يوميّة": [
    {
      "name": "المشروبات والأغذية",
      "image": "assets/images/categories/food.png",
    },
    {
      "name": "الألبسة والأزياء",
      "image": "assets/images/categories/clothing.png",
    },
    {
      "name": "المواصلات",
      "image": "assets/images/categories/transportation.png",
    },
    {
      "name": "العائلة والعلاقات الاجتماعية",
      "image": "assets/images/categories/family.png",
    },
    {
      "name": "المهن والتخصّصات",
      "image": "assets/images/categories/occupation.png",
    },
  ],
};

const skip = "skip";
const resetTime = "resetTime";

const inBetweenQuestionTimeInSeconds = 1;

const correctAnswerSoundTrack = "assets/sounds/right.mp3";
const wrongAnswerSoundTrack = "assets/sounds/wrong.mp3";

const clickEventSoundTrack = "assets/sounds/click.mp3";

const double winPercentageBreakPoint = 30.0;
