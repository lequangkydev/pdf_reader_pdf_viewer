// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get saveToAlbum => '앨범에 저장';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '이미지 $count개 저장됨',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return '$appName을(를) 통해 이 파일을 공유하세요 – 보기와 편집이 매우 쉽습니다. 여기에서 사용해 보세요: $value';
  }

  @override
  String get searchInPdf =>
      '<b><span style=\'color:#E01621\'>PDF Reader</span></b>에서 검색';

  @override
  String get searchInDoc =>
      '<b><span style=\'color:#2979FF\'>DOC Reader</span></b>에서 검색';

  @override
  String get searchInExcel =>
      '<b><span style=\'color:#388E3C\'>XLS Reader</span></b>에서 검색';

  @override
  String get searchInPpt =>
      '<b><span style=\'color:#F2590C\'>PPT Reader</span></b>에서 검색';

  @override
  String get unSelect => '선택 해제';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value 파일',
      one: '1 파일',
      zero: '파일 없음',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => '요약 진행 중';

  @override
  String get translationProgress => '번역 진행 중';

  @override
  String get tryAnotherFile => '이 파일을 병합할 수 없습니다. 계속하려면 다른 파일을 선택하세요.';

  @override
  String get result => '결과';

  @override
  String get scroll => '스크롤';

  @override
  String get giveFeedback => '피드백 보내기';

  @override
  String get add => '추가';

  @override
  String get selectText => '텍스트 선택';

  @override
  String get pleaseDoNot => '발음 부호가 포함된 문자를 사용하지 마세요';

  @override
  String get pleaseEnter => '텍스트를 입력하세요';

  @override
  String get watermark => '워터마크';

  @override
  String get enterText => '텍스트 입력';

  @override
  String get color => '색상';

  @override
  String get addText => '텍스트 추가';

  @override
  String get addWatermark => '워터마크 추가';

  @override
  String get watermarkContent => '워터마크 내용';

  @override
  String get editSuccess => '성공적으로 수정되었습니다!';

  @override
  String get signature => '서명';

  @override
  String get noSignature => '서명이 없습니다';

  @override
  String get createSignature => '새 서명 만들기';

  @override
  String get feedbackTitle => 'AI 도우미에 대한 피드백';

  @override
  String get feedbackTo => '받는 사람: kyle@vtn-global.com';

  @override
  String get feedbackSubject => '제목: “PDF Reader & Photo to PDF”에 대한 피드백.';

  @override
  String get feedbackHint => '여기에 피드백을 작성하세요...';

  @override
  String get feedbackButton => '피드백 보내기';

  @override
  String get feedbackEmptyMessage => '먼저 피드백을 입력하세요';

  @override
  String get feedbackSuccessMessage => '피드백이 전송되었습니다 (또는 이메일 앱이 열렸습니다)';

  @override
  String get feedbackErrorMessage => '이메일 앱을 열 수 없습니다';

  @override
  String get downloadSuccess => '다운로드 성공!';

  @override
  String get noTranslate => '번역된 콘텐츠가 없습니다.';

  @override
  String get keyPoint => '핵심 요점:';

  @override
  String get conclusion => '결론';

  @override
  String get summary => '요약';

  @override
  String get type => '유형';

  @override
  String get preview => '미리보기';

  @override
  String get startTranslate => '번역 시작';

  @override
  String get startSummary => '요약 시작';

  @override
  String get translateTo => '번역 대상';

  @override
  String get summaryStyle => '요약 스타일';

  @override
  String get selectPage => '페이지 선택';

  @override
  String get startAISummary => 'AI 요약 시작';

  @override
  String get startAITranslate => 'AI 번역 시작';

  @override
  String get aIAssistant => 'AI 도우미';

  @override
  String get aITranslate => 'AI 번역';

  @override
  String get aISummary => 'AI 요약';

  @override
  String get ai_translate_description =>
      '<b>AI로 문서를 즉시 번역하세요.\n</b> 한 번의 탭으로 전체 PDF를 다른 언어로 정확하고 자연스럽게 변환할 수 있습니다.';

  @override
  String get ai_summary_description =>
      '<b>AI 요약으로 문서를 더 빠르게 이해하세요.\n</b> 강력한 AI를 사용해 긴 PDF를 간결하고 구조적인 요약으로 변환하여 핵심만 빠르게 파악할 수 있습니다.';

  @override
  String get translate1 => '몇 초 만에 전체 문서 번역';

  @override
  String get translate2 => 'AI 기반의 자연스러운 번역 결과';

  @override
  String get translate3 => '다양한 언어 지원';

  @override
  String get translate4 => '학습, 업무, 여행에 이상적';

  @override
  String get summary1 => '원터치 빠른 요약';

  @override
  String get summary2 => '다양한 읽기 스타일을 위한 여러 요약 형식';

  @override
  String get summary3 => '가장 중요한 핵심 내용 강조';

  @override
  String get summary4 => '학생, 전문가, 일상 독서에 적합';

  @override
  String get convertedSuccess => '성공적으로 변환됨';

  @override
  String get convertPdfSuccess => 'PDF로 성공적으로 변환!';

  @override
  String get imageToPdf => '이미지를 PDF로';

  @override
  String get youCanHold => '이미지를 길게 눌러 끌어서 위치를 변경할 수 있습니다';

  @override
  String get addImage => '이미지 추가';

  @override
  String get selectImage => '이미지 선택';

  @override
  String get selectLanguage =>
      '<b><span style=\'color:#D90000\'>언어</span> 선택</b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value개의 결과',
      one: '1개의 결과',
      zero: '결과 없음',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return '로딩 중 ($value%)...';
  }

  @override
  String get searchOn => 'All File Viewer에서 검색';

  @override
  String get detail => '세부 정보';

  @override
  String get fileSize => '파일 크기';

  @override
  String get name => '이름';

  @override
  String get sign => '서명';

  @override
  String get systemLanguage => '시스템 언어';

  @override
  String get done => '완료';

  @override
  String get guideExportImage => '갤러리를 열어 이미지를 보거나 공유하세요.';

  @override
  String get textSetDefault => 'PDF Reader - PDF Viewer 를 기본 앱으로 설정해 즉시 열기.';

  @override
  String get enterPassSelect => '이 파일을 선택하려면 비밀번호를 입력하세요.';

  @override
  String get selectThePage => '분할할 페이지를 선택한 다음 길게 눌러 다른 페이지 사이로 이동하세요.';

  @override
  String get theFastestWay => '파일을 여는 가장 빠른 방법';

  @override
  String get neverMiss => '중요한 문서 업데이트를 놓치지 마세요.';

  @override
  String get guideMerge => '병합할 파일을 최소 2개 선택하세요.';

  @override
  String get notification => '알림';

  @override
  String get allowAccessTo => '모든 파일을 관리할 수 있는 액세스 허용';

  @override
  String get useDeviceLanguage => '기기 언어 사용';

  @override
  String get previewConvert => '변환 미리보기';

  @override
  String get download => '다운로드';

  @override
  String get pdfToLongImages => 'PDF를 긴 이미지로';

  @override
  String get convertSelect => '선택 항목 변환';

  @override
  String get convertAll => '전체 변환';

  @override
  String get searchInFile => '파일에서 검색';

  @override
  String get language => '언어';

  @override
  String get thisActionCanContainAds => '이 작업에는 광고가 포함될 수 있습니다';

  @override
  String get next => '다음';

  @override
  String get thank => '감사합니다!';

  @override
  String get start => '시작';

  @override
  String get go => '이동';

  @override
  String get permission => '권한';

  @override
  String get rate => '평가';

  @override
  String get share => '공유';

  @override
  String get policy => '개인정보 보호정책';

  @override
  String get rateUs => '평가하기';

  @override
  String get setting => '설정';

  @override
  String get unexpectedError => '예기치 않은 오류가 발생했습니다!';

  @override
  String get alreadyOwnError =>
      '이 항목을 이미 소유하고 있는 것 같습니다.\n‘구매 복원’을 클릭하여 계속 진행하세요.';

  @override
  String get confirm => '확인';

  @override
  String get yes => '예';

  @override
  String get no => '아니요';

  @override
  String get backToHomescreen => '홈 화면으로 돌아가기';

  @override
  String get exitApp => '앱 종료';

  @override
  String get areYouSureYouWantToExitApp => '앱을 종료하시겠습니까?';

  @override
  String get pleaseSelectLanguage => '계속하려면 언어를 선택하세요';

  @override
  String get allDocumentsViewer => '전체 문서 뷰어';

  @override
  String get onboardingTitle1 => '모든 문서 읽기';

  @override
  String get onboardingTitle2 => '어떤 문서든 즉시 이해';

  @override
  String get onboardingTitle3 => '전문가처럼 PDF 편집';

  @override
  String get onboardingContent1 => 'PDF, Word, Excel, PPT를 빠르고 부드럽게 열기';

  @override
  String get onboardingContent2 => 'AI로 파일을 몇 초 만에 번역 및 요약';

  @override
  String get onboardingContent3 => 'PDF를 쉽게 강조 표시, 주석, 서명 및 편집';

  @override
  String get requirePermission => '전체 문서 뷰어를 사용하려면 권한이 필요합니다!';

  @override
  String get goToSetting => '설정으로 이동';

  @override
  String get storage => '저장소';

  @override
  String get camera => '카메라';

  @override
  String get grantPermission => '나중에 허용';

  @override
  String get continuePer => '계속';

  @override
  String get cancel => '취소';

  @override
  String get ok => '확인';

  @override
  String get save => '저장';

  @override
  String get exit => '앱 종료';

  @override
  String get doYouWantExitApp => '앱을 종료하시겠습니까?';

  @override
  String get home => '홈';

  @override
  String get document => '문서';

  @override
  String get recent => '최근';

  @override
  String get bookmark => '북마크';

  @override
  String get searchOnAllDocumentsViewer => '전체 문서 뷰어에서 검색';

  @override
  String get mergePDF => 'PDF 병합';

  @override
  String get splitPDF => 'PDF 분할';

  @override
  String get unlockPDF => 'PDF 잠금 해제';

  @override
  String get lockPDF => 'PDF 잠금';

  @override
  String get scanPDF => 'PDF 스캔';

  @override
  String get pDFToImage => 'PDF를 이미지로 변환';

  @override
  String get documentTool => '문서 도구';

  @override
  String get documentReader => '문서 리더';

  @override
  String sumFiles(int count) {
    return '$count개 파일';
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
  String get image => '이미지';

  @override
  String get doYouLikeTheApp => '앱이 마음에 드시나요?';

  @override
  String get rate5 => '매우 좋아요';

  @override
  String get rate4 => '좋아요!';

  @override
  String get rate3 => '괜찮아요!';

  @override
  String get rate2 => '별로예요!';

  @override
  String get rate1 => '최악이에요!';

  @override
  String get notNow => '나중에';

  @override
  String get print => '인쇄';

  @override
  String get renameFile => '파일 이름 변경';

  @override
  String get pdfConverter => 'PDF 변환기';

  @override
  String get deleteFromDevice => '기기에서 삭제';

  @override
  String get fileName => '파일 이름';

  @override
  String get storagePath => '저장 경로';

  @override
  String get lastView => '마지막 보기';

  @override
  String get lastModified => '마지막 수정';

  @override
  String get size => '크기';

  @override
  String get rename => '이름 변경';

  @override
  String get all => '전체';

  @override
  String get fileNameCannotBeEmpty => '파일 이름은 비워둘 수 없습니다';

  @override
  String get pleaseEnterFileName => '파일 이름을 입력하세요';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String get last7Day => '지난 7일';

  @override
  String get monthAgo => '1개월 전';

  @override
  String get delete => '삭제';

  @override
  String get deleteIt => '정말 삭제하시겠습니까?';

  @override
  String fileSelected(Object count) {
    return '파일 $count 선택됨';
  }

  @override
  String get exitAndDiscard => '종료하고 변경 사항을 삭제하시겠습니까?';

  @override
  String get files => '파일';

  @override
  String get discard => '삭제';

  @override
  String get redOption => '빨강';

  @override
  String get greenOption => '초록';

  @override
  String get blueOption => '파랑';

  @override
  String get displayP3HexColor => 'P3 16진수 색상 표시 #';

  @override
  String get colorsOption => '색상';

  @override
  String get gridOption => '격자';

  @override
  String get spectrumOption => '스펙트럼';

  @override
  String get slidersOption => '슬라이더';

  @override
  String get opacityOption => '불투명도';

  @override
  String get fontSize => ' 글꼴 크기:';

  @override
  String get aToz => 'A부터 Z까지';

  @override
  String get zToa => 'Z부터 A까지';

  @override
  String get newToOld => '최신순';

  @override
  String get oldToNew => '오래된 순';

  @override
  String get smallToLarge => '작은 순';

  @override
  String get largeToSmall => '큰 순';

  @override
  String get title => '제목';

  @override
  String get time => '시간';

  @override
  String get open => '열기';

  @override
  String get empty => '비어 있음';

  @override
  String get goHome => '홈으로 이동';

  @override
  String get merge => '병합';

  @override
  String get success => '성공';

  @override
  String get split => '분할';

  @override
  String get remove => '제거';

  @override
  String get loading => '로딩 중...';

  @override
  String get sortBy => '정렬 기준';

  @override
  String get removePwTo => '비밀번호를 제거하면 파일이 더 이상 보호되지 않습니다.';

  @override
  String get setPwTo => 'PDF 파일을 보호할 비밀번호를 설정하세요.';

  @override
  String get setPassword => '비밀번호 설정';

  @override
  String get removePassword => '비밀번호 제거';

  @override
  String get longImages => '긴 이미지';

  @override
  String get separateImages => '개별 이미지';

  @override
  String get unknownError => '알 수 없는 오류';

  @override
  String get pdfToImages => 'PDF 이미지 변환';

  @override
  String get exportImageSuccess => '이미지 내보내기 성공!';

  @override
  String get lockPdfSuccess => 'PDF 잠금 성공!';

  @override
  String get scanPdfSuccess => 'PDF 스캔 성공!';

  @override
  String get mergePdfSuccess => 'PDF 병합 성공!';

  @override
  String get editPdfSuccess => 'PDF 편집 성공!';

  @override
  String get allDoc => '모든 문서 뷰어';

  @override
  String get splitSuccess => 'PDF 분할 성공!';

  @override
  String get enterPassword => '비밀번호 입력';

  @override
  String get enterThePassword => '파일을 열기 위한 비밀번호를 입력하세요';

  @override
  String get password => '비밀번호';

  @override
  String get wrongPassword => '비밀번호가 잘못되었습니다. 다시 시도하세요.';

  @override
  String passwordProtected(Object path) {
    return '$path은(는) 비밀번호로 보호됩니다';
  }

  @override
  String get unlockPdfSuccess => 'PDF 잠금 해제 성공!';

  @override
  String get search => '검색';

  @override
  String get errorCharacter =>
      '입력값에 특수문자가 포함되었거나 비어 있습니다. 특수문자 없이 유효한 텍스트를 입력하세요.';

  @override
  String get cameraReqPermission => 'PDF를 스캔하려면 카메라 접근 권한이 필요합니다';

  @override
  String get storageReqPermission => '모든 파일을 보려면 저장소 접근 권한이 필요합니다';

  @override
  String get reqPermission => '권한 요청';

  @override
  String get underline => '밑줄';

  @override
  String get brush => '브러시';

  @override
  String get highlight => '형광펜';

  @override
  String get strikethrough => '취소선';

  @override
  String get anError => '오류 발생: ';

  @override
  String get errorUpdatePw => 'PDF 비밀번호 업데이트 오류: ';

  @override
  String get noDocumentFound => '문서를 찾지 못했어요.';

  @override
  String get sampleFile => '샘플 파일';

  @override
  String get thisSampleFile => '이것은 샘플 파일입니다';

  @override
  String get developing => '개발 중';

  @override
  String get doNotSupport => '이 파일은 지원되지 않습니다';

  @override
  String get uninstall => '제거';

  @override
  String get whatProblemsYouEncounterDuringUse => '사용 중 어떤 문제가 발생했나요?';

  @override
  String get dontUninstallYet => '아직 제거하지 마세요';

  @override
  String get stillWantToUninstall => '정말 제거하시겠습니까?';

  @override
  String get difficultToUse => '사용하기 어려움';

  @override
  String get tooManyAds => '광고가 너무 많음';

  @override
  String get others => '기타';

  @override
  String get viewFiles => '파일 보기';

  @override
  String get unableToReceiveFiles => '파일을 받을 수 없음';

  @override
  String get unableToViewTheFile => '파일을 볼 수 없습니다';

  @override
  String get explore => '탐색';

  @override
  String whyUninstallApp(String appName) {
    return '$appName을(를) 왜 제거하시겠습니까?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return '$appName을(를) 제거하는 이유를 입력해주세요.';
  }

  @override
  String get tryAgain => '다시 시도';

  @override
  String get setAsDefault => '기본값으로 설정';

  @override
  String get justOnce => '한 번만';

  @override
  String get always => '항상';

  @override
  String get tip => '팁';

  @override
  String get subTip => '앱 아이콘이 보이지 않으면 \'더보기\' 또는 점 세 개를 눌러 찾아보세요';

  @override
  String get documentViewer => '문서 뷰어';

  @override
  String get allowAccess => '모든 파일을 관리할 수 있도록 접근 허용';

  @override
  String pleaseAllowAll(Object appName) {
    return '$appName이(가) 모든 파일에 접근할 수 있도록 허용해 주세요';
  }

  @override
  String get allowPermission => '권한 허용';

  @override
  String get welcomeTo => '환영합니다';

  @override
  String get yourDataRemain => '귀하의 데이터는 비공개로 유지됩니다';

  @override
  String get weNeedPermission =>
      '파일을 효율적으로 관리, 보기 및 정리하려면 \n 모든 파일에 대한 접근 권한이 필요합니다';

  @override
  String get failedToLoadPage => '페이지 로드 실패';

  @override
  String get savedSuccessfully => '성공적으로 저장됨';

  @override
  String get editPdf => 'PDF 편집';

  @override
  String get textStyle => '텍스트 스타일';

  @override
  String get more => '더보기';

  @override
  String get searchYourFile => '파일 검색';

  @override
  String get select => '선택';

  @override
  String imageExported(Object images) {
    return '$images개의 이미지가 내보내졌습니다';
  }

  @override
  String imagesExported(Object images) {
    return '$images개의 이미지가 내보내졌습니다';
  }

  @override
  String get openGallery => '파일을 찾으려면 \"갤러리\"를 여세요';

  @override
  String get tools => '도구';

  @override
  String get goStatusBar => '이미지를 찾으려면 상태 표시줄로 이동하세요';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      '모든 문서 뷰어가\n모든 파일에 액세스할 수 있도록 허용하세요';

  @override
  String get notificationsTurnedOff => '알림이 꺼져 있습니다! 중요한 문서를 놓칠 수 있습니다';

  @override
  String get tapToOpenSettings => '설정을 열고 알림을 활성화하려면 여기를 탭하세요';

  @override
  String get later => '나중에';

  @override
  String get showNotification => '알림 표시';

  @override
  String get enableNotification => '알림 활성화';

  @override
  String get appName => 'PDF 뷰어 - PDF Reader & PDF 편집';

  @override
  String get toViewYourFiles => '파일을 보려면 다음을 허용해 주세요:';

  @override
  String get withAccessToThem => '파일에 대한 접근 권한';

  @override
  String get languageOptions => '언어 옵션';

  @override
  String get toContinuePleaseGrant => '계속하려면';

  @override
  String get acceptToYourFile => '앱에 파일 액세스 권한을 부여해주세요.';

  @override
  String get apply => '적용';

  @override
  String get other => '기타';

  @override
  String get startNow => '지금 시작';

  @override
  String get page => '페이지';

  @override
  String get goToPage => '페이지로 이동';

  @override
  String get pageNumber => '페이지 번호';

  @override
  String enterPageNumber(int start, int end) {
    return '페이지 번호를 입력하세요 ($start - $end)';
  }

  @override
  String get invalid => '잘못된 값';
}
