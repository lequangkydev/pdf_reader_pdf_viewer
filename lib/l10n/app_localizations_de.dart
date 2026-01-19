// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get saveToAlbum => 'Im Album speichern';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bilder gespeichert',
      one: '1 Bild gespeichert',
      zero: '0 Bilder gespeichert',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Diese Datei über $appName teilen – super einfach anzusehen und zu bearbeiten. Hier ausprobieren: $value';
  }

  @override
  String get searchInPdf =>
      'Suchen im <b><span style=\'color:#E01621\'>PDF Reader</span></b>';

  @override
  String get searchInDoc =>
      'Suchen im <b><span style=\'color:#2979FF\'>DOC Reader</span></b>';

  @override
  String get searchInExcel =>
      'Suchen im <b><span style=\'color:#388E3C\'>XLS Reader</span></b>';

  @override
  String get searchInPpt =>
      'Suchen im <b><span style=\'color:#F2590C\'>PPT Reader</span></b>';

  @override
  String get unSelect => 'Abwählen';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value Dateien',
      one: '1 Datei',
      zero: 'Keine Datei',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Zusammenfassung läuft';

  @override
  String get translationProgress => 'Übersetzung läuft';

  @override
  String get tryAnotherFile =>
      'Diese Datei kann nicht zusammengeführt werden. Versuchen Sie, eine andere Datei auszuwählen, um fortzufahren.';

  @override
  String get result => 'Ergebnis';

  @override
  String get scroll => 'Scrollen';

  @override
  String get giveFeedback => 'Feedback geben';

  @override
  String get add => 'Hinzufügen';

  @override
  String get selectText => 'Text auswählen';

  @override
  String get pleaseDoNot => 'Bitte keine Akzentzeichen verwenden';

  @override
  String get pleaseEnter => 'Bitte Text eingeben';

  @override
  String get watermark => 'Wasserzeichen';

  @override
  String get enterText => 'Text eingeben';

  @override
  String get color => 'Farbe';

  @override
  String get addText => 'Text hinzufügen';

  @override
  String get addWatermark => 'Wasserzeichen hinzufügen';

  @override
  String get watermarkContent => 'Inhalt des Wasserzeichens';

  @override
  String get editSuccess => 'Erfolgreich bearbeitet!';

  @override
  String get signature => 'Unterschrift';

  @override
  String get noSignature => 'Keine Unterschrift';

  @override
  String get createSignature => 'Neue Unterschrift erstellen';

  @override
  String get feedbackTitle => 'Feedback zum KI-Assistenten';

  @override
  String get feedbackTo => 'An: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'Betreff: Feedback zu „PDF Reader & Photo to PDF“.';

  @override
  String get feedbackHint => 'Schreibe dein Feedback hier...';

  @override
  String get feedbackButton => 'Feedback senden';

  @override
  String get feedbackEmptyMessage => 'Bitte gib zuerst dein Feedback ein';

  @override
  String get feedbackSuccessMessage =>
      'Feedback gesendet (oder E-Mail-App geöffnet)';

  @override
  String get feedbackErrorMessage => 'E-Mail-App konnte nicht geöffnet werden';

  @override
  String get downloadSuccess => 'Erfolgreich heruntergeladen!';

  @override
  String get noTranslate => 'Kein übersetzter Inhalt verfügbar.';

  @override
  String get keyPoint => 'Wichtige Punkte:';

  @override
  String get conclusion => 'Fazit';

  @override
  String get summary => 'Zusammenfassung';

  @override
  String get type => 'Typ';

  @override
  String get preview => 'Vorschau';

  @override
  String get startTranslate => 'Übersetzung starten';

  @override
  String get startSummary => 'Zusammenfassung starten';

  @override
  String get translateTo => 'Übersetzen in';

  @override
  String get summaryStyle => 'Stil der Zusammenfassung';

  @override
  String get selectPage => 'Seite auswählen';

  @override
  String get startAISummary => 'KI-Zusammenfassung starten';

  @override
  String get startAITranslate => 'KI-Übersetzung starten';

  @override
  String get aIAssistant => 'KI-Assistent';

  @override
  String get aITranslate => 'KI-Übersetzung';

  @override
  String get aISummary => 'KI-Zusammenfassung';

  @override
  String get ai_translate_description =>
      '<b>Dokumente sofort mit KI übersetzen.\n</b> Ein Fingertipp genügt, um Ihr gesamtes PDF präzise, natürlich und mühelos in eine andere Sprache zu übertragen.';

  @override
  String get ai_summary_description =>
      '<b>Dokumente schneller verstehen mit KI-Zusammenfassung.\n</b> Verwandeln Sie lange PDFs mit leistungsstarker KI in prägnante, gut strukturierte Zusammenfassungen—damit Sie das Wesentliche ohne Mehraufwand erfassen.';

  @override
  String get translate1 => 'Übersetzung kompletter Dokumente in Sekunden';

  @override
  String get translate2 => 'Klare, menschenähnliche Ergebnisse dank KI';

  @override
  String get translate3 => 'Mehrere Sprachen unterstützt';

  @override
  String get translate4 => 'Ideal für Studium, Arbeit und Reisen';

  @override
  String get summary1 => 'Schnelle Zusammenfassungen mit nur einem Tipp';

  @override
  String get summary2 =>
      'Mehrere Zusammenfassungsformate für unterschiedliche Lesestile';

  @override
  String get summary3 => 'Klare Hervorhebung der wichtigsten Inhalte';

  @override
  String get summary4 => 'Perfekt für Studierende, Berufstätige und den Alltag';

  @override
  String get convertedSuccess => 'Erfolgreich konvertiert';

  @override
  String get convertPdfSuccess => 'Erfolgreich in PDF konvertiert!';

  @override
  String get imageToPdf => 'Bild zu PDF';

  @override
  String get youCanHold => 'Zum Verschieben gedrückt halten und ziehen';

  @override
  String get addImage => 'Bild hinzufügen';

  @override
  String get selectImage => 'Bild auswählen';

  @override
  String get selectLanguage =>
      '<b><span style=\'color:#D90000\'>Sprache</span> auswählen</b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value Ergebnisse',
      one: '1 Ergebnis',
      zero: 'Keine Ergebnisse',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'Wird geladen ($value%)...';
  }

  @override
  String get searchOn => 'In All File Viewer suchen';

  @override
  String get detail => 'Details';

  @override
  String get fileSize => 'Dateigröße';

  @override
  String get name => 'Name';

  @override
  String get sign => 'Unterschreiben';

  @override
  String get systemLanguage => 'Systemsprache';

  @override
  String get done => 'Fertig';

  @override
  String get guideExportImage =>
      'Öffne deine Galerie, um deine Bilder anzusehen oder zu teilen.';

  @override
  String get textSetDefault =>
      'PDF Reader - PDF Viewer als Standard setzen, Dateien sofort öffnen.';

  @override
  String get enterPassSelect =>
      'Geben Sie das Passwort ein, um diese Datei auszuwählen.';

  @override
  String get selectThePage =>
      'Wählen Sie die Seite zum Trennen aus, halten Sie sie gedrückt und verschieben Sie sie.';

  @override
  String get theFastestWay => ' Der schnellste Weg, Ihre Dateien zu öffnen';

  @override
  String get neverMiss =>
      'Verpassen Sie nie wichtige Aktualisierungen Ihrer Dokumente.';

  @override
  String get guideMerge =>
      'Wählen Sie mindestens 2 Dateien zum Zusammenführen aus.';

  @override
  String get notification => 'Benachrichtigungen';

  @override
  String get allowAccessTo => 'Zugriff gewähren, um alle Dateien zu verwalten';

  @override
  String get useDeviceLanguage => 'Gerätesprache verwenden';

  @override
  String get previewConvert => 'Vorschau konvertieren';

  @override
  String get download => 'Herunterladen';

  @override
  String get pdfToLongImages => 'Langes Bild aus PDF erstellen';

  @override
  String get convertSelect => 'Auswahl konvertieren';

  @override
  String get convertAll => 'Alle konvertieren';

  @override
  String get searchInFile => 'Im Dokument suchen';

  @override
  String get language => 'Sprache';

  @override
  String get thisActionCanContainAds => 'Diese Aktion kann Werbung enthalten';

  @override
  String get next => 'Weiter';

  @override
  String get thank => 'Danke!';

  @override
  String get start => 'Start';

  @override
  String get go => 'Los';

  @override
  String get permission => 'Berechtigung';

  @override
  String get rate => 'Bewerten';

  @override
  String get share => 'Teilen';

  @override
  String get policy => 'Datenschutzrichtlinie';

  @override
  String get rateUs => 'Bewerte uns';

  @override
  String get setting => 'Einstellungen';

  @override
  String get unexpectedError => 'Ein unerwarteter Fehler ist aufgetreten!';

  @override
  String get alreadyOwnError =>
      'Es scheint, dass Sie dieses Element bereits besitzen.\nBitte klicken Sie auf „Kauf wiederherstellen“, um fortzufahren.';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get backToHomescreen => 'Zur Startseite zurückkehren';

  @override
  String get exitApp => 'App beenden';

  @override
  String get areYouSureYouWantToExitApp =>
      'Möchten Sie die App wirklich beenden?';

  @override
  String get pleaseSelectLanguage =>
      'Bitte wählen Sie eine Sprache aus, um fortzufahren';

  @override
  String get allDocumentsViewer => 'Alle Dokumenten-Viewer';

  @override
  String get onboardingTitle1 => 'Alle Dokumente lesen';

  @override
  String get onboardingTitle2 => 'Jedes Dokument sofort verstehen';

  @override
  String get onboardingTitle3 => 'PDFs wie ein Profi bearbeiten';

  @override
  String get onboardingContent1 =>
      'PDF, Word, Excel und PPT schnell und nahtlos öffnen';

  @override
  String get onboardingContent2 =>
      'Dateien mit KI in Sekunden übersetzen und zusammenfassen';

  @override
  String get onboardingContent3 =>
      'PDFs einfach markieren, kommentieren, signieren und bearbeiten';

  @override
  String get requirePermission =>
      'Alle Dokumenten-Viewer benötigen Berechtigungen!';

  @override
  String get goToSetting => 'Zu den Einstellungen';

  @override
  String get storage => 'Speicher';

  @override
  String get camera => 'Kamera';

  @override
  String get grantPermission => 'Erlaubnis später erteilen';

  @override
  String get continuePer => 'Fortfahren';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Speichern';

  @override
  String get exit => 'App beenden';

  @override
  String get doYouWantExitApp => 'Möchten Sie die App beenden?';

  @override
  String get home => 'Startseite';

  @override
  String get document => 'Dokument';

  @override
  String get recent => 'Zuletzt';

  @override
  String get bookmark => 'Lesezeichen';

  @override
  String get searchOnAllDocumentsViewer => 'In Alle Dokumenten-Viewer suchen';

  @override
  String get mergePDF => 'PDFs zusammenführen';

  @override
  String get splitPDF => 'PDFs teilen';

  @override
  String get unlockPDF => 'PDF entsperren';

  @override
  String get lockPDF => 'PDF schützen';

  @override
  String get scanPDF => 'PDF scannen';

  @override
  String get pDFToImage => 'PDF zu Bild';

  @override
  String get documentTool => 'Dokumenten-Tool';

  @override
  String get documentReader => 'Dokumenten-Reader';

  @override
  String sumFiles(int count) {
    return '$count Dateien';
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
  String get image => 'Bild';

  @override
  String get doYouLikeTheApp => 'Gefällt Ihnen die App?';

  @override
  String get rate5 => 'Gefällt mir';

  @override
  String get rate4 => 'Super!';

  @override
  String get rate3 => 'Es tut uns leid!';

  @override
  String get rate2 => 'Schlecht!';

  @override
  String get rate1 => 'Schrecklich!';

  @override
  String get notNow => 'Nicht jetzt';

  @override
  String get print => 'Drucken';

  @override
  String get renameFile => 'Datei umbenennen';

  @override
  String get pdfConverter => 'PDF konvertieren';

  @override
  String get deleteFromDevice => 'Vom Gerät löschen';

  @override
  String get fileName => 'Dateiname';

  @override
  String get storagePath => 'Speicherpfad';

  @override
  String get lastView => 'Zuletzt angesehen';

  @override
  String get lastModified => 'Zuletzt geändert';

  @override
  String get size => 'Größe';

  @override
  String get rename => 'Umbenennen';

  @override
  String get all => 'Alle';

  @override
  String get fileNameCannotBeEmpty => 'Der Dateiname darf nicht leer sein';

  @override
  String get pleaseEnterFileName => 'Bitte geben Sie einen Dateinamen ein';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String get last7Day => 'Letzte 7 Tage';

  @override
  String get monthAgo => 'Vor 1 Monat';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteIt => 'Möchten Sie dies wirklich löschen?';

  @override
  String fileSelected(Object count) {
    return '$count Dateien ausgewählt';
  }

  @override
  String get exitAndDiscard => 'Beenden und Änderungen verwerfen?';

  @override
  String get files => 'Dateien';

  @override
  String get discard => 'Verwerfen';

  @override
  String get redOption => 'ROT';

  @override
  String get greenOption => 'GRÜN';

  @override
  String get blueOption => 'BLAU';

  @override
  String get displayP3HexColor => 'Anzeige P3 Hex-Farbe #';

  @override
  String get colorsOption => 'Farben';

  @override
  String get gridOption => 'Raster';

  @override
  String get spectrumOption => 'Spektrum';

  @override
  String get slidersOption => 'Schieberegler';

  @override
  String get opacityOption => 'Deckkraft';

  @override
  String get fontSize => ' Schriftgröße:';

  @override
  String get aToz => 'Von A bis Z';

  @override
  String get zToa => 'Von Z bis A';

  @override
  String get newToOld => 'Von neu zu alt';

  @override
  String get oldToNew => 'Von alt zu neu';

  @override
  String get smallToLarge => 'Von klein nach groß';

  @override
  String get largeToSmall => 'Von groß nach klein';

  @override
  String get title => 'Titel';

  @override
  String get time => 'Zeit';

  @override
  String get open => 'Öffnen';

  @override
  String get empty => 'Leer';

  @override
  String get goHome => 'Zur Startseite';

  @override
  String get merge => 'Zusammenführen';

  @override
  String get success => 'Erfolg';

  @override
  String get split => 'Teilen';

  @override
  String get remove => 'Entfernen';

  @override
  String get loading => 'Lädt...';

  @override
  String get sortBy => 'Sortieren nach';

  @override
  String get removePwTo =>
      'Passwort entfernen, die Datei ist nicht mehr geschützt.';

  @override
  String get setPwTo =>
      'Legen Sie ein Passwort fest, um Ihre PDF-Datei zu schützen.';

  @override
  String get setPassword => 'Passwort festlegen';

  @override
  String get removePassword => 'Passwort entfernen';

  @override
  String get longImages => 'Lange Bilder';

  @override
  String get separateImages => 'Einzelne Bilder';

  @override
  String get unknownError => 'Unbekannter Fehler';

  @override
  String get pdfToImages => 'PDF in Bilder umwandeln';

  @override
  String get exportImageSuccess => 'Bild erfolgreich exportiert!';

  @override
  String get lockPdfSuccess => 'PDF erfolgreich gesperrt!';

  @override
  String get scanPdfSuccess => 'PDF erfolgreich gescannt!';

  @override
  String get mergePdfSuccess => 'PDF erfolgreich zusammengeführt!';

  @override
  String get editPdfSuccess => 'PDF erfolgreich bearbeitet!';

  @override
  String get allDoc => 'Alle Dokumente anzeigen';

  @override
  String get splitSuccess => 'PDF erfolgreich geteilt!';

  @override
  String get enterPassword => 'Passwort eingeben';

  @override
  String get enterThePassword =>
      'Geben Sie das Passwort ein, um die Datei zu öffnen.';

  @override
  String get password => 'Passwort';

  @override
  String get wrongPassword => 'Falsches Passwort, bitte erneut versuchen';

  @override
  String passwordProtected(Object path) {
    return 'Die Datei „$path ist durch ein Passwort geschützt.';
  }

  @override
  String get unlockPdfSuccess => 'PDF erfolgreich entsperrt!';

  @override
  String get search => 'Suche';

  @override
  String get errorCharacter =>
      'Die Eingabe enthält Sonderzeichen oder ist leer. Bitte geben Sie gültigen Text ohne Sonderzeichen ein.';

  @override
  String get cameraReqPermission =>
      'Kamerazugriff erforderlich, um PDF zu scannen';

  @override
  String get storageReqPermission =>
      'Speicherzugriff erforderlich, um alle Dateien anzuzeigen';

  @override
  String get reqPermission => 'Berechtigungen anfordern';

  @override
  String get underline => 'Unterstreichen';

  @override
  String get brush => 'Pinsel';

  @override
  String get highlight => 'Markieren';

  @override
  String get strikethrough => 'Durchstreichen';

  @override
  String get anError => 'Ein Fehler ist aufgetreten: ';

  @override
  String get errorUpdatePw => 'Fehler beim Aktualisieren des PDF-Passworts: ';

  @override
  String get noDocumentFound => 'Keine Dokumente gefunden';

  @override
  String get sampleFile => 'Beispieldatei';

  @override
  String get thisSampleFile => 'Dies ist eine Beispieldatei';

  @override
  String get developing => 'In Entwicklung';

  @override
  String get doNotSupport => 'Diese Datei wird nicht unterstützt';

  @override
  String get uninstall => 'Deinstallieren';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'Welche Probleme treten bei der Nutzung auf?';

  @override
  String get dontUninstallYet => 'Noch nicht deinstallieren';

  @override
  String get stillWantToUninstall => 'Möchten Sie wirklich deinstallieren?';

  @override
  String get difficultToUse => 'Schwer zu benutzen';

  @override
  String get tooManyAds => 'Zu viele Anzeigen';

  @override
  String get others => 'Andere';

  @override
  String get viewFiles => 'Dateien anzeigen';

  @override
  String get unableToReceiveFiles => 'Dateien können nicht empfangen werden';

  @override
  String get unableToViewTheFile => 'Datei kann nicht angezeigt werden';

  @override
  String get explore => 'Entdecken';

  @override
  String whyUninstallApp(String appName) {
    return 'Warum $appName deinstallieren?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Bitte geben Sie den Grund für die Deinstallation von $appName ein.';
  }

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get setAsDefault => 'Als Standard festlegen';

  @override
  String get justOnce => 'Nur einmal';

  @override
  String get always => 'Immer';

  @override
  String get tip => 'Tipp';

  @override
  String get subTip =>
      'Wenn Sie das App-Symbol nicht finden, tippen Sie auf „Mehr“ oder auf die drei Punkte, um danach zu suchen.';

  @override
  String get documentViewer => 'Dokumente fest';

  @override
  String get allowAccess => 'Zugriff gewähren, um alle Dateien zu verwalten';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Bitte erlauben Sie $appName, auf alle Ihre Dateien zuzugreifen';
  }

  @override
  String get allowPermission => 'Berechtigung erlauben';

  @override
  String get welcomeTo => 'Willkommen bei';

  @override
  String get yourDataRemain => 'Ihre Daten bleiben privat';

  @override
  String get weNeedPermission =>
      'Wir benötigen die Erlaubnis, auf alle Dateien zuzugreifen, um sie effizient zu \n verwalten, anzeigen und organisieren zu können';

  @override
  String get failedToLoadPage => 'Seite konnte nicht geladen werden';

  @override
  String get savedSuccessfully => 'Erfolgreich gespeichert';

  @override
  String get editPdf => 'PDF bearbeiten';

  @override
  String get textStyle => 'Textstil';

  @override
  String get more => 'Mehr';

  @override
  String get searchYourFile => 'Durchsuchen Sie Ihre Dateien';

  @override
  String get select => 'Auswählen';

  @override
  String imageExported(Object images) {
    return '$images Bild exportiert';
  }

  @override
  String imagesExported(Object images) {
    return '$images Bilder exportiert';
  }

  @override
  String get openGallery =>
      'Öffnen Sie die \"Galerie\", um eine Datei zu finden';

  @override
  String get tools => 'Werkzeuge';

  @override
  String get goStatusBar => 'Gehen Sie zur Statusleiste, um Bilder zu finden';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Bitte erlauben Sie dem PDF Reader - PDF Viewer\nZugriff auf alle Ihre Dateien';

  @override
  String get notificationsTurnedOff =>
      'Benachrichtigungen sind deaktiviert! Sie könnten wichtige Dokumente verpassen';

  @override
  String get tapToOpenSettings =>
      'Tippen Sie hier, um die Einstellungen zu öffnen und Benachrichtigungen zu aktivieren';

  @override
  String get later => 'Später';

  @override
  String get showNotification => 'Benachrichtigungen anzeigen';

  @override
  String get enableNotification => 'Benachrichtigungen aktivieren';

  @override
  String get appName => 'PDF-Reader - PDF-Viewer';

  @override
  String get toViewYourFiles => 'Um Ihre Dateien anzuzeigen, geben Sie bitte';

  @override
  String get withAccessToThem => 'den Zugriff darauf frei';

  @override
  String get languageOptions => 'Sprachoptionen';

  @override
  String get toContinuePleaseGrant => 'Um fortzufahren, bitte gewähren Sie';

  @override
  String get acceptToYourFile => 'Zugriff auf Ihre Dateien.';

  @override
  String get apply => 'Anwenden';

  @override
  String get other => 'Andere';

  @override
  String get startNow => 'Jetzt starten';

  @override
  String get page => 'Seite';

  @override
  String get goToPage => 'Gehe zu Seite';

  @override
  String get pageNumber => 'Seitennummer';

  @override
  String enterPageNumber(int start, int end) {
    return 'Seitennummer eingeben ($start - $end)';
  }

  @override
  String get invalid => 'Ungültig';
}
