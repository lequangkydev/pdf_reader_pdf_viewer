import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans')
  ];

  /// No description provided for @saveToAlbum.
  ///
  /// In en, this message translates to:
  /// **'Save to Album'**
  String get saveToAlbum;

  /// No description provided for @imagesSaved.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Saved 0 images} =1{Saved 1 image} other{Saved {count} images}}'**
  String imagesSaved(num count);

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'Sharing this file via {appName} – super easy to view & edit. You can try it here: {value}'**
  String shareMessage(Object appName, Object value);

  /// No description provided for @searchInPdf.
  ///
  /// In en, this message translates to:
  /// **'Search in <b><span style=\'color:#E01621\'>PDF Reader</span></b>'**
  String get searchInPdf;

  /// No description provided for @searchInDoc.
  ///
  /// In en, this message translates to:
  /// **'Search in <b><span style=\'color:#2979FF\'>DOC Reader</span></b>'**
  String get searchInDoc;

  /// No description provided for @searchInExcel.
  ///
  /// In en, this message translates to:
  /// **'Search in <b><span style=\'color:#388E3C\'>XLS Reader</span></b>'**
  String get searchInExcel;

  /// No description provided for @searchInPpt.
  ///
  /// In en, this message translates to:
  /// **'Search in <b><span style=\'color:#F2590C\'>PPT Reader</span></b>'**
  String get searchInPpt;

  /// No description provided for @unSelect.
  ///
  /// In en, this message translates to:
  /// **'Unselect'**
  String get unSelect;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'{value, plural, =0{No file} =1{1 file} other{{value} files}}'**
  String file(num value);

  /// No description provided for @summaryProgress.
  ///
  /// In en, this message translates to:
  /// **'Summary in Progress'**
  String get summaryProgress;

  /// No description provided for @translationProgress.
  ///
  /// In en, this message translates to:
  /// **'Translation in Progress'**
  String get translationProgress;

  /// No description provided for @tryAnotherFile.
  ///
  /// In en, this message translates to:
  /// **'Unable to merge this file. Try selecting a different file to continue.'**
  String get tryAnotherFile;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @scroll.
  ///
  /// In en, this message translates to:
  /// **'Scroll'**
  String get scroll;

  /// No description provided for @giveFeedback.
  ///
  /// In en, this message translates to:
  /// **'Give me a feedback'**
  String get giveFeedback;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @selectText.
  ///
  /// In en, this message translates to:
  /// **'Select text'**
  String get selectText;

  /// No description provided for @pleaseDoNot.
  ///
  /// In en, this message translates to:
  /// **'Please do not include accented characters'**
  String get pleaseDoNot;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter some text'**
  String get pleaseEnter;

  /// No description provided for @watermark.
  ///
  /// In en, this message translates to:
  /// **'Watermark'**
  String get watermark;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Enter text'**
  String get enterText;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @addText.
  ///
  /// In en, this message translates to:
  /// **'Add text'**
  String get addText;

  /// No description provided for @addWatermark.
  ///
  /// In en, this message translates to:
  /// **'Add watermark'**
  String get addWatermark;

  /// No description provided for @watermarkContent.
  ///
  /// In en, this message translates to:
  /// **'Watermark content'**
  String get watermarkContent;

  /// No description provided for @editSuccess.
  ///
  /// In en, this message translates to:
  /// **'Edited Successfully!'**
  String get editSuccess;

  /// No description provided for @signature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get signature;

  /// No description provided for @noSignature.
  ///
  /// In en, this message translates to:
  /// **'No signature'**
  String get noSignature;

  /// No description provided for @createSignature.
  ///
  /// In en, this message translates to:
  /// **'Create a new signature'**
  String get createSignature;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback about AI Assistant'**
  String get feedbackTitle;

  /// No description provided for @feedbackTo.
  ///
  /// In en, this message translates to:
  /// **'To: kyle@vtn-global.com'**
  String get feedbackTo;

  /// No description provided for @feedbackSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject: Feedback about “PDF Reader & Photo to PDF”.'**
  String get feedbackSubject;

  /// No description provided for @feedbackHint.
  ///
  /// In en, this message translates to:
  /// **'Write your feedback here...'**
  String get feedbackHint;

  /// No description provided for @feedbackButton.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get feedbackButton;

  /// No description provided for @feedbackEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Please write your feedback first'**
  String get feedbackEmptyMessage;

  /// No description provided for @feedbackSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Feedback sent (or email app opened)'**
  String get feedbackSuccessMessage;

  /// No description provided for @feedbackErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not open email app'**
  String get feedbackErrorMessage;

  /// No description provided for @downloadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Download Successfully!'**
  String get downloadSuccess;

  /// No description provided for @noTranslate.
  ///
  /// In en, this message translates to:
  /// **'No translated content available.'**
  String get noTranslate;

  /// No description provided for @keyPoint.
  ///
  /// In en, this message translates to:
  /// **'Key Points:'**
  String get keyPoint;

  /// No description provided for @conclusion.
  ///
  /// In en, this message translates to:
  /// **'Conclusion'**
  String get conclusion;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @startTranslate.
  ///
  /// In en, this message translates to:
  /// **'Start Translate'**
  String get startTranslate;

  /// No description provided for @startSummary.
  ///
  /// In en, this message translates to:
  /// **'Start Summary'**
  String get startSummary;

  /// No description provided for @translateTo.
  ///
  /// In en, this message translates to:
  /// **'Translate To'**
  String get translateTo;

  /// No description provided for @summaryStyle.
  ///
  /// In en, this message translates to:
  /// **'Summary Style'**
  String get summaryStyle;

  /// No description provided for @selectPage.
  ///
  /// In en, this message translates to:
  /// **'Select page'**
  String get selectPage;

  /// No description provided for @startAISummary.
  ///
  /// In en, this message translates to:
  /// **'Start AI Summary'**
  String get startAISummary;

  /// No description provided for @startAITranslate.
  ///
  /// In en, this message translates to:
  /// **'Start AI Translate'**
  String get startAITranslate;

  /// No description provided for @aIAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aIAssistant;

  /// No description provided for @aITranslate.
  ///
  /// In en, this message translates to:
  /// **'AI Translate'**
  String get aITranslate;

  /// No description provided for @aISummary.
  ///
  /// In en, this message translates to:
  /// **'AI Summary'**
  String get aISummary;

  /// No description provided for @ai_translate_description.
  ///
  /// In en, this message translates to:
  /// **'<b>Translate documents instantly with AI.\n</b> One tap is all it takes to convert your entire PDF into another language—accurate, natural, and effortless.'**
  String get ai_translate_description;

  /// No description provided for @ai_summary_description.
  ///
  /// In en, this message translates to:
  /// **'<b>Understand documents faster with AI Summary.\n</b> Transform lengthy PDFs into concise, well-structured summaries using powerful AI—so you get the essentials without the extra reading.'**
  String get ai_summary_description;

  /// No description provided for @translate1.
  ///
  /// In en, this message translates to:
  /// **'Full-document translation in seconds'**
  String get translate1;

  /// No description provided for @translate2.
  ///
  /// In en, this message translates to:
  /// **'Clear, human-like results powered by AI'**
  String get translate2;

  /// No description provided for @translate3.
  ///
  /// In en, this message translates to:
  /// **'Multiple languages supported'**
  String get translate3;

  /// No description provided for @translate4.
  ///
  /// In en, this message translates to:
  /// **'Ideal for study, work, and travel'**
  String get translate4;

  /// No description provided for @summary1.
  ///
  /// In en, this message translates to:
  /// **'Quick, one-tap summaries'**
  String get summary1;

  /// No description provided for @summary2.
  ///
  /// In en, this message translates to:
  /// **'Multiple summary formats for different reading styles'**
  String get summary2;

  /// No description provided for @summary3.
  ///
  /// In en, this message translates to:
  /// **'Clear highlights of the most important ideas'**
  String get summary3;

  /// No description provided for @summary4.
  ///
  /// In en, this message translates to:
  /// **'Great for academics, professionals, and everyday reading'**
  String get summary4;

  /// No description provided for @convertedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Converted Successfully'**
  String get convertedSuccess;

  /// No description provided for @convertPdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'Convert to PDF Successfully!'**
  String get convertPdfSuccess;

  /// No description provided for @imageToPdf.
  ///
  /// In en, this message translates to:
  /// **'Image to PDF'**
  String get imageToPdf;

  /// No description provided for @youCanHold.
  ///
  /// In en, this message translates to:
  /// **'You can hold and drag to reposition\nthe images'**
  String get youCanHold;

  /// No description provided for @addImage.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get addImage;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select image'**
  String get selectImage;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'<b>Select <span style=\'color:#D90000\'>Language</span></b>'**
  String get selectLanguage;

  /// No description provided for @valueResults.
  ///
  /// In en, this message translates to:
  /// **'{value, plural, =0{No result} =1{1 result} other{{value} results}}'**
  String valueResults(num value);

  /// No description provided for @loadingSplash.
  ///
  /// In en, this message translates to:
  /// **'Loading ({value}%)...'**
  String loadingSplash(Object value);

  /// No description provided for @searchOn.
  ///
  /// In en, this message translates to:
  /// **'Search on All File Viewer'**
  String get searchOn;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detail;

  /// No description provided for @fileSize.
  ///
  /// In en, this message translates to:
  /// **'File size'**
  String get fileSize;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @sign.
  ///
  /// In en, this message translates to:
  /// **'Sign'**
  String get sign;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get systemLanguage;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @guideExportImage.
  ///
  /// In en, this message translates to:
  /// **'Open your gallery to view or share your images.'**
  String get guideExportImage;

  /// No description provided for @textSetDefault.
  ///
  /// In en, this message translates to:
  /// **'Set PDF Reader - PDF Viewer as your default to open files instantly.'**
  String get textSetDefault;

  /// No description provided for @enterPassSelect.
  ///
  /// In en, this message translates to:
  /// **'Enter the password to select this file'**
  String get enterPassSelect;

  /// No description provided for @selectThePage.
  ///
  /// In en, this message translates to:
  /// **'Select the page you want to split, then tap and hold to drag and rearrange it among the other pages'**
  String get selectThePage;

  /// No description provided for @theFastestWay.
  ///
  /// In en, this message translates to:
  /// **'The fastest way to open your files'**
  String get theFastestWay;

  /// No description provided for @neverMiss.
  ///
  /// In en, this message translates to:
  /// **'Never miss important updates to your documents.'**
  String get neverMiss;

  /// No description provided for @guideMerge.
  ///
  /// In en, this message translates to:
  /// **'Select at least 2 files to merge'**
  String get guideMerge;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// No description provided for @allowAccessTo.
  ///
  /// In en, this message translates to:
  /// **'Allow Access to \nmanage all files'**
  String get allowAccessTo;

  /// No description provided for @useDeviceLanguage.
  ///
  /// In en, this message translates to:
  /// **'Use device language'**
  String get useDeviceLanguage;

  /// No description provided for @previewConvert.
  ///
  /// In en, this message translates to:
  /// **'Preview Convert'**
  String get previewConvert;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @pdfToLongImages.
  ///
  /// In en, this message translates to:
  /// **'PDF to Long Images'**
  String get pdfToLongImages;

  /// No description provided for @convertSelect.
  ///
  /// In en, this message translates to:
  /// **'Convert selected'**
  String get convertSelect;

  /// No description provided for @convertAll.
  ///
  /// In en, this message translates to:
  /// **'Convert All'**
  String get convertAll;

  /// No description provided for @searchInFile.
  ///
  /// In en, this message translates to:
  /// **'Search in file'**
  String get searchInFile;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @thisActionCanContainAds.
  ///
  /// In en, this message translates to:
  /// **'This action can contain ads'**
  String get thisActionCanContainAds;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @thank.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get thank;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// No description provided for @permission.
  ///
  /// In en, this message translates to:
  /// **'Permission'**
  String get permission;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get policy;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred!'**
  String get unexpectedError;

  /// No description provided for @alreadyOwnError.
  ///
  /// In en, this message translates to:
  /// **'Looks like you already owned this item.\nPlease click \"Restore purchase\" to continue.'**
  String get alreadyOwnError;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @backToHomescreen.
  ///
  /// In en, this message translates to:
  /// **'Back to Homescreen'**
  String get backToHomescreen;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit app'**
  String get exitApp;

  /// No description provided for @areYouSureYouWantToExitApp.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the app?'**
  String get areYouSureYouWantToExitApp;

  /// No description provided for @pleaseSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Please select language to continue'**
  String get pleaseSelectLanguage;

  /// No description provided for @allDocumentsViewer.
  ///
  /// In en, this message translates to:
  /// **'PDF Reader - PDF Viewer'**
  String get allDocumentsViewer;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Read All Documents'**
  String get onboardingTitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Understand Any Document Instantly'**
  String get onboardingTitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Edit PDFs Like a Pro'**
  String get onboardingTitle3;

  /// No description provided for @onboardingContent1.
  ///
  /// In en, this message translates to:
  /// **'Open PDF, Word, Excel, PPT - fast and seamless'**
  String get onboardingContent1;

  /// No description provided for @onboardingContent2.
  ///
  /// In en, this message translates to:
  /// **'Translate and summarize files with AI in seconds'**
  String get onboardingContent2;

  /// No description provided for @onboardingContent3.
  ///
  /// In en, this message translates to:
  /// **'Highlight, annotate, sign, and mark up PDFs easily'**
  String get onboardingContent3;

  /// No description provided for @requirePermission.
  ///
  /// In en, this message translates to:
  /// **'PDF Reader - PDF Viewer requires permission!'**
  String get requirePermission;

  /// No description provided for @goToSetting.
  ///
  /// In en, this message translates to:
  /// **'Go to setting'**
  String get goToSetting;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant permission later'**
  String get grantPermission;

  /// No description provided for @continuePer.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuePer;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exit;

  /// No description provided for @doYouWantExitApp.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit app?'**
  String get doYouWantExitApp;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get document;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @bookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmark;

  /// No description provided for @searchOnAllDocumentsViewer.
  ///
  /// In en, this message translates to:
  /// **'Search on PDF Reader - PDF Viewer'**
  String get searchOnAllDocumentsViewer;

  /// No description provided for @mergePDF.
  ///
  /// In en, this message translates to:
  /// **'Merge PDF'**
  String get mergePDF;

  /// No description provided for @splitPDF.
  ///
  /// In en, this message translates to:
  /// **'Split PDF'**
  String get splitPDF;

  /// No description provided for @unlockPDF.
  ///
  /// In en, this message translates to:
  /// **'Unlock PDF'**
  String get unlockPDF;

  /// No description provided for @lockPDF.
  ///
  /// In en, this message translates to:
  /// **'Lock PDF'**
  String get lockPDF;

  /// No description provided for @scanPDF.
  ///
  /// In en, this message translates to:
  /// **'Scan PDF'**
  String get scanPDF;

  /// No description provided for @pDFToImage.
  ///
  /// In en, this message translates to:
  /// **'PDF to Image'**
  String get pDFToImage;

  /// No description provided for @documentTool.
  ///
  /// In en, this message translates to:
  /// **'Document tool'**
  String get documentTool;

  /// No description provided for @documentReader.
  ///
  /// In en, this message translates to:
  /// **'Document reader'**
  String get documentReader;

  /// No description provided for @sumFiles.
  ///
  /// In en, this message translates to:
  /// **'{count} files'**
  String sumFiles(int count);

  /// No description provided for @pdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get pdf;

  /// No description provided for @word.
  ///
  /// In en, this message translates to:
  /// **'DOC'**
  String get word;

  /// No description provided for @excel.
  ///
  /// In en, this message translates to:
  /// **'XLSX'**
  String get excel;

  /// No description provided for @ppt.
  ///
  /// In en, this message translates to:
  /// **'PPT'**
  String get ppt;

  /// No description provided for @txt.
  ///
  /// In en, this message translates to:
  /// **'TXT'**
  String get txt;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'IMAGE'**
  String get image;

  /// No description provided for @doYouLikeTheApp.
  ///
  /// In en, this message translates to:
  /// **'Do you like the app?'**
  String get doYouLikeTheApp;

  /// No description provided for @rate5.
  ///
  /// In en, this message translates to:
  /// **'Love it'**
  String get rate5;

  /// No description provided for @rate4.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get rate4;

  /// No description provided for @rate3.
  ///
  /// In en, this message translates to:
  /// **'Sad!'**
  String get rate3;

  /// No description provided for @rate2.
  ///
  /// In en, this message translates to:
  /// **'Poor!'**
  String get rate2;

  /// No description provided for @rate1.
  ///
  /// In en, this message translates to:
  /// **'Oh no!'**
  String get rate1;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @renameFile.
  ///
  /// In en, this message translates to:
  /// **'Rename file'**
  String get renameFile;

  /// No description provided for @pdfConverter.
  ///
  /// In en, this message translates to:
  /// **'PDF Converter'**
  String get pdfConverter;

  /// No description provided for @deleteFromDevice.
  ///
  /// In en, this message translates to:
  /// **'Delete from Device'**
  String get deleteFromDevice;

  /// No description provided for @fileName.
  ///
  /// In en, this message translates to:
  /// **'File name'**
  String get fileName;

  /// No description provided for @storagePath.
  ///
  /// In en, this message translates to:
  /// **'Storage path'**
  String get storagePath;

  /// No description provided for @lastView.
  ///
  /// In en, this message translates to:
  /// **'Last view'**
  String get lastView;

  /// No description provided for @lastModified.
  ///
  /// In en, this message translates to:
  /// **'Last modified'**
  String get lastModified;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @fileNameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'File name cannot be empty'**
  String get fileNameCannotBeEmpty;

  /// No description provided for @pleaseEnterFileName.
  ///
  /// In en, this message translates to:
  /// **'Please enter file name'**
  String get pleaseEnterFileName;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @last7Day.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get last7Day;

  /// No description provided for @monthAgo.
  ///
  /// In en, this message translates to:
  /// **'1 month ago'**
  String get monthAgo;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteIt.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete it?'**
  String get deleteIt;

  /// No description provided for @fileSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} File selected'**
  String fileSelected(Object count);

  /// No description provided for @exitAndDiscard.
  ///
  /// In en, this message translates to:
  /// **'Exit and discard the changes?'**
  String get exitAndDiscard;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'files'**
  String get files;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @redOption.
  ///
  /// In en, this message translates to:
  /// **'RED'**
  String get redOption;

  /// No description provided for @greenOption.
  ///
  /// In en, this message translates to:
  /// **'GREEN'**
  String get greenOption;

  /// No description provided for @blueOption.
  ///
  /// In en, this message translates to:
  /// **'BLUE'**
  String get blueOption;

  /// No description provided for @displayP3HexColor.
  ///
  /// In en, this message translates to:
  /// **'Display P3 Hex Color #'**
  String get displayP3HexColor;

  /// No description provided for @colorsOption.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colorsOption;

  /// No description provided for @gridOption.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get gridOption;

  /// No description provided for @spectrumOption.
  ///
  /// In en, this message translates to:
  /// **'Spectrum'**
  String get spectrumOption;

  /// No description provided for @slidersOption.
  ///
  /// In en, this message translates to:
  /// **'Sliders'**
  String get slidersOption;

  /// No description provided for @opacityOption.
  ///
  /// In en, this message translates to:
  /// **'Opacity'**
  String get opacityOption;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **' Font size:'**
  String get fontSize;

  /// No description provided for @aToz.
  ///
  /// In en, this message translates to:
  /// **'A-Z'**
  String get aToz;

  /// No description provided for @zToa.
  ///
  /// In en, this message translates to:
  /// **'Z-A'**
  String get zToa;

  /// No description provided for @newToOld.
  ///
  /// In en, this message translates to:
  /// **'new to old'**
  String get newToOld;

  /// No description provided for @oldToNew.
  ///
  /// In en, this message translates to:
  /// **'old to new'**
  String get oldToNew;

  /// No description provided for @smallToLarge.
  ///
  /// In en, this message translates to:
  /// **'small to large'**
  String get smallToLarge;

  /// No description provided for @largeToSmall.
  ///
  /// In en, this message translates to:
  /// **'large to small'**
  String get largeToSmall;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// No description provided for @merge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get merge;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @split.
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get split;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @removePwTo.
  ///
  /// In en, this message translates to:
  /// **'Remove the password, the file will no longer be protected.'**
  String get removePwTo;

  /// No description provided for @setPwTo.
  ///
  /// In en, this message translates to:
  /// **'Set a password to protect your PDF file.'**
  String get setPwTo;

  /// No description provided for @setPassword.
  ///
  /// In en, this message translates to:
  /// **'Set Password'**
  String get setPassword;

  /// No description provided for @removePassword.
  ///
  /// In en, this message translates to:
  /// **'Remove Password'**
  String get removePassword;

  /// No description provided for @longImages.
  ///
  /// In en, this message translates to:
  /// **'Long Images'**
  String get longImages;

  /// No description provided for @separateImages.
  ///
  /// In en, this message translates to:
  /// **'Separate Images'**
  String get separateImages;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @pdfToImages.
  ///
  /// In en, this message translates to:
  /// **'PDF to Images'**
  String get pdfToImages;

  /// No description provided for @exportImageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Export Image Successfully!'**
  String get exportImageSuccess;

  /// No description provided for @lockPdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'Lock PDF Successfully!'**
  String get lockPdfSuccess;

  /// No description provided for @scanPdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'Scan PDF Successfully!'**
  String get scanPdfSuccess;

  /// No description provided for @mergePdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'Merge PDF Successfully!'**
  String get mergePdfSuccess;

  /// No description provided for @editPdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'Edit PDF Successfully!'**
  String get editPdfSuccess;

  /// No description provided for @allDoc.
  ///
  /// In en, this message translates to:
  /// **'All Document Viewer'**
  String get allDoc;

  /// No description provided for @splitSuccess.
  ///
  /// In en, this message translates to:
  /// **'Split PDF Successfully!'**
  String get splitSuccess;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @enterThePassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the password to open the file'**
  String get enterThePassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password, please try again'**
  String get wrongPassword;

  /// No description provided for @passwordProtected.
  ///
  /// In en, this message translates to:
  /// **'{path} is password protected'**
  String passwordProtected(Object path);

  /// No description provided for @unlockPdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'Unlock PDF Successfully!'**
  String get unlockPdfSuccess;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @errorCharacter.
  ///
  /// In en, this message translates to:
  /// **'The input contains special characters or is empty. Please enter valid text without special characters.'**
  String get errorCharacter;

  /// No description provided for @cameraReqPermission.
  ///
  /// In en, this message translates to:
  /// **'Camera access required to scan pdf'**
  String get cameraReqPermission;

  /// No description provided for @storageReqPermission.
  ///
  /// In en, this message translates to:
  /// **'Storage access is required to view all files'**
  String get storageReqPermission;

  /// No description provided for @reqPermission.
  ///
  /// In en, this message translates to:
  /// **'Request permissions'**
  String get reqPermission;

  /// No description provided for @underline.
  ///
  /// In en, this message translates to:
  /// **'Underline'**
  String get underline;

  /// No description provided for @brush.
  ///
  /// In en, this message translates to:
  /// **'Brush'**
  String get brush;

  /// No description provided for @highlight.
  ///
  /// In en, this message translates to:
  /// **'Highlight'**
  String get highlight;

  /// No description provided for @strikethrough.
  ///
  /// In en, this message translates to:
  /// **'Strike'**
  String get strikethrough;

  /// No description provided for @anError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: '**
  String get anError;

  /// No description provided for @errorUpdatePw.
  ///
  /// In en, this message translates to:
  /// **'Error updating PDF password: '**
  String get errorUpdatePw;

  /// No description provided for @noDocumentFound.
  ///
  /// In en, this message translates to:
  /// **'No documents found'**
  String get noDocumentFound;

  /// No description provided for @sampleFile.
  ///
  /// In en, this message translates to:
  /// **'Sample File'**
  String get sampleFile;

  /// No description provided for @thisSampleFile.
  ///
  /// In en, this message translates to:
  /// **'This is a file sample'**
  String get thisSampleFile;

  /// No description provided for @developing.
  ///
  /// In en, this message translates to:
  /// **'Developing'**
  String get developing;

  /// No description provided for @doNotSupport.
  ///
  /// In en, this message translates to:
  /// **'Do not support this file'**
  String get doNotSupport;

  /// No description provided for @uninstall.
  ///
  /// In en, this message translates to:
  /// **'Uninstall'**
  String get uninstall;

  /// No description provided for @whatProblemsYouEncounterDuringUse.
  ///
  /// In en, this message translates to:
  /// **'What problems do you encounter during use?'**
  String get whatProblemsYouEncounterDuringUse;

  /// No description provided for @dontUninstallYet.
  ///
  /// In en, this message translates to:
  /// **'Don’t uninstall yet'**
  String get dontUninstallYet;

  /// No description provided for @stillWantToUninstall.
  ///
  /// In en, this message translates to:
  /// **'Still want to uninstall?'**
  String get stillWantToUninstall;

  /// No description provided for @difficultToUse.
  ///
  /// In en, this message translates to:
  /// **'Difficult to use'**
  String get difficultToUse;

  /// No description provided for @tooManyAds.
  ///
  /// In en, this message translates to:
  /// **'Too many ads'**
  String get tooManyAds;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @viewFiles.
  ///
  /// In en, this message translates to:
  /// **'View Files'**
  String get viewFiles;

  /// No description provided for @unableToReceiveFiles.
  ///
  /// In en, this message translates to:
  /// **'Unable to retrieve the files'**
  String get unableToReceiveFiles;

  /// No description provided for @unableToViewTheFile.
  ///
  /// In en, this message translates to:
  /// **'Unable to view the file'**
  String get unableToViewTheFile;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @whyUninstallApp.
  ///
  /// In en, this message translates to:
  /// **'Why uninstall {appName}?'**
  String whyUninstallApp(String appName);

  /// No description provided for @pleaseEnterReasonForUninstalling.
  ///
  /// In en, this message translates to:
  /// **'Please enter the reason why you are uninstalling {appName}.'**
  String pleaseEnterReasonForUninstalling(String appName);

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @setAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get setAsDefault;

  /// No description provided for @justOnce.
  ///
  /// In en, this message translates to:
  /// **'Just once'**
  String get justOnce;

  /// No description provided for @always.
  ///
  /// In en, this message translates to:
  /// **'Always'**
  String get always;

  /// No description provided for @tip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tip;

  /// No description provided for @subTip.
  ///
  /// In en, this message translates to:
  /// **'If you can\'t find the app icon, tap \'More\' or the three dots to search for it'**
  String get subTip;

  /// No description provided for @documentViewer.
  ///
  /// In en, this message translates to:
  /// **'Documents Viewer'**
  String get documentViewer;

  /// No description provided for @allowAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow Access to manage all files'**
  String get allowAccess;

  /// No description provided for @pleaseAllowAll.
  ///
  /// In en, this message translates to:
  /// **'Please allow {appName} to access all your files'**
  String pleaseAllowAll(Object appName);

  /// No description provided for @allowPermission.
  ///
  /// In en, this message translates to:
  /// **'Allow Permission'**
  String get allowPermission;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @yourDataRemain.
  ///
  /// In en, this message translates to:
  /// **'Your data remains private'**
  String get yourDataRemain;

  /// No description provided for @weNeedPermission.
  ///
  /// In en, this message translates to:
  /// **'We need permission to access all files to \n manage. view, and organize them efficiently'**
  String get weNeedPermission;

  /// No description provided for @failedToLoadPage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load page'**
  String get failedToLoadPage;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get savedSuccessfully;

  /// No description provided for @editPdf.
  ///
  /// In en, this message translates to:
  /// **'Edit PDF'**
  String get editPdf;

  /// No description provided for @textStyle.
  ///
  /// In en, this message translates to:
  /// **'Text Style'**
  String get textStyle;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @searchYourFile.
  ///
  /// In en, this message translates to:
  /// **'Search your files'**
  String get searchYourFile;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @imageExported.
  ///
  /// In en, this message translates to:
  /// **'{images} image exported'**
  String imageExported(Object images);

  /// No description provided for @imagesExported.
  ///
  /// In en, this message translates to:
  /// **'{images} images exported'**
  String imagesExported(Object images);

  /// No description provided for @openGallery.
  ///
  /// In en, this message translates to:
  /// **'\'Open \"Gallery\" to find a file\''**
  String get openGallery;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @goStatusBar.
  ///
  /// In en, this message translates to:
  /// **'Go to the Status Bar to find the images.'**
  String get goStatusBar;

  /// No description provided for @pleaseAllowAllDocumentsViewer.
  ///
  /// In en, this message translates to:
  /// **'Please allow All Documents\nViewer to access all your files'**
  String get pleaseAllowAllDocumentsViewer;

  /// No description provided for @notificationsTurnedOff.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off! You may miss important documents'**
  String get notificationsTurnedOff;

  /// No description provided for @tapToOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Tap here to open settings and enable notifications'**
  String get tapToOpenSettings;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @showNotification.
  ///
  /// In en, this message translates to:
  /// **'Show Notifications'**
  String get showNotification;

  /// No description provided for @enableNotification.
  ///
  /// In en, this message translates to:
  /// **'Enable Notification'**
  String get enableNotification;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PDF Reader - PDF Viewer'**
  String get appName;

  /// No description provided for @toViewYourFiles.
  ///
  /// In en, this message translates to:
  /// **'To view your files, please provide'**
  String get toViewYourFiles;

  /// No description provided for @withAccessToThem.
  ///
  /// In en, this message translates to:
  /// **'with access to them'**
  String get withAccessToThem;

  /// No description provided for @languageOptions.
  ///
  /// In en, this message translates to:
  /// **'Language Options'**
  String get languageOptions;

  /// No description provided for @toContinuePleaseGrant.
  ///
  /// In en, this message translates to:
  /// **'To continue, please grant'**
  String get toContinuePleaseGrant;

  /// No description provided for @acceptToYourFile.
  ///
  /// In en, this message translates to:
  /// **'access to your files.'**
  String get acceptToYourFile;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get startNow;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @goToPage.
  ///
  /// In en, this message translates to:
  /// **'Go to page'**
  String get goToPage;

  /// No description provided for @pageNumber.
  ///
  /// In en, this message translates to:
  /// **'Page number'**
  String get pageNumber;

  /// No description provided for @enterPageNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter page number ({start} - {end})'**
  String enterPageNumber(int start, int end);

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalid;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'bn',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'ja',
        'ko',
        'pt',
        'ru',
        'tr',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hans':
            return AppLocalizationsZhHans();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
