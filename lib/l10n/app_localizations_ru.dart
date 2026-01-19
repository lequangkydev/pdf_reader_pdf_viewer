// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get saveToAlbum => 'Сохранить в альбом';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Сохранено $count изображений',
      many: 'Сохранено $count изображений',
      few: 'Сохранено $count изображения',
      one: 'Сохранено $count изображение',
      zero: 'Сохранено 0 изображений',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Поделиться этим файлом через $appName — очень удобно для просмотра и редактирования. Попробуйте здесь: $value';
  }

  @override
  String get searchInPdf =>
      'Поиск в <b><span style=\'color:#E01621\'>PDF Reader</span></b>';

  @override
  String get searchInDoc =>
      'Поиск в <b><span style=\'color:#2979FF\'>DOC Reader</span></b>';

  @override
  String get searchInExcel =>
      'Поиск в <b><span style=\'color:#388E3C\'>XLS Reader</span></b>';

  @override
  String get searchInPpt =>
      'Поиск в <b><span style=\'color:#F2590C\'>PPT Reader</span></b>';

  @override
  String get unSelect => 'Отменить выбор';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value файлов',
      many: '$value файлов',
      few: '$value файла',
      one: '$value файл',
      zero: 'Нет файлов',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Идет создание резюме';

  @override
  String get translationProgress => 'Идет перевод';

  @override
  String get tryAnotherFile =>
      'Не удалось объединить этот файл. Попробуйте выбрать другой файл, чтобы продолжить.';

  @override
  String get result => 'Результат';

  @override
  String get scroll => 'Прокрутка';

  @override
  String get giveFeedback => 'Оставьте отзыв';

  @override
  String get add => 'Добавить';

  @override
  String get selectText => 'Выбрать текст';

  @override
  String get pleaseDoNot => 'Пожалуйста, не используйте символы с акцентами';

  @override
  String get pleaseEnter => 'Пожалуйста, введите текст';

  @override
  String get watermark => 'Водяной знак';

  @override
  String get enterText => 'Введите текст';

  @override
  String get color => 'Цвет';

  @override
  String get addText => 'Добавить текст';

  @override
  String get addWatermark => 'Добавить водяной знак';

  @override
  String get watermarkContent => 'Содержимое водяного знака';

  @override
  String get editSuccess => 'Успешно отредактировано!';

  @override
  String get signature => 'Подпись';

  @override
  String get noSignature => 'Нет подписи';

  @override
  String get createSignature => 'Создать новую подпись';

  @override
  String get feedbackTitle => 'Отзыв об AI Assistant';

  @override
  String get feedbackTo => 'Кому: kyle@vtn-global.com';

  @override
  String get feedbackSubject => 'Тема: Отзыв о «PDF Reader & Photo to PDF».';

  @override
  String get feedbackHint => 'Напишите ваш отзыв здесь...';

  @override
  String get feedbackButton => 'Отправить отзыв';

  @override
  String get feedbackEmptyMessage => 'Пожалуйста, сначала напишите отзыв';

  @override
  String get feedbackSuccessMessage =>
      'Отзыв отправлен (или открыто приложение электронной почты)';

  @override
  String get feedbackErrorMessage =>
      'Не удалось открыть приложение электронной почты';

  @override
  String get downloadSuccess => 'Загрузка успешно завершена!';

  @override
  String get noTranslate => 'Нет доступного переведенного контента.';

  @override
  String get keyPoint => 'Ключевые моменты:';

  @override
  String get conclusion => 'Заключение';

  @override
  String get summary => 'Резюме';

  @override
  String get type => 'Тип';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get startTranslate => 'Начать перевод';

  @override
  String get startSummary => 'Начать резюме';

  @override
  String get translateTo => 'Перевести на';

  @override
  String get summaryStyle => 'Стиль резюме';

  @override
  String get selectPage => 'Выбрать страницу';

  @override
  String get startAISummary => 'Начать AI-резюме';

  @override
  String get startAITranslate => 'Начать AI-перевод';

  @override
  String get aIAssistant => 'AI Ассистент';

  @override
  String get aITranslate => 'AI Перевод';

  @override
  String get aISummary => 'AI Резюме';

  @override
  String get ai_translate_description =>
      '<b>Мгновенно переводите документы с помощью ИИ.\n</b> Всего одно нажатие — и весь PDF будет точно и естественно переведён на другой язык.';

  @override
  String get ai_summary_description =>
      '<b>Быстрее понимайте документы с ИИ-резюме.\n</b> Превращайте длинные PDF в краткие и структурированные обзоры с помощью мощного ИИ.';

  @override
  String get translate1 => 'Полный перевод документа за секунды';

  @override
  String get translate2 => 'Чёткие и естественные результаты на основе ИИ';

  @override
  String get translate3 => 'Поддержка нескольких языков';

  @override
  String get translate4 => 'Идеально для учёбы, работы и путешествий';

  @override
  String get summary1 => 'Быстрые резюме одним нажатием';

  @override
  String get summary2 => 'Несколько форматов резюме для разных стилей чтения';

  @override
  String get summary3 => 'Чёткое выделение самых важных идей';

  @override
  String get summary4 =>
      'Отлично подходит для учёных, специалистов и повседневного чтения';

  @override
  String get convertedSuccess => 'Успешно преобразовано';

  @override
  String get convertPdfSuccess => 'Успешно преобразовано в PDF!';

  @override
  String get imageToPdf => 'Изображение в PDF';

  @override
  String get youCanHold =>
      'Вы можете удерживать и перетаскивать, чтобы изменить положение\nизображений';

  @override
  String get addImage => 'Добавить изображение';

  @override
  String get selectImage => 'Выбрать изображение';

  @override
  String get selectLanguage =>
      '<b>Выбрать <span style=\'color:#D90000\'>Язык</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value результатов',
      one: '1 результат',
      zero: 'Нет результатов',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'Загрузка ($value%)...';
  }

  @override
  String get searchOn => 'Искать в All File Viewer';

  @override
  String get detail => 'Детали';

  @override
  String get fileSize => 'Размер файла';

  @override
  String get name => 'Имя';

  @override
  String get sign => 'Подписать';

  @override
  String get systemLanguage => 'Язык системы';

  @override
  String get done => 'Готово';

  @override
  String get guideExportImage =>
      'Откройте галерею, чтобы просмотреть или поделиться изображениями.';

  @override
  String get textSetDefault =>
      'Сделайте PDF Reader - PDF Viewer по умолчанию для мгновенного открытия.\n';

  @override
  String get enterPassSelect => 'Введите пароль, чтобы выбрать этот файл.';

  @override
  String get selectThePage =>
      'Выберите страницу для разделения, затем удерживайте её, чтобы перетащить и изменить порядок.';

  @override
  String get theFastestWay => 'Самый быстрый способ открыть ваши файлы';

  @override
  String get neverMiss =>
      'Никогда не пропускайте важные обновления ваших документов.';

  @override
  String get guideMerge => 'Выберите как минимум 2 файла для объединения.';

  @override
  String get notification => 'Уведомления';

  @override
  String get allowAccessTo => 'Разрешить доступ для управления всеми файлами';

  @override
  String get useDeviceLanguage => 'Использовать язык устройства';

  @override
  String get previewConvert => 'Предпросмотр конверсии';

  @override
  String get download => 'Скачать';

  @override
  String get pdfToLongImages => 'PDF в длинные изображения';

  @override
  String get convertSelect => 'Преобразовать выбранное';

  @override
  String get convertAll => 'Преобразовать всё';

  @override
  String get searchInFile => 'Поиск в файле';

  @override
  String get language => 'языка';

  @override
  String get thisActionCanContainAds => 'Это действие может содержать рекламу';

  @override
  String get next => 'Далее';

  @override
  String get thank => 'Спасибо!';

  @override
  String get start => 'Начать';

  @override
  String get go => 'Перейти';

  @override
  String get permission => 'Разрешение';

  @override
  String get rate => 'Оценить';

  @override
  String get share => 'Поделиться';

  @override
  String get policy => 'Политика конфиденциальности';

  @override
  String get rateUs => 'Оцените нас';

  @override
  String get setting => 'Настройки';

  @override
  String get unexpectedError => 'Произошла неожиданная ошибка!';

  @override
  String get alreadyOwnError =>
      'Похоже, у вас уже есть этот элемент.\nНажмите \'Восстановить покупку\', чтобы продолжить.';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get backToHomescreen => 'Вернуться на главный экран';

  @override
  String get exitApp => 'Выйти из приложения';

  @override
  String get areYouSureYouWantToExitApp =>
      'Вы уверены, что хотите выйти из приложения?';

  @override
  String get pleaseSelectLanguage => 'Выберите языка для продолжения';

  @override
  String get allDocumentsViewer => 'Просмотр всех документов';

  @override
  String get onboardingTitle1 => 'Читайте все документы';

  @override
  String get onboardingTitle2 => 'Мгновенно понимайте любой документ';

  @override
  String get onboardingTitle3 => 'Редактируйте PDF как профессионал';

  @override
  String get onboardingContent1 =>
      'Быстро и удобно открывайте PDF, Word, Excel и PPT';

  @override
  String get onboardingContent2 =>
      'Переводите и обобщайте файлы с помощью ИИ за секунды';

  @override
  String get onboardingContent3 =>
      'Легко выделяйте, комментируйте, подписывайте и редактируйте PDF';

  @override
  String get requirePermission =>
      'Требуется разрешение для использования просмотрщика документов!';

  @override
  String get goToSetting => 'Перейти в настройки';

  @override
  String get storage => 'Хранилище';

  @override
  String get camera => 'Камера';

  @override
  String get grantPermission => 'Предоставить разрешение позже';

  @override
  String get continuePer => 'Продолжить';

  @override
  String get cancel => 'Отмена';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Сохранить';

  @override
  String get exit => 'Выход';

  @override
  String get doYouWantExitApp => 'Вы хотите выйти из приложения?';

  @override
  String get home => 'Главная';

  @override
  String get document => 'Документ';

  @override
  String get recent => 'Недавние';

  @override
  String get bookmark => 'Закладки';

  @override
  String get searchOnAllDocumentsViewer => 'Поиск в просмотрщике документов';

  @override
  String get mergePDF => 'Объединить PDF';

  @override
  String get splitPDF => 'Разделить PDF';

  @override
  String get unlockPDF => 'Снять защиту с PDF';

  @override
  String get lockPDF => 'Заблокировать PDF';

  @override
  String get scanPDF => 'Сканировать PDF';

  @override
  String get pDFToImage => 'Конвертировать PDF в изображение';

  @override
  String get documentTool => 'Инструменты для документов';

  @override
  String get documentReader => 'Просмотрщик документов';

  @override
  String sumFiles(int count) {
    return '$count файлов';
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
  String get image => 'Изображение';

  @override
  String get doYouLikeTheApp => 'Вам нравится приложение?';

  @override
  String get rate5 => 'Очень нравится!';

  @override
  String get rate4 => 'Отлично!';

  @override
  String get rate3 => 'Хорошо!';

  @override
  String get rate2 => 'Можно лучше!';

  @override
  String get rate1 => 'Не понравилось!';

  @override
  String get notNow => 'Не сейчас';

  @override
  String get print => 'Печать';

  @override
  String get renameFile => 'Переименовать файл';

  @override
  String get pdfConverter => 'Конвертер PDF';

  @override
  String get deleteFromDevice => 'Удалить с устройства';

  @override
  String get fileName => 'Имя файла';

  @override
  String get storagePath => 'Путь к хранилищу';

  @override
  String get lastView => 'Последний просмотр';

  @override
  String get lastModified => 'Последнее изменение';

  @override
  String get size => 'Размер';

  @override
  String get rename => 'Переименовать';

  @override
  String get all => 'Все';

  @override
  String get fileNameCannotBeEmpty => 'Имя файла не может быть пустым';

  @override
  String get pleaseEnterFileName => 'Введите имя файла';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String get last7Day => 'Последние 7 дней';

  @override
  String get monthAgo => 'Месяц назад';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteIt => 'Вы действительно хотите удалить?';

  @override
  String fileSelected(Object count) {
    return 'Выбрано $count файлов';
  }

  @override
  String get exitAndDiscard => 'Выйти и отменить изменения?';

  @override
  String get files => 'Файлы';

  @override
  String get discard => 'Отменить';

  @override
  String get redOption => 'Красный';

  @override
  String get greenOption => 'Зелёный';

  @override
  String get blueOption => 'Синий';

  @override
  String get displayP3HexColor => 'Отображение цвета P3 Hex #';

  @override
  String get colorsOption => 'Цвета';

  @override
  String get gridOption => 'Сетка';

  @override
  String get spectrumOption => 'Спектр';

  @override
  String get slidersOption => 'Ползунки';

  @override
  String get opacityOption => 'Прозрачность';

  @override
  String get fontSize => ' Размер шрифта:';

  @override
  String get aToz => 'От A до Z';

  @override
  String get zToa => 'От Z до A';

  @override
  String get newToOld => 'От нового к старому';

  @override
  String get oldToNew => 'От старого к новому';

  @override
  String get smallToLarge => 'От меньшего к большему';

  @override
  String get largeToSmall => 'От большего к меньшему';

  @override
  String get title => 'Заголовок';

  @override
  String get time => 'Время';

  @override
  String get open => 'Открыть';

  @override
  String get empty => 'Пусто';

  @override
  String get goHome => 'На главную';

  @override
  String get merge => 'Объединить';

  @override
  String get success => 'Успех';

  @override
  String get split => 'Разделить';

  @override
  String get remove => 'Удалить';

  @override
  String get loading => 'Загрузка...';

  @override
  String get sortBy => 'Сортировать по';

  @override
  String get removePwTo => 'Удалите пароль, чтобы файл больше не был защищён.';

  @override
  String get setPwTo => 'Установите пароль для защиты вашего PDF-файла.';

  @override
  String get setPassword => 'Установить пароль';

  @override
  String get removePassword => 'Удалить пароль';

  @override
  String get longImages => 'Длинные изображения';

  @override
  String get separateImages => 'Отдельные изображения';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get pdfToImages => 'PDF в JPG';

  @override
  String get exportImageSuccess => 'Изображение успешно экспортировано!';

  @override
  String get lockPdfSuccess => 'PDF успешно заблокирован!';

  @override
  String get scanPdfSuccess => 'PDF успешно отсканирован!';

  @override
  String get mergePdfSuccess => 'PDF успешно объединён!';

  @override
  String get editPdfSuccess => 'PDF успешно отредактирован!';

  @override
  String get allDoc => 'Просмотр всех документов';

  @override
  String get splitSuccess => 'PDF успешно разделён!';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get enterThePassword => 'Введите пароль для открытия файла';

  @override
  String get password => 'Пароль';

  @override
  String get wrongPassword => 'Неверный пароль, попробуйте снова';

  @override
  String passwordProtected(Object path) {
    return '$path защищён паролем';
  }

  @override
  String get unlockPdfSuccess => 'PDF успешно разблокирован!';

  @override
  String get search => 'Поиск';

  @override
  String get errorCharacter =>
      'Введённое значение содержит специальные символы или пусто. Введите корректный текст без специальных символов.';

  @override
  String get cameraReqPermission =>
      'Необходимо разрешение на доступ к камере для сканирования PDF';

  @override
  String get storageReqPermission =>
      'Необходимо разрешение на доступ к хранилищу для просмотра всех файлов';

  @override
  String get reqPermission => 'Запросить разрешение';

  @override
  String get underline => 'Подчёркивание';

  @override
  String get brush => 'Кисть';

  @override
  String get highlight => 'Выделение';

  @override
  String get strikethrough => 'Зачёркивание';

  @override
  String get anError => 'Произошла ошибка: ';

  @override
  String get errorUpdatePw => 'Ошибка при обновлении пароля PDF: ';

  @override
  String get noDocumentFound => 'Документы не найдены';

  @override
  String get sampleFile => 'Пример файла';

  @override
  String get thisSampleFile => 'Это пример файла';

  @override
  String get developing => 'В разработке';

  @override
  String get doNotSupport => 'Этот файл не поддерживается';

  @override
  String get uninstall => 'Удалить';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'Какие проблемы возникли во время использования?';

  @override
  String get dontUninstallYet => 'Пока не удаляйте';

  @override
  String get stillWantToUninstall => 'Вы все еще хотите удалить?';

  @override
  String get difficultToUse => 'Сложно использовать';

  @override
  String get tooManyAds => 'Слишком много рекламы';

  @override
  String get others => 'Другие';

  @override
  String get viewFiles => 'Просмотреть файлы';

  @override
  String get unableToReceiveFiles => 'Невозможно получить файлы';

  @override
  String get unableToViewTheFile => 'Невозможно просмотреть файл';

  @override
  String get explore => 'Исследовать';

  @override
  String whyUninstallApp(String appName) {
    return 'Почему удаляете $appName?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Пожалуйста, укажите причину удаления $appName.';
  }

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get setAsDefault => 'Установить по умолчанию';

  @override
  String get justOnce => 'Только один раз';

  @override
  String get always => 'Всегда';

  @override
  String get tip => 'Совет';

  @override
  String get subTip =>
      'Если вы не можете найти значок приложения, нажмите «Ещё» или на три точки, чтобы найти его.';

  @override
  String get documentViewer => 'Просмотр документов';

  @override
  String get allowAccess => 'Разрешить доступ для управления всеми файлами';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Пожалуйста, разрешите $appName доступ ко всем вашим файлам';
  }

  @override
  String get allowPermission => 'Разрешить доступ';

  @override
  String get welcomeTo => 'Добро пожаловать в';

  @override
  String get yourDataRemain => 'Ваши данные остаются конфиденциальными';

  @override
  String get weNeedPermission =>
      'Нам нужно разрешение на доступ ко всем файлам, чтобы \n эффективно управлять ими, просматривать и организовывать';

  @override
  String get failedToLoadPage => 'Не удалось загрузить страницу';

  @override
  String get savedSuccessfully => 'Успешно сохранено';

  @override
  String get editPdf => 'Редактировать PDF';

  @override
  String get textStyle => 'Стиль текста';

  @override
  String get more => 'Ещё';

  @override
  String get searchYourFile => 'Искать файлы';

  @override
  String get select => 'Выбор';

  @override
  String imageExported(Object images) {
    return 'Экспортировано $images изображений';
  }

  @override
  String imagesExported(Object images) {
    return 'Экспортировано $images изображений';
  }

  @override
  String get openGallery => 'Откройте \"Галерею\", чтобы найти файл';

  @override
  String get tools => 'Инструменты';

  @override
  String get goStatusBar =>
      'Перейти в строку состояния, чтобы найти изображения';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Пожалуйста, разрешите Все Документы\nПросмотрщик для доступа ко всем вашим файлам';

  @override
  String get notificationsTurnedOff =>
      'Уведомления отключены! Вы можете пропустить важные документы';

  @override
  String get tapToOpenSettings =>
      'Нажмите здесь, чтобы открыть настройки и включить уведомления';

  @override
  String get later => 'Позже';

  @override
  String get showNotification => 'Показать уведомления';

  @override
  String get enableNotification => 'Включить уведомления';

  @override
  String get appName => 'Читалка PDF – Просмотрщик PDF';

  @override
  String get toViewYourFiles => 'Чтобы просмотреть ваши файлы, предоставьте';

  @override
  String get withAccessToThem => 'доступ к ним';

  @override
  String get languageOptions => 'Языковые параметры';

  @override
  String get toContinuePleaseGrant => 'Чтобы продолжить, предоставьте';

  @override
  String get acceptToYourFile => 'доступ к вашим файлам.';

  @override
  String get apply => 'Применить';

  @override
  String get other => 'Другое';

  @override
  String get startNow => 'Начать сейчас';

  @override
  String get page => 'Страница';

  @override
  String get goToPage => 'Перейти на страницу';

  @override
  String get pageNumber => 'Номер страницы';

  @override
  String enterPageNumber(int start, int end) {
    return 'Введите номер страницы ($start - $end)';
  }

  @override
  String get invalid => 'Недопустимо';
}
