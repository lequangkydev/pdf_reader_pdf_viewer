// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get saveToAlbum => 'アルバムに保存';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '画像を$count枚保存しました',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return '$appName でこのファイルを共有 – 表示や編集がとても簡単です。こちらで試せます: $value';
  }

  @override
  String get searchInPdf =>
      '<b><span style=\'color:#E01621\'>PDF Reader</span></b> で検索';

  @override
  String get searchInDoc =>
      '<b><span style=\'color:#2979FF\'>DOC Reader</span></b> で検索';

  @override
  String get searchInExcel =>
      '<b><span style=\'color:#388E3C\'>XLS Reader</span></b> で検索';

  @override
  String get searchInPpt =>
      '<b><span style=\'color:#F2590C\'>PPT Reader</span></b> で検索';

  @override
  String get unSelect => '選択を解除';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value ファイル',
      one: '1 ファイル',
      zero: 'ファイルなし',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => '要約を作成中';

  @override
  String get translationProgress => '翻訳を進行中';

  @override
  String get tryAnotherFile => 'このファイルを結合できません。続行するには別のファイルを選択してください。';

  @override
  String get result => '結果';

  @override
  String get scroll => 'スクロール';

  @override
  String get giveFeedback => 'フィードバックを送る';

  @override
  String get add => '追加';

  @override
  String get selectText => 'テキストを選択';

  @override
  String get pleaseDoNot => 'アクセント付き文字を含めないでください';

  @override
  String get pleaseEnter => 'テキストを入力してください';

  @override
  String get watermark => 'ウォーターマーク';

  @override
  String get enterText => 'テキストを入力';

  @override
  String get color => '色';

  @override
  String get addText => 'テキストを追加';

  @override
  String get addWatermark => 'ウォーターマークを追加';

  @override
  String get watermarkContent => 'ウォーターマーク内容';

  @override
  String get editSuccess => '編集に成功しました！';

  @override
  String get signature => '署名';

  @override
  String get noSignature => '署名なし';

  @override
  String get createSignature => '新しい署名を作成';

  @override
  String get feedbackTitle => 'AIアシスタントへのフィードバック';

  @override
  String get feedbackTo => '宛先: kyle@vtn-global.com';

  @override
  String get feedbackSubject => '件名: 「PDF Reader & Photo to PDF」へのフィードバック。';

  @override
  String get feedbackHint => 'ここにフィードバックを入力してください...';

  @override
  String get feedbackButton => 'フィードバックを送信';

  @override
  String get feedbackEmptyMessage => 'まずフィードバックを入力してください';

  @override
  String get feedbackSuccessMessage => 'フィードバックを送信しました（またはメールアプリが開きました）';

  @override
  String get feedbackErrorMessage => 'メールアプリを開けませんでした';

  @override
  String get downloadSuccess => 'ダウンロードに成功しました！';

  @override
  String get noTranslate => '翻訳されたコンテンツはありません。';

  @override
  String get keyPoint => '重要ポイント：';

  @override
  String get conclusion => '結論';

  @override
  String get summary => '要約';

  @override
  String get type => '種類';

  @override
  String get preview => 'プレビュー';

  @override
  String get startTranslate => '翻訳を開始';

  @override
  String get startSummary => '要約を開始';

  @override
  String get translateTo => '翻訳先';

  @override
  String get summaryStyle => '要約スタイル';

  @override
  String get selectPage => 'ページを選択';

  @override
  String get startAISummary => 'AI要約を開始';

  @override
  String get startAITranslate => 'AI翻訳を開始';

  @override
  String get aIAssistant => 'AIアシスタント';

  @override
  String get aITranslate => 'AI翻訳';

  @override
  String get aISummary => 'AI要約';

  @override
  String get ai_translate_description =>
      '<b>AIでドキュメントを瞬時に翻訳。\n</b> ワンタップでPDF全体を別の言語へ変換—正確で自然、そして簡単です。';

  @override
  String get ai_summary_description =>
      '<b>AI要約でドキュメントを素早く理解。\n</b> 強力なAIを使って長いPDFを簡潔で整理された要約に変換し、余分な読書なしで要点を把握できます。';

  @override
  String get translate1 => '数秒で全文ドキュメントを翻訳';

  @override
  String get translate2 => 'AIによる自然で分かりやすい結果';

  @override
  String get translate3 => '複数言語に対応';

  @override
  String get translate4 => '学習・仕事・旅行に最適';

  @override
  String get summary1 => 'ワンタップで素早く要約';

  @override
  String get summary2 => '読書スタイルに合わせた複数の要約形式';

  @override
  String get summary3 => '重要なポイントを明確にハイライト';

  @override
  String get summary4 => '学生、社会人、日常読書に最適';

  @override
  String get convertedSuccess => '変換に成功しました';

  @override
  String get convertPdfSuccess => 'PDFへの変換に成功！';

  @override
  String get imageToPdf => '画像をPDFに';

  @override
  String get youCanHold => '画像を押してドラッグすると位置を変更できます';

  @override
  String get addImage => '画像を追加';

  @override
  String get selectImage => '画像を選択';

  @override
  String get selectLanguage =>
      '<b><span style=\'color:#D90000\'>言語</span>を選択</b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value件の結果',
      one: '1件の結果',
      zero: '結果なし',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return '読み込み中 ($value%)...';
  }

  @override
  String get searchOn => 'All File Viewer で検索';

  @override
  String get detail => '詳細';

  @override
  String get fileSize => 'ファイルサイズ';

  @override
  String get name => '名前';

  @override
  String get sign => '署名';

  @override
  String get systemLanguage => 'システム言語';

  @override
  String get done => '完了';

  @override
  String get guideExportImage => 'ギャラリーを開いて画像を表示または共有しましょう。';

  @override
  String get textSetDefault => 'PDF Reader - PDF Viewer を既定にしてすぐ開けます。';

  @override
  String get enterPassSelect => 'このファイルを選択するにはパスワードを入力してください。';

  @override
  String get selectThePage => '分割したいページを選び、長押ししてドラッグし、並べ替えてください。';

  @override
  String get theFastestWay => 'ファイルを開く最速の方法';

  @override
  String get neverMiss => '大切なドキュメントの重要な更新を見逃さないようにしましょう。';

  @override
  String get guideMerge => '結合するには少なくとも2つのファイルを選択してください。';

  @override
  String get notification => '通知';

  @override
  String get allowAccessTo => 'すべてのファイルを管理するアクセスを許可する';

  @override
  String get useDeviceLanguage => 'デバイスの言語を使用';

  @override
  String get previewConvert => '変換のプレビュー';

  @override
  String get download => 'ダウンロード';

  @override
  String get pdfToLongImages => 'PDFを長い画像に変換';

  @override
  String get convertSelect => '選択を変換';

  @override
  String get convertAll => 'すべて変換';

  @override
  String get searchInFile => 'ファイル内を検索';

  @override
  String get language => '言語';

  @override
  String get thisActionCanContainAds => 'この操作には広告が含まれる可能性があります';

  @override
  String get next => '次へ';

  @override
  String get thank => 'ありがとうございます！';

  @override
  String get start => '開始';

  @override
  String get go => '進む';

  @override
  String get permission => '許可';

  @override
  String get rate => '評価';

  @override
  String get share => '共有';

  @override
  String get policy => 'プライバシーポリシー';

  @override
  String get rateUs => '評価する';

  @override
  String get setting => '設定';

  @override
  String get unexpectedError => '予期しないエラーが発生しました！';

  @override
  String get alreadyOwnError =>
      'このアイテムはすでに所有しているようです。\n「購入を復元」をクリックして続行してください。';

  @override
  String get confirm => '確認';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get backToHomescreen => 'ホーム画面に戻る';

  @override
  String get exitApp => 'アプリを終了';

  @override
  String get areYouSureYouWantToExitApp => 'アプリを終了してもよろしいですか？';

  @override
  String get pleaseSelectLanguage => '続行するには言語を選択してください';

  @override
  String get allDocumentsViewer => 'すべてのドキュメントビューア';

  @override
  String get onboardingTitle1 => 'すべてのドキュメントを読む';

  @override
  String get onboardingTitle2 => 'あらゆるドキュメントを瞬時に理解';

  @override
  String get onboardingTitle3 => 'プロのようにPDFを編集';

  @override
  String get onboardingContent1 => 'PDF、Word、Excel、PPTを高速かつスムーズに開く';

  @override
  String get onboardingContent2 => 'AIでファイルを数秒で翻訳・要約';

  @override
  String get onboardingContent3 => 'PDFを簡単にハイライト、注釈、署名、編集';

  @override
  String get requirePermission => 'すべてのドキュメントビュー\nアには許可が必要です！';

  @override
  String get goToSetting => '設定に移動';

  @override
  String get storage => 'ストレージ';

  @override
  String get camera => 'カメラ';

  @override
  String get grantPermission => '後で許可する';

  @override
  String get continuePer => '続行';

  @override
  String get cancel => 'キャンセル';

  @override
  String get ok => 'OK';

  @override
  String get save => '保存';

  @override
  String get exit => 'アプリを終了';

  @override
  String get doYouWantExitApp => 'アプリを終了しますか？';

  @override
  String get home => 'ホーム';

  @override
  String get document => 'ドキュメント';

  @override
  String get recent => '最近';

  @override
  String get bookmark => 'ブックマーク';

  @override
  String get searchOnAllDocumentsViewer => 'すべてのドキュメントビューアで検索';

  @override
  String get mergePDF => 'PDFを結合';

  @override
  String get splitPDF => 'PDFを分割';

  @override
  String get unlockPDF => 'PDFロック解除';

  @override
  String get lockPDF => 'PDFをロック';

  @override
  String get scanPDF => 'PDFをスキャン';

  @override
  String get pDFToImage => 'PDF画像変換';

  @override
  String get documentTool => 'ドキュメントツール';

  @override
  String get documentReader => 'ドキュメントリーダー';

  @override
  String sumFiles(int count) {
    return '$count ファイル';
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
  String get image => '画像';

  @override
  String get doYouLikeTheApp => 'このアプリが気に入りましたか？';

  @override
  String get rate5 => '大好き';

  @override
  String get rate4 => '素晴らしい！';

  @override
  String get rate3 => '残念！';

  @override
  String get rate2 => '良くない！';

  @override
  String get rate1 => '最悪！';

  @override
  String get notNow => '後で';

  @override
  String get print => '印刷';

  @override
  String get renameFile => 'ファイル名を変更';

  @override
  String get pdfConverter => 'PDFコンバーター';

  @override
  String get deleteFromDevice => 'デバイスから削除';

  @override
  String get fileName => 'ファイル名';

  @override
  String get storagePath => '保存パス';

  @override
  String get lastView => '最後に閲覧';

  @override
  String get lastModified => '最終更新';

  @override
  String get size => 'サイズ';

  @override
  String get rename => '名前を変更';

  @override
  String get all => 'すべて';

  @override
  String get fileNameCannotBeEmpty => 'ファイル名を空にすることはできません';

  @override
  String get pleaseEnterFileName => 'ファイル名を入力してください';

  @override
  String get today => '今日';

  @override
  String get yesterday => '昨日';

  @override
  String get last7Day => '過去7日間';

  @override
  String get monthAgo => '1か月前';

  @override
  String get delete => '削除';

  @override
  String get deleteIt => '本当に削除しますか？';

  @override
  String fileSelected(Object count) {
    return '$count ファイルが選択されました';
  }

  @override
  String get exitAndDiscard => '終了して変更を破棄しますか？';

  @override
  String get files => 'ファイル';

  @override
  String get discard => '破棄';

  @override
  String get redOption => '赤';

  @override
  String get greenOption => '緑';

  @override
  String get blueOption => '青';

  @override
  String get displayP3HexColor => 'P3 16進カラーを表示 #';

  @override
  String get colorsOption => '色';

  @override
  String get gridOption => 'グリッド';

  @override
  String get spectrumOption => 'スペクトル';

  @override
  String get slidersOption => 'スライダー';

  @override
  String get opacityOption => '不透明度';

  @override
  String get fontSize => ' フォントサイズ:';

  @override
  String get aToz => 'AからZへ';

  @override
  String get zToa => 'ZからAへ';

  @override
  String get newToOld => '新しい順';

  @override
  String get oldToNew => '古い順';

  @override
  String get smallToLarge => '小さい順';

  @override
  String get largeToSmall => '大きい順';

  @override
  String get title => 'タイトル';

  @override
  String get time => '時間';

  @override
  String get open => '開く';

  @override
  String get empty => '空';

  @override
  String get goHome => 'ホームへ戻る';

  @override
  String get merge => '結合';

  @override
  String get success => '成功';

  @override
  String get split => '分割';

  @override
  String get remove => '削除';

  @override
  String get loading => '読み込み中...';

  @override
  String get sortBy => '並び替え';

  @override
  String get removePwTo => 'パスワードを削除すると、ファイルは保護されなくなります。';

  @override
  String get setPwTo => 'PDFファイルを保護するためのパスワードを設定してください。';

  @override
  String get setPassword => 'パスワードを設定';

  @override
  String get removePassword => 'パスワードを削除';

  @override
  String get longImages => '長い画像';

  @override
  String get separateImages => '分割画像';

  @override
  String get unknownError => '不明なエラー';

  @override
  String get pdfToImages => 'PDF画像変換';

  @override
  String get exportImageSuccess => '画像のエクスポートに成功しました！';

  @override
  String get lockPdfSuccess => 'PDFのロックに成功しました！';

  @override
  String get scanPdfSuccess => 'PDFのスキャンに成功しました！';

  @override
  String get mergePdfSuccess => 'PDFの結合に成功しました！';

  @override
  String get editPdfSuccess => 'PDFの編集に成功しました！';

  @override
  String get allDoc => 'すべてのドキュメントビューア';

  @override
  String get splitSuccess => 'PDFの分割に成功しました！';

  @override
  String get enterPassword => 'パスワードを入力';

  @override
  String get enterThePassword => 'ファイルを開くためのパスワードを入力してください';

  @override
  String get password => 'パスワード';

  @override
  String get wrongPassword => 'パスワードが間違っています。もう一度お試しください。';

  @override
  String passwordProtected(Object path) {
    return '$path はパスワードで保護されています';
  }

  @override
  String get unlockPdfSuccess => 'PDFのロック解除に成功しました！';

  @override
  String get search => '検索';

  @override
  String get errorCharacter => '入力に特殊文字が含まれているか、空欄です。有効なテキストを特殊文字なしで入力してください。';

  @override
  String get cameraReqPermission => 'PDFをスキャンするにはカメラのアクセスが必要です';

  @override
  String get storageReqPermission => 'すべてのファイルを表示するにはストレージのアクセスが必要です';

  @override
  String get reqPermission => '権限をリクエスト';

  @override
  String get underline => '下線';

  @override
  String get brush => 'ブラシ';

  @override
  String get highlight => 'ハイライト';

  @override
  String get strikethrough => '取り消し線';

  @override
  String get anError => 'エラーが発生しました: ';

  @override
  String get errorUpdatePw => 'PDFのパスワード更新エラー: ';

  @override
  String get noDocumentFound => 'ドキュメントが見つかりません';

  @override
  String get sampleFile => 'サンプルファイル';

  @override
  String get thisSampleFile => 'これはサンプルファイルです';

  @override
  String get developing => '開発中';

  @override
  String get doNotSupport => 'このファイルはサポートされていません';

  @override
  String get uninstall => 'アンインストール';

  @override
  String get whatProblemsYouEncounterDuringUse => '使用中にどのような問題が発生しましたか？';

  @override
  String get dontUninstallYet => 'まだアンインストールしないでください';

  @override
  String get stillWantToUninstall => '本当にアンインストールしますか？';

  @override
  String get difficultToUse => '使いにくい';

  @override
  String get tooManyAds => '広告が多すぎる';

  @override
  String get others => 'その他';

  @override
  String get viewFiles => 'ファイルを表示';

  @override
  String get unableToReceiveFiles => 'ファイルを受信できません';

  @override
  String get unableToViewTheFile => 'ファイルを表示できません';

  @override
  String get explore => '探索';

  @override
  String whyUninstallApp(String appName) {
    return 'なぜ$appNameをアンインストールするのですか？';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return '$appNameをアンインストールする理由を入力してください。';
  }

  @override
  String get tryAgain => 'もう一度試してください';

  @override
  String get setAsDefault => 'デフォルトに設定';

  @override
  String get justOnce => '1回のみ';

  @override
  String get always => '常に';

  @override
  String get tip => 'ヒント';

  @override
  String get subTip => 'アプリアイコンが見つからない場合は、「その他」または3つの点をタップして検索してください';

  @override
  String get documentViewer => 'ドキュメントビューア';

  @override
  String get allowAccess => 'すべてのファイルを管理するためにアクセスを許可';

  @override
  String pleaseAllowAll(Object appName) {
    return '$appName にすべてのファイルへのアクセスを許可してください';
  }

  @override
  String get allowPermission => '権限を許可';

  @override
  String get welcomeTo => 'ようこそ';

  @override
  String get yourDataRemain => 'あなたのデータはプライベートのままです';

  @override
  String get weNeedPermission =>
      'ファイルを効率的に管理、表示、整理するために\n すべてのファイルへのアクセス許可が必要です';

  @override
  String get failedToLoadPage => 'ページの読み込みに失敗しました';

  @override
  String get savedSuccessfully => '正常に保存されました';

  @override
  String get editPdf => 'PDFを編集';

  @override
  String get textStyle => 'テキストスタイル';

  @override
  String get more => 'もっと見る';

  @override
  String get searchYourFile => 'ファイルを検索';

  @override
  String get select => '選択';

  @override
  String imageExported(Object images) {
    return '$images 件の画像をエクスポートしました';
  }

  @override
  String imagesExported(Object images) {
    return '$images 件の画像をエクスポートしました';
  }

  @override
  String get openGallery => 'ファイルを探すには「ギャラリー」を開いてください';

  @override
  String get tools => 'ツール';

  @override
  String get goStatusBar => '画像を見つけるにはステータスバーに移動してください';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'すべてのドキュメントビューアが\nすべてのファイルにアクセスできるようにしてください';

  @override
  String get notificationsTurnedOff => '通知がオフになっています！重要なドキュメントを見逃す可能性があります';

  @override
  String get tapToOpenSettings => 'ここをタップして設定を開き、通知を有効にしてください';

  @override
  String get later => 'あとで';

  @override
  String get showNotification => '通知を表示';

  @override
  String get enableNotification => '通知を有効にする';

  @override
  String get appName => 'PDFリーダー - PDFビューア';

  @override
  String get toViewYourFiles => 'ファイルを表示するには、次を許可してください:';

  @override
  String get withAccessToThem => 'アクセス権';

  @override
  String get languageOptions => '言語オプション';

  @override
  String get toContinuePleaseGrant => '続行するには、許可を与えてください';

  @override
  String get acceptToYourFile => 'ファイルへのアクセス。';

  @override
  String get apply => '適用';

  @override
  String get other => 'その他';

  @override
  String get startNow => '今すぐ始める';

  @override
  String get page => 'ページ';

  @override
  String get goToPage => 'ページに移動';

  @override
  String get pageNumber => 'ページ番号';

  @override
  String enterPageNumber(int start, int end) {
    return 'ページ番号を入力してください ($start - $end)';
  }

  @override
  String get invalid => '無効';
}
