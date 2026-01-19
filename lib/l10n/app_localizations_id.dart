// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get saveToAlbum => 'Simpan ke album';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Berhasil menyimpan $count gambar',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Membagikan file ini melalui $appName – sangat mudah untuk dilihat dan diedit. Coba di sini: $value';
  }

  @override
  String get searchInPdf =>
      'Cari di <b><span style=\'color:#E01621\'>PDF Reader</span></b>';

  @override
  String get searchInDoc =>
      'Cari di <b><span style=\'color:#2979FF\'>DOC Reader</span></b>';

  @override
  String get searchInExcel =>
      'Cari di <b><span style=\'color:#388E3C\'>XLS Reader</span></b>';

  @override
  String get searchInPpt =>
      'Cari di <b><span style=\'color:#F2590C\'>PPT Reader</span></b>';

  @override
  String get unSelect => 'Batalkan pilihan';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value file',
      one: '1 file',
      zero: 'Tidak ada file',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Ringkasan sedang diproses';

  @override
  String get translationProgress => 'Terjemahan sedang diproses';

  @override
  String get tryAnotherFile =>
      'Tidak dapat menggabungkan file ini. Coba pilih file lain untuk melanjutkan.';

  @override
  String get result => 'Hasil';

  @override
  String get scroll => 'Gulir';

  @override
  String get giveFeedback => 'Beri saya umpan balik';

  @override
  String get add => 'Tambah';

  @override
  String get selectText => 'Pilih teks';

  @override
  String get pleaseDoNot => 'Silakan jangan sertakan karakter beraksen';

  @override
  String get pleaseEnter => 'Silakan masukkan beberapa teks';

  @override
  String get watermark => 'Tanda air';

  @override
  String get enterText => 'Masukkan teks';

  @override
  String get color => 'Warna';

  @override
  String get addText => 'Tambahkan teks';

  @override
  String get addWatermark => 'Tambahkan tanda air';

  @override
  String get watermarkContent => 'Konten tanda air';

  @override
  String get editSuccess => 'Berhasil diedit!';

  @override
  String get signature => 'Tanda tangan';

  @override
  String get noSignature => 'Tidak ada tanda tangan';

  @override
  String get createSignature => 'Buat tanda tangan baru';

  @override
  String get feedbackTitle => 'Masukan tentang Asisten AI';

  @override
  String get feedbackTo => 'Kepada: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'Subjek: Masukan tentang “PDF Reader & Photo to PDF”.';

  @override
  String get feedbackHint => 'Tulis masukan Anda di sini...';

  @override
  String get feedbackButton => 'Kirim Masukan';

  @override
  String get feedbackEmptyMessage =>
      'Silakan tulis masukan Anda terlebih dahulu';

  @override
  String get feedbackSuccessMessage =>
      'Masukan dikirim (atau aplikasi email dibuka)';

  @override
  String get feedbackErrorMessage => 'Tidak dapat membuka aplikasi email';

  @override
  String get downloadSuccess => 'Berhasil diunduh!';

  @override
  String get noTranslate => 'Tidak ada konten terjemahan yang tersedia.';

  @override
  String get keyPoint => 'Poin Utama:';

  @override
  String get conclusion => 'Kesimpulan';

  @override
  String get summary => 'Ringkasan';

  @override
  String get type => 'Tipe';

  @override
  String get preview => 'Pratinjau';

  @override
  String get startTranslate => 'Mulai Terjemahan';

  @override
  String get startSummary => 'Mulai Ringkasan';

  @override
  String get translateTo => 'Terjemahkan Ke';

  @override
  String get summaryStyle => 'Gaya Ringkasan';

  @override
  String get selectPage => 'Pilih halaman';

  @override
  String get startAISummary => 'Mulai Ringkasan AI';

  @override
  String get startAITranslate => 'Mulai Terjemahan AI';

  @override
  String get aIAssistant => 'Asisten AI';

  @override
  String get aITranslate => 'Terjemahan AI';

  @override
  String get aISummary => 'Ringkasan AI';

  @override
  String get ai_translate_description =>
      '<b>Terjemahkan dokumen secara instan dengan AI.\n</b> Cukup satu ketukan untuk mengubah seluruh PDF Anda ke bahasa lain—akurat, alami, dan tanpa usaha.';

  @override
  String get ai_summary_description =>
      '<b>Pahami dokumen lebih cepat dengan Ringkasan AI.\n</b> Ubah PDF panjang menjadi ringkasan singkat dan terstruktur dengan AI canggih—dapatkan inti tanpa membaca berlebihan.';

  @override
  String get translate1 => 'Terjemahan seluruh dokumen dalam hitungan detik';

  @override
  String get translate2 => 'Hasil jelas dan alami berkat AI';

  @override
  String get translate3 => 'Mendukung banyak bahasa';

  @override
  String get translate4 => 'Ideal untuk belajar, bekerja, dan bepergian';

  @override
  String get summary1 => 'Ringkasan cepat dengan satu ketukan';

  @override
  String get summary2 => 'Beragam format ringkasan untuk berbagai gaya membaca';

  @override
  String get summary3 => 'Sorotan jelas pada ide-ide terpenting';

  @override
  String get summary4 =>
      'Cocok untuk pelajar, profesional, dan bacaan sehari-hari';

  @override
  String get convertedSuccess => 'Berhasil dikonversi';

  @override
  String get convertPdfSuccess => 'Berhasil dikonversi ke PDF!';

  @override
  String get imageToPdf => 'Gambar ke PDF';

  @override
  String get youCanHold =>
      'Anda dapat menahan dan menyeret untuk memposisikan ulang gambar';

  @override
  String get addImage => 'Tambahkan gambar';

  @override
  String get selectImage => 'Pilih gambar';

  @override
  String get selectLanguage =>
      '<b>Pilih <span style=\'color:#D90000\'>Bahasa</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value hasil',
      one: '1 hasil',
      zero: 'Tidak ada hasil',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'Memuat ($value%)...';
  }

  @override
  String get searchOn => 'Cari di All File Viewer';

  @override
  String get detail => 'Detail';

  @override
  String get fileSize => 'Ukuran file';

  @override
  String get name => 'Nama';

  @override
  String get sign => 'Tanda tangan';

  @override
  String get systemLanguage => 'Bahasa sistem';

  @override
  String get done => 'Selesai';

  @override
  String get guideExportImage =>
      'Buka galeri Anda untuk melihat atau membagikan gambar Anda.';

  @override
  String get textSetDefault =>
      'Jadikan PDF Reader - PDF Viewer default untuk buka cepat.';

  @override
  String get enterPassSelect => 'Masukkan kata sandi untuk memilih file ini.';

  @override
  String get selectThePage =>
      'Pilih halaman yang ingin Anda pisahkan, lalu tahan dan seret untuk menyusunnya ulang.';

  @override
  String get theFastestWay => 'Cara tercepat untuk membuka file Anda';

  @override
  String get neverMiss =>
      'Jangan lewatkan pembaruan penting untuk dokumen Anda.';

  @override
  String get guideMerge => 'Pilih setidaknya 2 file untuk digabungkan.';

  @override
  String get notification => 'Pemberitahuan';

  @override
  String get allowAccessTo => 'Izinkan akses untuk mengelola semua file';

  @override
  String get useDeviceLanguage => 'Gunakan bahasa perangkat';

  @override
  String get previewConvert => 'Pratinjau Konversi';

  @override
  String get download => 'Unduh';

  @override
  String get pdfToLongImages => 'PDF ke Gambar Gulir';

  @override
  String get convertSelect => 'Konversi yang dipilih';

  @override
  String get convertAll => 'Konversi Semua';

  @override
  String get searchInFile => 'Cari dalam file';

  @override
  String get language => 'Bahasa';

  @override
  String get thisActionCanContainAds => 'Tindakan ini dapat berisi iklan';

  @override
  String get next => 'Berikutnya';

  @override
  String get thank => 'Terima kasih!';

  @override
  String get start => 'Mulai';

  @override
  String get go => 'Pergi';

  @override
  String get permission => 'Izin';

  @override
  String get rate => 'Beri rating';

  @override
  String get share => 'Bagikan';

  @override
  String get policy => 'Kebijakan Privasi';

  @override
  String get rateUs => 'Beri kami rating';

  @override
  String get setting => 'Pengaturan';

  @override
  String get unexpectedError => 'Terjadi kesalahan yang tidak terduga!';

  @override
  String get alreadyOwnError =>
      'Sepertinya Anda sudah memiliki item ini.\nSilakan klik \"Pulihkan pembelian\" untuk melanjutkan.';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get backToHomescreen => 'Kembali ke layar utama';

  @override
  String get exitApp => 'Keluar aplikasi';

  @override
  String get areYouSureYouWantToExitApp =>
      'Apakah Anda yakin ingin keluar dari aplikasi?';

  @override
  String get pleaseSelectLanguage => 'Silakan pilih bahasa untuk melanjutkan';

  @override
  String get allDocumentsViewer => 'Penampil Semua Dokumen';

  @override
  String get onboardingTitle1 => 'Baca semua dokumen';

  @override
  String get onboardingTitle2 => 'Pahami dokumen apa pun secara instan';

  @override
  String get onboardingTitle3 => 'Edit PDF seperti profesional';

  @override
  String get onboardingContent1 =>
      'Buka PDF, Word, Excel, PPT dengan cepat dan lancar';

  @override
  String get onboardingContent2 =>
      'Terjemahkan dan ringkas file dengan AI dalam hitungan detik';

  @override
  String get onboardingContent3 =>
      'Sorot, beri catatan, tanda tangan, dan edit PDF dengan mudah';

  @override
  String get requirePermission => 'Penampil Semua Dokumen memerlukan izin!';

  @override
  String get goToSetting => 'Pergi ke pengaturan';

  @override
  String get storage => 'Penyimpanan';

  @override
  String get camera => 'Kamera';

  @override
  String get grantPermission => 'Beri izin nanti';

  @override
  String get continuePer => 'Lanjutkan';

  @override
  String get cancel => 'Batal';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Simpan';

  @override
  String get exit => 'Keluar Aplikasi';

  @override
  String get doYouWantExitApp => 'Apakah Anda ingin keluar dari aplikasi?';

  @override
  String get home => 'Beranda';

  @override
  String get document => 'Dokumen';

  @override
  String get recent => 'Terbaru';

  @override
  String get bookmark => 'Penanda';

  @override
  String get searchOnAllDocumentsViewer => 'Cari di Penampil Semua Dokumen';

  @override
  String get mergePDF => 'Gabungkan PDF';

  @override
  String get splitPDF => 'Pisahkan PDF';

  @override
  String get unlockPDF => 'Buka kunci PDF';

  @override
  String get lockPDF => 'Kunci PDF';

  @override
  String get scanPDF => 'Pindai PDF';

  @override
  String get pDFToImage => 'PDF ke Gambar';

  @override
  String get documentTool => 'Alat Dokumen';

  @override
  String get documentReader => 'Pembaca Dokumen';

  @override
  String sumFiles(int count) {
    return '$count file';
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
  String get image => 'Gambar';

  @override
  String get doYouLikeTheApp => 'Apakah Anda menyukai aplikasi ini?';

  @override
  String get rate5 => 'Suka sekali';

  @override
  String get rate4 => 'Bagus!';

  @override
  String get rate3 => 'Sedih!';

  @override
  String get rate2 => 'Buruk!';

  @override
  String get rate1 => 'Sangat buruk!';

  @override
  String get notNow => 'Nanti saja';

  @override
  String get print => 'Cetak';

  @override
  String get renameFile => 'Ubah nama file';

  @override
  String get pdfConverter => 'Konverter PDF';

  @override
  String get deleteFromDevice => 'Hapus dari perangkat';

  @override
  String get fileName => 'Nama file';

  @override
  String get storagePath => 'Jalur penyimpanan';

  @override
  String get lastView => 'Terakhir dilihat';

  @override
  String get lastModified => 'Terakhir diubah';

  @override
  String get size => 'Ukuran';

  @override
  String get rename => 'Ubah nama';

  @override
  String get all => 'Semua';

  @override
  String get fileNameCannotBeEmpty => 'Nama file tidak boleh kosong';

  @override
  String get pleaseEnterFileName => 'Silakan masukkan nama file';

  @override
  String get today => 'Hari ini';

  @override
  String get yesterday => 'Kemarin';

  @override
  String get last7Day => '7 hari terakhir';

  @override
  String get monthAgo => '1 bulan yang lalu';

  @override
  String get delete => 'Hapus';

  @override
  String get deleteIt => 'Apakah Anda yakin ingin menghapus ini?';

  @override
  String fileSelected(Object count) {
    return '$count file dipilih';
  }

  @override
  String get exitAndDiscard => 'Keluar dan buang perubahan?';

  @override
  String get files => 'file';

  @override
  String get discard => 'Buang';

  @override
  String get redOption => 'MERAH';

  @override
  String get greenOption => 'HIJAU';

  @override
  String get blueOption => 'BIRU';

  @override
  String get displayP3HexColor => 'Tampilkan Warna Hex P3 #';

  @override
  String get colorsOption => 'Warna';

  @override
  String get gridOption => 'Grid';

  @override
  String get spectrumOption => 'Spektrum';

  @override
  String get slidersOption => 'Slider';

  @override
  String get opacityOption => 'Opasitas';

  @override
  String get fontSize => ' Ukuran font:';

  @override
  String get aToz => 'Dari A ke Z';

  @override
  String get zToa => 'Dari Z ke A';

  @override
  String get newToOld => 'Dari baru ke lama';

  @override
  String get oldToNew => 'Dari lama ke baru';

  @override
  String get smallToLarge => 'Dari kecil ke besar';

  @override
  String get largeToSmall => 'Dari besar ke kecil';

  @override
  String get title => 'Judul';

  @override
  String get time => 'Waktu';

  @override
  String get open => 'Buka';

  @override
  String get empty => 'Kosong';

  @override
  String get goHome => 'Kembali ke Beranda';

  @override
  String get merge => 'Gabung';

  @override
  String get success => 'Berhasil';

  @override
  String get split => 'Pisah';

  @override
  String get remove => 'Hapus';

  @override
  String get loading => 'Memuat...';

  @override
  String get sortBy => 'Urutkan berdasarkan';

  @override
  String get removePwTo => 'Hapus kata sandi, file tidak akan lagi dilindungi.';

  @override
  String get setPwTo => 'Atur kata sandi untuk melindungi file PDF Anda.';

  @override
  String get setPassword => 'Atur Kata Sandi';

  @override
  String get removePassword => 'Hapus Kata Sandi';

  @override
  String get longImages => 'Gambar Panjang';

  @override
  String get separateImages => 'Gambar Terpisah';

  @override
  String get unknownError => 'Kesalahan tidak diketahui';

  @override
  String get pdfToImages => 'PDF ke Gambar';

  @override
  String get exportImageSuccess => 'Ekspor Gambar Berhasil!';

  @override
  String get lockPdfSuccess => 'Kunci PDF Berhasil!';

  @override
  String get scanPdfSuccess => 'Pindai PDF Berhasil!';

  @override
  String get mergePdfSuccess => 'PDF berhasil digabung';

  @override
  String get editPdfSuccess => 'PDF berhasil diedit!';

  @override
  String get allDoc => 'Penampil Semua Dokumen';

  @override
  String get splitSuccess => 'PDF berhasil dipisah!';

  @override
  String get enterPassword => 'Masukkan kata sandi';

  @override
  String get enterThePassword => 'Masukkan kata sandi untuk membuka file';

  @override
  String get password => 'Kata Sandi';

  @override
  String get wrongPassword => 'Kata sandi salah, silakan coba lagi';

  @override
  String passwordProtected(Object path) {
    return '$path dilindungi kata sandi';
  }

  @override
  String get unlockPdfSuccess => 'Buka Kunci PDF Berhasil!';

  @override
  String get search => 'Cari';

  @override
  String get errorCharacter =>
      'Masukan mengandung karakter khusus atau kosong. Harap masukkan teks yang valid tanpa karakter khusus.';

  @override
  String get cameraReqPermission =>
      'Akses kamera diperlukan untuk memindai PDF';

  @override
  String get storageReqPermission =>
      'Akses penyimpanan diperlukan untuk melihat semua file';

  @override
  String get reqPermission => 'Minta izin';

  @override
  String get underline => 'Garis Bawah';

  @override
  String get brush => 'Kuas';

  @override
  String get highlight => 'Sorot';

  @override
  String get strikethrough => 'Coret';

  @override
  String get anError => 'Terjadi kesalahan: ';

  @override
  String get errorUpdatePw => 'Kesalahan saat memperbarui kata sandi PDF: ';

  @override
  String get noDocumentFound => 'Tidak ada dokumen ditemukan';

  @override
  String get sampleFile => 'File Contoh';

  @override
  String get thisSampleFile => 'Ini adalah file contoh';

  @override
  String get developing => 'Sedang dikembangkan';

  @override
  String get doNotSupport => 'File ini tidak didukung';

  @override
  String get uninstall => 'Hapus Instalasi';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'Masalah apa yang Anda temui selama penggunaan?';

  @override
  String get dontUninstallYet => 'Jangan hapus instalasi dulu';

  @override
  String get stillWantToUninstall => 'Masih ingin menghapus instalasi?';

  @override
  String get difficultToUse => 'Sulit digunakan';

  @override
  String get tooManyAds => 'Terlalu banyak iklan';

  @override
  String get others => 'Lainnya';

  @override
  String get viewFiles => 'Lihat File';

  @override
  String get unableToReceiveFiles => 'Tidak dapat menerima file';

  @override
  String get unableToViewTheFile => 'Tidak dapat melihat file';

  @override
  String get explore => 'Jelajahi';

  @override
  String whyUninstallApp(String appName) {
    return 'Mengapa menghapus $appName?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Silakan masukkan alasan menghapus $appName.';
  }

  @override
  String get tryAgain => 'Coba lagi';

  @override
  String get setAsDefault => 'Atur sebagai default';

  @override
  String get justOnce => 'Hanya sekali';

  @override
  String get always => 'Selalu';

  @override
  String get tip => 'Tips';

  @override
  String get subTip =>
      'Jika Anda tidak dapat menemukan ikon aplikasi, ketuk \'Lainnya\' atau tiga titik untuk mencarinya';

  @override
  String get documentViewer => 'Penampil Dokumen';

  @override
  String get allowAccess => 'Izinkan akses untuk mengelola semua file';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Harap izinkan $appName untuk mengakses semua file Anda';
  }

  @override
  String get allowPermission => 'Izinkan Izin';

  @override
  String get welcomeTo => 'Selamat datang di';

  @override
  String get yourDataRemain => 'Data Anda tetap pribadi';

  @override
  String get weNeedPermission =>
      'Kami memerlukan izin untuk mengakses semua file untuk \n mengelola, melihat, dan mengatur file secara efisien';

  @override
  String get failedToLoadPage => 'Gagal memuat halaman';

  @override
  String get savedSuccessfully => 'Berhasil disimpan';

  @override
  String get editPdf => 'Edit PDF';

  @override
  String get textStyle => 'Gaya Teks';

  @override
  String get more => 'Lebih';

  @override
  String get searchYourFile => 'Cari file Anda';

  @override
  String get select => 'Pilih';

  @override
  String imageExported(Object images) {
    return '$images gambar diekspor';
  }

  @override
  String imagesExported(Object images) {
    return '$images gambar diekspor';
  }

  @override
  String get openGallery => 'Buka \"Galeri\" untuk menemukan file';

  @override
  String get tools => 'Alat';

  @override
  String get goStatusBar => 'Pergi ke status bar untuk menemukan gambar';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Harap izinkan Semua Penampil Dokumen\nmengakses semua file Anda';

  @override
  String get notificationsTurnedOff =>
      'Notifikasi dimatikan! Anda mungkin melewatkan dokumen penting';

  @override
  String get tapToOpenSettings =>
      'Ketuk di sini untuk membuka pengaturan dan mengaktifkan notifikasi';

  @override
  String get later => 'Nanti';

  @override
  String get showNotification => 'Tampilkan Notifikasi';

  @override
  String get enableNotification => 'Aktifkan Notifikasi';

  @override
  String get appName => 'Pembaca PDF - Penampil PDF';

  @override
  String get toViewYourFiles => 'Untuk melihat file Anda, silakan berikan';

  @override
  String get withAccessToThem => 'akses ke file tersebut';

  @override
  String get languageOptions => 'Opsi Bahasa';

  @override
  String get toContinuePleaseGrant => 'Untuk melanjutkan, silakan berikan';

  @override
  String get acceptToYourFile => 'akses ke file Anda.';

  @override
  String get apply => 'Terapkan';

  @override
  String get other => 'Lainnya';

  @override
  String get startNow => 'Mulai sekarang';

  @override
  String get page => 'Halaman';

  @override
  String get goToPage => 'Pergi ke halaman';

  @override
  String get pageNumber => 'Nomor halaman';

  @override
  String enterPageNumber(int start, int end) {
    return 'Masukkan nomor halaman ($start - $end)';
  }

  @override
  String get invalid => 'Tidak valid';
}
