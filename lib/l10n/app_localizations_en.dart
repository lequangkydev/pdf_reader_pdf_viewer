// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get saveToAlbum => 'Save to Album';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Saved $count images',
      one: 'Saved 1 image',
      zero: 'Saved 0 images',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Sharing this file via $appName – super easy to view & edit. You can try it here: $value';
  }

  @override
  String get searchInPdf =>
      'Search in <b><span style=\'color:#E01621\'>PDF Reader</span></b>';

  @override
  String get searchInDoc =>
      'Search in <b><span style=\'color:#2979FF\'>DOC Reader</span></b>';

  @override
  String get searchInExcel =>
      'Search in <b><span style=\'color:#388E3C\'>XLS Reader</span></b>';

  @override
  String get searchInPpt =>
      'Search in <b><span style=\'color:#F2590C\'>PPT Reader</span></b>';

  @override
  String get unSelect => 'Unselect';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value files',
      one: '1 file',
      zero: 'No file',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Summary in Progress';

  @override
  String get translationProgress => 'Translation in Progress';

  @override
  String get tryAnotherFile =>
      'Unable to merge this file. Try selecting a different file to continue.';

  @override
  String get result => 'Result';

  @override
  String get scroll => 'Scroll';

  @override
  String get giveFeedback => 'Give me a feedback';

  @override
  String get add => 'Add';

  @override
  String get selectText => 'Select text';

  @override
  String get pleaseDoNot => 'Please do not include accented characters';

  @override
  String get pleaseEnter => 'Please enter some text';

  @override
  String get watermark => 'Watermark';

  @override
  String get enterText => 'Enter text';

  @override
  String get color => 'Color';

  @override
  String get addText => 'Add text';

  @override
  String get addWatermark => 'Add watermark';

  @override
  String get watermarkContent => 'Watermark content';

  @override
  String get editSuccess => 'Edited Successfully!';

  @override
  String get signature => 'Signature';

  @override
  String get noSignature => 'No signature';

  @override
  String get createSignature => 'Create a new signature';

  @override
  String get feedbackTitle => 'Feedback about AI Assistant';

  @override
  String get feedbackTo => 'To: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'Subject: Feedback about “PDF Reader & Photo to PDF”.';

  @override
  String get feedbackHint => 'Write your feedback here...';

  @override
  String get feedbackButton => 'Send Feedback';

  @override
  String get feedbackEmptyMessage => 'Please write your feedback first';

  @override
  String get feedbackSuccessMessage => 'Feedback sent (or email app opened)';

  @override
  String get feedbackErrorMessage => 'Could not open email app';

  @override
  String get downloadSuccess => 'Download Successfully!';

  @override
  String get noTranslate => 'No translated content available.';

  @override
  String get keyPoint => 'Key Points:';

  @override
  String get conclusion => 'Conclusion';

  @override
  String get summary => 'Summary';

  @override
  String get type => 'Type';

  @override
  String get preview => 'Preview';

  @override
  String get startTranslate => 'Start Translate';

  @override
  String get startSummary => 'Start Summary';

  @override
  String get translateTo => 'Translate To';

  @override
  String get summaryStyle => 'Summary Style';

  @override
  String get selectPage => 'Select page';

  @override
  String get startAISummary => 'Start AI Summary';

  @override
  String get startAITranslate => 'Start AI Translate';

  @override
  String get aIAssistant => 'AI Assistant';

  @override
  String get aITranslate => 'AI Translate';

  @override
  String get aISummary => 'AI Summary';

  @override
  String get ai_translate_description =>
      '<b>Translate documents instantly with AI.\n</b> One tap is all it takes to convert your entire PDF into another language—accurate, natural, and effortless.';

  @override
  String get ai_summary_description =>
      '<b>Understand documents faster with AI Summary.\n</b> Transform lengthy PDFs into concise, well-structured summaries using powerful AI—so you get the essentials without the extra reading.';

  @override
  String get translate1 => 'Full-document translation in seconds';

  @override
  String get translate2 => 'Clear, human-like results powered by AI';

  @override
  String get translate3 => 'Multiple languages supported';

  @override
  String get translate4 => 'Ideal for study, work, and travel';

  @override
  String get summary1 => 'Quick, one-tap summaries';

  @override
  String get summary2 =>
      'Multiple summary formats for different reading styles';

  @override
  String get summary3 => 'Clear highlights of the most important ideas';

  @override
  String get summary4 =>
      'Great for academics, professionals, and everyday reading';

  @override
  String get convertedSuccess => 'Converted Successfully';

  @override
  String get convertPdfSuccess => 'Convert to PDF Successfully!';

  @override
  String get imageToPdf => 'Image to PDF';

  @override
  String get youCanHold => 'You can hold and drag to reposition\nthe images';

  @override
  String get addImage => 'Add image';

  @override
  String get selectImage => 'Select image';

  @override
  String get selectLanguage =>
      '<b>Select <span style=\'color:#D90000\'>Language</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value results',
      one: '1 result',
      zero: 'No result',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'Loading ($value%)...';
  }

  @override
  String get searchOn => 'Search on All File Viewer';

  @override
  String get detail => 'Details';

  @override
  String get fileSize => 'File size';

  @override
  String get name => 'Name';

  @override
  String get sign => 'Sign';

  @override
  String get systemLanguage => 'System language';

  @override
  String get done => 'Done';

  @override
  String get guideExportImage =>
      'Open your gallery to view or share your images.';

  @override
  String get textSetDefault =>
      'Set PDF Reader - PDF Viewer as your default to open files instantly.';

  @override
  String get enterPassSelect => 'Enter the password to select this file';

  @override
  String get selectThePage =>
      'Select the page you want to split, then tap and hold to drag and rearrange it among the other pages';

  @override
  String get theFastestWay => 'The fastest way to open your files';

  @override
  String get neverMiss => 'Never miss important updates to your documents.';

  @override
  String get guideMerge => 'Select at least 2 files to merge';

  @override
  String get notification => 'Notifications';

  @override
  String get allowAccessTo => 'Allow Access to \nmanage all files';

  @override
  String get useDeviceLanguage => 'Use device language';

  @override
  String get previewConvert => 'Preview Convert';

  @override
  String get download => 'Download';

  @override
  String get pdfToLongImages => 'PDF to Long Images';

  @override
  String get convertSelect => 'Convert selected';

  @override
  String get convertAll => 'Convert All';

  @override
  String get searchInFile => 'Search in file';

  @override
  String get language => 'Language';

  @override
  String get thisActionCanContainAds => 'This action can contain ads';

  @override
  String get next => 'Next';

  @override
  String get thank => 'Thank you!';

  @override
  String get start => 'Start';

  @override
  String get go => 'Go';

  @override
  String get permission => 'Permission';

  @override
  String get rate => 'Rate';

  @override
  String get share => 'Share';

  @override
  String get policy => 'Privacy Policy';

  @override
  String get rateUs => 'Rate Us';

  @override
  String get setting => 'Settings';

  @override
  String get unexpectedError => 'An unexpected error occurred!';

  @override
  String get alreadyOwnError =>
      'Looks like you already owned this item.\nPlease click \"Restore purchase\" to continue.';

  @override
  String get confirm => 'Confirm';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get backToHomescreen => 'Back to Homescreen';

  @override
  String get exitApp => 'Exit app';

  @override
  String get areYouSureYouWantToExitApp =>
      'Are you sure you want to exit the app?';

  @override
  String get pleaseSelectLanguage => 'Please select language to continue';

  @override
  String get allDocumentsViewer => 'PDF Reader - PDF Viewer';

  @override
  String get onboardingTitle1 => 'Read All Documents';

  @override
  String get onboardingTitle2 => 'Understand Any Document Instantly';

  @override
  String get onboardingTitle3 => 'Edit PDFs Like a Pro';

  @override
  String get onboardingContent1 =>
      'Open PDF, Word, Excel, PPT - fast and seamless';

  @override
  String get onboardingContent2 =>
      'Translate and summarize files with AI in seconds';

  @override
  String get onboardingContent3 =>
      'Highlight, annotate, sign, and mark up PDFs easily';

  @override
  String get requirePermission =>
      'PDF Reader - PDF Viewer requires permission!';

  @override
  String get goToSetting => 'Go to setting';

  @override
  String get storage => 'Storage';

  @override
  String get camera => 'Camera';

  @override
  String get grantPermission => 'Grant permission later';

  @override
  String get continuePer => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'Ok';

  @override
  String get save => 'Save';

  @override
  String get exit => 'Exit App';

  @override
  String get doYouWantExitApp => 'Do you want to exit app?';

  @override
  String get home => 'Home';

  @override
  String get document => 'Document';

  @override
  String get recent => 'Recent';

  @override
  String get bookmark => 'Bookmark';

  @override
  String get searchOnAllDocumentsViewer => 'Search on PDF Reader - PDF Viewer';

  @override
  String get mergePDF => 'Merge PDF';

  @override
  String get splitPDF => 'Split PDF';

  @override
  String get unlockPDF => 'Unlock PDF';

  @override
  String get lockPDF => 'Lock PDF';

  @override
  String get scanPDF => 'Scan PDF';

  @override
  String get pDFToImage => 'PDF to Image';

  @override
  String get documentTool => 'Document tool';

  @override
  String get documentReader => 'Document reader';

  @override
  String sumFiles(int count) {
    return '$count files';
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
  String get image => 'IMAGE';

  @override
  String get doYouLikeTheApp => 'Do you like the app?';

  @override
  String get rate5 => 'Love it';

  @override
  String get rate4 => 'Great!';

  @override
  String get rate3 => 'Sad!';

  @override
  String get rate2 => 'Poor!';

  @override
  String get rate1 => 'Oh no!';

  @override
  String get notNow => 'Not now';

  @override
  String get print => 'Print';

  @override
  String get renameFile => 'Rename file';

  @override
  String get pdfConverter => 'PDF Converter';

  @override
  String get deleteFromDevice => 'Delete from Device';

  @override
  String get fileName => 'File name';

  @override
  String get storagePath => 'Storage path';

  @override
  String get lastView => 'Last view';

  @override
  String get lastModified => 'Last modified';

  @override
  String get size => 'Size';

  @override
  String get rename => 'Rename';

  @override
  String get all => 'All';

  @override
  String get fileNameCannotBeEmpty => 'File name cannot be empty';

  @override
  String get pleaseEnterFileName => 'Please enter file name';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get last7Day => 'Last 7 days';

  @override
  String get monthAgo => '1 month ago';

  @override
  String get delete => 'Delete';

  @override
  String get deleteIt => 'Are you sure to delete it?';

  @override
  String fileSelected(Object count) {
    return '$count File selected';
  }

  @override
  String get exitAndDiscard => 'Exit and discard the changes?';

  @override
  String get files => 'files';

  @override
  String get discard => 'Discard';

  @override
  String get redOption => 'RED';

  @override
  String get greenOption => 'GREEN';

  @override
  String get blueOption => 'BLUE';

  @override
  String get displayP3HexColor => 'Display P3 Hex Color #';

  @override
  String get colorsOption => 'Colors';

  @override
  String get gridOption => 'Grid';

  @override
  String get spectrumOption => 'Spectrum';

  @override
  String get slidersOption => 'Sliders';

  @override
  String get opacityOption => 'Opacity';

  @override
  String get fontSize => ' Font size:';

  @override
  String get aToz => 'A-Z';

  @override
  String get zToa => 'Z-A';

  @override
  String get newToOld => 'new to old';

  @override
  String get oldToNew => 'old to new';

  @override
  String get smallToLarge => 'small to large';

  @override
  String get largeToSmall => 'large to small';

  @override
  String get title => 'Title';

  @override
  String get time => 'Time';

  @override
  String get open => 'Open';

  @override
  String get empty => 'Empty';

  @override
  String get goHome => 'Go Home';

  @override
  String get merge => 'Merge';

  @override
  String get success => 'Success';

  @override
  String get split => 'Split';

  @override
  String get remove => 'Remove';

  @override
  String get loading => 'Loading...';

  @override
  String get sortBy => 'Sort by';

  @override
  String get removePwTo =>
      'Remove the password, the file will no longer be protected.';

  @override
  String get setPwTo => 'Set a password to protect your PDF file.';

  @override
  String get setPassword => 'Set Password';

  @override
  String get removePassword => 'Remove Password';

  @override
  String get longImages => 'Long Images';

  @override
  String get separateImages => 'Separate Images';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get pdfToImages => 'PDF to Images';

  @override
  String get exportImageSuccess => 'Export Image Successfully!';

  @override
  String get lockPdfSuccess => 'Lock PDF Successfully!';

  @override
  String get scanPdfSuccess => 'Scan PDF Successfully!';

  @override
  String get mergePdfSuccess => 'Merge PDF Successfully!';

  @override
  String get editPdfSuccess => 'Edit PDF Successfully!';

  @override
  String get allDoc => 'All Document Viewer';

  @override
  String get splitSuccess => 'Split PDF Successfully!';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get enterThePassword => 'Enter the password to open the file';

  @override
  String get password => 'Password';

  @override
  String get wrongPassword => 'Wrong password, please try again';

  @override
  String passwordProtected(Object path) {
    return '$path is password protected';
  }

  @override
  String get unlockPdfSuccess => 'Unlock PDF Successfully!';

  @override
  String get search => 'Search';

  @override
  String get errorCharacter =>
      'The input contains special characters or is empty. Please enter valid text without special characters.';

  @override
  String get cameraReqPermission => 'Camera access required to scan pdf';

  @override
  String get storageReqPermission =>
      'Storage access is required to view all files';

  @override
  String get reqPermission => 'Request permissions';

  @override
  String get underline => 'Underline';

  @override
  String get brush => 'Brush';

  @override
  String get highlight => 'Highlight';

  @override
  String get strikethrough => 'Strike';

  @override
  String get anError => 'An error occurred: ';

  @override
  String get errorUpdatePw => 'Error updating PDF password: ';

  @override
  String get noDocumentFound => 'No documents found';

  @override
  String get sampleFile => 'Sample File';

  @override
  String get thisSampleFile => 'This is a file sample';

  @override
  String get developing => 'Developing';

  @override
  String get doNotSupport => 'Do not support this file';

  @override
  String get uninstall => 'Uninstall';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'What problems do you encounter during use?';

  @override
  String get dontUninstallYet => 'Don’t uninstall yet';

  @override
  String get stillWantToUninstall => 'Still want to uninstall?';

  @override
  String get difficultToUse => 'Difficult to use';

  @override
  String get tooManyAds => 'Too many ads';

  @override
  String get others => 'Others';

  @override
  String get viewFiles => 'View Files';

  @override
  String get unableToReceiveFiles => 'Unable to retrieve the files';

  @override
  String get unableToViewTheFile => 'Unable to view the file';

  @override
  String get explore => 'Explore';

  @override
  String whyUninstallApp(String appName) {
    return 'Why uninstall $appName?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Please enter the reason why you are uninstalling $appName.';
  }

  @override
  String get tryAgain => 'Try again';

  @override
  String get setAsDefault => 'Set as default';

  @override
  String get justOnce => 'Just once';

  @override
  String get always => 'Always';

  @override
  String get tip => 'Tip';

  @override
  String get subTip =>
      'If you can\'t find the app icon, tap \'More\' or the three dots to search for it';

  @override
  String get documentViewer => 'Documents Viewer';

  @override
  String get allowAccess => 'Allow Access to manage all files';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Please allow $appName to access all your files';
  }

  @override
  String get allowPermission => 'Allow Permission';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get yourDataRemain => 'Your data remains private';

  @override
  String get weNeedPermission =>
      'We need permission to access all files to \n manage. view, and organize them efficiently';

  @override
  String get failedToLoadPage => 'Failed to load page';

  @override
  String get savedSuccessfully => 'Saved successfully';

  @override
  String get editPdf => 'Edit PDF';

  @override
  String get textStyle => 'Text Style';

  @override
  String get more => 'More';

  @override
  String get searchYourFile => 'Search your files';

  @override
  String get select => 'Select';

  @override
  String imageExported(Object images) {
    return '$images image exported';
  }

  @override
  String imagesExported(Object images) {
    return '$images images exported';
  }

  @override
  String get openGallery => '\'Open \"Gallery\" to find a file\'';

  @override
  String get tools => 'Tools';

  @override
  String get goStatusBar => 'Go to the Status Bar to find the images.';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Please allow All Documents\nViewer to access all your files';

  @override
  String get notificationsTurnedOff =>
      'Notifications are turned off! You may miss important documents';

  @override
  String get tapToOpenSettings =>
      'Tap here to open settings and enable notifications';

  @override
  String get later => 'Later';

  @override
  String get showNotification => 'Show Notifications';

  @override
  String get enableNotification => 'Enable Notification';

  @override
  String get appName => 'PDF Reader - PDF Viewer';

  @override
  String get toViewYourFiles => 'To view your files, please provide';

  @override
  String get withAccessToThem => 'with access to them';

  @override
  String get languageOptions => 'Language Options';

  @override
  String get toContinuePleaseGrant => 'To continue, please grant';

  @override
  String get acceptToYourFile => 'access to your files.';

  @override
  String get apply => 'Apply';

  @override
  String get other => 'Other';

  @override
  String get startNow => 'Start Now';

  @override
  String get page => 'Page';

  @override
  String get goToPage => 'Go to page';

  @override
  String get pageNumber => 'Page number';

  @override
  String enterPageNumber(int start, int end) {
    return 'Enter page number ($start - $end)';
  }

  @override
  String get invalid => 'Invalid';
}
