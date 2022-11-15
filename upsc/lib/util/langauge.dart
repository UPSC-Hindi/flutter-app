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
  static String courses = 'c';
  static String home = '';
  static String mockTest = '';

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

  static initState() {
    Languages.isEnglish =
        SharedPreferenceHelper.getString(Preferences.language)! == "English"
            ? true
            : false;

    learnAbout = isEnglish ? 'Learn About' : 'जानिए ...';
    ncertBatches = isEnglish ? 'Join Us on' : 'को हमारे साथ शामिल हों';
    youTube = isEnglish ? 'On YouTube' : 'यूट्यूब पर ';
    telegram = isEnglish ? 'On Telegram' : 'टेलीग्राम पर ';
    latestNews = isEnglish ? 'On YouTube' : 'नवीनतम खबरें ';

    //tab bar course
    prelims = isEnglish ? 'Prelims' : 'प्रीलिम्स';
    mains = isEnglish ? 'Mains' : 'मैन्स';
    interview = isEnglish ? 'Interview' : 'इंटरव्यू ';
    ro = isEnglish ? 'Ro' : 'आर ओ ';

    //bottom bar
    courses = isEnglish ? 'Courses' : 'कोर्सेस ';
    home = isEnglish ? 'Home' : 'होम ';
    profile = isEnglish ? 'Profile' : 'प्रोफाइल ';
    mockTest = isEnglish ? 'Mock Test' : 'मॉक टेस्ट';

    //profile info
    personalInformation =
        isEnglish ? 'Personal Information' : 'व्यक्तिगत जानकारी';
    yourTestSeries = isEnglish ? 'Your Test Series' : 'टेस्ट सीरीज';
    yourCourses = isEnglish ? 'Your Courses' : 'कोर्सेस';
    editProfile =
        isEnglish ? 'Edit Phone,Email,Profile Name' : 'फ़ोन ईमेल नाम बदले';
    seeYourEnrollTest =
        isEnglish ? 'See your enrolled tests' : 'अपने दाखिल टेस्ट देखे';
    seeYourEnrollCourses =
        isEnglish ? 'See your enrolled courses' : 'अपने दाखिल कोर्स देखे';
    saveChanges = isEnglish ? 'Save Changes' : 'परिवर्तनों को सुरक्षित करें';
    mobile = isEnglish ? 'Mobile' : 'मोबाइल';

    //Drawer
    aboutUs = isEnglish ? 'About Us' : 'हमारे बारे में';
    yourDownloads = isEnglish ? 'Your Downloads' : 'डाउनलोडस';
    myCart = isEnglish ? 'My Cart' : 'कार्ट ';
    myOrders = isEnglish ? 'My Orders' : 'ऑर्डर्स ';
    myCourses = isEnglish ? 'My Courses' : 'कोर्सेस';
    mySchedule = isEnglish ? 'My Schedule' : 'अनुसूची';
    resources = isEnglish ? 'Resources' : 'संसाधन ';
    helpAndSupport = isEnglish ? 'Help & Support' : 'सहायता और समर्थन';
    shareApp = isEnglish ? 'Share App' : 'एप शेयर करें ';
    setting = isEnglish ? 'Settings' : 'सेटिंग्स ';

    //Download screen
    download = isEnglish ? 'Downloads' : 'निःशुल्क टेस्ट सीरीज ';
    video = isEnglish ? 'Videos' : 'वीडियो ';
    testSeries = isEnglish ? 'Test Series' : 'टेस्ट सीरीज';

    //cart
    cart = isEnglish ? 'My Cart' : 'कार्ट ';
    makePayment = isEnglish ? 'Make Payment' : 'पेमेंट करें ';
    remove = isEnglish ? 'Remove' : 'हटाए';
    total = isEnglish ? 'Total' : 'कुलs';

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
    freeMessage = isEnglish ? 'Feel free to message us at' : '+ कार्य जोड़ें';
    emailText = isEnglish ? 'email' : 'ईमेल ';
    whatsApp = isEnglish ? 'WhatsApp us' : 'व्हाट्सप्प करें ';
  }
}
