// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get saveToAlbum => 'Albüm’e kaydet';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count görsel kaydedildi',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Bu dosyayı $appName ile paylaşın – görüntülemek ve düzenlemek çok kolay. Buradan deneyebilirsiniz: $value';
  }

  @override
  String get searchInPdf =>
      '<b><span style=\'color:#E01621\'>PDF Reader</span></b> içinde ara';

  @override
  String get searchInDoc =>
      '<b><span style=\'color:#2979FF\'>DOC Reader</span></b> içinde ara';

  @override
  String get searchInExcel =>
      '<b><span style=\'color:#388E3C\'>XLS Reader</span></b> içinde ara';

  @override
  String get searchInPpt =>
      '<b><span style=\'color:#F2590C\'>PPT Reader</span></b> içinde ara';

  @override
  String get unSelect => 'Seçimi kaldır';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value dosya',
      one: '1 dosya',
      zero: 'Dosya yok',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Özet oluşturuluyor';

  @override
  String get translationProgress => 'Çeviri devam ediyor';

  @override
  String get tryAnotherFile =>
      'Bu dosya birleştirilemiyor. Devam etmek için farklı bir dosya seçmeyi deneyin.';

  @override
  String get result => 'Sonuç';

  @override
  String get scroll => 'Kaydır';

  @override
  String get giveFeedback => 'Geri bildirim ver';

  @override
  String get add => 'Ekle';

  @override
  String get selectText => 'Metin seç';

  @override
  String get pleaseDoNot => 'Lütfen aksanlı karakterler kullanmayın';

  @override
  String get pleaseEnter => 'Lütfen bir metin girin';

  @override
  String get watermark => 'Filigran';

  @override
  String get enterText => 'Metin gir';

  @override
  String get color => 'Renk';

  @override
  String get addText => 'Metin ekle';

  @override
  String get addWatermark => 'Filigran ekle';

  @override
  String get watermarkContent => 'Filigran içeriği';

  @override
  String get editSuccess => 'Başarıyla düzenlendi!';

  @override
  String get signature => 'İmza';

  @override
  String get noSignature => 'İmza yok';

  @override
  String get createSignature => 'Yeni imza oluştur';

  @override
  String get feedbackTitle => 'AI Asistanı hakkında geri bildirim';

  @override
  String get feedbackTo => 'Kime: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'Konu: “PDF Reader & Photo to PDF” hakkında geri bildirim.';

  @override
  String get feedbackHint => 'Geri bildiriminizi buraya yazın...';

  @override
  String get feedbackButton => 'Geri Bildirim Gönder';

  @override
  String get feedbackEmptyMessage => 'Lütfen önce geri bildiriminizi yazın';

  @override
  String get feedbackSuccessMessage =>
      'Geri bildirim gönderildi (veya e-posta uygulaması açıldı)';

  @override
  String get feedbackErrorMessage => 'E-posta uygulaması açılamadı';

  @override
  String get downloadSuccess => 'Başarıyla indirildi!';

  @override
  String get noTranslate => 'Çevrilmiş içerik mevcut değil.';

  @override
  String get keyPoint => 'Ana Noktalar:';

  @override
  String get conclusion => 'Sonuç';

  @override
  String get summary => 'Özet';

  @override
  String get type => 'Tür';

  @override
  String get preview => 'Önizleme';

  @override
  String get startTranslate => 'Çeviriyi Başlat';

  @override
  String get startSummary => 'Özeti Başlat';

  @override
  String get translateTo => 'Şuna çevir';

  @override
  String get summaryStyle => 'Özet Stili';

  @override
  String get selectPage => 'Sayfa seç';

  @override
  String get startAISummary => 'AI Özetini Başlat';

  @override
  String get startAITranslate => 'AI Çevirisini Başlat';

  @override
  String get aIAssistant => 'AI Asistan';

  @override
  String get aITranslate => 'AI Çeviri';

  @override
  String get aISummary => 'AI Özeti';

  @override
  String get ai_translate_description =>
      '<b>Belgeleri yapay zekâ ile anında çevirin.\n</b> Tek dokunuşla tüm PDF’nizi başka bir dile doğru ve doğal şekilde dönüştürün.';

  @override
  String get ai_summary_description =>
      '<b>AI Özet ile belgeleri daha hızlı anlayın.\n</b> Güçlü yapay zekâ sayesinde uzun PDF’leri kısa ve düzenli özetlere dönüştürün.';

  @override
  String get translate1 => 'Saniyeler içinde tam belge çevirisi';

  @override
  String get translate2 => 'Yapay zekâ destekli doğal sonuçlar';

  @override
  String get translate3 => 'Birden fazla dil desteği';

  @override
  String get translate4 => 'Eğitim, iş ve seyahat için ideal';

  @override
  String get summary1 => 'Tek dokunuşla hızlı özetler';

  @override
  String get summary2 => 'Farklı okuma stilleri için çoklu özet formatları';

  @override
  String get summary3 => 'En önemli fikirlerin net vurgusu';

  @override
  String get summary4 =>
      'Akademisyenler, profesyoneller ve günlük okuma için harika';

  @override
  String get convertedSuccess => 'Başarıyla dönüştürüldü';

  @override
  String get convertPdfSuccess => 'PDF\'ye başarıyla dönüştürüldü!';

  @override
  String get imageToPdf => 'Görselden PDF\'ye';

  @override
  String get youCanHold =>
      'Görselleri yeniden konumlandırmak için basılı tutup sürükleyebilirsiniz';

  @override
  String get addImage => 'Görsel ekle';

  @override
  String get selectImage => 'Görsel seç';

  @override
  String get selectLanguage =>
      '<b><span style=\'color:#D90000\'>Dili</span></b> Seç';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value sonuç',
      one: '1 sonuç',
      zero: 'Sonuç yok',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'Yükleniyor ($value%)...';
  }

  @override
  String get searchOn => 'All File Viewer üzerinde ara';

  @override
  String get detail => 'Detaylar';

  @override
  String get fileSize => 'Dosya boyutu';

  @override
  String get name => 'Ad';

  @override
  String get sign => 'İmzala';

  @override
  String get systemLanguage => 'Sistem dili';

  @override
  String get done => 'Bitti';

  @override
  String get guideExportImage =>
      'Görüntüleri görüntülemek veya paylaşmak için galerinizi açın.';

  @override
  String get textSetDefault =>
      'PDF Reader - PDF Viewer\'ı varsayılan yapın, anında açın.';

  @override
  String get enterPassSelect => 'Bu dosyayı seçmek için parolayı girin.';

  @override
  String get selectThePage =>
      'Bölmek istediğiniz sayfayı seçin, basılı tutup sürükleyerek yeniden düzenleyin.';

  @override
  String get theFastestWay => 'Dosyalarınızı açmanın en hızlı yolu';

  @override
  String get neverMiss =>
      'NBelgelerinizdeki önemli güncellemeleri asla kaçırmayın.';

  @override
  String get guideMerge => 'Birleştirmek için en az 2 dosya seçin.';

  @override
  String get notification => 'Bildirimler';

  @override
  String get allowAccessTo => 'Tüm dosyaları yönetmek için erişime izin ver';

  @override
  String get useDeviceLanguage => 'Cihaz dilini kullan';

  @override
  String get previewConvert => 'Dönüştürmeyi Önizle';

  @override
  String get download => 'İndir';

  @override
  String get pdfToLongImages => 'PDF\'den Uzun Görsellere';

  @override
  String get convertSelect => 'Seçileni dönüştür';

  @override
  String get convertAll => 'Tümünü dönüştür';

  @override
  String get searchInFile => 'Dosyada ara';

  @override
  String get language => 'Dil';

  @override
  String get thisActionCanContainAds => 'Bu işlem reklam içerebilir';

  @override
  String get next => 'Sonraki';

  @override
  String get thank => 'Teşekkürler!';

  @override
  String get start => 'Başla';

  @override
  String get go => 'Git';

  @override
  String get permission => 'İzin';

  @override
  String get rate => 'Değerlendir';

  @override
  String get share => 'Paylaş';

  @override
  String get policy => 'Gizlilik Politikası';

  @override
  String get rateUs => 'Bizi değerlendir';

  @override
  String get setting => 'Ayarlar';

  @override
  String get unexpectedError => 'Beklenmeyen bir hata oluştu!';

  @override
  String get alreadyOwnError =>
      'Görünüşe göre bu öğeye zaten sahipsiniz.\nDevam etmek için \'Satın Almayı Geri Yükle\'ye tıklayın.';

  @override
  String get confirm => 'Onayla';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get backToHomescreen => 'Ana ekrana dön';

  @override
  String get exitApp => 'Uygulamadan çık';

  @override
  String get areYouSureYouWantToExitApp =>
      'Uygulamadan çıkmak istediğinizden emin misiniz?';

  @override
  String get pleaseSelectLanguage => 'Devam etmek için bir dil seçin';

  @override
  String get allDocumentsViewer => 'Tüm Belgeleri Görüntüleyici';

  @override
  String get onboardingTitle1 => 'Tüm belgeleri okuyun';

  @override
  String get onboardingTitle2 => 'Herhangi bir belgeyi anında anlayın';

  @override
  String get onboardingTitle3 => 'PDF’leri profesyonelce düzenleyin';

  @override
  String get onboardingContent1 =>
      'PDF, Word, Excel, PPT dosyalarını hızlı ve sorunsuz açın';

  @override
  String get onboardingContent2 =>
      'Dosyaları yapay zeka ile saniyeler içinde çevirin ve özetleyin';

  @override
  String get onboardingContent3 =>
      'PDF’leri kolayca vurgulayın, not alın, imzalayın ve düzenleyin';

  @override
  String get requirePermission =>
      'Belge görüntüleyiciyi kullanabilmek için izin gereklidir!';

  @override
  String get goToSetting => 'Ayarlar\'a Git';

  @override
  String get storage => 'Depolama';

  @override
  String get camera => 'Kamera';

  @override
  String get grantPermission => 'İzni Daha Sonra Ver';

  @override
  String get continuePer => 'Devam Et';

  @override
  String get cancel => 'İptal';

  @override
  String get ok => 'Tamam';

  @override
  String get save => 'Kaydet';

  @override
  String get exit => 'Çıkış';

  @override
  String get doYouWantExitApp => 'Uygulamadan çıkmak istiyor musunuz?';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get document => 'Belge';

  @override
  String get recent => 'Son Kullanılanlar';

  @override
  String get bookmark => 'Yer İmleri';

  @override
  String get searchOnAllDocumentsViewer => 'Tüm Belgelerde Ara';

  @override
  String get mergePDF => 'PDF Birleştir';

  @override
  String get splitPDF => 'PDF Böl';

  @override
  String get unlockPDF => 'PDF Kilidini Aç';

  @override
  String get lockPDF => 'PDF Kilitle';

  @override
  String get scanPDF => 'PDF Tara';

  @override
  String get pDFToImage => 'PDF\'yi Görsele Dönüştür';

  @override
  String get documentTool => 'Belge Araçları';

  @override
  String get documentReader => 'Belge Okuyucu';

  @override
  String sumFiles(int count) {
    return '$count dosya';
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
  String get image => 'Görsel';

  @override
  String get doYouLikeTheApp => 'Uygulamayı beğendiniz mi?';

  @override
  String get rate5 => 'Bayıldım!';

  @override
  String get rate4 => 'Harika!';

  @override
  String get rate3 => 'Güzel!';

  @override
  String get rate2 => 'Daha iyi olabilir!';

  @override
  String get rate1 => 'Beğenmedim!';

  @override
  String get notNow => 'Şimdi değil';

  @override
  String get print => 'Yazdır';

  @override
  String get renameFile => 'Dosya Adını Değiştir';

  @override
  String get pdfConverter => 'PDF Dönüştürücü';

  @override
  String get deleteFromDevice => 'Cihazdan Sil';

  @override
  String get fileName => 'Dosya Adı';

  @override
  String get storagePath => 'Depolama Yolu';

  @override
  String get lastView => 'Son Görüntüleme';

  @override
  String get lastModified => 'Son Değişiklik';

  @override
  String get size => 'Boyut';

  @override
  String get rename => 'Yeniden Adlandır';

  @override
  String get all => 'Tümü';

  @override
  String get fileNameCannotBeEmpty => 'Dosya adı boş olamaz';

  @override
  String get pleaseEnterFileName => 'Lütfen dosya adını girin';

  @override
  String get today => 'Bugün';

  @override
  String get yesterday => 'Dün';

  @override
  String get last7Day => 'Son 7 Gün';

  @override
  String get monthAgo => 'Bir Ay Önce';

  @override
  String get delete => 'Sil';

  @override
  String get deleteIt => 'Silmek istediğinizden emin misiniz?';

  @override
  String fileSelected(Object count) {
    return '$count dosya seçildi';
  }

  @override
  String get exitAndDiscard =>
      'Çıkmak ve değişiklikleri iptal etmek istiyor musunuz?';

  @override
  String get files => 'Dosyalar';

  @override
  String get discard => 'İptal et';

  @override
  String get redOption => 'Kırmızı';

  @override
  String get greenOption => 'Yeşil';

  @override
  String get blueOption => 'Mavi';

  @override
  String get displayP3HexColor => 'P3 Onaltılık Renk Göster #';

  @override
  String get colorsOption => 'Renkler';

  @override
  String get gridOption => 'Izgara';

  @override
  String get spectrumOption => 'Spektrum';

  @override
  String get slidersOption => 'Kaydırıcılar';

  @override
  String get opacityOption => 'Opaklık';

  @override
  String get fontSize => ' Yazı tipi boyutu:';

  @override
  String get aToz => 'A\'dan Z\'ye';

  @override
  String get zToa => 'Z\'den A\'ya';

  @override
  String get newToOld => 'En yeni önce';

  @override
  String get oldToNew => 'En eski önce';

  @override
  String get smallToLarge => 'Küçükten büyüğe';

  @override
  String get largeToSmall => 'Büyükten küçüğe';

  @override
  String get title => 'Başlık';

  @override
  String get time => 'Zaman';

  @override
  String get open => 'Aç';

  @override
  String get empty => 'Boş';

  @override
  String get goHome => 'Ana Sayfaya Git';

  @override
  String get merge => 'Birlestir';

  @override
  String get success => 'Başarılı';

  @override
  String get split => 'Böl';

  @override
  String get remove => 'Kaldır';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get sortBy => 'Sırala';

  @override
  String get removePwTo =>
      'Bu dosyanın korumasını kaldırmak için parolayı girin';

  @override
  String get setPwTo => 'PDF dosyanızı korumak için bir parola oluşturun.';

  @override
  String get setPassword => 'Parola Ayarla';

  @override
  String get removePassword => 'Parolayı Kaldır';

  @override
  String get longImages => 'Uzun Görseller';

  @override
  String get separateImages => 'Ayrı Görseller';

  @override
  String get unknownError => 'Bilinmeyen hata';

  @override
  String get pdfToImages => 'PDF\'den Görsellere';

  @override
  String get exportImageSuccess => 'Görsel başarıyla dışa aktarıldı!';

  @override
  String get lockPdfSuccess => 'PDF başarıyla kilitlendi!';

  @override
  String get scanPdfSuccess => 'PDF başarıyla tarandı!';

  @override
  String get mergePdfSuccess => 'PDF başarıyla birleştirildi!';

  @override
  String get editPdfSuccess => 'PDF başarıyla düzenlendi!';

  @override
  String get allDoc => 'Tüm Belgeleri Görüntüle';

  @override
  String get splitSuccess => 'PDF başarıyla bölündü!';

  @override
  String get enterPassword => 'Parolayı girin';

  @override
  String get enterThePassword => 'Bu dosyayı açmak için şifreyi girin';

  @override
  String get password => 'Parola';

  @override
  String get wrongPassword => 'Yanlış parola, tekrar deneyin';

  @override
  String passwordProtected(Object path) {
    return '$path parola ile korunmaktadır';
  }

  @override
  String get unlockPdfSuccess => 'PDF başarıyla kilit açıldı!';

  @override
  String get search => 'Ara';

  @override
  String get errorCharacter =>
      'Girdi özel karakterler içeriyor veya boş. Lütfen geçerli bir metin girin.';

  @override
  String get cameraReqPermission =>
      'PDF taramak için kamera erişim izni gereklidir';

  @override
  String get storageReqPermission =>
      'Tüm dosyaları görüntülemek için depolama erişim izni gereklidir';

  @override
  String get reqPermission => 'İzin iste';

  @override
  String get underline => 'Altı Çizili';

  @override
  String get brush => 'Fırça';

  @override
  String get highlight => 'Vurgulama';

  @override
  String get strikethrough => 'Üstü Çizili';

  @override
  String get anError => 'Bir hata oluştu: ';

  @override
  String get errorUpdatePw => 'PDF parolasını güncelleme hatası: ';

  @override
  String get noDocumentFound => 'Belge bulunamadı';

  @override
  String get sampleFile => 'Örnek Dosya';

  @override
  String get thisSampleFile => 'Bu bir örnek dosyadır';

  @override
  String get developing => 'Geliştirme aşamasında';

  @override
  String get doNotSupport => 'Bu dosya desteklenmiyor';

  @override
  String get uninstall => 'Kaldır';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'Kullanım sırasında hangi sorunlarla karşılaştınız?';

  @override
  String get dontUninstallYet => 'Henüz kaldırmayın';

  @override
  String get stillWantToUninstall => 'Hâlâ kaldırmak istiyor musunuz?';

  @override
  String get difficultToUse => 'Kullanımı zor';

  @override
  String get tooManyAds => 'Çok fazla reklam';

  @override
  String get others => 'Diğer';

  @override
  String get viewFiles => 'Dosyaları Görüntüle';

  @override
  String get unableToReceiveFiles => 'Dosyalar alınamıyor';

  @override
  String get unableToViewTheFile => 'Dosya görüntülenemiyor';

  @override
  String get explore => 'Keşfet';

  @override
  String whyUninstallApp(String appName) {
    return '$appName neden kaldırılıyor?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Lütfen $appName kaldırma nedeninizi girin.';
  }

  @override
  String get tryAgain => 'Tekrar dene';

  @override
  String get setAsDefault => 'Varsayılan olarak ayarla';

  @override
  String get justOnce => 'Sadece bir kez';

  @override
  String get always => 'Her zaman';

  @override
  String get tip => 'İpucu';

  @override
  String get subTip =>
      'Uygulama simgesini bulamazsanız, \'Daha fazla\' veya üç noktaya dokunarak arayın';

  @override
  String get documentViewer => 'Belge Görüntüleyici';

  @override
  String get allowAccess => 'Tüm dosyaları yönetmek için erişime izin ver';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Lütfen $appName uygulamasının tüm dosyalarınıza erişmesine izin verin';
  }

  @override
  String get allowPermission => 'İzne izin ver';

  @override
  String get welcomeTo => 'Hoş geldiniz';

  @override
  String get yourDataRemain => 'Verileriniz gizli kalır';

  @override
  String get weNeedPermission =>
      'Dosyaları verimli bir şekilde yönetmek, görüntülemek ve düzenlemek için \n tüm dosyalara erişim iznine ihtiyacımız var';

  @override
  String get failedToLoadPage => 'Sayfa yüklenemedi';

  @override
  String get savedSuccessfully => 'Başarıyla kaydedildi';

  @override
  String get editPdf => 'PDF\'yi Düzenle';

  @override
  String get textStyle => 'Metin Stili';

  @override
  String get more => 'Daha Fazla';

  @override
  String get searchYourFile => 'Dosyalarınızı arayın';

  @override
  String get select => 'Seç';

  @override
  String imageExported(Object images) {
    return '$images resim dışa aktarıldı';
  }

  @override
  String imagesExported(Object images) {
    return '$images resim dışa aktarıldı';
  }

  @override
  String get openGallery => '\"Galeri\"yi açarak bir dosya bulun';

  @override
  String get tools => 'Araçlar';

  @override
  String get goStatusBar => 'Görüntüleri bulmak için durum çubuğuna gidin';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Lütfen Tüm Belgeler Görüntüleyicisinin\ntüm dosyalarınıza erişmesine izin verin';

  @override
  String get notificationsTurnedOff =>
      'Bildirimler kapalı! Önemli belgeleri kaçırabilirsiniz';

  @override
  String get tapToOpenSettings =>
      'Ayarları açmak ve bildirimleri etkinleştirmek için buraya dokunun';

  @override
  String get later => 'Daha sonra';

  @override
  String get showNotification => 'Bildirimleri göster';

  @override
  String get enableNotification => 'Bildirimleri etkinleştir';

  @override
  String get appName => 'PDF Okuyucu - PDF Görüntüleyici';

  @override
  String get toViewYourFiles => 'Dosyalarınızı görüntülemek için lütfen';

  @override
  String get withAccessToThem => 'erişim izni verin';

  @override
  String get languageOptions => 'Dil Seçenekleri';

  @override
  String get toContinuePleaseGrant => 'Devam etmek için lütfen izin verin';

  @override
  String get acceptToYourFile => 'dosyalarınıza erişim.';

  @override
  String get apply => 'Uygula';

  @override
  String get other => 'Diğer';

  @override
  String get startNow => 'Şimdi başla';

  @override
  String get page => 'Sayfa';

  @override
  String get goToPage => 'Sayfaya git';

  @override
  String get pageNumber => 'Sayfa numarası';

  @override
  String enterPageNumber(int start, int end) {
    return 'Sayfa numarasını girin ($start - $end)';
  }

  @override
  String get invalid => 'Geçersiz';
}
