import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class Languages {
  static bool isEnglish = true;
  static String learnAbout = '';
  static String ncertBatches = '';
  static String youTube = '';
  static String telegram = '';
  static String latestNews = '';
  static String prelims = '';
  static String mains = '';
  static String interview = '';
  static String ro = '';
  static String courses = '';
  static String home = '';
  static String Test = '';
  static String Daily_Current_Affaris = "";
  static String GotaQuery = "";
  //buttons
  static String explore = '';
  static String LearnMore = "";
  //profile
  static String profile = '';
  static String personalInformation = '';
  static String yourTestSeries = '';
  static String yourCourses = '';
  static String editProfile = '';
  static String seeYourEnrollTest = '';
  static String seeYourEnrollCourses = '';
  static String saveChanges = '';
  static String mobile = '';

  //Drawer
  static String aboutUs = '';
  static String yourDownloads = '';
  static String myCart = '';
  static String myOrders = '';
  static String myCourses = '';
  static String myTestseries = '';
  static String ourachievements = '';
  static String mySchedule = '';
  static String resources = '';
  static String helpAndSupport = '';
  static String shareApp = '';
  static String setting = '';

  //download screen
  static String download = '';
  static String video = '';
  static String testSeries = '';

  //Cart
  static String cart = '';
  static String makePayment = '';
  static String remove = '';
  static String total = '';
  static String createdFor = '';

  //my orders

  //my courses
  static String inProgress = '';
  static String continueText = '';
  static String complete = '';

  //schedule
  static String scheduleForToday = '';
  static String selectDate = '';
  static String scheduleDetails = '';
  static String task = '';
  static String notifyAt = '';
  static String scheduleForEveryday = '';
  static String scheduleFor = '';
  static String addTask = '';

  //Help And Support
  static String freeMessage = '';
  static String emailText = '';
  static String phoneText = '';
  static String whatsApp = '';
  //test
  static String score = "";
  static String Take_Live_Test = "";
  static String OMR_Sheet = "";
  static String Submit = "";
  static String Notification = "";
  //resources
  static String Course_Index = "";
  //search
  static String SearchMockTestQuizzes = "";

  static initState() {
    Languages.isEnglish =
        SharedPreferenceHelper.getString(Preferences.language)! == "English"
            ? true
            : false;
    //buttons
    explore = isEnglish ? 'Explore' : 'और खोंज़े';
    learnAbout = isEnglish ? 'Learn About' : 'जानिए ...';
    LearnMore = isEnglish ? "Learn More" : "और जाने";
    ncertBatches = isEnglish ? 'Join Us On' : 'हमसे जुड़ें';
    youTube = isEnglish ? 'On YouTube' : 'यूट्यूब पर ';
    telegram = isEnglish ? 'On Telegram' : 'टेलीग्राम पर ';
    latestNews = isEnglish ? 'Our Videos ' : 'हमारे वीडियो';
    Notification = isEnglish ? "Notification " : "सूचना";
    //search
    SearchMockTestQuizzes =
        isEnglish ? "Search Mock Test,Quizzes" : "मॉकटेस्ट/क्विज खोजे";
    //tab bar course
    prelims = isEnglish ? 'Prelims' : 'प्रीलिम्स';
    mains = isEnglish ? 'Mains' : 'मैन्स';
    interview = isEnglish ? 'Interview' : 'इंटरव्यू ';
    ro = isEnglish ? 'Ro' : 'आर ओ ';

    //bottom bar
    courses = isEnglish ? 'Courses' : 'कोर्स';
    home = isEnglish ? 'Home' : 'होम ';
    profile = isEnglish ? 'Profile' : 'प्रोफ़ाइल ';
    Test = isEnglish ? 'Tests' : 'टेस्ट';
    Daily_Current_Affaris =
        isEnglish ? "Daily Current Affaris " : "दैनिक करंट अफेयर्स";
    GotaQuery = isEnglish ? "Got a Query ?" : "कोई समस्या ?";
    //profile info
    personalInformation =
        isEnglish ? 'Personal Information' : 'व्यक्तिगत जानकारी';
    yourTestSeries = isEnglish ? 'My Test Series' : 'टेस्ट सीरीज';
    yourCourses = isEnglish ? 'Your Courses' : 'कोर्सेस';
    editProfile = isEnglish
        ? 'Edit Phone, Email, Profile Name'
        : 'फ़ोन, ईमेल, प्रोफ़ाइल नाम संपादित करें';
    seeYourEnrollTest =
        isEnglish ? 'See your enrolled tests' : 'अपने दाखिल टेस्ट देखे';
    seeYourEnrollCourses =
        isEnglish ? 'See your enrolled courses' : 'अपने दाखिल कोर्स देखे';
    saveChanges = isEnglish ? 'Save Changes' : 'बदलाव सहजें';
    mobile = isEnglish ? 'Mobile' : 'मोबाइल';

    //Drawer
    aboutUs = isEnglish ? 'About Us' : 'हमारे बारे में';
    yourDownloads = isEnglish ? 'Your Downloads' : 'आपके डाउनलोड्स';
    myCart = isEnglish ? 'My Cart' : 'मेरा कार्ट';
    myOrders = isEnglish ? 'My Orders' : 'मेरे ऑर्डर्स';
    myCourses = isEnglish ? 'My Courses' : 'आपके कोर्स';
    myTestseries = isEnglish ? 'My Test Series' : 'मेरी टेस्ट सीरीज';
    ourachievements = isEnglish ? 'Our Achievements' : 'हमारी उपलब्धियां';
    mySchedule = isEnglish ? 'My Schedule' : 'अनुसूची';
    resources = isEnglish ? 'Resources' : 'संसाधन ';
    helpAndSupport = isEnglish ? 'Help & Support' : 'सहायता और समर्थन';
    shareApp = isEnglish ? 'Share App' : 'एप शेयर करें ';
    setting = isEnglish ? 'Settings' : 'सेटिंग्स ';

    //Download screen
    download = isEnglish ? 'Downloads' : 'डाउनलोड';
    video = isEnglish ? 'Videos' : 'वीडियो ';
    testSeries = isEnglish ? 'Test Series' : 'टेस्ट सीरीज';

    //cart
    cart = isEnglish ? 'My Cart' : 'कार्ट ';
    makePayment = isEnglish ? 'Make Payment' : 'भुगतान करें';
    remove = isEnglish ? 'Remove' : 'हटाएं';
    total = isEnglish ? 'Total' : 'कुलs';
    //resources
    Course_Index = isEnglish ? "Course Index" : "पाठ्यक्रम";
    //courses
    inProgress = isEnglish ? 'In Progress' : 'प्रगति मे';
    continueText = isEnglish ? 'Continue' : 'जारी रखे';
    complete = isEnglish ? 'Complete' : 'पूर्ण';

    //my schedule
    scheduleForToday = isEnglish ? 'Schedule For Today' : 'आज की अनुसूची';
    scheduleFor = isEnglish ? 'Schedule For ' : 'आज की ';
    selectDate = isEnglish ? 'Select Date' : 'तारीख चुने';
    scheduleDetails = isEnglish ? 'Schedule Details' : 'अनुसूची विवरण';
    task = isEnglish ? 'Task' : 'कार्य ';
    notifyAt = isEnglish ? 'Notify at' : 'पर सूचित करें';
    createdFor = isEnglish ? 'Create for' : 'के िलए बनाएँं';
    addTask = isEnglish ? '+ Add Task' : '+ कार्य जोड़ें';

    //help and support
    freeMessage =
        isEnglish ? 'Feel free to message us at' : 'बेझिझक हमें पर मैसेज करें';
    emailText = isEnglish ? 'Mail us at' : 'हमे ईमेल करें';
    whatsApp = isEnglish ? 'WhatsApp us' : 'व्हाट्सअप पर सम्पर्क करें';

    //test
    score = isEnglish ? "Score" : "स्कोर";
    Take_Live_Test = isEnglish ? "Take Live Test" : "लाइव टेस्ट दे";
    OMR_Sheet = isEnglish ? "OMR Sheet" : "ओएमआर शीट";
    Submit = isEnglish ? "Submit" : "जमा  करें";
  }
}
