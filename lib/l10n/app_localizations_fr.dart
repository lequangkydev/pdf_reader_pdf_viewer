// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get saveToAlbum => 'Enregistrer dans l’album';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count images enregistrées',
      one: '1 image enregistrée',
      zero: '0 image enregistrée',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Partage de ce fichier via $appName – très facile à consulter et modifier. Essayez-le ici : $value';
  }

  @override
  String get searchInPdf =>
      'Rechercher dans <b><span style=\'color:#E01621\'>PDF Reader</span></b>';

  @override
  String get searchInDoc =>
      'Rechercher dans <b><span style=\'color:#2979FF\'>DOC Reader</span></b>';

  @override
  String get searchInExcel =>
      'Rechercher dans <b><span style=\'color:#388E3C\'>XLS Reader</span></b>';

  @override
  String get searchInPpt =>
      'Rechercher dans <b><span style=\'color:#F2590C\'>PPT Reader</span></b>';

  @override
  String get unSelect => 'Désélectionner';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value fichiers',
      one: '1 fichier',
      zero: 'Aucun fichier',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Résumé en cours';

  @override
  String get translationProgress => 'Traduction en cours';

  @override
  String get tryAnotherFile =>
      'Impossible de fusionner ce fichier. Essayez de sélectionner un autre fichier pour continuer.';

  @override
  String get result => 'Résultat';

  @override
  String get scroll => 'Faire défiler';

  @override
  String get giveFeedback => 'Donnez-moi votre avis';

  @override
  String get add => 'Ajouter';

  @override
  String get selectText => 'Sélectionner le texte';

  @override
  String get pleaseDoNot => 'Veuillez ne pas inclure de caractères accentués';

  @override
  String get pleaseEnter => 'Veuillez entrer du texte';

  @override
  String get watermark => 'Filigrane';

  @override
  String get enterText => 'Saisir du texte';

  @override
  String get color => 'Couleur';

  @override
  String get addText => 'Ajouter du texte';

  @override
  String get addWatermark => 'Ajouter un filigrane';

  @override
  String get watermarkContent => 'Contenu du filigrane';

  @override
  String get editSuccess => 'Modifié avec succès !';

  @override
  String get signature => 'Signature';

  @override
  String get noSignature => 'Aucune signature';

  @override
  String get createSignature => 'Créer une nouvelle signature';

  @override
  String get feedbackTitle => 'Retour sur l’assistant IA';

  @override
  String get feedbackTo => 'À : kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'Objet : retour sur « PDF Reader & Photo to PDF ».';

  @override
  String get feedbackHint => 'Écrivez votre avis ici...';

  @override
  String get feedbackButton => 'Envoyer le retour';

  @override
  String get feedbackEmptyMessage => 'Veuillez d’abord écrire votre avis';

  @override
  String get feedbackSuccessMessage =>
      'Avis envoyé (ou application e-mail ouverte)';

  @override
  String get feedbackErrorMessage => 'Impossible d’ouvrir l’application e-mail';

  @override
  String get downloadSuccess => 'Téléchargé avec succès !';

  @override
  String get noTranslate => 'Aucun contenu traduit disponible.';

  @override
  String get keyPoint => 'Points clés :';

  @override
  String get conclusion => 'Conclusion';

  @override
  String get summary => 'Résumé';

  @override
  String get type => 'Type';

  @override
  String get preview => 'Aperçu';

  @override
  String get startTranslate => 'Commencer la traduction';

  @override
  String get startSummary => 'Commencer le résumé';

  @override
  String get translateTo => 'Traduire vers';

  @override
  String get summaryStyle => 'Style de résumé';

  @override
  String get selectPage => 'Sélectionner la page';

  @override
  String get startAISummary => 'Démarrer le résumé IA';

  @override
  String get startAITranslate => 'Démarrer la traduction IA';

  @override
  String get aIAssistant => 'Assistant IA';

  @override
  String get aITranslate => 'Traduction IA';

  @override
  String get aISummary => 'Résumé IA';

  @override
  String get ai_translate_description =>
      '<b>Traduisez instantanément vos documents grâce à l’IA.\n</b> Un simple geste suffit pour convertir l’intégralité de votre PDF dans une autre langue—avec précision, naturel et simplicité.';

  @override
  String get ai_summary_description =>
      '<b>Comprenez plus vite vos documents avec le Résumé IA.\n</b> Transformez de longs PDF en résumés clairs et structurés grâce à une IA puissante—accédez à l’essentiel sans lecture superflue.';

  @override
  String get translate1 =>
      'Traduction complète de documents en quelques secondes';

  @override
  String get translate2 => 'Résultats clairs et naturels propulsés par l’IA';

  @override
  String get translate3 => 'Prise en charge de plusieurs langues';

  @override
  String get translate4 => 'Idéal pour les études, le travail et les voyages';

  @override
  String get summary1 => 'Résumés rapides en un seul geste';

  @override
  String get summary2 =>
      'Plusieurs formats de résumé pour différents styles de lecture';

  @override
  String get summary3 => 'Mise en évidence claire des idées clés';

  @override
  String get summary4 =>
      'Parfait pour les étudiants, les professionnels et la lecture quotidienne';

  @override
  String get convertedSuccess => 'Converti avec succès';

  @override
  String get convertPdfSuccess => 'Converti en PDF avec succès !';

  @override
  String get imageToPdf => 'Image en PDF';

  @override
  String get youCanHold =>
      'Vous pouvez maintenir et faire glisser pour repositionner les images';

  @override
  String get addImage => 'Ajouter une image';

  @override
  String get selectImage => 'Sélectionner une image';

  @override
  String get selectLanguage =>
      '<b>Sélectionnez la <span style=\'color:#D90000\'>langue</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value résultats',
      one: '1 résultat',
      zero: 'Aucun résultat',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'Chargement ($value%)...';
  }

  @override
  String get searchOn => 'Rechercher sur All File Viewer';

  @override
  String get detail => 'Détails';

  @override
  String get fileSize => 'Taille du fichier';

  @override
  String get name => 'Nom';

  @override
  String get sign => 'Signer';

  @override
  String get systemLanguage => 'Langue du système';

  @override
  String get done => 'Terminé';

  @override
  String get guideExportImage =>
      'Ouvrez votre galerie pour voir ou partager vos images.';

  @override
  String get textSetDefault =>
      'Définissez PDF Reader - PDF Viewer par défaut pour tout ouvrir vite.';

  @override
  String get enterPassSelect =>
      'Entrez le mot de passe pour sélectionner ce fichier.';

  @override
  String get selectThePage =>
      'Sélectionnez la page à diviser, puis appuyez et maintenez pour la réorganiser parmi les autres.';

  @override
  String get theFastestWay => 'Le moyen le plus rapide d’ouvrir vos fichiers';

  @override
  String get neverMiss =>
      'Ne manquez jamais les mises à jour importantes de vos documents.';

  @override
  String get guideMerge => 'Sélectionnez au moins 2 fichiers à fusionner.';

  @override
  String get notification => 'Notifications';

  @override
  String get allowAccessTo => 'Autoriser l\'accès pour gérer tous les fichiers';

  @override
  String get useDeviceLanguage => 'Utiliser la langue de l’appareil';

  @override
  String get previewConvert => 'Aperçu de la conversion';

  @override
  String get download => 'Télécharger';

  @override
  String get pdfToLongImages => 'PDF en images longues';

  @override
  String get convertSelect => 'Convertir la sélection';

  @override
  String get convertAll => 'Tout convertir';

  @override
  String get searchInFile => 'Rechercher dans le fichier';

  @override
  String get language => 'Langue';

  @override
  String get thisActionCanContainAds =>
      'Cette action peut contenir des publicités';

  @override
  String get next => 'Suivant';

  @override
  String get thank => 'Merci !';

  @override
  String get start => 'Démarrer';

  @override
  String get go => 'Aller';

  @override
  String get permission => 'Permission';

  @override
  String get rate => 'Évaluer';

  @override
  String get share => 'Partager';

  @override
  String get policy => 'Politique de confidentialité';

  @override
  String get rateUs => 'Évaluez-nous';

  @override
  String get setting => 'Paramètre';

  @override
  String get unexpectedError => 'Une erreur inattendue est survenue !';

  @override
  String get alreadyOwnError =>
      'Il semble que vous possédiez déjà cet article.\nVeuillez cliquer sur \"Restaurer l\'achat\" pour continuer.';

  @override
  String get confirm => 'Confirmer';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get backToHomescreen => 'Retour à l\'écran d\'accueil';

  @override
  String get exitApp => 'Quitter l\'application';

  @override
  String get areYouSureYouWantToExitApp =>
      'Êtes-vous sûr de vouloir quitter l\'application ?';

  @override
  String get pleaseSelectLanguage =>
      'Veuillez sélectionner une langue pour continuer';

  @override
  String get allDocumentsViewer => 'Visionneuse de tous les documents';

  @override
  String get onboardingTitle1 => 'Lire tous les documents';

  @override
  String get onboardingTitle2 =>
      'Comprendre instantanément n’importe quel document';

  @override
  String get onboardingTitle3 => 'Modifier les PDF comme un pro';

  @override
  String get onboardingContent1 =>
      'Ouvrez PDF, Word, Excel, PPT rapidement et sans interruption';

  @override
  String get onboardingContent2 =>
      'Traduisez et résumez des fichiers avec l’IA en quelques secondes';

  @override
  String get onboardingContent3 =>
      'Surlignez, annotez, signez et modifiez les PDF facilement';

  @override
  String get requirePermission =>
      'La visionneuse de tous les documents nécessite une autorisation !';

  @override
  String get goToSetting => 'Aller aux paramètres';

  @override
  String get storage => 'Stockage';

  @override
  String get camera => 'Caméra';

  @override
  String get grantPermission => 'Accorder la permission plus tard';

  @override
  String get continuePer => 'Continuer';

  @override
  String get cancel => 'Annuler';

  @override
  String get ok => 'D\'accord';

  @override
  String get save => 'Sauvegarder';

  @override
  String get exit => 'Quitter l\'application';

  @override
  String get doYouWantExitApp => 'Voulez-vous quitter l\'application ?';

  @override
  String get home => 'Accueil';

  @override
  String get document => 'Document';

  @override
  String get recent => 'Récent';

  @override
  String get bookmark => 'Marque-page';

  @override
  String get searchOnAllDocumentsViewer =>
      'Rechercher dans la visionneuse de tous les documents';

  @override
  String get mergePDF => 'Fusionner PDF';

  @override
  String get splitPDF => 'Diviser PDF';

  @override
  String get unlockPDF => 'Déverrouiller PDF';

  @override
  String get lockPDF => 'Verrouiller PDF';

  @override
  String get scanPDF => 'Scanner PDF';

  @override
  String get pDFToImage => 'PDF en image';

  @override
  String get documentTool => 'Outil de document';

  @override
  String get documentReader => 'Lecteur de documents';

  @override
  String sumFiles(int count) {
    return '$count fichiers';
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
  String get doYouLikeTheApp => 'Aimez-vous l\'application ?';

  @override
  String get rate5 => 'J\'adore';

  @override
  String get rate4 => 'Génial !';

  @override
  String get rate3 => 'Bon !';

  @override
  String get rate2 => 'Mauvais !';

  @override
  String get rate1 => 'Oh non !';

  @override
  String get notNow => 'Pas maintenant';

  @override
  String get print => 'Imprimer';

  @override
  String get renameFile => 'Renommer le fichier';

  @override
  String get pdfConverter => 'Convertisseur PDF';

  @override
  String get deleteFromDevice => 'Supprimer de l\'appareil';

  @override
  String get fileName => 'Nom du fichier';

  @override
  String get storagePath => 'Chemin de stockage';

  @override
  String get lastView => 'Dernière vue';

  @override
  String get lastModified => 'Dernière modification';

  @override
  String get size => 'Taille';

  @override
  String get rename => 'Renommer';

  @override
  String get all => 'Tous  ';

  @override
  String get fileNameCannotBeEmpty => 'Le nom de fichier ne peut pas être vide';

  @override
  String get pleaseEnterFileName => 'Veuillez entrer le nom du fichier';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get last7Day => 'Derniers 7 jours';

  @override
  String get monthAgo => 'Il y a 1 mois';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteIt => 'Êtes-vous sûr de vouloir le supprimer ?';

  @override
  String fileSelected(Object count) {
    return '$count fichier sélectionné';
  }

  @override
  String get exitAndDiscard => 'Quitter et abandonner les modifications ?';

  @override
  String get files => 'fichiers';

  @override
  String get discard => 'Abandonner';

  @override
  String get redOption => 'ROUGE';

  @override
  String get greenOption => 'VERT';

  @override
  String get blueOption => 'BLEU';

  @override
  String get displayP3HexColor => 'Afficher la couleur hexagonale P3 #';

  @override
  String get colorsOption => 'Couleurs';

  @override
  String get gridOption => 'Grille';

  @override
  String get spectrumOption => 'Spectre';

  @override
  String get slidersOption => 'Curseurs';

  @override
  String get opacityOption => 'Opacité';

  @override
  String get fontSize => 'Taille de la police :';

  @override
  String get aToz => 'De A à Z';

  @override
  String get zToa => 'De Z à A';

  @override
  String get newToOld => 'Du nouveau à l\'ancien';

  @override
  String get oldToNew => 'De l\'ancien au nouveau';

  @override
  String get smallToLarge => 'Du petit au grand';

  @override
  String get largeToSmall => 'Du grand au petit';

  @override
  String get title => 'Titre';

  @override
  String get time => 'Temps';

  @override
  String get open => 'Ouvrir';

  @override
  String get empty => 'Vide';

  @override
  String get goHome => 'Accueil';

  @override
  String get merge => 'Fusionner';

  @override
  String get success => 'Succès';

  @override
  String get split => 'Diviser';

  @override
  String get remove => 'Supprimer';

  @override
  String get loading => 'Chargement...';

  @override
  String get sortBy => 'Trier par';

  @override
  String get removePwTo =>
      'Supprimer le mot de passe, le fichier ne sera plus protégé.';

  @override
  String get setPwTo =>
      'Définir un mot de passe pour protéger votre fichier PDF.';

  @override
  String get setPassword => 'Définir le mot de passe';

  @override
  String get removePassword => 'Supprimer le mot de passe';

  @override
  String get longImages => 'Images longues';

  @override
  String get separateImages => 'Images séparées';

  @override
  String get unknownError => 'Erreur inconnue';

  @override
  String get pdfToImages => 'PDF en images';

  @override
  String get exportImageSuccess => 'Exportation d\'image réussie !';

  @override
  String get lockPdfSuccess => 'Verrouillage de PDF réussi !';

  @override
  String get scanPdfSuccess => 'Numérisation de PDF réussie !';

  @override
  String get mergePdfSuccess => 'Fusion de PDF réussie !';

  @override
  String get editPdfSuccess => 'Édition de PDF réussie !';

  @override
  String get allDoc => 'Visionneuse de tous les documents';

  @override
  String get splitSuccess => 'PDF divisé avec succès !';

  @override
  String get enterPassword => 'Entrez le mot de passe';

  @override
  String get enterThePassword =>
      'Entrez le mot de passe pour ouvrir le fichier';

  @override
  String get password => 'Mot de passe';

  @override
  String get wrongPassword => 'Mot de passe incorrect, veuillez réessayer';

  @override
  String passwordProtected(Object path) {
    return '$path est protégé par un mot de passe';
  }

  @override
  String get unlockPdfSuccess => 'Déverrouillage de PDF réussi !';

  @override
  String get search => 'Rechercher';

  @override
  String get errorCharacter =>
      'L\'entrée contient des caractères spéciaux ou est vide. Veuillez saisir un texte valide sans caractères spéciaux.';

  @override
  String get cameraReqPermission =>
      'L\'accès à la caméra est requis pour scanner le PDF';

  @override
  String get storageReqPermission =>
      'L\'accès au stockage est requis pour voir tous les fichiers';

  @override
  String get reqPermission => 'Demander des autorisations';

  @override
  String get underline => 'Souligner';

  @override
  String get brush => 'Pinceau';

  @override
  String get highlight => 'Mettre en surbrillance';

  @override
  String get strikethrough => 'Barré';

  @override
  String get anError => 'Une erreur s\'est produite : ';

  @override
  String get errorUpdatePw =>
      'Erreur lors de la mise à jour du mot de passe PDF : ';

  @override
  String get noDocumentFound => 'Aucun document trouvé';

  @override
  String get sampleFile => 'Fichier d\'exemple';

  @override
  String get thisSampleFile => 'Ceci est un fichier exemple';

  @override
  String get developing => 'Développement';

  @override
  String get doNotSupport => 'Ne supporte pas ce fichier';

  @override
  String get uninstall => 'Désinstaller';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'Quels problèmes rencontrez-vous lors de l\'utilisation?';

  @override
  String get dontUninstallYet => 'Ne désinstallez pas encore';

  @override
  String get stillWantToUninstall => 'Voulez-vous toujours désinstaller?';

  @override
  String get difficultToUse => 'Difficile à utiliser';

  @override
  String get tooManyAds => 'Trop de publicités';

  @override
  String get others => 'Autres';

  @override
  String get viewFiles => 'Voir les fichiers';

  @override
  String get unableToReceiveFiles => 'Impossible de recevoir les fichiers';

  @override
  String get unableToViewTheFile => 'Impossible de voir le fichier';

  @override
  String get explore => 'Explorer';

  @override
  String whyUninstallApp(String appName) {
    return 'Pourquoi désinstaller $appName?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Veuillez entrer la raison pour laquelle vous désinstallez $appName.';
  }

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get setAsDefault => 'Définir par défaut';

  @override
  String get justOnce => 'Juste une fois';

  @override
  String get always => 'Toujours';

  @override
  String get tip => 'Astuce';

  @override
  String get subTip =>
      'Si vous ne trouvez pas l’icône de l’application, appuyez sur \'Plus\' ou les trois points pour la rechercher';

  @override
  String get documentViewer => 'Visionneuse de documents';

  @override
  String get allowAccess => 'Autoriser l\'accès pour gérer tous les fichiers';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Veuillez autoriser $appName à accéder à tous vos fichiers';
  }

  @override
  String get allowPermission => 'Autoriser l\'autorisation';

  @override
  String get welcomeTo => 'Bienvenue sur';

  @override
  String get yourDataRemain => 'Vos données restent privées';

  @override
  String get weNeedPermission =>
      'Nous avons besoin d\'une autorisation pour accéder à tous les fichiers afin de \n les gérer, les visualiser et les organiser efficacement';

  @override
  String get failedToLoadPage => 'Échec du chargement de la page';

  @override
  String get savedSuccessfully => 'Enregistré avec succès';

  @override
  String get editPdf => 'Modifier le PDF';

  @override
  String get textStyle => 'Style de texte';

  @override
  String get more => 'Autres';

  @override
  String get searchYourFile => 'Rechercher des fichiers';

  @override
  String get select => 'Sélectionner la';

  @override
  String imageExported(Object images) {
    return '$images image exportée';
  }

  @override
  String imagesExported(Object images) {
    return '$images images exportées';
  }

  @override
  String get openGallery => 'Ouvrez \"Galerie\" pour trouver un fichier';

  @override
  String get tools => 'Outils';

  @override
  String get goStatusBar =>
      'Allez dans la barre d\'état pour trouver des images';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Por favor, permite que el Visor de Todos los Documentos\nacceda a todos tus archivos';

  @override
  String get notificationsTurnedOff =>
      'Les notifications sont désactivées ! Vous pourriez manquer des documents importants';

  @override
  String get tapToOpenSettings =>
      'Appuyez ici pour ouvrir les paramètres et activer les notifications';

  @override
  String get later => 'Plus tard';

  @override
  String get showNotification => 'Afficher les notifications';

  @override
  String get enableNotification => 'Activer les notifications';

  @override
  String get appName => 'Lecteur PDF - PDF, DOCX, XLSX';

  @override
  String get toViewYourFiles => 'Pour afficher vos fichiers, veuillez fournir';

  @override
  String get withAccessToThem => 'l\'accès à ceux-ci';

  @override
  String get languageOptions => 'Options de langue';

  @override
  String get toContinuePleaseGrant => 'Pour continuer, veuillez accorder';

  @override
  String get acceptToYourFile => 'l\'accès à vos fichiers.';

  @override
  String get apply => 'Appliquer';

  @override
  String get other => 'Autre';

  @override
  String get startNow => 'Commencer maintenant';

  @override
  String get page => 'Page';

  @override
  String get goToPage => 'Aller à la page';

  @override
  String get pageNumber => 'Numéro de page';

  @override
  String enterPageNumber(int start, int end) {
    return 'Entrez le numéro de page ($start - $end)';
  }

  @override
  String get invalid => 'Invalide';
}
