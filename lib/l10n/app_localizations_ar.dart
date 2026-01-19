// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get saveToAlbum => 'حفظ في الألبوم';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم حفظ $count صورة',
      many: 'تم حفظ $count صورة',
      few: 'تم حفظ $count صور',
      two: 'تم حفظ صورتين',
      one: 'تم حفظ صورة واحدة',
      zero: 'لم يتم حفظ أي صورة',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'مشاركة هذا الملف عبر $appName – سهل جدًا للعرض والتحرير. يمكنك تجربته هنا: $value';
  }

  @override
  String get searchInPdf =>
      'ابحث في <b><span style=\'color:#E01621\'>قارئ PDF</span></b>';

  @override
  String get searchInDoc =>
      'ابحث في <b><span style=\'color:#2979FF\'>قارئ DOC</span></b>';

  @override
  String get searchInExcel =>
      'ابحث في <b><span style=\'color:#388E3C\'>قارئ XLS</span></b>';

  @override
  String get searchInPpt =>
      'ابحث في <b><span style=\'color:#F2590C\'>قارئ PPT</span></b>';

  @override
  String get unSelect => 'إلغاء التحديد';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value ملفات',
      one: 'ملف واحد',
      zero: 'لا يوجد ملفات',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'جارٍ تلخيص المحتوى';

  @override
  String get translationProgress => 'جارٍ الترجمة';

  @override
  String get tryAnotherFile =>
      'تعذر دمج هذا الملف. حاول تحديد ملف آخر للمتابعة.';

  @override
  String get result => 'النتيجة';

  @override
  String get scroll => 'التمرير';

  @override
  String get giveFeedback => 'أرسل ملاحظاتك';

  @override
  String get add => 'إضافة';

  @override
  String get selectText => 'حدد النص';

  @override
  String get pleaseDoNot => 'يرجى عدم تضمين أحرف مشكّلة';

  @override
  String get pleaseEnter => 'الرجاء إدخال نص';

  @override
  String get watermark => 'علامة مائية';

  @override
  String get enterText => 'أدخل النص';

  @override
  String get color => 'اللون';

  @override
  String get addText => 'إضافة نص';

  @override
  String get addWatermark => 'إضافة علامة مائية';

  @override
  String get watermarkContent => 'محتوى العلامة المائية';

  @override
  String get editSuccess => 'تم التعديل بنجاح!';

  @override
  String get signature => 'توقيع';

  @override
  String get noSignature => 'لا يوجد توقيع';

  @override
  String get createSignature => 'إنشاء توقيع جديد';

  @override
  String get feedbackTitle => 'ملاحظات حول المساعد الذكي';

  @override
  String get feedbackTo => 'إلى: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'الموضوع: ملاحظات حول “قارئ PDF ومحول الصور إلى PDF”.';

  @override
  String get feedbackHint => 'اكتب ملاحظاتك هنا...';

  @override
  String get feedbackButton => 'إرسال الملاحظات';

  @override
  String get feedbackEmptyMessage => 'يرجى كتابة ملاحظاتك أولاً';

  @override
  String get feedbackSuccessMessage =>
      'تم إرسال الملاحظات (أو تم فتح تطبيق البريد)';

  @override
  String get feedbackErrorMessage => 'تعذر فتح تطبيق البريد';

  @override
  String get downloadSuccess => 'تم التحميل بنجاح!';

  @override
  String get noTranslate => 'لا يوجد محتوى مترجم.';

  @override
  String get keyPoint => 'النقاط الرئيسية:';

  @override
  String get conclusion => 'الاستنتاج';

  @override
  String get summary => 'الملخص';

  @override
  String get type => 'النوع';

  @override
  String get preview => 'معاينة';

  @override
  String get startTranslate => 'ابدأ الترجمة';

  @override
  String get startSummary => 'ابدأ التلخيص';

  @override
  String get translateTo => 'ترجمة إلى';

  @override
  String get summaryStyle => 'أسلوب التلخيص';

  @override
  String get selectPage => 'اختر الصفحة';

  @override
  String get startAISummary => 'ابدأ التلخيص بالذكاء الاصطناعي';

  @override
  String get startAITranslate => 'ابدأ الترجمة بالذكاء الاصطناعي';

  @override
  String get aIAssistant => 'المساعد الذكي';

  @override
  String get aITranslate => 'ترجمة بالذكاء الاصطناعي';

  @override
  String get aISummary => 'تلخيص بالذكاء الاصطناعي';

  @override
  String get ai_translate_description =>
      '<b>ترجمة المستندات فورًا باستخدام الذكاء الاصطناعي.\n</b> بنقرة واحدة فقط، يمكنك تحويل ملف PDF بالكامل إلى لغة أخرى بدقة وطبيعية وسهولة.';

  @override
  String get ai_summary_description =>
      '<b>افهم المستندات بشكل أسرع مع ملخص الذكاء الاصطناعي.\n</b> حوّل ملفات PDF الطويلة إلى ملخصات موجزة ومنظمة باستخدام ذكاء اصطناعي قوي—لتحصل على المهم دون قراءة إضافية.';

  @override
  String get translate1 => 'ترجمة المستند بالكامل خلال ثوانٍ';

  @override
  String get translate2 => 'نتائج واضحة وطبيعية مدعومة بالذكاء الاصطناعي';

  @override
  String get translate3 => 'دعم لغات متعددة';

  @override
  String get translate4 => 'مثالي للدراسة والعمل والسفر';

  @override
  String get summary1 => 'ملخصات سريعة بنقرة واحدة';

  @override
  String get summary2 => 'تنسيقات ملخص متعددة تناسب أنماط القراءة المختلفة';

  @override
  String get summary3 => 'إبراز واضح لأهم الأفكار';

  @override
  String get summary4 => 'ممتاز للطلاب والمهنيين والقراءة اليومية';

  @override
  String get convertedSuccess => 'تم التحويل بنجاح';

  @override
  String get convertPdfSuccess => 'تم التحويل إلى PDF بنجاح!';

  @override
  String get imageToPdf => 'تحويل الصور إلى PDF';

  @override
  String get youCanHold => 'يمكنك الضغط والسحب لإعادة ترتيب الصور';

  @override
  String get addImage => 'إضافة صورة';

  @override
  String get selectImage => 'اختر صورة';

  @override
  String get selectLanguage =>
      '<b>اختر <span style=\'color:#D90000\'>اللغة</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value نتائج',
      one: 'نتيجة واحدة',
      zero: 'لا توجد نتائج',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'جارٍ التحميل ($value%)...';
  }

  @override
  String get searchOn => 'ابحث في All File Viewer';

  @override
  String get detail => 'تفاصيل';

  @override
  String get fileSize => 'حجم الملف';

  @override
  String get name => 'الاسم';

  @override
  String get sign => 'توقيع';

  @override
  String get systemLanguage => 'لغة النظام';

  @override
  String get done => 'تم';

  @override
  String get guideExportImage => 'افتح معرض الصور لعرض صورك أو مشاركتها.';

  @override
  String get textSetDefault =>
      ' اجعل PDF Reader - PDF Viewer هو الافتراضي لفتح فوري.';

  @override
  String get enterPassSelect => 'أدخل كلمة المرور لاختيار هذا الملف.';

  @override
  String get selectThePage =>
      'اختر الصفحة التي تريد تقسيمها، ثم اضغط مطولًا لسحبها وإعادة ترتيبها.';

  @override
  String get theFastestWay => ' أسرع طريقة لفتح ملفاتك';

  @override
  String get neverMiss => 'لا تفوّت أبدًا التحديثات المهمة لمستنداتك.';

  @override
  String get guideMerge => 'اختر ملفين على الأقل للدمج.';

  @override
  String get notification => 'إشعارات';

  @override
  String get allowAccessTo => 'السماح بالوصول لإدارة جميع الملفات';

  @override
  String get useDeviceLanguage => 'استخدام لغة الجهاز';

  @override
  String get previewConvert => 'معاينة التحويل';

  @override
  String get download => 'تحميل';

  @override
  String get pdfToLongImages => 'PDF إلى صور طويلة';

  @override
  String get convertSelect => 'تحويل المحدد';

  @override
  String get convertAll => 'تحويل الكل';

  @override
  String get searchInFile => 'البحث في الملف';

  @override
  String get language => 'اللغة';

  @override
  String get thisActionCanContainAds => 'قد تحتوي هذه العملية على إعلانات';

  @override
  String get next => 'التالي';

  @override
  String get thank => 'شكرا لك!';

  @override
  String get start => 'ابدأ';

  @override
  String get go => 'اذهب';

  @override
  String get permission => 'الإذن';

  @override
  String get rate => 'تقييم';

  @override
  String get share => 'مشاركة';

  @override
  String get policy => 'سياسة الخصوصية';

  @override
  String get rateUs => 'قيمنا';

  @override
  String get setting => 'الإعدادات';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع!';

  @override
  String get alreadyOwnError =>
      'يبدو أنك تمتلك هذا العنصر بالفعل.\nيرجى النقر فوق \"استعادة الشراء\" للمتابعة.';

  @override
  String get confirm => 'تأكيد';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get backToHomescreen => 'العودة إلى الشاشة الرئيسية';

  @override
  String get exitApp => 'الخروج من التطبيق';

  @override
  String get areYouSureYouWantToExitApp =>
      'هل أنت متأكد أنك تريد الخروج من التطبيق؟';

  @override
  String get pleaseSelectLanguage => 'يرجى تحديد اللغة للمتابعة';

  @override
  String get allDocumentsViewer => 'عارض جميع المستندات';

  @override
  String get onboardingTitle1 => 'اقرأ جميع المستندات';

  @override
  String get onboardingTitle2 => 'افهم أي مستند فورًا';

  @override
  String get onboardingTitle3 => 'حرر ملفات PDF باحتراف';

  @override
  String get onboardingContent1 =>
      'افتح ملفات PDF وWord وExcel وPPT بسرعة وسلاسة';

  @override
  String get onboardingContent2 =>
      'ترجم ولخص الملفات باستخدام الذكاء الاصطناعي خلال ثوانٍ';

  @override
  String get onboardingContent3 =>
      'قم بتمييز ملفات PDF والتعليق عليها وتوقيعها وتحريرها بسهولة';

  @override
  String get requirePermission => 'عارض جميع المستندات يتطلب إذنًا!';

  @override
  String get goToSetting => 'اذهب إلى الإعدادات';

  @override
  String get storage => 'التخزين';

  @override
  String get camera => 'الكاميرا';

  @override
  String get grantPermission => 'منح الإذن لاحقًا';

  @override
  String get continuePer => 'استمر';

  @override
  String get cancel => 'إلغاء';

  @override
  String get ok => 'موافق';

  @override
  String get save => 'حفظ';

  @override
  String get exit => 'الخروج من التطبيق';

  @override
  String get doYouWantExitApp => 'هل تريد الخروج من التطبيق؟';

  @override
  String get home => 'الرئيسية';

  @override
  String get document => 'مستند';

  @override
  String get recent => 'الأخيرة';

  @override
  String get bookmark => 'إشارة مرجعية';

  @override
  String get searchOnAllDocumentsViewer => 'البحث في عارض جميع المستندات';

  @override
  String get mergePDF => 'دمج PDF';

  @override
  String get splitPDF => 'تقسيم PDF';

  @override
  String get unlockPDF => 'إلغاء تأمين PDF';

  @override
  String get lockPDF => 'تأمين PDF';

  @override
  String get scanPDF => 'مسح PDF';

  @override
  String get pDFToImage => 'تحويل PDF إلى صورة';

  @override
  String get documentTool => 'أداة المستندات';

  @override
  String get documentReader => 'قارئ المستندات';

  @override
  String sumFiles(int count) {
    return '$count ملفات';
  }

  @override
  String get pdf => 'PDF';

  @override
  String get word => 'DOC';

  @override
  String get excel => 'XLSX';

  @override
  String get ppt => 'PPT';

  @override
  String get txt => 'TXT';

  @override
  String get image => 'صورة';

  @override
  String get doYouLikeTheApp => 'هل تحب التطبيق؟';

  @override
  String get rate5 => 'أحبه';

  @override
  String get rate4 => 'رائع!';

  @override
  String get rate3 => 'حزين!';

  @override
  String get rate2 => 'سيء!';

  @override
  String get rate1 => 'سيء جدًا!';

  @override
  String get notNow => 'ليس الآن';

  @override
  String get print => 'طباعة';

  @override
  String get renameFile => 'إعادة تسمية الملف';

  @override
  String get pdfConverter => 'محول PDF';

  @override
  String get deleteFromDevice => 'حذف من الجهاز';

  @override
  String get fileName => 'اسم الملف';

  @override
  String get storagePath => 'مسار التخزين';

  @override
  String get lastView => 'آخر مشاهدة';

  @override
  String get lastModified => 'آخر تعديل';

  @override
  String get size => 'الحجم';

  @override
  String get rename => 'إعادة تسمية';

  @override
  String get all => 'الكل';

  @override
  String get fileNameCannotBeEmpty => 'لا يمكن أن يكون اسم الملف فارغًا';

  @override
  String get pleaseEnterFileName => 'يرجى إدخال اسم الملف';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get last7Day => 'آخر 7 أيام';

  @override
  String get monthAgo => 'منذ شهر';

  @override
  String get delete => 'حذف';

  @override
  String get deleteIt => 'هل أنت متأكد من حذفه؟';

  @override
  String fileSelected(Object count) {
    return '$count ملف محدد';
  }

  @override
  String get exitAndDiscard => 'الخروج والتخلي عن التغييرات؟';

  @override
  String get files => 'ملفات';

  @override
  String get discard => 'تجاهل';

  @override
  String get redOption => 'أحمر';

  @override
  String get greenOption => 'أخضر';

  @override
  String get blueOption => 'أزرق';

  @override
  String get displayP3HexColor => 'عرض لون P3 Hex #';

  @override
  String get colorsOption => 'الألوان';

  @override
  String get gridOption => 'شبكة';

  @override
  String get spectrumOption => 'طيف';

  @override
  String get slidersOption => 'منزلقات';

  @override
  String get opacityOption => 'الشفافية';

  @override
  String get fontSize => 'حجم الخط:';

  @override
  String get aToz => 'من A إلى Z';

  @override
  String get zToa => 'من Z إلى A';

  @override
  String get newToOld => 'من الأحدث إلى الأقدم';

  @override
  String get oldToNew => 'من الأقدم إلى الأحدث';

  @override
  String get smallToLarge => 'من الأصغر إلى الأكبر';

  @override
  String get largeToSmall => 'من الأكبر إلى الأصغر';

  @override
  String get title => 'العنوان';

  @override
  String get time => 'الوقت';

  @override
  String get open => 'فتح';

  @override
  String get empty => 'فارغ';

  @override
  String get goHome => 'العودة إلى الرئيسية';

  @override
  String get merge => 'دمج';

  @override
  String get success => 'نجاح';

  @override
  String get split => 'تقسيم';

  @override
  String get remove => 'إزالة';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get sortBy => 'فرز حسب';

  @override
  String get removePwTo => 'إزالة كلمة المرور، لن يكون الملف محمياً بعد الآن.';

  @override
  String get setPwTo => 'تعيين كلمة مرور لحماية ملف PDF الخاص بك.';

  @override
  String get setPassword => 'تعيين كلمة مرور';

  @override
  String get removePassword => 'إزالة كلمة المرور';

  @override
  String get longImages => 'صور طويلة';

  @override
  String get separateImages => 'صور منفصلة';

  @override
  String get unknownError => 'خطأ غير معروف';

  @override
  String get pdfToImages => 'تحويل PDF إلى صور';

  @override
  String get exportImageSuccess => 'تم تصدير الصورة بنجاح!';

  @override
  String get lockPdfSuccess => 'تم قفل PDF بنجاح!';

  @override
  String get scanPdfSuccess => 'تم مسح PDF ضوئيًا بنجاح!';

  @override
  String get mergePdfSuccess => 'تم دمج PDF بنجاح!';

  @override
  String get editPdfSuccess => 'تم تعديل PDF بنجاح!';

  @override
  String get allDoc => 'عارض جميع المستندات';

  @override
  String get splitSuccess => 'تم تقسيم PDF بنجاح!';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get enterThePassword => 'أدخل كلمة المرور لفتح الملف';

  @override
  String get password => 'كلمة المرور';

  @override
  String get wrongPassword => 'كلمة مرور خاطئة، يرجى المحاولة مرة أخرى';

  @override
  String passwordProtected(Object path) {
    return '$path محمي بكلمة مرور';
  }

  @override
  String get unlockPdfSuccess => 'تم إلغاء قفل PDF بنجاح!';

  @override
  String get search => 'بحث';

  @override
  String get errorCharacter =>
      'الإدخال يحتوي على أحرف خاصة أو فارغ. يرجى إدخال نص صالح بدون أحرف خاصة.';

  @override
  String get cameraReqPermission => 'يتطلب الوصول إلى الكاميرا لمسح PDF ضوئيًا';

  @override
  String get storageReqPermission =>
      'يتطلب الوصول إلى التخزين لعرض جميع الملفات';

  @override
  String get reqPermission => 'طلب الأذونات';

  @override
  String get underline => 'تسطير';

  @override
  String get brush => 'فرشاة';

  @override
  String get highlight => 'تمييز';

  @override
  String get strikethrough => 'شطب';

  @override
  String get anError => 'حدث خطأ:';

  @override
  String get errorUpdatePw => 'خطأ في تحديث كلمة مرور PDF:';

  @override
  String get noDocumentFound => 'لم يتم العثور على مستندات';

  @override
  String get sampleFile => 'ملف عينة';

  @override
  String get thisSampleFile => 'هذا ملف عينة';

  @override
  String get developing => 'قيد التطوير';

  @override
  String get doNotSupport => 'لا يدعم هذا الملف';

  @override
  String get uninstall => 'إلغاء التثبيت';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'ما المشكلات التي تواجهها أثناء الاستخدام؟';

  @override
  String get dontUninstallYet => 'لا تقم بإلغاء التثبيت بعد';

  @override
  String get stillWantToUninstall => 'هل ما زلت ترغب في إلغاء التثبيت؟';

  @override
  String get difficultToUse => 'صعب الاستخدام';

  @override
  String get tooManyAds => 'الإعلانات كثيرة جدًا';

  @override
  String get others => 'أخرى';

  @override
  String get viewFiles => 'عرض الملفات';

  @override
  String get unableToReceiveFiles => 'غير قادر على استلام الملفات';

  @override
  String get unableToViewTheFile => 'غير قادر على عرض الملف';

  @override
  String get explore => 'استكشاف';

  @override
  String whyUninstallApp(String appName) {
    return 'لماذا تقوم بإلغاء تثبيت $appName؟';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'يرجى إدخال سبب إلغاء تثبيت $appName.';
  }

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get setAsDefault => 'تعيين كافتراضي';

  @override
  String get justOnce => 'مرة واحدة فقط';

  @override
  String get always => 'دائمًا';

  @override
  String get tip => 'نصيحة';

  @override
  String get subTip =>
      'إذا لم تتمكن من العثور على أيقونة التطبيق، اضغط على \'المزيد\' أو النقاط الثلاث للبحث عنها';

  @override
  String get documentViewer => 'عارض المستندات';

  @override
  String get allowAccess => 'السماح بالوصول لإدارة جميع الملفات';

  @override
  String pleaseAllowAll(Object appName) {
    return 'يرجى السماح لتطبيق $appName بالوصول إلى جميع ملفاتك';
  }

  @override
  String get allowPermission => 'السماح بالإذن';

  @override
  String get welcomeTo => 'مرحبًا بك في';

  @override
  String get yourDataRemain => 'تظل بياناتك خاصة';

  @override
  String get weNeedPermission =>
      'نحن بحاجة إلى إذن للوصول إلى جميع الملفات من أجل \n إدارتها وعرضها وتنظيمها بكفاءة';

  @override
  String get failedToLoadPage => 'فشل في تحميل الصفحة';

  @override
  String get savedSuccessfully => 'تم الحفظ بنجاح';

  @override
  String get editPdf => 'تحرير PDF';

  @override
  String get textStyle => 'نمط النص';

  @override
  String get more => 'المزيد';

  @override
  String get searchYourFile => 'ابحث في ملفاتك';

  @override
  String get select => 'تحديد';

  @override
  String imageExported(Object images) {
    return 'تم تصدير $images صورة';
  }

  @override
  String imagesExported(Object images) {
    return 'تم تصدير $images صور';
  }

  @override
  String get openGallery => 'افتح \"المعرض\" للعثور على ملف';

  @override
  String get tools => 'أدوات';

  @override
  String get goStatusBar => 'انتقل إلى شريط الحالة للعثور على الصور';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'يرجى السماح لتطبيق عارض جميع المستندات\nبالوصول إلى جميع ملفاتك';

  @override
  String get notificationsTurnedOff =>
      'تم إيقاف الإشعارات! قد تفوتك مستندات هامة';

  @override
  String get tapToOpenSettings => 'اضغط هنا لفتح الإعدادات وتمكين الإشعارات';

  @override
  String get later => 'لاحقًا';

  @override
  String get showNotification => 'عرض الإشعارات';

  @override
  String get enableNotification => 'تمكين الإشعارات';

  @override
  String get appName => 'PDF Reader - Document Editor';

  @override
  String get toViewYourFiles => 'لعرض ملفاتك، يرجى توفير';

  @override
  String get withAccessToThem => 'إمكانية الوصول إليها';

  @override
  String get languageOptions => 'خيارات اللغة';

  @override
  String get toContinuePleaseGrant => 'للمتابعة، يرجى منح';

  @override
  String get acceptToYourFile => 'الوصول إلى ملفاتك.';

  @override
  String get apply => 'تطبيق';

  @override
  String get other => 'أخرى';

  @override
  String get startNow => 'ابدأ الآن';

  @override
  String get page => 'الصفحة';

  @override
  String get goToPage => 'اذهب إلى الصفحة';

  @override
  String get pageNumber => 'رقم الصفحة';

  @override
  String enterPageNumber(int start, int end) {
    return 'أدخل رقم الصفحة ($start - $end)';
  }

  @override
  String get invalid => 'غير صالح';
}
