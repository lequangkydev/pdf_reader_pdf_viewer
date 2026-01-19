// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get saveToAlbum => 'एल्बम में सहेजें';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count चित्र सहेजे गए',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return '$appName के माध्यम से इस फ़ाइल को साझा करें – देखना और संपादित करना बेहद आसान। इसे यहाँ आज़माएँ: $value';
  }

  @override
  String get searchInPdf =>
      '<b><span style=\'color:#E01621\'>PDF Reader</span></b> में खोजें';

  @override
  String get searchInDoc =>
      '<b><span style=\'color:#2979FF\'>DOC Reader</span></b> में खोजें';

  @override
  String get searchInExcel =>
      '<b><span style=\'color:#388E3C\'>XLS Reader</span></b> में खोजें';

  @override
  String get searchInPpt =>
      '<b><span style=\'color:#F2590C\'>PPT Reader</span></b> में खोजें';

  @override
  String get unSelect => 'चयन हटाएं';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value फ़ाइलें',
      one: '1 फ़ाइल',
      zero: 'कोई फ़ाइल नहीं',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'सारांश प्रगति पर है';

  @override
  String get translationProgress => 'अनुवाद प्रगति पर है';

  @override
  String get tryAnotherFile =>
      'इस फ़ाइल को मर्ज नहीं किया जा सका। जारी रखने के लिए कोई अन्य फ़ाइल चुनने का प्रयास करें।';

  @override
  String get result => 'परिणाम';

  @override
  String get scroll => 'स्क्रॉल करें';

  @override
  String get giveFeedback => 'मुझे प्रतिक्रिया दें';

  @override
  String get add => 'जोड़ें';

  @override
  String get selectText => 'पाठ चुनें';

  @override
  String get pleaseDoNot => 'कृपया उच्चारण चिह्न वाले अक्षर शामिल न करें';

  @override
  String get pleaseEnter => 'कृपया कुछ टेक्स्ट दर्ज करें';

  @override
  String get watermark => 'वॉटरमार्क';

  @override
  String get enterText => 'पाठ दर्ज करें';

  @override
  String get color => 'रंग';

  @override
  String get addText => 'टेक्स्ट जोड़ें';

  @override
  String get addWatermark => 'वॉटरमार्क जोड़ें';

  @override
  String get watermarkContent => 'वॉटरमार्क सामग्री';

  @override
  String get editSuccess => 'सफलतापूर्वक संपादित!';

  @override
  String get signature => 'हस्ताक्षर';

  @override
  String get noSignature => 'कोई हस्ताक्षर नहीं';

  @override
  String get createSignature => 'नया हस्ताक्षर बनाएं';

  @override
  String get feedbackTitle => 'एआई सहायक के बारे में प्रतिक्रिया';

  @override
  String get feedbackTo => 'प्रति: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'विषय: “PDF Reader & Photo to PDF” के बारे में प्रतिक्रिया।';

  @override
  String get feedbackHint => 'अपनी प्रतिक्रिया यहाँ लिखें...';

  @override
  String get feedbackButton => 'प्रतिक्रिया भेजें';

  @override
  String get feedbackEmptyMessage => 'कृपया पहले अपनी प्रतिक्रिया लिखें';

  @override
  String get feedbackSuccessMessage =>
      'प्रतिक्रिया भेज दी गई (या ईमेल ऐप खुल गया)';

  @override
  String get feedbackErrorMessage => 'ईमेल ऐप खोलने में असमर्थ';

  @override
  String get downloadSuccess => 'सफलतापूर्वक डाउनलोड!';

  @override
  String get noTranslate => 'कोई अनुवादित सामग्री उपलब्ध नहीं।';

  @override
  String get keyPoint => 'मुख्य बिंदु:';

  @override
  String get conclusion => 'निष्कर्ष';

  @override
  String get summary => 'सारांश';

  @override
  String get type => 'प्रकार';

  @override
  String get preview => 'पूर्वावलोकन';

  @override
  String get startTranslate => 'अनुवाद प्रारंभ करें';

  @override
  String get startSummary => 'सारांश प्रारंभ करें';

  @override
  String get translateTo => 'अनुवादित करें';

  @override
  String get summaryStyle => 'सारांश शैली';

  @override
  String get selectPage => 'पृष्ठ चुनें';

  @override
  String get startAISummary => 'एआई सारांश प्रारंभ करें';

  @override
  String get startAITranslate => 'एआई अनुवाद प्रारंभ करें';

  @override
  String get aIAssistant => 'एआई सहायक';

  @override
  String get aITranslate => 'एआई अनुवाद';

  @override
  String get aISummary => 'एआई सारांश';

  @override
  String get ai_translate_description =>
      '<b>AI के साथ तुरंत दस्तावेज़ों का अनुवाद करें।\n</b> सिर्फ़ एक टैप में पूरे PDF को दूसरी भाषा में बदलें—सटीक, स्वाभाविक और आसान।';

  @override
  String get ai_summary_description =>
      '<b>AI सारांश के साथ दस्तावेज़ जल्दी समझें।\n</b> शक्तिशाली AI का उपयोग करके लंबे PDF को संक्षिप्त और सुव्यवस्थित सारांश में बदलें—बिना अतिरिक्त पढ़े ज़रूरी बातें पाएं।';

  @override
  String get translate1 => 'सेकंडों में पूरे दस्तावेज़ का अनुवाद';

  @override
  String get translate2 => 'AI द्वारा संचालित स्पष्ट और मानव-जैसे परिणाम';

  @override
  String get translate3 => 'कई भाषाओं का समर्थन';

  @override
  String get translate4 => 'पढ़ाई, काम और यात्रा के लिए आदर्श';

  @override
  String get summary1 => 'तेज़, एक-टैप सारांश';

  @override
  String get summary2 => 'विभिन्न पढ़ने की शैलियों के लिए कई सारांश फ़ॉर्मेट';

  @override
  String get summary3 => 'सबसे महत्वपूर्ण विचारों की स्पष्ट झलक';

  @override
  String get summary4 =>
      'छात्रों, पेशेवरों और रोज़मर्रा की पढ़ाई के लिए बेहतरीन';

  @override
  String get convertedSuccess => 'सफलतापूर्वक रूपांतरित';

  @override
  String get convertPdfSuccess => 'सफलतापूर्वक PDF में बदला गया!';

  @override
  String get imageToPdf => 'छवि से PDF';

  @override
  String get youCanHold =>
      'छवियों को पुनःस्थिति देने के लिए दबाए रखें और खींचें';

  @override
  String get addImage => 'छवि जोड़ें';

  @override
  String get selectImage => 'छवि चुनें';

  @override
  String get selectLanguage =>
      '<b>भाषा चुनें <span style=\'color:#D90000\'></span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value परिणाम',
      one: '1 परिणाम',
      zero: 'कोई परिणाम नहीं',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'लोड हो रहा है ($value%)...';
  }

  @override
  String get searchOn => 'All File Viewer पर खोजें';

  @override
  String get detail => 'विवरण';

  @override
  String get fileSize => 'फ़ाइल आकार';

  @override
  String get name => 'नाम';

  @override
  String get sign => 'हस्ताक्षर';

  @override
  String get systemLanguage => 'सिस्टम भाषा';

  @override
  String get done => 'पूर्ण';

  @override
  String get guideExportImage =>
      'अपनी गैलरी खोलें ताकि आप अपनी छवियों को देख या साझा कर सकें।';

  @override
  String get textSetDefault =>
      'फ़ाइलें तुरंत खोलने के लिए PDF Reader - PDF Viewer सेट करें।';

  @override
  String get enterPassSelect => 'इस फ़ाइल को चुनने के लिए पासवर्ड दर्ज करें।';

  @override
  String get selectThePage =>
      'विभाजित करने के लिए पेज चुनें, फिर दबाकर रखें और खींचकर पुनः व्यवस्थित करें।';

  @override
  String get theFastestWay => 'अपनी फ़ाइलें खोलने का सबसे तेज़ तरीका';

  @override
  String get neverMiss => 'अपने दस्तावेज़ों के महत्वपूर्ण अपडेट कभी न चूकें।';

  @override
  String get guideMerge => 'मर्ज करने के लिए कम से कम 2 फ़ाइलें चुनें।';

  @override
  String get notification => 'सूचनाएँ';

  @override
  String get allowAccessTo =>
      'सभी फ़ाइलों को प्रबंधित करने के लिए एक्सेस अनुमति दें';

  @override
  String get useDeviceLanguage => 'डिवाइस की भाषा का उपयोग करें';

  @override
  String get previewConvert => 'पूर्वावलोकन रूपांतरण';

  @override
  String get download => 'डाउनलोड';

  @override
  String get pdfToLongImages => 'PDF को लंबी छवियों में';

  @override
  String get convertSelect => 'चयनित रूपांतरित करें';

  @override
  String get convertAll => 'सभी रूपांतरित करें';

  @override
  String get searchInFile => 'फ़ाइल में खोजें';

  @override
  String get language => 'भाषा';

  @override
  String get thisActionCanContainAds => 'इस क्रिया में विज्ञापन हो सकते हैं';

  @override
  String get next => 'अगला';

  @override
  String get thank => 'धन्यवाद!';

  @override
  String get start => 'शुरू करें';

  @override
  String get go => 'जाओ';

  @override
  String get permission => 'अनुमति';

  @override
  String get rate => 'रेटिंग';

  @override
  String get share => 'शेयर करें';

  @override
  String get policy => 'गोपनीयता नीति';

  @override
  String get rateUs => 'हमें रेटिंग दें';

  @override
  String get setting => 'सेटिंग';

  @override
  String get unexpectedError => 'एक अप्रत्याशित त्रुटि हुई!';

  @override
  String get alreadyOwnError =>
      'ऐसा लगता है कि आप पहले से ही इस आइटम के मालिक हैं।\nजारी रखने के लिए \"खरीद पुनर्स्थापित करें\" पर क्लिक करें।';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get backToHomescreen => 'होम स्क्रीन पर वापस जाएं';

  @override
  String get exitApp => 'ऐप से बाहर निकलें';

  @override
  String get areYouSureYouWantToExitApp =>
      'क्या आप वाकई ऐप से बाहर निकलना चाहते हैं?';

  @override
  String get pleaseSelectLanguage => 'जारी रखने के लिए कृपया एक भाषा चुनें';

  @override
  String get allDocumentsViewer => 'सभी दस्तावेज़ों का दृश्य';

  @override
  String get onboardingTitle1 => 'सभी दस्तावेज़ पढ़ें';

  @override
  String get onboardingTitle2 => 'किसी भी दस्तावेज़ को तुरंत समझें';

  @override
  String get onboardingTitle3 => 'PDF को प्रोफेशनल की तरह संपादित करें';

  @override
  String get onboardingContent1 => 'PDF, Word, Excel, PPT खोलें — तेज़ और सहज';

  @override
  String get onboardingContent2 =>
      'AI के साथ सेकंडों में फ़ाइलों का अनुवाद और सारांश बनाएँ';

  @override
  String get onboardingContent3 =>
      'PDF को आसानी से हाइलाइट, एनोटेट, साइन और मार्कअप करें';

  @override
  String get requirePermission =>
      'सभी दस्तावेज़ों के दृश्य के लिए अनुमति की आवश्यकता है!';

  @override
  String get goToSetting => 'सेटिंग पर जाएं';

  @override
  String get storage => 'भंडारण';

  @override
  String get camera => 'कैमरा';

  @override
  String get grantPermission => 'बाद में अनुमति दें';

  @override
  String get continuePer => 'जारी रखें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get ok => 'ठीक है';

  @override
  String get save => 'सहेजें';

  @override
  String get exit => 'ऐप से बाहर निकलें';

  @override
  String get doYouWantExitApp => 'क्या आप ऐप से बाहर निकलना चाहते हैं?';

  @override
  String get home => 'मुख्य पृष्ठ';

  @override
  String get document => 'फ़ाइलें';

  @override
  String get recent => 'हाल ही में';

  @override
  String get bookmark => 'बुकमार्क';

  @override
  String get searchOnAllDocumentsViewer => 'सभी दस्तावेज़ों के दृश्य में खोजें';

  @override
  String get mergePDF => 'PDF मिलाएं';

  @override
  String get splitPDF => 'PDF विभाजित करें';

  @override
  String get unlockPDF => 'PDF अनलॉक करें';

  @override
  String get lockPDF => 'PDF लॉक करें';

  @override
  String get scanPDF => 'PDF स्कैन करें';

  @override
  String get pDFToImage => 'PDF से चित्र';

  @override
  String get documentTool => 'दस्तावेज़ उपकरण';

  @override
  String get documentReader => 'दस्तावेज़ रीडर';

  @override
  String sumFiles(int count) {
    return '$count फ़ाइलें';
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
  String get image => 'छवि';

  @override
  String get doYouLikeTheApp => 'क्या आपको ऐप पसंद है?';

  @override
  String get rate5 => 'मुझे पसंद है';

  @override
  String get rate4 => 'शानदार!';

  @override
  String get rate3 => 'अच्छा!';

  @override
  String get rate2 => 'बुरा!';

  @override
  String get rate1 => 'ओह नहीं!';

  @override
  String get notNow => 'अभी नहीं';

  @override
  String get print => 'छापें';

  @override
  String get renameFile => 'फ़ाइल का नाम बदलें';

  @override
  String get pdfConverter => 'PDF कन्वर्टर';

  @override
  String get deleteFromDevice => 'डिवाइस से हटाएँ';

  @override
  String get fileName => 'फ़ाइल का नाम';

  @override
  String get storagePath => 'स्टोरेज पाथ';

  @override
  String get lastView => 'अंतिम दृश्य';

  @override
  String get lastModified => 'अंतिम संशोधन';

  @override
  String get size => 'आकार';

  @override
  String get rename => 'नाम बदलें';

  @override
  String get all => 'सभी';

  @override
  String get fileNameCannotBeEmpty => 'फ़ाइल का नाम खाली नहीं हो सकता';

  @override
  String get pleaseEnterFileName => 'कृपया फ़ाइल का नाम दर्ज करें';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'कल';

  @override
  String get last7Day => 'पिछले 7 दिन';

  @override
  String get monthAgo => '1 महीने पहले';

  @override
  String get delete => 'हटाएँ';

  @override
  String get deleteIt => 'क्या आप इसे हटाना चाहते हैं?';

  @override
  String fileSelected(Object count) {
    return '$count फ़ाइल का चयन किया गया';
  }

  @override
  String get exitAndDiscard =>
      'क्या आप बाहर निकलना और परिवर्तनों को छोड़ना चाहते हैं?';

  @override
  String get files => 'फ़ाइलें';

  @override
  String get discard => 'छोड़ना';

  @override
  String get redOption => 'लाल';

  @override
  String get greenOption => 'हरा';

  @override
  String get blueOption => 'नीला';

  @override
  String get displayP3HexColor => 'P3 हेक्स रंग दिखाएँ #';

  @override
  String get colorsOption => 'रंग';

  @override
  String get gridOption => 'ग्रिड';

  @override
  String get spectrumOption => 'स्पेक्ट्रम';

  @override
  String get slidersOption => 'स्लाइडर';

  @override
  String get opacityOption => 'अपारदर्शिता';

  @override
  String get fontSize => 'फॉन्ट का आकार:';

  @override
  String get aToz => 'A से Z तक';

  @override
  String get zToa => 'Z से A तक';

  @override
  String get newToOld => 'नए से पुराने';

  @override
  String get oldToNew => 'पुराने से नए';

  @override
  String get smallToLarge => 'छोटे से बड़े';

  @override
  String get largeToSmall => 'बड़े से छोटे';

  @override
  String get title => 'शीर्षक';

  @override
  String get time => 'समय';

  @override
  String get open => 'खोलें';

  @override
  String get empty => 'खाली';

  @override
  String get goHome => 'घर जाओ';

  @override
  String get merge => 'मिलाना';

  @override
  String get success => 'सफलता';

  @override
  String get split => 'विभाजित करें';

  @override
  String get remove => 'हटाएँ';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get sortBy => 'द्वारा छाँटें';

  @override
  String get removePwTo => 'पासवर्ड हटाएं, फ़ाइल अब सुरक्षित नहीं होगी।';

  @override
  String get setPwTo =>
      'अपने PDF फ़ाइल को सुरक्षित करने के लिए पासवर्ड सेट करें।';

  @override
  String get setPassword => 'पासवर्ड सेट करें';

  @override
  String get removePassword => 'पासवर्ड हटाएँ';

  @override
  String get longImages => 'लंबी छवियाँ';

  @override
  String get separateImages => 'अलग छवियाँ';

  @override
  String get unknownError => 'अज्ञात त्रुटि';

  @override
  String get pdfToImages => 'PDF से छवियाँ';

  @override
  String get exportImageSuccess => 'छवि निर्यात सफल!';

  @override
  String get lockPdfSuccess => 'PDF लॉक करना सफल!';

  @override
  String get scanPdfSuccess => 'PDF स्कैन करना सफल!';

  @override
  String get mergePdfSuccess => 'PDF मिलाना सफल!';

  @override
  String get editPdfSuccess => 'PDF संपादन सफल!';

  @override
  String get allDoc => 'सभी दस्तावेज़ों का दृश्य';

  @override
  String get splitSuccess => 'PDF विभाजित करना सफल!';

  @override
  String get enterPassword => 'पासवर्ड दर्ज करें';

  @override
  String get enterThePassword => 'फ़ाइल खोलने के लिए पासवर्ड दर्ज करें';

  @override
  String get password => 'पासवर्ड';

  @override
  String get wrongPassword => 'गलत पासवर्ड, कृपया पुनः प्रयास करें';

  @override
  String passwordProtected(Object path) {
    return '$path पासवर्ड से सुरक्षित है';
  }

  @override
  String get unlockPdfSuccess => 'PDF अनलॉक करना सफल!';

  @override
  String get search => 'खोजें';

  @override
  String get errorCharacter =>
      'इनपुट में विशेष वर्ण हैं या यह खाली है। कृपया बिना विशेष वर्णों के मान्य पाठ दर्ज करें।';

  @override
  String get cameraReqPermission =>
      'पीडीएफ स्कैन करने के लिए कैमरा एक्सेस की आवश्यकता है';

  @override
  String get storageReqPermission =>
      'सभी फ़ाइलों को देखने के लिए स्टोरेज एक्सेस की आवश्यकता है';

  @override
  String get reqPermission => 'अनुमतियाँ मांगें';

  @override
  String get underline => 'रेखांकित करें';

  @override
  String get brush => 'ब्रश';

  @override
  String get highlight => 'हाइलाइट करें';

  @override
  String get strikethrough => 'ट्राइकथ्रू';

  @override
  String get anError => 'एक त्रुटि हुई: ';

  @override
  String get errorUpdatePw => 'PDF पासवर्ड अपडेट करते समय त्रुटि: ';

  @override
  String get noDocumentFound => 'कोई दस्तावेज़ नहीं मिला';

  @override
  String get sampleFile => 'नमूना फ़ाइल';

  @override
  String get thisSampleFile => 'यह एक फ़ाइल का नमूना है';

  @override
  String get developing => 'विकासशील';

  @override
  String get doNotSupport => 'यह फ़ाइल समर्थित नहीं है';

  @override
  String get uninstall => 'अनइंस्टॉल करें';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'उपयोग के दौरान आपको किन समस्याओं का सामना करना पड़ता है?';

  @override
  String get dontUninstallYet => 'अभी अनइंस्टॉल न करें';

  @override
  String get stillWantToUninstall => 'क्या आप अभी भी अनइंस्टॉल करना चाहते हैं?';

  @override
  String get difficultToUse => 'उपयोग में कठिन';

  @override
  String get tooManyAds => 'बहुत अधिक विज्ञापन';

  @override
  String get others => 'अन्य';

  @override
  String get viewFiles => 'फाइलें देखें';

  @override
  String get unableToReceiveFiles => 'फ़ाइलें प्राप्त करने में असमर्थ';

  @override
  String get unableToViewTheFile => 'फ़ाइल देखने में असमर्थ';

  @override
  String get explore => 'अन्वेषण करें';

  @override
  String whyUninstallApp(String appName) {
    return 'आप $appName को क्यों अनइंस्टॉल कर रहे हैं?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'कृपया $appName अनइंस्टॉल करने का कारण दर्ज करें।';
  }

  @override
  String get tryAgain => 'फिर से प्रयास करें';

  @override
  String get setAsDefault => 'डिफ़ॉल्ट रूप से सेट करें';

  @override
  String get justOnce => 'सिर्फ एक बार';

  @override
  String get always => 'हमेशा';

  @override
  String get tip => 'सुझाव';

  @override
  String get subTip =>
      'यदि आपको ऐप आइकन नहीं दिख रहा है, तो \'अधिक\' या तीन बिंदुओं पर टैप करके खोजें';

  @override
  String get documentViewer => 'दस्तावेज़ दर्शक';

  @override
  String get allowAccess =>
      'सभी फ़ाइलों को प्रबंधित करने के लिए एक्सेस की अनुमति दें';

  @override
  String pleaseAllowAll(Object appName) {
    return 'कृपया $appName को आपकी सभी फ़ाइलों तक पहुँचने की अनुमति दें';
  }

  @override
  String get allowPermission => 'अनुमति दें';

  @override
  String get welcomeTo => 'में आपका स्वागत है';

  @override
  String get yourDataRemain => 'आपका डेटा निजी रहता है';

  @override
  String get weNeedPermission =>
      'सभी फ़ाइलों तक पहुँचने की अनुमति चाहिए ताकि हम उन्हें \n कुशलतापूर्वक प्रबंधित, देख और व्यवस्थित कर सकें';

  @override
  String get failedToLoadPage => 'पृष्ठ लोड करने में विफल';

  @override
  String get savedSuccessfully => 'सफलतापूर्वक सहेजा गया';

  @override
  String get editPdf => 'PDF संपादित करें';

  @override
  String get textStyle => 'पाठ शैली';

  @override
  String get more => 'अधिक';

  @override
  String get searchYourFile => 'अपनी फ़ाइलें खोजें';

  @override
  String get select => 'चयन करें';

  @override
  String imageExported(Object images) {
    return '$images छवि निर्यात की गई';
  }

  @override
  String imagesExported(Object images) {
    return '$images छवियाँ निर्यात की गईं';
  }

  @override
  String get openGallery => '\"गैलरी\" खोलें और फ़ाइल खोजें';

  @override
  String get tools => 'उपकरण';

  @override
  String get goStatusBar => 'छवि खोजने के लिए स्टेटस बार पर जाएं';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'कृपया सभी दस्तावेज़ दर्शक को\nआपकी सभी फ़ाइलों तक पहुँचने की अनुमति दें';

  @override
  String get notificationsTurnedOff =>
      'सूचनाएँ बंद कर दी गई हैं! आप महत्वपूर्ण दस्तावेज़ खो सकते हैं';

  @override
  String get tapToOpenSettings =>
      'सेटिंग्स खोलने और सूचनाएँ सक्षम करने के लिए यहाँ टैप करें';

  @override
  String get later => 'बाद में';

  @override
  String get showNotification => 'सूचनाएँ दिखाएँ';

  @override
  String get enableNotification => 'सूचनाएँ सक्षम करें';

  @override
  String get appName => 'PDF रीडर - PDF व्यूअर';

  @override
  String get toViewYourFiles => 'अपनी फ़ाइलें देखने के लिए, कृपया प्रदान करें';

  @override
  String get withAccessToThem => 'उन तक पहुंच के साथ';

  @override
  String get languageOptions => 'भाषा विकल्प';

  @override
  String get toContinuePleaseGrant => 'जारी रखने के लिए, कृपया अनुमति दें';

  @override
  String get acceptToYourFile => 'आपकी फ़ाइलों तक पहुँच।';

  @override
  String get apply => 'लागू करें';

  @override
  String get other => 'अन्य';

  @override
  String get startNow => 'अभी शुरू करें';

  @override
  String get page => 'पृष्ठ';

  @override
  String get goToPage => 'पृष्ठ पर जाएं';

  @override
  String get pageNumber => 'पृष्ठ संख्या';

  @override
  String enterPageNumber(int start, int end) {
    return 'पृष्ठ संख्या दर्ज करें ($start - $end)';
  }

  @override
  String get invalid => 'अमान्य';
}
