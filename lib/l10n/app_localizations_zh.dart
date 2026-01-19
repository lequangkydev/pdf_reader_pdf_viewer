// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get saveToAlbum => '儲存到相簿';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已儲存 $count 張圖片',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return '透過 $appName 分享此檔案——檢視與編輯都非常輕鬆。你可以在這裡試用：$value';
  }

  @override
  String get searchInPdf =>
      '在 <b><span style=\'color:#E01621\'>PDF 閱讀器</span></b> 中搜尋';

  @override
  String get searchInDoc =>
      '在 <b><span style=\'color:#2979FF\'>DOC 閱讀器</span></b> 中搜尋';

  @override
  String get searchInExcel =>
      '在 <b><span style=\'color:#388E3C\'>XLS 閱讀器</span></b> 中搜尋';

  @override
  String get searchInPpt =>
      '在 <b><span style=\'color:#F2590C\'>PPT 閱讀器</span></b> 中搜尋';

  @override
  String get unSelect => '取消選取';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value 個文件',
      one: '1 個文件',
      zero: '沒有文件',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => '摘要生成中';

  @override
  String get translationProgress => '翻譯進行中';

  @override
  String get tryAnotherFile => '無法合併此檔案。請嘗試選擇其他檔案以繼續。';

  @override
  String get result => '結果';

  @override
  String get scroll => '捲動';

  @override
  String get giveFeedback => '給我回饋';

  @override
  String get add => '新增';

  @override
  String get selectText => '選擇文字';

  @override
  String get pleaseDoNot => '請勿包含重音或特殊符號';

  @override
  String get pleaseEnter => '請輸入文字';

  @override
  String get watermark => '浮水印';

  @override
  String get enterText => '輸入文字';

  @override
  String get color => '顏色';

  @override
  String get addText => '新增文字';

  @override
  String get addWatermark => '新增浮水印';

  @override
  String get watermarkContent => '浮水印內容';

  @override
  String get editSuccess => '編輯成功！';

  @override
  String get signature => '簽名';

  @override
  String get noSignature => '無簽名';

  @override
  String get createSignature => '建立新簽名';

  @override
  String get feedbackTitle => '關於 AI 助手的回饋';

  @override
  String get feedbackTo => '收件人：kyle@vtn-global.com';

  @override
  String get feedbackSubject => '主旨：「PDF Reader & Photo to PDF」的回饋';

  @override
  String get feedbackHint => '請在此輸入您的回饋內容...';

  @override
  String get feedbackButton => '送出回饋';

  @override
  String get feedbackEmptyMessage => '請先輸入您的回饋內容';

  @override
  String get feedbackSuccessMessage => '回饋已送出（或已開啟郵件應用程式）';

  @override
  String get feedbackErrorMessage => '無法開啟郵件應用程式';

  @override
  String get downloadSuccess => '下載成功！';

  @override
  String get noTranslate => '沒有可用的翻譯內容。';

  @override
  String get keyPoint => '重點：';

  @override
  String get conclusion => '結論';

  @override
  String get summary => '摘要';

  @override
  String get type => '類型';

  @override
  String get preview => '預覽';

  @override
  String get startTranslate => '開始翻譯';

  @override
  String get startSummary => '開始摘要';

  @override
  String get translateTo => '翻譯成';

  @override
  String get summaryStyle => '摘要樣式';

  @override
  String get selectPage => '選擇頁面';

  @override
  String get startAISummary => '開始 AI 摘要';

  @override
  String get startAITranslate => '開始 AI 翻譯';

  @override
  String get aIAssistant => 'AI 助手';

  @override
  String get aITranslate => 'AI 翻譯';

  @override
  String get aISummary => 'AI 摘要';

  @override
  String get ai_translate_description =>
      '<b>使用 AI 即時翻譯文件。\n</b> 只需輕點一下，即可將整個 PDF 精準且自然地轉換為其他語言。';

  @override
  String get ai_summary_description =>
      '<b>透過 AI 摘要更快理解文件。\n</b> 利用強大的 AI，將冗長的 PDF 轉換為精簡且結構清楚的摘要。';

  @override
  String get translate1 => '數秒內完成整份文件翻譯';

  @override
  String get translate2 => 'AI 驅動的自然翻譯結果';

  @override
  String get translate3 => '支援多種語言';

  @override
  String get translate4 => '適合學習、工作與旅行';

  @override
  String get summary1 => '一鍵快速摘要';

  @override
  String get summary2 => '多種摘要格式，適合不同閱讀風格';

  @override
  String get summary3 => '清楚標示最重要的重點內容';

  @override
  String get summary4 => '非常適合學者、專業人士與日常閱讀';

  @override
  String get convertedSuccess => '轉換成功';

  @override
  String get convertPdfSuccess => '成功轉換為 PDF！';

  @override
  String get imageToPdf => '圖片轉 PDF';

  @override
  String get youCanHold => '可按住並拖曳以重新排列圖片';

  @override
  String get addImage => '新增圖片';

  @override
  String get selectImage => '選擇圖片';

  @override
  String get selectLanguage =>
      '<b>選擇 <span style=\'color:#D90000\'>語言</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value 個結果',
      one: '1 個結果',
      zero: '沒有結果',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return '正在加载 ($value%)...';
  }

  @override
  String get searchOn => '在 All File Viewer 中搜索';

  @override
  String get detail => '详情';

  @override
  String get fileSize => '文件大小';

  @override
  String get name => '名称';

  @override
  String get sign => '签名';

  @override
  String get systemLanguage => '系统语言';

  @override
  String get done => '完成';

  @override
  String get guideExportImage => '打開圖庫以查看或分享您的圖片。';

  @override
  String get textSetDefault => '将 PDF Reader - PDF Viewer 设为默认，立即打开。';

  @override
  String get enterPassSelect => '请输入密码以选择此文件。';

  @override
  String get selectThePage => '选择要拆分的页面，长按并拖动以重新排序。';

  @override
  String get theFastestWay => '打开文件最快的方法';

  @override
  String get neverMiss => '绝不错过文档的重要更新。';

  @override
  String get guideMerge => '请选择至少两个要合并的文件。';

  @override
  String get notification => '通知';

  @override
  String get allowAccessTo => '允许访问以管理所有文件';

  @override
  String get useDeviceLanguage => '使用设备语言';

  @override
  String get previewConvert => '預覽轉換';

  @override
  String get download => '下載';

  @override
  String get pdfToLongImages => 'PDF 轉為長圖';

  @override
  String get convertSelect => '轉換所選項';

  @override
  String get convertAll => '全部轉換';

  @override
  String get searchInFile => '在檔案中搜尋';

  @override
  String get language => '語言';

  @override
  String get thisActionCanContainAds => '此操作可能包含廣告';

  @override
  String get next => '下一步';

  @override
  String get thank => '感謝！';

  @override
  String get start => '開始';

  @override
  String get go => '前往';

  @override
  String get permission => '權限';

  @override
  String get rate => '評價';

  @override
  String get share => '分享';

  @override
  String get policy => '隱私政策';

  @override
  String get rateUs => '為我們評分';

  @override
  String get setting => '設定';

  @override
  String get unexpectedError => '發生意外錯誤！';

  @override
  String get alreadyOwnError => '您似乎已經擁有此項目。\n請點擊 \'恢復購買\' 以繼續。';

  @override
  String get confirm => '確認';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get backToHomescreen => '返回主畫面';

  @override
  String get exitApp => '退出應用程式';

  @override
  String get areYouSureYouWantToExitApp => '您確定要退出應用程式嗎？';

  @override
  String get pleaseSelectLanguage => '請選擇語言以繼續';

  @override
  String get allDocumentsViewer => '所有文件檢視器';

  @override
  String get onboardingTitle1 => '閱讀所有文件';

  @override
  String get onboardingTitle2 => '即時理解任何文件';

  @override
  String get onboardingTitle3 => '像專業人士一樣編輯 PDF';

  @override
  String get onboardingContent1 => '快速且流暢地開啟 PDF、Word、Excel、PPT';

  @override
  String get onboardingContent2 => '使用 AI 在幾秒鐘內翻譯並摘要文件';

  @override
  String get onboardingContent3 => '輕鬆標註、註解、簽署與編輯 PDF';

  @override
  String get requirePermission => '需要權限才能使用文件檢視器！';

  @override
  String get goToSetting => '前往設定';

  @override
  String get storage => '儲存';

  @override
  String get camera => '相機';

  @override
  String get grantPermission => '稍後授權';

  @override
  String get continuePer => '繼續';

  @override
  String get cancel => '取消';

  @override
  String get ok => '确定';

  @override
  String get save => '儲存';

  @override
  String get exit => '退出';

  @override
  String get doYouWantExitApp => '您確定要退出應用程式嗎？';

  @override
  String get home => '首頁';

  @override
  String get document => '文件';

  @override
  String get recent => '最近';

  @override
  String get bookmark => '書籤';

  @override
  String get searchOnAllDocumentsViewer => '搜尋所有文件';

  @override
  String get mergePDF => '合併 PDF';

  @override
  String get splitPDF => '拆分 PDF';

  @override
  String get unlockPDF => '解鎖 PDF';

  @override
  String get lockPDF => '加密 PDF';

  @override
  String get scanPDF => '掃描 PDF';

  @override
  String get pDFToImage => 'PDF 轉圖片';

  @override
  String get documentTool => '文件工具';

  @override
  String get documentReader => '文件閱讀器';

  @override
  String sumFiles(int count) {
    return '$count 個文件';
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
  String get image => '圖片';

  @override
  String get doYouLikeTheApp => '您喜歡這款應用程式嗎？';

  @override
  String get rate5 => '超喜歡！';

  @override
  String get rate4 => '很棒！';

  @override
  String get rate3 => '不錯！';

  @override
  String get rate2 => '還可以！';

  @override
  String get rate1 => '不喜歡！';

  @override
  String get notNow => '暫不評分';

  @override
  String get print => '列印';

  @override
  String get renameFile => '重新命名文件';

  @override
  String get pdfConverter => 'PDF 轉換工具';

  @override
  String get deleteFromDevice => '從裝置中刪除';

  @override
  String get fileName => '文件名稱';

  @override
  String get storagePath => '存儲路徑';

  @override
  String get lastView => '最近檢視';

  @override
  String get lastModified => '最後修改';

  @override
  String get size => '大小';

  @override
  String get rename => '重新命名';

  @override
  String get all => '全部';

  @override
  String get fileNameCannotBeEmpty => '文件名稱不能為空';

  @override
  String get pleaseEnterFileName => '請輸入文件名稱';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get last7Day => '最近 7 天';

  @override
  String get monthAgo => '一個月前';

  @override
  String get delete => '刪除';

  @override
  String get deleteIt => '您確定要刪除嗎？';

  @override
  String fileSelected(Object count) {
    return '已選擇 $count 個文件';
  }

  @override
  String get exitAndDiscard => '您確定要退出並放棄更改嗎？';

  @override
  String get files => '文件';

  @override
  String get discard => '放棄';

  @override
  String get redOption => '紅色';

  @override
  String get greenOption => '綠色';

  @override
  String get blueOption => '藍色';

  @override
  String get displayP3HexColor => '顯示 P3 十六進制顏色 #';

  @override
  String get colorsOption => '顏色';

  @override
  String get gridOption => '網格';

  @override
  String get spectrumOption => '光譜';

  @override
  String get slidersOption => '滑桿';

  @override
  String get opacityOption => '不透明度';

  @override
  String get fontSize => '字體大小：';

  @override
  String get aToz => '從 A 到 Z';

  @override
  String get zToa => '從 Z 到 A';

  @override
  String get newToOld => '從新到舊';

  @override
  String get oldToNew => '從舊到新';

  @override
  String get smallToLarge => '從小到大';

  @override
  String get largeToSmall => '從大到小';

  @override
  String get title => '標題';

  @override
  String get time => '時間';

  @override
  String get open => '打開';

  @override
  String get empty => '空的';

  @override
  String get goHome => '回到主頁';

  @override
  String get merge => '合併';

  @override
  String get success => '成功';

  @override
  String get split => '分割';

  @override
  String get remove => '移除';

  @override
  String get loading => '載入中...';

  @override
  String get sortBy => '排序方式';

  @override
  String get removePwTo => '移除密碼，該文件將不再受保護。';

  @override
  String get setPwTo => '設置密碼以保護您的 PDF 文件。';

  @override
  String get setPassword => '設置密碼';

  @override
  String get removePassword => '移除密碼';

  @override
  String get longImages => '長圖';

  @override
  String get separateImages => '分離圖片';

  @override
  String get unknownError => '未知錯誤';

  @override
  String get pdfToImages => 'PDF 轉圖片';

  @override
  String get exportImageSuccess => '成功匯出圖片！';

  @override
  String get lockPdfSuccess => '成功加密 PDF！';

  @override
  String get scanPdfSuccess => '成功掃描 PDF！';

  @override
  String get mergePdfSuccess => '成功合併 PDF！';

  @override
  String get editPdfSuccess => '成功編輯 PDF！';

  @override
  String get allDoc => '所有文件檢視器';

  @override
  String get splitSuccess => '成功分割 PDF！';

  @override
  String get enterPassword => '輸入密碼';

  @override
  String get enterThePassword => '請輸入密碼以開啟文件';

  @override
  String get password => '密碼';

  @override
  String get wrongPassword => '密碼錯誤，請重試';

  @override
  String passwordProtected(Object path) {
    return '$path 受密碼保護';
  }

  @override
  String get unlockPdfSuccess => '成功解鎖 PDF！';

  @override
  String get search => '搜索';

  @override
  String get errorCharacter => '輸入包含特殊字符或為空。請輸入有效文本，不能包含特殊字符。';

  @override
  String get cameraReqPermission => '需要相機存取權限以掃描 PDF';

  @override
  String get storageReqPermission => '需要存儲權限以檢視所有文件';

  @override
  String get reqPermission => '請求權限';

  @override
  String get underline => '底線';

  @override
  String get brush => '畫筆';

  @override
  String get highlight => '高亮';

  @override
  String get strikethrough => '刪除線';

  @override
  String get anError => '發生錯誤：';

  @override
  String get errorUpdatePw => '更新 PDF 密碼時發生錯誤：';

  @override
  String get noDocumentFound => '未找到文件';

  @override
  String get sampleFile => '示例文件';

  @override
  String get thisSampleFile => '這是一個示例文件';

  @override
  String get developing => '開發中';

  @override
  String get doNotSupport => '不支援此文件';

  @override
  String get uninstall => '解除安裝';

  @override
  String get whatProblemsYouEncounterDuringUse => '您在使用過程中遇到了哪些問題？';

  @override
  String get dontUninstallYet => '暫時不要解除安裝';

  @override
  String get stillWantToUninstall => '仍然要解除安裝？';

  @override
  String get difficultToUse => '難以使用';

  @override
  String get tooManyAds => '廣告太多';

  @override
  String get others => '其他';

  @override
  String get viewFiles => '查看檔案';

  @override
  String get unableToReceiveFiles => '無法接收檔案';

  @override
  String get unableToViewTheFile => '無法查看檔案';

  @override
  String get explore => '探索';

  @override
  String whyUninstallApp(String appName) {
    return '為什麼要解除安裝 $appName？';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return '請輸入解除安裝 $appName 的原因。';
  }

  @override
  String get tryAgain => '請再試一次';

  @override
  String get setAsDefault => '設為預設';

  @override
  String get justOnce => '僅此一次';

  @override
  String get always => '總是';

  @override
  String get tip => '提示';

  @override
  String get subTip => '如果找不到應用程式圖示，請點選「更多」或三個點來搜尋';

  @override
  String get documentViewer => '文件檢視器';

  @override
  String get allowAccess => '允許存取以管理所有檔案';

  @override
  String pleaseAllowAll(Object appName) {
    return '請允許 $appName 存取您所有的檔案';
  }

  @override
  String get allowPermission => '允許權限';

  @override
  String get welcomeTo => '歡迎使用';

  @override
  String get yourDataRemain => '您的資料將保持私密';

  @override
  String get weNeedPermission => '我們需要存取所有檔案的權限，以便 \n 有效地管理、檢視及整理這些檔案';

  @override
  String get failedToLoadPage => '無法加載頁面';

  @override
  String get savedSuccessfully => '保存成功';

  @override
  String get editPdf => '编辑 PDF';

  @override
  String get textStyle => '文本样式';

  @override
  String get more => '更多';

  @override
  String get searchYourFile => '搜尋您的文件';

  @override
  String get select => '選擇';

  @override
  String imageExported(Object images) {
    return '已匯出 $images 張圖像';
  }

  @override
  String imagesExported(Object images) {
    return '已匯出 $images 張圖像';
  }

  @override
  String get openGallery => '打開「相簿」以查找文件';

  @override
  String get tools => '工具';

  @override
  String get goStatusBar => '前往狀態欄以查找圖片';

  @override
  String get pleaseAllowAllDocumentsViewer => '請允許所有文件檢視器\n訪問您的所有文件';

  @override
  String get notificationsTurnedOff => '通知已關閉！您可能會錯過重要文件';

  @override
  String get tapToOpenSettings => '點擊此處打開設置並啟用通知';

  @override
  String get later => '稍後';

  @override
  String get showNotification => '顯示通知';

  @override
  String get enableNotification => '啟用通知';

  @override
  String get appName => 'PDF 閱讀器 - PDF 檢視器';

  @override
  String get toViewYourFiles => '如需查看您的檔案，請提供';

  @override
  String get withAccessToThem => '其存取權限';

  @override
  String get languageOptions => '語言選項';

  @override
  String get toContinuePleaseGrant => '要繼續，請授予';

  @override
  String get acceptToYourFile => '訪問您的文件。';

  @override
  String get apply => '應用';

  @override
  String get other => '其他';

  @override
  String get startNow => '立即開始';

  @override
  String get page => '頁面';

  @override
  String get goToPage => '跳至頁面';

  @override
  String get pageNumber => '頁碼';

  @override
  String enterPageNumber(int start, int end) {
    return '輸入頁碼 ($start - $end)';
  }

  @override
  String get invalid => '無效';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get saveToAlbum => '保存到相册';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已保存 $count 张图片',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return '通过 $appName 分享此文件——查看和编辑都非常简单。你可以在这里试用：$value';
  }

  @override
  String get searchInPdf =>
      '在 <b><span style=\'color:#E01621\'>PDF 阅读器</span></b> 中搜索';

  @override
  String get searchInDoc =>
      '在 <b><span style=\'color:#2979FF\'>DOC 阅读器</span></b> 中搜索';

  @override
  String get searchInExcel =>
      '在 <b><span style=\'color:#388E3C\'>XLS 阅读器</span></b> 中搜索';

  @override
  String get searchInPpt =>
      '在 <b><span style=\'color:#F2590C\'>PPT 阅读器</span></b> 中搜索';

  @override
  String get unSelect => '取消选择';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value 个文件',
      one: '1 个文件',
      zero: '没有文件',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => '摘要生成中';

  @override
  String get translationProgress => '翻译进行中';

  @override
  String get tryAnotherFile => '无法合并此文件。请尝试选择其他文件以继续。';

  @override
  String get result => '结果';

  @override
  String get scroll => '滚动';

  @override
  String get giveFeedback => '给我反馈';

  @override
  String get add => '添加';

  @override
  String get selectText => '选择文字';

  @override
  String get pleaseDoNot => '请不要包含重音字符';

  @override
  String get pleaseEnter => '请输入文字';

  @override
  String get watermark => '水印';

  @override
  String get enterText => '输入文字';

  @override
  String get color => '颜色';

  @override
  String get addText => '添加文字';

  @override
  String get addWatermark => '添加水印';

  @override
  String get watermarkContent => '水印内容';

  @override
  String get editSuccess => '编辑成功！';

  @override
  String get signature => '签名';

  @override
  String get noSignature => '无签名';

  @override
  String get createSignature => '创建新签名';

  @override
  String get feedbackTitle => '关于 AI 助手的反馈';

  @override
  String get feedbackTo => '收件人：kyle@vtn-global.com';

  @override
  String get feedbackSubject => '主题：“PDF Reader & Photo to PDF”的反馈';

  @override
  String get feedbackHint => '请在此处填写您的反馈...';

  @override
  String get feedbackButton => '发送反馈';

  @override
  String get feedbackEmptyMessage => '请先填写您的反馈内容';

  @override
  String get feedbackSuccessMessage => '反馈已发送（或已打开邮件应用）';

  @override
  String get feedbackErrorMessage => '无法打开邮件应用';

  @override
  String get downloadSuccess => '下载成功！';

  @override
  String get noTranslate => '暂无可用翻译内容。';

  @override
  String get keyPoint => '关键点：';

  @override
  String get conclusion => '结论';

  @override
  String get summary => '摘要';

  @override
  String get type => '类型';

  @override
  String get preview => '预览';

  @override
  String get startTranslate => '开始翻译';

  @override
  String get startSummary => '开始摘要';

  @override
  String get translateTo => '翻译为';

  @override
  String get summaryStyle => '摘要样式';

  @override
  String get selectPage => '选择页面';

  @override
  String get startAISummary => '开始 AI 摘要';

  @override
  String get startAITranslate => '开始 AI 翻译';

  @override
  String get aIAssistant => 'AI 助手';

  @override
  String get aITranslate => 'AI 翻译';

  @override
  String get aISummary => 'AI 摘要';

  @override
  String get ai_translate_description =>
      '<b>使用 AI 即时翻译文档。\n</b> 只需轻点一下，即可将整个 PDF 准确、自然地转换为其他语言。';

  @override
  String get ai_summary_description =>
      '<b>通过 AI 摘要更快理解文档。\n</b> 利用强大的 AI，将冗长的 PDF 转换为简洁、结构清晰的摘要。';

  @override
  String get translate1 => '几秒内完成整份文档翻译';

  @override
  String get translate2 => 'AI 驱动的自然翻译效果';

  @override
  String get translate3 => '支持多种语言';

  @override
  String get translate4 => '适用于学习、工作和旅行';

  @override
  String get summary1 => '一键快速摘要';

  @override
  String get summary2 => '多种摘要格式，满足不同阅读习惯';

  @override
  String get summary3 => '清晰突出最重要的核心内容';

  @override
  String get summary4 => '非常适合学者、专业人士和日常阅读';

  @override
  String get convertedSuccess => '转换成功';

  @override
  String get convertPdfSuccess => '成功转换为 PDF！';

  @override
  String get imageToPdf => '图片转 PDF';

  @override
  String get youCanHold => '可按住并拖动以重新排列图片';

  @override
  String get addImage => '添加图片';

  @override
  String get selectImage => '选择图片';

  @override
  String get selectLanguage =>
      '<b>选择 <span style=\'color:#D90000\'>语言</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value 个结果',
      one: '1 个结果',
      zero: '无结果',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return '正在加載 ($value%)...';
  }

  @override
  String get searchOn => '在 All File Viewer 中搜尋';

  @override
  String get detail => '詳細';

  @override
  String get fileSize => '檔案大小';

  @override
  String get name => '名稱';

  @override
  String get sign => '簽名';

  @override
  String get systemLanguage => '系统语言';

  @override
  String get done => '完成';

  @override
  String get guideExportImage => '打开图库以查看或分享您的图片。';

  @override
  String get textSetDefault => '將 PDF Reader - PDF Viewer 設為預設，立即開啟。';

  @override
  String get enterPassSelect => '请输入密码以选择此文件。';

  @override
  String get selectThePage => '選擇要分割的頁面，長按並拖曳以重新排序。';

  @override
  String get theFastestWay => '開啟檔案最快的方法';

  @override
  String get neverMiss => '絕不錯過文件的重要更新.';

  @override
  String get guideMerge => '請選擇至少兩個要合併的檔案。';

  @override
  String get notification => '通知';

  @override
  String get allowAccessTo => '允許訪問以管理所有文件';

  @override
  String get useDeviceLanguage => '使用裝置語言';

  @override
  String get previewConvert => '预览转换';

  @override
  String get download => '下载';

  @override
  String get pdfToLongImages => 'PDF 转长图片';

  @override
  String get convertSelect => '转换选定';

  @override
  String get convertAll => '全部转换';

  @override
  String get searchInFile => '在文件中搜索';

  @override
  String get language => '语言';

  @override
  String get thisActionCanContainAds => '此操作可能包含广告';

  @override
  String get next => '下一步';

  @override
  String get thank => '谢谢！';

  @override
  String get start => '开始';

  @override
  String get go => '前往';

  @override
  String get permission => '权限';

  @override
  String get rate => '评分';

  @override
  String get share => '分享';

  @override
  String get policy => '隐私政策';

  @override
  String get rateUs => '给我们评分';

  @override
  String get setting => '设置';

  @override
  String get unexpectedError => '发生意外错误！';

  @override
  String get alreadyOwnError => '看起来您已拥有此项目。\n请点击“恢复购买”以继续。';

  @override
  String get confirm => '确认';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get backToHomescreen => '返回主屏幕';

  @override
  String get exitApp => '退出应用';

  @override
  String get areYouSureYouWantToExitApp => '您确定要退出应用吗？';

  @override
  String get pleaseSelectLanguage => '请选择语言以继续';

  @override
  String get allDocumentsViewer => '所有文档查看器';

  @override
  String get onboardingTitle1 => '阅读所有文档';

  @override
  String get onboardingTitle2 => '即时理解任何文档';

  @override
  String get onboardingTitle3 => '像专业人士一样编辑 PDF';

  @override
  String get onboardingContent1 => '快速、流畅地打开 PDF、Word、Excel、PPT';

  @override
  String get onboardingContent2 => '使用 AI 在几秒钟内翻译并总结文件';

  @override
  String get onboardingContent3 => '轻松高亮、批注、签名和标记 PDF';

  @override
  String get requirePermission => '所有文档查看器需要权限！';

  @override
  String get goToSetting => '前往设置';

  @override
  String get storage => '存储';

  @override
  String get camera => '相机';

  @override
  String get grantPermission => '稍后授予权限';

  @override
  String get continuePer => '继续';

  @override
  String get cancel => '取消';

  @override
  String get ok => '確定';

  @override
  String get save => '保存';

  @override
  String get exit => '退出应用';

  @override
  String get doYouWantExitApp => '您想退出应用吗？';

  @override
  String get home => '主页';

  @override
  String get document => '文档';

  @override
  String get recent => '最近';

  @override
  String get bookmark => '书签';

  @override
  String get searchOnAllDocumentsViewer => '在所有文档查看器中搜索';

  @override
  String get mergePDF => '合并 PDF';

  @override
  String get splitPDF => '分割 PDF';

  @override
  String get unlockPDF => '解锁 PDF';

  @override
  String get lockPDF => '加密 PDF';

  @override
  String get scanPDF => '扫描 PDF';

  @override
  String get pDFToImage => 'PDF 转图片';

  @override
  String get documentTool => '文档工具';

  @override
  String get documentReader => '文档阅读器';

  @override
  String sumFiles(int count) {
    return '$count 个文件';
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
  String get image => '图片';

  @override
  String get doYouLikeTheApp => '您喜欢这个应用吗？';

  @override
  String get rate5 => '喜欢';

  @override
  String get rate4 => '很好！';

  @override
  String get rate3 => '难过！';

  @override
  String get rate2 => '差劲！';

  @override
  String get rate1 => '糟糕！';

  @override
  String get notNow => '稍后';

  @override
  String get print => '打印';

  @override
  String get renameFile => '重命名文件';

  @override
  String get pdfConverter => 'PDF 转换器';

  @override
  String get deleteFromDevice => '从设备中删除';

  @override
  String get fileName => '文件名';

  @override
  String get storagePath => '存储路径';

  @override
  String get lastView => '最后查看';

  @override
  String get lastModified => '最后修改';

  @override
  String get size => '大小';

  @override
  String get rename => '重命名';

  @override
  String get all => '全部';

  @override
  String get fileNameCannotBeEmpty => '文件名不能为空';

  @override
  String get pleaseEnterFileName => '请输入文件名';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get last7Day => '最近 7 天';

  @override
  String get monthAgo => '1 个月前';

  @override
  String get delete => '删除';

  @override
  String get deleteIt => '您确定要删除吗？';

  @override
  String fileSelected(Object count) {
    return '$count 个文件已选择';
  }

  @override
  String get exitAndDiscard => '退出并放弃更改？';

  @override
  String get files => '文件';

  @override
  String get discard => '放弃';

  @override
  String get redOption => '红色';

  @override
  String get greenOption => '绿色';

  @override
  String get blueOption => '蓝色';

  @override
  String get displayP3HexColor => '显示 P3 十六进制颜色 #';

  @override
  String get colorsOption => '颜色';

  @override
  String get gridOption => '网格';

  @override
  String get spectrumOption => '光谱';

  @override
  String get slidersOption => '滑块';

  @override
  String get opacityOption => '不透明度';

  @override
  String get fontSize => '字体大小：';

  @override
  String get aToz => '从 A 到 Z';

  @override
  String get zToa => '从 Z 到 A';

  @override
  String get newToOld => '从新到旧';

  @override
  String get oldToNew => '从旧到新';

  @override
  String get smallToLarge => '从小到大';

  @override
  String get largeToSmall => '从大到小';

  @override
  String get title => '标题';

  @override
  String get time => '时间';

  @override
  String get open => '打开';

  @override
  String get empty => '空';

  @override
  String get goHome => '回到主页';

  @override
  String get merge => '合并';

  @override
  String get success => '成功';

  @override
  String get split => '分割';

  @override
  String get remove => '移除';

  @override
  String get loading => '加载中...';

  @override
  String get sortBy => '排序方式';

  @override
  String get removePwTo => '移除密码，文件将不再受保护。';

  @override
  String get setPwTo => '设置密码以保护您的 PDF 文件。';

  @override
  String get setPassword => '设置密码';

  @override
  String get removePassword => '移除密码';

  @override
  String get longImages => '长图片';

  @override
  String get separateImages => '分离图片';

  @override
  String get unknownError => '未知错误';

  @override
  String get pdfToImages => 'PDF 转图片';

  @override
  String get exportImageSuccess => '成功导出图片！';

  @override
  String get lockPdfSuccess => '成功加密 PDF！';

  @override
  String get scanPdfSuccess => '成功扫描 PDF！';

  @override
  String get mergePdfSuccess => '成功合并 PDF！';

  @override
  String get editPdfSuccess => '成功编辑 PDF！';

  @override
  String get allDoc => '所有文档查看器';

  @override
  String get splitSuccess => '成功分割 PDF！';

  @override
  String get enterPassword => '输入密码';

  @override
  String get enterThePassword => '请输入密码以打开文件';

  @override
  String get password => '密码';

  @override
  String get wrongPassword => '密码错误，请重试';

  @override
  String passwordProtected(Object path) {
    return '$path 受密码保护';
  }

  @override
  String get unlockPdfSuccess => '成功解锁 PDF！';

  @override
  String get search => '搜索';

  @override
  String get errorCharacter => '输入包含特殊字符或为空。请输入有效文本，不能包含特殊字符。';

  @override
  String get cameraReqPermission => '需要相机访问权限以扫描 PDF';

  @override
  String get storageReqPermission => '需要存储权限以查看所有文件';

  @override
  String get reqPermission => '请求权限';

  @override
  String get underline => '下划线';

  @override
  String get brush => '画笔';

  @override
  String get highlight => '高亮';

  @override
  String get strikethrough => '删除线';

  @override
  String get anError => '发生错误：';

  @override
  String get errorUpdatePw => '更新 PDF 密码时发生错误：';

  @override
  String get noDocumentFound => '未找到文件';

  @override
  String get sampleFile => '示例文件';

  @override
  String get thisSampleFile => '这是一个示例文件';

  @override
  String get developing => '开发中';

  @override
  String get doNotSupport => '不支持此文件';

  @override
  String get uninstall => '卸载';

  @override
  String get whatProblemsYouEncounterDuringUse => '您在使用过程中遇到了哪些问题？';

  @override
  String get dontUninstallYet => '暂时不要卸载';

  @override
  String get stillWantToUninstall => '仍然要卸载？';

  @override
  String get difficultToUse => '难以使用';

  @override
  String get tooManyAds => '广告太多';

  @override
  String get others => '其他';

  @override
  String get viewFiles => '查看文件';

  @override
  String get unableToReceiveFiles => '无法接收文件';

  @override
  String get unableToViewTheFile => '无法查看文件';

  @override
  String get explore => '探索';

  @override
  String whyUninstallApp(String appName) {
    return '为什么卸载 $appName？';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return '请输入卸载 $appName 的原因。';
  }

  @override
  String get tryAgain => '请再试一次';

  @override
  String get setAsDefault => '设为默认';

  @override
  String get justOnce => '仅此一次';

  @override
  String get always => '总是';

  @override
  String get tip => '提示';

  @override
  String get subTip => '如果找不到应用图标，请点击“更多”或三个点来搜索';

  @override
  String get documentViewer => '文档查看器';

  @override
  String get allowAccess => '允许访问以管理所有文件';

  @override
  String pleaseAllowAll(Object appName) {
    return '请允许 $appName 访问您所有的文件';
  }

  @override
  String get allowPermission => '允许权限';

  @override
  String get welcomeTo => '欢迎使用';

  @override
  String get yourDataRemain => '您的数据将保持私密';

  @override
  String get weNeedPermission => '我们需要访问所有文件的权限，以便 \n 有效地管理、查看及整理这些文件';

  @override
  String get failedToLoadPage => '无法加载页面';

  @override
  String get savedSuccessfully => '保存成功';

  @override
  String get editPdf => '编辑 PDF';

  @override
  String get textStyle => '文本样式';

  @override
  String get more => '更多';

  @override
  String get searchYourFile => '搜索您的文件';

  @override
  String get select => '选择';

  @override
  String imageExported(Object images) {
    return '已导出 $images 张图片';
  }

  @override
  String imagesExported(Object images) {
    return '已导出 $images 张图片';
  }

  @override
  String get openGallery => '打开“相册”以查找文件';

  @override
  String get tools => '工具';

  @override
  String get goStatusBar => '前往状态栏以查找图片。';

  @override
  String get pleaseAllowAllDocumentsViewer => '请允许所有文档查看器\n访问您的所有文件';

  @override
  String get notificationsTurnedOff => '通知已关闭！您可能会错过重要文件';

  @override
  String get tapToOpenSettings => '点击此处打开设置并启用通知';

  @override
  String get later => '稍后';

  @override
  String get showNotification => '显示通知';

  @override
  String get enableNotification => '启用通知';

  @override
  String get appName => 'PDF 阅读器 - PDF 查看器';

  @override
  String get toViewYourFiles => '如需查看您的文件，请提供';

  @override
  String get withAccessToThem => '其访问权限';

  @override
  String get languageOptions => '语言选项';

  @override
  String get toContinuePleaseGrant => '要继续，请授予';

  @override
  String get acceptToYourFile => '访问您的文件。';

  @override
  String get apply => '应用';

  @override
  String get other => '其他';

  @override
  String get startNow => '立即开始';

  @override
  String get page => '页面';

  @override
  String get goToPage => '跳至页面';

  @override
  String get pageNumber => '页码';

  @override
  String enterPageNumber(int start, int end) {
    return '输入页码 ($start - $end)';
  }

  @override
  String get invalid => '无效';
}
