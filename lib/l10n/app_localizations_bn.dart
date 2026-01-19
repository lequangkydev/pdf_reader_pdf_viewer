// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get saveToAlbum => 'অ্যালবামে সংরক্ষণ করুন';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি ছবি সংরক্ষণ করা হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'مشاركة هذا الملف عبر $appName – سهل جدًا للعرض والتحرير. يمكنك تجربته هنا: $value';
  }

  @override
  String get searchInPdf =>
      '<b><span style=\'color:#E01621\'>PDF Reader</span></b>-এ অনুসন্ধান করুন';

  @override
  String get searchInDoc =>
      '<b><span style=\'color:#2979FF\'>DOC Reader</span></b>-এ অনুসন্ধান করুন';

  @override
  String get searchInExcel =>
      '<b><span style=\'color:#388E3C\'>XLS Reader</span></b>-এ অনুসন্ধান করুন';

  @override
  String get searchInPpt =>
      '<b><span style=\'color:#F2590C\'>PPT Reader</span></b>-এ অনুসন্ধান করুন';

  @override
  String get unSelect => 'নির্বাচন বাতিল করুন';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$valueটি ফাইল',
      one: '১টি ফাইল',
      zero: 'কোনো ফাইল নেই',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'সারাংশ তৈরি হচ্ছে';

  @override
  String get translationProgress => 'অনুবাদ চলছে';

  @override
  String get tryAnotherFile =>
      'এই ফাইলটি একত্র করা যায়নি। চালিয়ে যেতে একটি ভিন্ন ফাইল নির্বাচন করার চেষ্টা করুন।';

  @override
  String get result => 'ফলাফল';

  @override
  String get scroll => 'স্ক্রল';

  @override
  String get giveFeedback => 'প্রতিক্রিয়া দিন';

  @override
  String get add => 'যোগ করুন';

  @override
  String get selectText => 'টেক্সট নির্বাচন করুন';

  @override
  String get pleaseDoNot =>
      'অনুগ্রহ করে উচ্চারণ চিহ্নযুক্ত অক্ষর ব্যবহার করবেন না';

  @override
  String get pleaseEnter => 'অনুগ্রহ করে কিছু টেক্সট লিখুন';

  @override
  String get watermark => 'ওয়াটারমার্ক';

  @override
  String get enterText => 'টেক্সট লিখুন';

  @override
  String get color => 'রং';

  @override
  String get addText => 'টেক্সট যোগ করুন';

  @override
  String get addWatermark => 'ওয়াটারমার্ক যোগ করুন';

  @override
  String get watermarkContent => 'ওয়াটারমার্ক বিষয়বস্তু';

  @override
  String get editSuccess => 'সফলভাবে সম্পাদিত হয়েছে!';

  @override
  String get signature => 'স্বাক্ষর';

  @override
  String get noSignature => 'কোন স্বাক্ষর নেই';

  @override
  String get createSignature => 'নতুন স্বাক্ষর তৈরি করুন';

  @override
  String get feedbackTitle => 'এআই সহকারী সম্পর্কে প্রতিক্রিয়া';

  @override
  String get feedbackTo => 'প্রাপক: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'বিষয়: “PDF Reader & Photo to PDF” সম্পর্কে প্রতিক্রিয়া।';

  @override
  String get feedbackHint => 'এখানে আপনার প্রতিক্রিয়া লিখুন...';

  @override
  String get feedbackButton => 'প্রতিক্রিয়া পাঠান';

  @override
  String get feedbackEmptyMessage => 'প্রথমে আপনার প্রতিক্রিয়া লিখুন';

  @override
  String get feedbackSuccessMessage =>
      'প্রতিক্রিয়া পাঠানো হয়েছে (অথবা ইমেইল অ্যাপ খোলা হয়েছে)';

  @override
  String get feedbackErrorMessage => 'ইমেইল অ্যাপ খোলা যায়নি';

  @override
  String get downloadSuccess => 'সফলভাবে ডাউনলোড হয়েছে!';

  @override
  String get noTranslate => 'কোন অনুবাদ করা বিষয়বস্তু নেই।';

  @override
  String get keyPoint => 'মূল পয়েন্ট:';

  @override
  String get conclusion => 'উপসংহার';

  @override
  String get summary => 'সারসংক্ষেপ';

  @override
  String get type => 'ধরন';

  @override
  String get preview => 'পূর্বরূপ';

  @override
  String get startTranslate => 'অনুবাদ শুরু করুন';

  @override
  String get startSummary => 'সারসংক্ষেপ শুরু করুন';

  @override
  String get translateTo => 'অনুবাদ করুন';

  @override
  String get summaryStyle => 'সারসংক্ষেপের ধরন';

  @override
  String get selectPage => 'পৃষ্ঠা নির্বাচন করুন';

  @override
  String get startAISummary => 'এআই সারসংক্ষেপ শুরু করুন';

  @override
  String get startAITranslate => 'এআই অনুবাদ শুরু করুন';

  @override
  String get aIAssistant => 'এআই সহকারী';

  @override
  String get aITranslate => 'এআই অনুবাদ';

  @override
  String get aISummary => 'এআই সারসংক্ষেপ';

  @override
  String get ai_translate_description =>
      '<b>AI দিয়ে তাৎক্ষণিকভাবে ডকুমেন্ট অনুবাদ করুন।\n</b> মাত্র এক ট্যাপে পুরো PDF অন্য ভাষায় রূপান্তর করুন—নির্ভুল, স্বাভাবিক ও সহজভাবে।';

  @override
  String get ai_summary_description =>
      '<b>AI Summary দিয়ে ডকুমেন্ট দ্রুত বুঝুন।\n</b> শক্তিশালী AI ব্যবহার করে দীর্ঘ PDF কে সংক্ষিপ্ত ও গুছানো সারাংশে রূপান্তর করুন—অপ্রয়োজনীয় পড়া ছাড়াই মূল বিষয় পান।';

  @override
  String get translate1 => 'সেকেন্ডের মধ্যে সম্পূর্ণ ডকুমেন্ট অনুবাদ';

  @override
  String get translate2 => 'AI দ্বারা চালিত স্বচ্ছ ও মানবসদৃশ ফলাফল';

  @override
  String get translate3 => 'একাধিক ভাষা সমর্থিত';

  @override
  String get translate4 => 'পড়াশোনা, কাজ ও ভ্রমণের জন্য আদর্শ';

  @override
  String get summary1 => 'দ্রুত, এক-ট্যাপ সারাংশ';

  @override
  String get summary2 => 'বিভিন্ন পড়ার স্টাইলের জন্য একাধিক সারাংশ ফরম্যাট';

  @override
  String get summary3 => 'সবচেয়ে গুরুত্বপূর্ণ ধারণার স্পষ্ট হাইলাইট';

  @override
  String get summary4 => 'শিক্ষার্থী, পেশাজীবী ও দৈনন্দিন পড়ার জন্য উপযুক্ত';

  @override
  String get convertedSuccess => 'সফলভাবে রূপান্তরিত হয়েছে';

  @override
  String get convertPdfSuccess => 'PDF-এ সফলভাবে রূপান্তরিত হয়েছে!';

  @override
  String get imageToPdf => 'ছবি থেকে PDF';

  @override
  String get youCanHold => 'আপনি চেপে ধরে টেনে ছবি পুনর্বিন্যাস করতে পারেন';

  @override
  String get addImage => 'ছবি যোগ করুন';

  @override
  String get selectImage => 'ছবি নির্বাচন করুন';

  @override
  String get selectLanguage =>
      '<b><span style=\'color:#D90000\'>ভাষা</span> নির্বাচন করুন</b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value ফলাফল',
      one: '1 ফলাফল',
      zero: 'কোন ফলাফল নেই',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'লোড হচ্ছে ($value%)...';
  }

  @override
  String get searchOn => 'All File Viewer এ অনুসন্ধান করুন';

  @override
  String get detail => 'বিস্তারিত';

  @override
  String get fileSize => 'ফাইলের আকার';

  @override
  String get name => 'নাম';

  @override
  String get sign => 'স্বাক্ষর';

  @override
  String get systemLanguage => 'সিস্টেমের ভাষা';

  @override
  String get done => 'সম্পন্ন';

  @override
  String get guideExportImage =>
      'আপনার গ্যালারি খুলে ছবিগুলি দেখুন বা শেয়ার করুন।';

  @override
  String get textSetDefault =>
      'PDF Reader - PDF Viewer ডিফল্ট করুন, সঙ্গে সঙ্গে খুলুন।';

  @override
  String get enterPassSelect => 'এই ফাইলটি নির্বাচন করতে পাসওয়ার্ড দিন।';

  @override
  String get selectThePage =>
      'বিভাজনের জন্য পৃষ্ঠা নির্বাচন করুন, তারপর ট্যাপ করে ধরে রেখে সরান ও পুনর্বিন্যাস করুন।';

  @override
  String get theFastestWay => ' আপনার ফাইল খুলতে সবচেয়ে দ্রুত উপায়';

  @override
  String get neverMiss =>
      'আপনার ডকুমেন্টের গুরুত্বপূর্ণ আপডেট কখনও মিস করবেন না।';

  @override
  String get guideMerge => 'মার্জ করতে অন্তত ২টি ফাইল নির্বাচন করুন।';

  @override
  String get notification => 'নোটিফিকেশন';

  @override
  String get allowAccessTo => 'সমস্ত ফাইল পরিচালনা করার জন্য প্রবেশাধিকার দিন';

  @override
  String get useDeviceLanguage => 'ডিভাইসের ভাষা ব্যবহার করুন';

  @override
  String get previewConvert => 'রূপান্তর প্রাকদর্শন';

  @override
  String get download => 'ডাউনলোড';

  @override
  String get pdfToLongImages => 'PDF থেকে লম্বা ছবি';

  @override
  String get convertSelect => 'নির্বাচিত রূপান্তর করুন';

  @override
  String get convertAll => 'সব রূপান্তর করুন';

  @override
  String get searchInFile => 'ফাইলে অনুসন্ধান করুন';

  @override
  String get language => 'ভাষা';

  @override
  String get thisActionCanContainAds => 'এই ক্রিয়াটি বিজ্ঞাপন থাকতে পারে';

  @override
  String get next => 'পরবর্তী';

  @override
  String get thank => 'ধন্যবাদ!';

  @override
  String get start => 'শুরু করুন';

  @override
  String get go => 'যাও';

  @override
  String get permission => 'অনুমতি';

  @override
  String get rate => 'মূল্যায়ন';

  @override
  String get share => 'শেয়ার করুন';

  @override
  String get policy => 'গোপনীয়তা নীতি';

  @override
  String get rateUs => 'আমাদের মূল্যায়ন করুন';

  @override
  String get setting => 'সেটিংস';

  @override
  String get unexpectedError => 'একটি অপ্রত্যাশিত ত্রুটি ঘটেছে!';

  @override
  String get alreadyOwnError =>
      'মনে হচ্ছে আপনি ইতিমধ্যে এই আইটেমটির মালিক।\nঅনুগ্রহ করে চালিয়ে যেতে \"ক্রয় পুনরুদ্ধার করুন\" ক্লিক করুন।';

  @override
  String get confirm => 'নিশ্চিত করুন';

  @override
  String get yes => 'হ্যাঁ';

  @override
  String get no => 'না';

  @override
  String get backToHomescreen => 'হোম স্ক্রীনে ফিরে যান';

  @override
  String get exitApp => 'অ্যাপ থেকে বেরিয়ে যান';

  @override
  String get areYouSureYouWantToExitApp =>
      'আপনি কি অ্যাপ থেকে বেরিয়ে যেতে চান?';

  @override
  String get pleaseSelectLanguage => 'চালিয়ে যেতে দয়া করে ভাষা নির্বাচন করুন';

  @override
  String get allDocumentsViewer => 'সমস্ত ডকুমেন্ট ভিউয়ার';

  @override
  String get onboardingTitle1 => 'সব ডকুমেন্ট পড়ুন';

  @override
  String get onboardingTitle2 => 'যেকোনো ডকুমেন্ট মুহূর্তেই বুঝুন';

  @override
  String get onboardingTitle3 => 'পেশাদারের মতো PDF সম্পাদনা করুন';

  @override
  String get onboardingContent1 =>
      'PDF, Word, Excel, PPT খুলুন — দ্রুত ও নির্বিঘ্নে';

  @override
  String get onboardingContent2 =>
      'AI দিয়ে কয়েক সেকেন্ডে ফাইল অনুবাদ ও সারসংক্ষেপ করুন';

  @override
  String get onboardingContent3 =>
      'সহজেই PDF হাইলাইট, মন্তব্য, স্বাক্ষর ও মার্কআপ করুন';

  @override
  String get requirePermission => 'সমস্ত ডকুমেন্ট ভিউয়ার অনুমতি প্রয়োজন!';

  @override
  String get goToSetting => 'সেটিংসে যান';

  @override
  String get storage => 'সংগ্রহস্থল';

  @override
  String get camera => 'ক্যামেরা';

  @override
  String get grantPermission => 'পরবর্তীতে অনুমতি দিন';

  @override
  String get continuePer => 'চালিয়ে যান';

  @override
  String get cancel => 'থাকুন';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get exit => 'অ্যাপ থেকে বেরিয়ে যান';

  @override
  String get doYouWantExitApp => 'আপনি কি অ্যাপ থেকে বেরিয়ে যেতে চান?';

  @override
  String get home => 'হোম';

  @override
  String get document => 'ডকুমেন্ট';

  @override
  String get recent => 'সাম্প্রতিক';

  @override
  String get bookmark => 'বুকমার্ক';

  @override
  String get searchOnAllDocumentsViewer =>
      'সমস্ত ডকুমেন্ট ভিউয়ার-এ অনুসন্ধান করুন';

  @override
  String get mergePDF => 'PDF একত্রিত করুন';

  @override
  String get splitPDF => 'PDF বিভক্ত করুন';

  @override
  String get unlockPDF => 'PDF আনলক করুন';

  @override
  String get lockPDF => 'PDF লক করুন';

  @override
  String get scanPDF => 'PDF স্ক্যান করুন';

  @override
  String get pDFToImage => 'PDF থেকে ইমেজ';

  @override
  String get documentTool => 'ডকুমেন্ট সরঞ্জাম';

  @override
  String get documentReader => 'ডকুমেন্ট রিডার';

  @override
  String sumFiles(int count) {
    return '$count ফাইল';
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
  String get image => 'ইমেজ';

  @override
  String get doYouLikeTheApp => 'আপনার কি অ্যাপটি পছন্দ হয়েছে?';

  @override
  String get rate5 => 'ভালো লেগেছে';

  @override
  String get rate4 => 'দারুণ!';

  @override
  String get rate3 => 'দুঃখিত!';

  @override
  String get rate2 => 'খারাপ!';

  @override
  String get rate1 => 'ভয়াবহ!';

  @override
  String get notNow => 'এখন নয়';

  @override
  String get print => 'প্রিন্ট করুন';

  @override
  String get renameFile => 'ফাইলের নাম পরিবর্তন করুন';

  @override
  String get pdfConverter => 'PDF কনভার্টার';

  @override
  String get deleteFromDevice => 'ডিভাইস থেকে মুছুন';

  @override
  String get fileName => 'ফাইলের নাম';

  @override
  String get storagePath => 'সংগ্রহস্থলের পথ';

  @override
  String get lastView => 'সর্বশেষ দেখা';

  @override
  String get lastModified => 'সর্বশেষ পরিবর্তিত';

  @override
  String get size => 'মাপ';

  @override
  String get rename => 'নাম পরিবর্তন';

  @override
  String get all => 'সব';

  @override
  String get fileNameCannotBeEmpty => 'ফাইলের নাম খালি রাখা যাবে না';

  @override
  String get pleaseEnterFileName => 'অনুগ্রহ করে ফাইলের নাম লিখুন';

  @override
  String get today => 'আজ';

  @override
  String get yesterday => 'গতকাল';

  @override
  String get last7Day => 'শেষ ৭ দিন';

  @override
  String get monthAgo => '১ মাস আগে';

  @override
  String get delete => 'মুছুন';

  @override
  String get deleteIt => 'আপনি কি এটি মুছে ফেলতে নিশ্চিত?';

  @override
  String fileSelected(Object count) {
    return '$count ফাইল নির্বাচিত';
  }

  @override
  String get exitAndDiscard => 'বেরিয়ে যান এবং পরিবর্তন বাতিল করুন?';

  @override
  String get files => 'ফাইল';

  @override
  String get discard => 'বেরিয়ে যান';

  @override
  String get redOption => 'লাল';

  @override
  String get greenOption => 'সবুজ';

  @override
  String get blueOption => 'নীল';

  @override
  String get displayP3HexColor => 'P3 হেক্স রঙ দেখান #';

  @override
  String get colorsOption => 'রঙ';

  @override
  String get gridOption => 'গ্রিড';

  @override
  String get spectrumOption => 'স্পেকট্রাম';

  @override
  String get slidersOption => 'স্লাইডার';

  @override
  String get opacityOption => 'অস্বচ্ছতা';

  @override
  String get fontSize => 'ফন্ট আকার:';

  @override
  String get aToz => 'A থেকে Z';

  @override
  String get zToa => 'Z থেকে A';

  @override
  String get newToOld => 'নতুন থেকে পুরাতন';

  @override
  String get oldToNew => 'পুরাতন থেকে নতুন';

  @override
  String get smallToLarge => 'ছোট থেকে বড়';

  @override
  String get largeToSmall => 'বড় থেকে ছোট';

  @override
  String get title => 'শিরোনাম';

  @override
  String get time => 'সময়';

  @override
  String get open => 'খুলুন';

  @override
  String get empty => 'খালি';

  @override
  String get goHome => 'প্রথম পৃষ্ঠায় যান';

  @override
  String get merge => 'মার্জ';

  @override
  String get success => 'সফলতা';

  @override
  String get split => 'বিভক্ত';

  @override
  String get remove => 'অপসারণ';

  @override
  String get loading => 'লোড হচ্ছে...';

  @override
  String get sortBy => 'সাজানোর ক্রম';

  @override
  String get removePwTo => 'পাসওয়ার্ড সরান, ফাইল আর সুরক্ষিত থাকবে না।';

  @override
  String get setPwTo => 'আপনার PDF ফাইল রক্ষা করতে পাসওয়ার্ড সেট করুন।';

  @override
  String get setPassword => 'পাসওয়ার্ড সেট করুন';

  @override
  String get removePassword => 'পাসওয়ার্ড সরান';

  @override
  String get longImages => 'লম্বা ছবি';

  @override
  String get separateImages => 'আলাদা ছবি';

  @override
  String get unknownError => 'অজানা ত্রুটি';

  @override
  String get pdfToImages => 'PDF থেকে ছবি';

  @override
  String get exportImageSuccess => 'সফলভাবে ইমেজ রপ্তানি হয়েছে!';

  @override
  String get lockPdfSuccess => 'সফলভাবে PDF লক হয়েছে!';

  @override
  String get scanPdfSuccess => 'সফলভাবে PDF স্ক্যান হয়েছে!';

  @override
  String get mergePdfSuccess => 'সফলভাবে PDF মার্জ হয়েছে!';

  @override
  String get editPdfSuccess => 'সফলভাবে PDF সম্পাদনা হয়েছে!';

  @override
  String get allDoc => 'সমস্ত নথি প্রদর্শক';

  @override
  String get splitSuccess => 'সফলভাবে PDF বিভক্ত হয়েছে!';

  @override
  String get enterPassword => 'পাসওয়ার্ড প্রবেশ করান';

  @override
  String get enterThePassword => 'ফাইলটি খুলতে পাসওয়ার্ড লিখুন';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get wrongPassword => 'ভুল পাসওয়ার্ড, আবার চেষ্টা করুন';

  @override
  String passwordProtected(Object path) {
    return '$path পাসওয়ার্ড দ্বারা সুরক্ষিত';
  }

  @override
  String get unlockPdfSuccess => 'সফলভাবে PDF আনলক হয়েছে!';

  @override
  String get search => 'অনুসন্ধান';

  @override
  String get errorCharacter =>
      'ইনপুটে বিশেষ অক্ষর রয়েছে বা এটি খালি। অনুগ্রহ করে বৈধ পাঠ্য লিখুন।';

  @override
  String get cameraReqPermission =>
      'PDF স্ক্যান করার জন্য ক্যামেরা অ্যাক্সেস প্রয়োজন';

  @override
  String get storageReqPermission =>
      'সমস্ত ফাইল দেখার জন্য স্টোরেজ অ্যাক্সেস প্রয়োজন';

  @override
  String get reqPermission => 'অনুমতি অনুরোধ';

  @override
  String get underline => 'আন্ডারলাইন';

  @override
  String get brush => 'ব্রাশ';

  @override
  String get highlight => 'হাইলাইট';

  @override
  String get strikethrough => 'কাটা লেখা';

  @override
  String get anError => 'একটি ত্রুটি ঘটেছে:';

  @override
  String get errorUpdatePw => 'PDF পাসওয়ার্ড আপডেট করার সময় ত্রুটি:';

  @override
  String get noDocumentFound => 'কোনও নথি পাওয়া যায়নি';

  @override
  String get sampleFile => 'নমুনা ফাইল';

  @override
  String get thisSampleFile => 'এটি একটি নমুনা ফাইল';

  @override
  String get developing => 'উন্নয়নাধীন';

  @override
  String get doNotSupport => 'এই ফাইল সমর্থন করা হয় না';

  @override
  String get uninstall => 'আনইনস্টল করুন';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'আপনি ব্যবহারের সময় কী সমস্যার সম্মুখীন হন?';

  @override
  String get dontUninstallYet => 'এখনই আনইনস্টল করবেন না';

  @override
  String get stillWantToUninstall => 'আপনি কি এখনও আনইনস্টল করতে চান?';

  @override
  String get difficultToUse => 'ব্যবহার করা কঠিন';

  @override
  String get tooManyAds => 'অতিরিক্ত বিজ্ঞাপন';

  @override
  String get others => 'অন্যান্য';

  @override
  String get viewFiles => 'ফাইল দেখুন';

  @override
  String get unableToReceiveFiles => 'ফাইল পেতে অক্ষম';

  @override
  String get unableToViewTheFile => 'ফাইল দেখতে অক্ষম';

  @override
  String get explore => 'অন্বেষণ করুন';

  @override
  String whyUninstallApp(String appName) {
    return 'কেন $appName আনইনস্টল করছেন?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'অনুগ্রহ করে $appName আনইনস্টল করার কারণ লিখুন।';
  }

  @override
  String get tryAgain => 'আবার চেষ্টা করুন';

  @override
  String get setAsDefault => 'ডিফল্ট হিসেবে সেট করুন';

  @override
  String get justOnce => 'শুধুমাত্র একবার';

  @override
  String get always => 'সবসময়';

  @override
  String get tip => 'পরামর্শ';

  @override
  String get subTip =>
      'আপনি যদি অ্যাপ আইকন না পান, তাহলে \'আরও\' অথবা তিনটি ডট ট্যাপ করে খুঁজুন';

  @override
  String get documentViewer => 'নথি প্রদর্শক';

  @override
  String get allowAccess => 'সমস্ত ফাইল পরিচালনার জন্য প্রবেশাধিকার দিন';

  @override
  String pleaseAllowAll(Object appName) {
    return 'অনুগ্রহ করে $appName কে আপনার সব ফাইলে অ্যাক্সেসের অনুমতি দিন';
  }

  @override
  String get allowPermission => 'অনুমতি দিন';

  @override
  String get welcomeTo => 'স্বাগতম';

  @override
  String get yourDataRemain => 'আপনার ডেটা গোপন থাকবে';

  @override
  String get weNeedPermission =>
      'ফাইলগুলি পরিচালনা, দেখা এবং দক্ষভাবে সংগঠিত করতে \n আমাদের সমস্ত ফাইল অ্যাক্সেস করার অনুমতি প্রয়োজন';

  @override
  String get failedToLoadPage => 'পৃষ্ঠা লোড করতে ব্যর্থ হয়েছে';

  @override
  String get savedSuccessfully => 'সফলভাবে সংরক্ষিত হয়েছে';

  @override
  String get editPdf => 'PDF সম্পাদনা করুন';

  @override
  String get textStyle => 'টেক্সট স্টাইল';

  @override
  String get more => 'আরও';

  @override
  String get searchYourFile => 'আপনার ফাইল খুঁজুন';

  @override
  String get select => 'নির্বাচন করুন';

  @override
  String imageExported(Object images) {
    return '$images টি ছবি রপ্তানি হয়েছে';
  }

  @override
  String imagesExported(Object images) {
    return '$images টি ছবি রপ্তানি হয়েছে';
  }

  @override
  String get openGallery => 'ফাইল খুঁজতে \"গ্যালারি\" খুলুন';

  @override
  String get tools => 'সরঞ্জাম';

  @override
  String get goStatusBar => 'ছবি খুঁজতে স্ট্যাটাস বারে যান';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'অনুগ্রহ করে সমস্ত ডকুমেন্টস\nভিউয়ারকে আপনার সমস্ত ফাইলে অ্যাক্সেস করার অনুমতি দিন';

  @override
  String get notificationsTurnedOff =>
      'নোটিফিকেশন বন্ধ করা হয়েছে! আপনি গুরুত্বপূর্ণ ডকুমেন্ট মিস করতে পারেন';

  @override
  String get tapToOpenSettings =>
      'সেটিংস খুলতে এবং নোটিফিকেশন চালু করতে এখানে ট্যাপ করুন';

  @override
  String get later => 'পরে';

  @override
  String get showNotification => 'নোটিফিকেশন দেখান';

  @override
  String get enableNotification => 'নোটিফিকেশন সক্ষম করুন';

  @override
  String get appName => 'PDF রিডার - PDF ভিউয়ার';

  @override
  String get toViewYourFiles => 'আপনার ফাইল দেখতে, অনুগ্রহ করে প্রদান করুন';

  @override
  String get withAccessToThem => 'তাদের অ্যাক্সেস সহ';

  @override
  String get languageOptions => 'ভাষার বিকল্প';

  @override
  String get toContinuePleaseGrant => 'চালিয়ে যেতে, অনুগ্রহ করে অনুমতি দিন';

  @override
  String get acceptToYourFile => 'আপনার ফাইলগুলিতে অ্যাক্সেস।';

  @override
  String get apply => 'আবেদন করুন';

  @override
  String get other => 'অন্যান্য';

  @override
  String get startNow => 'এখন শুরু করুন';

  @override
  String get page => 'পৃষ্ঠা';

  @override
  String get goToPage => 'পৃষ্ঠা যান';

  @override
  String get pageNumber => 'পৃষ্ঠা নম্বর';

  @override
  String enterPageNumber(int start, int end) {
    return 'পৃষ্ঠা নম্বর লিখুন ($start - $end)';
  }

  @override
  String get invalid => 'অবৈধ';
}
