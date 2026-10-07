/**
 * Tsarin Harsuna da Fassara (Multi-Language Localization Engine)
 * Hausa, Arabic (العربية), English
 */

const TRANSLATIONS = {
  ar: {
    dir: "rtl",
    langName: "العربية",
    centerName: "مركز محمد بن إبراهيم آل الشيخ رحمه الله",
    centerFullName: "مركز محمد بن إبراهيم آل الشيخ رحمه الله للعلوم الشرعية",
    tagline: "منارة لنشر العلم الشرعي المؤصل على منهج الكتاب والسنة بفهم سلف الأمة",
    
    // Navigation
    navHome: "الرئيسية",
    navBooks: "المكتبة والكتب",
    navAudios: "الدروس الصوتية",
    navVideos: "المرئيات والدورات",
    navSchedule: "جدول الدروس",
    navFavorites: "المفضلة",
    navAdmin: "لوحة التحكم",
    
    // Search & Filter
    searchPlaceholder: "ابحث عن كتاب، درس صوتي، شيخ، أو موضوع...",
    allCategories: "جميع الأقسام",
    filterByCategory: "تصفية حسب القسم",
    sortBy: "ترتيب حسب",
    sortNewest: "الأحدث إضافة",
    sortPopular: "الأكثر تحميلاً",
    sortAlphabetical: "أبجدياً",
    viewGrid: "شبكة",
    viewList: "قائمة",
    
    // Stats
    statBooks: "كتاب وبحث PDF",
    statAudios: "درس ومحاضرة صوتية",
    statVideos: "محاضرة ومرئية",
    statCourses: "حلقة ودرس أسبوعي",
    
    // Actions
    readBook: "قراءة الكتاب",
    downloadPdf: "تحميل PDF",
    listenAudio: "استماع للدرس",
    downloadAudio: "تحميل MP3",
    watchVideo: "مشاهدة الفيديو",
    addToFavorites: "إضافة للمفضلة",
    removeFromFavorites: "إزالة من المفضلة",
    share: "مشاركة",
    close: "إغلاق",
    pages: "صفحة",
    size: "الحجم",
    author: "المؤلف",
    speaker: "المحاضر",
    instructor: "الشيخ",
    category: "القسم",
    year: "سنة الطبع",
    date: "التاريخ",
    duration: "المدة",
    views: "مشاهدة",
    downloads: "تحميل",
    
    // Sections
    featuredBooks: "أبرز الكتب والرسائل",
    upcomingBooks: "الإصدارات القادمة (قيد النشر)",
    directorPublications: "مؤلفات إبراهيم شريف أبوبكر",
    directorHeader: "رئيس المركز والمشرف العام",
    directorName: "إبراهيم شريف أبوبكر",
    directorMessage: "كلمة المشرف العام",
    directorMessageText: "نسأل الله تعالى أن يجعل هذا الصرح العلمي منارة هدى وخير، وأن ينفع بهذه المصنفات والمؤلفات والدروس طلاب العلم والمسلمين في كل مكان.",
    upcomingBadge: "قريباً بإذن الله",
    underPublication: "قيد الإعداد والنشر",
    previewInfo: "تفاصيل الكتاب",
    viewDetails: "معلومات الكتاب",
    latestAudios: "أحدث الدروس الصوتية",
    latestVideos: "المرئيات والمحاضرات",
    weeklySchedule: "جدول الدروس الأسبوعية بالمركز",
    aboutCenter: "عن المركز وسماحة الشيخ",
    aboutText: "تأسس المركز تيمناً وتخليداً لجهود إمام الدعوة في عصره، سماحة الشيخ العلامة محمد بن إبراهيم آل الشيخ رحمه الله (مفتي الديار السعودية ورئيس قضاتها الأسبق)، لنشر التوحيد والعقيدة الصحيحة والفقه الإسلامي الأصيل.",
    
    // Player
    nowPlaying: "قيد الاستماع الآن",
    speed: "السرعة",
    playbackRate: "سرعة القراءة",
    
    // Empty states
    noResults: "لم يتم العثور على نتائج مطابقة",
    noFavorites: "لم تقم بإضافة أي عناصر إلى المفضلة بعد.",
    
    // Admin
    adminTitle: "لوحة إدارة محتوى المركز",
    addNewItem: "إضافة مادة جديدة",
    itemType: "نوع المادة",
    save: "حفظ ونشر",
    cancel: "إلغاء",
    edit: "تعديل",
    delete: "حذف",
    exportData: "تصدير نسخة احتياطية",
    importData: "استيراد بيانات",
    successAdded: "تمت إضافة المادة بنجاح!",
    confirmDelete: "هل أنت متأكد من رغبتك في حذف هذا العنصر؟"
  },

  ha: {
    dir: "ltr",
    langName: "Hausa",
    centerName: "Markaz Muhammad bin Ibrahim",
    centerFullName: "Cibiyar Sheikh Muhammad bin Ibrahim Aal Al-Sheikh Domin Ilimin Addinin Musulunci",
    tagline: "Hasken yada ingantaccen ilimin addinin Musulunci bisa koyarwar Alkur'ani da Sunnah",
    
    // Navigation
    navHome: "Babban Shafi",
    navBooks: "Maktaba (Littattafai)",
    navAudios: "Karatuttukan Murya",
    navVideos: "Bidiyoyi & Darussa",
    navSchedule: "Jadawalin Karatu",
    navFavorites: "Abubuwan da Na Ajiye",
    navAdmin: "Shafin Admin",
    
    // Search & Filter
    searchPlaceholder: "Nemi littafi, karatun sauti, malami, ko maudhu'i...",
    allCategories: "Dukkan Bangarori",
    filterByCategory: "Tace ta Bangare",
    sortBy: "Tsara da",
    sortNewest: "Sababbi",
    sortPopular: "Wadanda Aka Fi Saukewa",
    sortAlphabetical: "Bisa Haruffa (A-Z)",
    viewGrid: "A Tsaye (Grid)",
    viewList: "A Jere (List)",
    
    // Stats
    statBooks: "Littattafan Maktaba",
    statAudios: "Karatun Sauti (MP3)",
    statVideos: "Bidiyoyin Karatu",
    statCourses: "Darussan Mako-Mako",
    
    // Actions
    readBook: "Karanta PDF",
    downloadPdf: "Sauke PDF",
    listenAudio: "Saurari Karatu",
    downloadAudio: "Sauke MP3",
    watchVideo: "Kalli Bidiyo",
    addToFavorites: "Ajiye (Favorite)",
    removeFromFavorites: "Cire daga Ajiyar",
    share: "Rarraba (Share)",
    close: "Rufe",
    pages: "Shafuka",
    size: "Girma (Size)",
    author: "Mawallafi",
    speaker: "Malami mai Karatu",
    instructor: "Mai Gabatarwa",
    category: "Bangare",
    year: "Shekara",
    date: "Rana / Kwanan Wata",
    duration: "Tsayin Karatu",
    views: "Kallo",
    downloads: "Saukewa",
    
    // Sections
    featuredBooks: "Fitattun Littattafai & Risaloli",
    upcomingBooks: "Littattafai Masu Fitowa (Masu Zuwa)",
    directorPublications: "Wallafe-Wallafen Sheikh Ibrahim Sharif Abubakar",
    directorHeader: "Shugaban Cibiyar & Babban Mai Kulawa",
    directorName: "Sheikh Ibrahim Sharif Abubakar",
    directorMessage: "Jawabin Shugaban Cibiyar",
    directorMessageText: "Muna rokon Allah Madaukakin Sarki da Ya sanya wannan cibiya ta zama hasken shiriya da alheri, kuma Ya amfanar da daliban ilimi da al'ummar Musulmi da wadannan rubuce-rubuce da darussa.",
    upcomingBadge: "Yana Nan Tafe",
    underPublication: "Ana Shirin Wallafawa",
    previewInfo: "Bayanin Littafi",
    viewDetails: "Duba Bayani",
    latestAudios: "Sabbin Karatuttukan Murya (Audios)",
    latestVideos: "Bidiyoyin Karatuttuka & Taruka",
    weeklySchedule: "Jadawalin Karatuttukan Mako-Mako na Cibiyar",
    aboutCenter: "Game da Cibiyar da Sheikh Muhammad bin Ibrahim",
    aboutText: "An bude wannan cibiya mai albarka don yada ingantaccen ilimin addinin Musulunci, koyar da Tauhidi, Fiqhu, da Hadisi bisa tafarkin magabata na kwarai (Salafus-Salih), tare da raya ilimin babban malamin nan Sheikh Muhammad bin Ibrahim Aal Al-Sheikh (rahimahullah).",
    
    // Player
    nowPlaying: "Ana Saurara Yanzu",
    speed: "Sauri",
    playbackRate: "Saurin Kunna Karatu",
    
    // Empty states
    noResults: "Ba a sami abin da kake nema ba",
    noFavorites: "Ba ka ajiye wani littafi ko karatu a jerin abubuwan da kake so ba tukunna.",
    
    // Admin
    adminTitle: "Shafin Kula da Dandalin Markazi (Admin Panel)",
    addNewItem: "Sanya Sabon Abu",
    itemType: "Nau'in Abu (Littafi/Audio/Video)",
    save: "Ajiye & Wallafa",
    cancel: "Soke",
    edit: "Gyara",
    delete: "Goge",
    exportData: "Fitar da Bayanai (Backup)",
    importData: "Shigar da Bayanai (Import)",
    successAdded: "An sanya sabon abun cikin nasara!",
    confirmDelete: "Shin ka tabbata kana son goge wannan abun?"
  },

  en: {
    dir: "ltr",
    langName: "English",
    centerName: "Markaz Muhammad bin Ibrahim",
    centerFullName: "Sheikh Muhammad bin Ibrahim Aal Al-Sheikh Islamic Center",
    tagline: "A beacon for authentic Islamic knowledge based on Quran and Sunnah",
    
    // Navigation
    navHome: "Home",
    navBooks: "PDF Library",
    navAudios: "Audio Lectures",
    navVideos: "Video Courses",
    navSchedule: "Schedule",
    navFavorites: "Favorites",
    navAdmin: "Admin Portal",
    
    // Search & Filter
    searchPlaceholder: "Search book, audio lecture, scholar, or topic...",
    allCategories: "All Categories",
    filterByCategory: "Filter by Category",
    sortBy: "Sort by",
    sortNewest: "Newest",
    sortPopular: "Most Downloaded",
    sortAlphabetical: "Alphabetical",
    viewGrid: "Grid",
    viewList: "List",
    
    // Stats
    statBooks: "Library Books",
    statAudios: "Audio Lessons",
    statVideos: "Video Classes",
    statCourses: "Weekly Lessons",
    
    // Actions
    readBook: "Read PDF",
    downloadPdf: "Download PDF",
    listenAudio: "Listen Audio",
    downloadAudio: "Download MP3",
    watchVideo: "Watch Video",
    addToFavorites: "Add to Favorites",
    removeFromFavorites: "Remove Favorite",
    share: "Share",
    close: "Close",
    pages: "pages",
    size: "Size",
    author: "Author",
    speaker: "Speaker",
    instructor: "Instructor",
    category: "Category",
    year: "Year",
    date: "Date",
    duration: "Duration",
    views: "views",
    downloads: "downloads",
    
    // Sections
    featuredBooks: "Featured Books & Treatises",
    upcomingBooks: "Forthcoming Publications",
    directorPublications: "Publications by Sheikh Ibrahim Sharif Abubakar",
    directorHeader: "Center Director & General Supervisor",
    directorName: "Sheikh Ibrahim Sharif Abubakar",
    directorMessage: "Director's Message",
    directorMessageText: "We pray that Allah makes this academic foundation a beacon of light, benefiting students of knowledge and the Muslim Ummah through these beneficial works.",
    upcomingBadge: "Coming Soon",
    underPublication: "In Preparation & Publishing",
    previewInfo: "Book Overview",
    viewDetails: "View Details",
    latestAudios: "Latest Audio Lectures",
    latestVideos: "Video Classes & Events",
    weeklySchedule: "Center Weekly Study Timetable",
    aboutCenter: "About the Center & Sheikh Muhammad bin Ibrahim",
    aboutText: "The Center is dedicated to advancing authentic Islamic education, grounded in pure Tawheed, Fiqh, and Hadith upon the methodology of the righteous predecessors, honoring the scholarly legacy of Grand Mufti Sheikh Muhammad bin Ibrahim Aal Al-Sheikh.",
    
    // Player
    nowPlaying: "Now Playing",
    speed: "Speed",
    playbackRate: "Playback Speed",
    
    // Empty states
    noResults: "No matching results found",
    noFavorites: "You haven't saved any items to favorites yet.",
    
    // Admin
    adminTitle: "Markaz Content Management Panel",
    addNewItem: "Add New Material",
    itemType: "Material Type",
    save: "Save & Publish",
    cancel: "Cancel",
    edit: "Edit",
    delete: "Delete",
    exportData: "Export Backup",
    importData: "Import Data",
    successAdded: "Item successfully added!",
    confirmDelete: "Are you sure you want to delete this item?"
  }
};

class I18nManager {
  constructor() {
    this.currentLang = localStorage.getItem("markaz_lang") || "ha";
  }

  setLanguage(lang) {
    if (!TRANSLATIONS[lang]) return;
    this.currentLang = lang;
    localStorage.setItem("markaz_lang", lang);
    
    document.documentElement.lang = lang;
    document.documentElement.dir = TRANSLATIONS[lang].dir;
    
    if (lang === "ar") {
      document.body.classList.add("lang-ar");
      document.body.classList.remove("lang-ltr");
    } else {
      document.body.classList.remove("lang-ar");
      document.body.classList.add("lang-ltr");
    }

    this.applyTranslations();
    window.dispatchEvent(new CustomEvent("languageChanged", { detail: { lang } }));
  }

  t(key) {
    const dict = TRANSLATIONS[this.currentLang] || TRANSLATIONS.ha;
    return dict[key] || TRANSLATIONS.ar[key] || key;
  }

  getLocalizedField(obj, fieldName) {
    if (!obj) return "";
    const suffix = this.currentLang === "ar" ? "Ar" : (this.currentLang === "ha" ? "Ha" : "En");
    return obj[fieldName + suffix] || obj[fieldName + "Ar"] || obj[fieldName + "Ha"] || obj[fieldName] || "";
  }

  applyTranslations() {
    const elements = document.querySelectorAll("[data-i18n]");
    elements.forEach(el => {
      const key = el.getAttribute("data-i18n");
      const translation = this.t(key);
      if (translation) {
        if (el.tagName === "INPUT" || el.tagName === "TEXTAREA") {
          el.placeholder = translation;
        } else {
          el.textContent = translation;
        }
      }
    });

    // Update active state in language pickers
    document.querySelectorAll(".lang-btn").forEach(btn => {
      if (btn.dataset.lang === this.currentLang) {
        btn.classList.add("active");
      } else {
        btn.classList.remove("active");
      }
    });
  }
}

const i18n = new I18nManager();
if (typeof window !== "undefined") {
  window.i18n = i18n;
}
