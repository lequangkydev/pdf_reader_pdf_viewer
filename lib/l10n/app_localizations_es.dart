// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get saveToAlbum => 'Guardar en el álbum';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imágenes guardadas',
      one: '1 imagen guardada',
      zero: '0 imágenes guardadas',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Compartiendo este archivo vía $appName: muy fácil de ver y editar. Puedes probarlo aquí: $value';
  }

  @override
  String get searchInPdf =>
      'Buscar en <b><span style=\'color:#E01621\'>PDF Reader</span></b>';

  @override
  String get searchInDoc =>
      'Buscar en <b><span style=\'color:#2979FF\'>DOC Reader</span></b>';

  @override
  String get searchInExcel =>
      'Buscar en <b><span style=\'color:#388E3C\'>XLS Reader</span></b>';

  @override
  String get searchInPpt =>
      'Buscar en <b><span style=\'color:#F2590C\'>PPT Reader</span></b>';

  @override
  String get unSelect => 'Deseleccionar';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value archivos',
      one: '1 archivo',
      zero: 'Ningún archivo',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Resumiendo en progreso';

  @override
  String get translationProgress => 'Traducción en progreso';

  @override
  String get tryAnotherFile =>
      'No se puede fusionar este archivo. Intenta seleccionar otro archivo para continuar.';

  @override
  String get result => 'Resultado';

  @override
  String get scroll => 'Desplazar';

  @override
  String get giveFeedback => 'Darme tu opinión';

  @override
  String get add => 'Agregar';

  @override
  String get selectText => 'Seleccionar texto';

  @override
  String get pleaseDoNot => 'Por favor, no incluyas caracteres con acentos';

  @override
  String get pleaseEnter => 'Por favor, introduce un texto';

  @override
  String get watermark => 'Marca de agua';

  @override
  String get enterText => 'Introducir texto';

  @override
  String get color => 'Color';

  @override
  String get addText => 'Agregar texto';

  @override
  String get addWatermark => 'Agregar marca de agua';

  @override
  String get watermarkContent => 'Contenido de la marca de agua';

  @override
  String get editSuccess => '¡Editado con éxito!';

  @override
  String get signature => 'Firma';

  @override
  String get noSignature => 'Sin firma';

  @override
  String get createSignature => 'Crear una nueva firma';

  @override
  String get feedbackTitle => 'Comentarios sobre el Asistente de IA';

  @override
  String get feedbackTo => 'Para: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'Asunto: Comentarios sobre “PDF Reader & Photo to PDF”.';

  @override
  String get feedbackHint => 'Escribe tus comentarios aquí...';

  @override
  String get feedbackButton => 'Enviar comentarios';

  @override
  String get feedbackEmptyMessage =>
      'Por favor, escribe tus comentarios primero';

  @override
  String get feedbackSuccessMessage =>
      'Comentarios enviados (o aplicación de correo abierta)';

  @override
  String get feedbackErrorMessage => 'No se pudo abrir la aplicación de correo';

  @override
  String get downloadSuccess => '¡Descargado con éxito!';

  @override
  String get noTranslate => 'No hay contenido traducido disponible.';

  @override
  String get keyPoint => 'Puntos clave:';

  @override
  String get conclusion => 'Conclusión';

  @override
  String get summary => 'Resumen';

  @override
  String get type => 'Tipo';

  @override
  String get preview => 'Vista previa';

  @override
  String get startTranslate => 'Iniciar traducción';

  @override
  String get startSummary => 'Iniciar resumen';

  @override
  String get translateTo => 'Traducir a';

  @override
  String get summaryStyle => 'Estilo del resumen';

  @override
  String get selectPage => 'Seleccionar página';

  @override
  String get startAISummary => 'Iniciar resumen con IA';

  @override
  String get startAITranslate => 'Iniciar traducción con IA';

  @override
  String get aIAssistant => 'Asistente de IA';

  @override
  String get aITranslate => 'Traducción con IA';

  @override
  String get aISummary => 'Resumen con IA';

  @override
  String get ai_translate_description =>
      '<b>Traduce documentos al instante con IA.\n</b> Con un solo toque, convierte todo tu PDF a otro idioma de forma precisa, natural y sin esfuerzo.';

  @override
  String get ai_summary_description =>
      '<b>Comprende documentos más rápido con el Resumen por IA.\n</b> Convierte PDFs largos en resúmenes claros y bien estructurados con una potente IA—obtén lo esencial sin leer de más.';

  @override
  String get translate1 => 'Traducción completa de documentos en segundos';

  @override
  String get translate2 => 'Resultados claros y naturales impulsados por IA';

  @override
  String get translate3 => 'Compatibilidad con varios idiomas';

  @override
  String get translate4 => 'Ideal para estudio, trabajo y viajes';

  @override
  String get summary1 => 'Resúmenes rápidos con un solo toque';

  @override
  String get summary2 =>
      'Múltiples formatos de resumen para distintos estilos de lectura';

  @override
  String get summary3 => 'Destacados claros de las ideas más importantes';

  @override
  String get summary4 =>
      'Perfecto para estudiantes, profesionales y lectura diaria';

  @override
  String get convertedSuccess => 'Convertido con éxito';

  @override
  String get convertPdfSuccess => '¡Convertido a PDF con éxito!';

  @override
  String get imageToPdf => 'Imagen a PDF';

  @override
  String get youCanHold =>
      'Puedes mantener presionado y arrastrar para reposicionar las imágenes';

  @override
  String get addImage => 'Agregar imagen';

  @override
  String get selectImage => 'Seleccionar imagen';

  @override
  String get selectLanguage =>
      '<b>Seleccionar <span style=\'color:#D90000\'>idioma</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value resultados',
      one: '1 resultado',
      zero: 'Sin resultados',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'Cargando ($value%)...';
  }

  @override
  String get searchOn => 'Buscar en All File Viewer';

  @override
  String get detail => 'Detalles';

  @override
  String get fileSize => 'Tamaño de archivo';

  @override
  String get name => 'Nombre';

  @override
  String get sign => 'Firmar';

  @override
  String get systemLanguage => 'Idioma del sistema';

  @override
  String get done => 'Hecho';

  @override
  String get guideExportImage =>
      'Abre tu galería para ver o compartir tus imágenes.';

  @override
  String get textSetDefault =>
      'Usa PDF Reader - PDF Viewer como predeterminado para abrir archivos.';

  @override
  String get enterPassSelect =>
      'Ingresa la contraseña para seleccionar este archivo.';

  @override
  String get selectThePage =>
      'Selecciona la página que quieres dividir, luego mantén pulsado para moverla y reorganizarla.';

  @override
  String get theFastestWay => 'La forma más rápida de leer tus archivos';

  @override
  String get neverMiss =>
      'Nunca te pierdas actualizaciones importantes de tus documentos.';

  @override
  String get guideMerge => 'Selecciona al menos 2 archivos para combinar.';

  @override
  String get notification => 'Notificaciones';

  @override
  String get allowAccessTo =>
      'Permitir acceso para gestionar todos los archivos';

  @override
  String get useDeviceLanguage => 'Usar el idioma del dispositivo';

  @override
  String get previewConvert => 'Vista previa de conversión';

  @override
  String get download => 'Descargar';

  @override
  String get pdfToLongImages => 'PDF a imágenes largas';

  @override
  String get convertSelect => 'Convertir seleccionados';

  @override
  String get convertAll => 'Convertir todo';

  @override
  String get searchInFile => 'Buscar en el archivo';

  @override
  String get language => 'Idioma';

  @override
  String get thisActionCanContainAds => 'Esta acción puede contener anuncios';

  @override
  String get next => 'Siguiente';

  @override
  String get thank => '¡Gracias!';

  @override
  String get start => 'Comenzar';

  @override
  String get go => 'Ir';

  @override
  String get permission => 'Permiso';

  @override
  String get rate => 'Calificar';

  @override
  String get share => 'Compartir';

  @override
  String get policy => 'Política de privacidad';

  @override
  String get rateUs => 'Califícanos';

  @override
  String get setting => 'Configuración';

  @override
  String get unexpectedError => '¡Ocurrió un error inesperado!';

  @override
  String get alreadyOwnError =>
      'Parece que ya posees este artículo.\nHaz clic en \"Restaurar compra\" para continuar.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get backToHomescreen => 'Volver a la pantalla de inicio';

  @override
  String get exitApp => 'Salir de la aplicación';

  @override
  String get areYouSureYouWantToExitApp =>
      '¿Estás seguro de que quieres salir de la aplicación?';

  @override
  String get pleaseSelectLanguage =>
      'Por favor, selecciona un idioma para continuar';

  @override
  String get allDocumentsViewer => 'Visor de todos los documentos';

  @override
  String get onboardingTitle1 => 'Lee todos los documentos';

  @override
  String get onboardingTitle2 => 'Comprende cualquier documento al instante';

  @override
  String get onboardingTitle3 => 'Edita PDF como un profesional';

  @override
  String get onboardingContent1 =>
      'Abre PDF, Word, Excel y PPT de forma rápida y fluida';

  @override
  String get onboardingContent2 =>
      'Traduce y resume archivos con IA en segundos';

  @override
  String get onboardingContent3 =>
      'Resalta, anota, firma y edita PDFs fácilmente';

  @override
  String get requirePermission =>
      '¡El visor de todos los documentos requiere permiso!';

  @override
  String get goToSetting => 'Ir a la configuración';

  @override
  String get storage => 'Almacenamiento';

  @override
  String get camera => 'Cámara';

  @override
  String get grantPermission => 'Conceder permiso más tarde';

  @override
  String get continuePer => 'Continuar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'Confirmar';

  @override
  String get save => 'Guardar';

  @override
  String get exit => 'Salir de la aplicación';

  @override
  String get doYouWantExitApp => '¿Quieres salir de la aplicación?';

  @override
  String get home => 'Inicio';

  @override
  String get document => 'Documento';

  @override
  String get recent => 'Reciente';

  @override
  String get bookmark => 'Marcador';

  @override
  String get searchOnAllDocumentsViewer =>
      'Buscar en el visor de todos los documentos';

  @override
  String get mergePDF => 'Combinar PDF';

  @override
  String get splitPDF => 'Dividir PDF';

  @override
  String get unlockPDF => 'Desbloquear PDF';

  @override
  String get lockPDF => 'Bloquear PDF';

  @override
  String get scanPDF => 'Escanear PDF';

  @override
  String get pDFToImage => 'PDF a imagen';

  @override
  String get documentTool => 'Herramienta de documento';

  @override
  String get documentReader => 'Lector de documentos';

  @override
  String sumFiles(int count) {
    return '$count archivos';
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
  String get image => 'IMAGEN';

  @override
  String get doYouLikeTheApp => '¿Te gusta la aplicación?';

  @override
  String get rate5 => 'Me encanta';

  @override
  String get rate4 => '¡Genial!';

  @override
  String get rate3 => '¡Buena!';

  @override
  String get rate2 => '¡Pobre!';

  @override
  String get rate1 => '¡Oh no!';

  @override
  String get notNow => 'No ahora';

  @override
  String get print => 'Imprimir';

  @override
  String get renameFile => 'Renombrar archivo';

  @override
  String get pdfConverter => 'Convertidor PDF';

  @override
  String get deleteFromDevice => 'Eliminar del dispositivo';

  @override
  String get fileName => 'Nombre del archivo';

  @override
  String get storagePath => 'Ruta de almacenamiento';

  @override
  String get lastView => 'Última vista';

  @override
  String get lastModified => 'Última modificación';

  @override
  String get size => 'Tamaño';

  @override
  String get rename => 'Renombrar';

  @override
  String get all => 'Todos';

  @override
  String get fileNameCannotBeEmpty =>
      'El nombre del archivo no puede estar vacío';

  @override
  String get pleaseEnterFileName =>
      'Por favor, introduce el nombre del archivo';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String get last7Day => 'Últimos 7 días';

  @override
  String get monthAgo => 'Hace 1 mes';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteIt => '¿Estás seguro de eliminarlo?';

  @override
  String fileSelected(Object count) {
    return '$count archivo seleccionado';
  }

  @override
  String get exitAndDiscard => '¿Salir y descartar los cambios?';

  @override
  String get files => 'archivos';

  @override
  String get discard => 'Descartar';

  @override
  String get redOption => 'ROJO';

  @override
  String get greenOption => 'VERDE';

  @override
  String get blueOption => 'AZUL';

  @override
  String get displayP3HexColor => 'Mostrar color hexagonal P3 #';

  @override
  String get colorsOption => 'Colores';

  @override
  String get gridOption => 'Cuadrícula';

  @override
  String get spectrumOption => 'Espectro';

  @override
  String get slidersOption => 'Controles deslizantes';

  @override
  String get opacityOption => 'Opacidad';

  @override
  String get fontSize => ' Tamaño de fuente:';

  @override
  String get aToz => 'De A a Z';

  @override
  String get zToa => 'De Z a A';

  @override
  String get newToOld => 'Recientes primero';

  @override
  String get oldToNew => 'Antiguos primero';

  @override
  String get smallToLarge => 'De pequeño a grande';

  @override
  String get largeToSmall => 'De grande a pequeño';

  @override
  String get title => 'Título';

  @override
  String get time => 'Fecha';

  @override
  String get open => 'Abrir';

  @override
  String get empty => 'Vacío';

  @override
  String get goHome => 'Ir al inicio';

  @override
  String get merge => 'Combinar';

  @override
  String get success => 'Éxito';

  @override
  String get split => 'Dividir';

  @override
  String get remove => 'Eliminar';

  @override
  String get loading => 'Cargando...';

  @override
  String get sortBy => 'Ordenar por';

  @override
  String get removePwTo =>
      'Eliminar la contraseña, el archivo ya no estará protegido.';

  @override
  String get setPwTo =>
      'Establecer una contraseña para proteger tu archivo PDF.';

  @override
  String get setPassword => 'Establecer contraseña';

  @override
  String get removePassword => 'Eliminar contraseña';

  @override
  String get longImages => 'Imágenes largas';

  @override
  String get separateImages => 'Imágenes separadas';

  @override
  String get unknownError => 'Error desconocido';

  @override
  String get pdfToImages => 'PDF a imágenes';

  @override
  String get exportImageSuccess => '¡Imagen exportada con éxito!';

  @override
  String get lockPdfSuccess => '¡Bloquear PDF exitosamente!';

  @override
  String get scanPdfSuccess => '¡Escanear PDF exitosamente!';

  @override
  String get mergePdfSuccess => '¡PDF combinado con éxito!';

  @override
  String get editPdfSuccess => '¡Editar PDF exitosamente!';

  @override
  String get allDoc => 'Visor de todos los documentos';

  @override
  String get splitSuccess => '¡PDF dividido con éxito!';

  @override
  String get enterPassword => 'Introduce la contraseña';

  @override
  String get enterThePassword =>
      'Introduce la contraseña para abrir el archivo';

  @override
  String get password => 'Contraseña';

  @override
  String get wrongPassword =>
      'Contraseña incorrecta, por favor intenta de nuevo';

  @override
  String passwordProtected(Object path) {
    return '$path está protegido por contraseña';
  }

  @override
  String get unlockPdfSuccess => '¡PDF desbloqueado con éxito!';

  @override
  String get search => 'Buscar';

  @override
  String get errorCharacter =>
      'La entrada contiene caracteres especiales o está vacía. Por favor, introduce texto válido sin caracteres especiales.';

  @override
  String get cameraReqPermission =>
      'Se requiere acceso a la cámara para escanear PDF';

  @override
  String get storageReqPermission =>
      'Se requiere acceso a almacenamiento para ver todos los archivos';

  @override
  String get reqPermission => 'Solicitar permisos';

  @override
  String get underline => 'Subrayar';

  @override
  String get brush => 'Pincel';

  @override
  String get highlight => 'Resaltar';

  @override
  String get strikethrough => 'Tachado';

  @override
  String get anError => 'Ocurrió un error: ';

  @override
  String get errorUpdatePw => 'Error al actualizar la contraseña del PDF: ';

  @override
  String get noDocumentFound => 'No se encontraron documentos';

  @override
  String get sampleFile => 'Archivo de muestra';

  @override
  String get thisSampleFile => 'Este es un archivo de muestra';

  @override
  String get developing => 'Desarrollo';

  @override
  String get doNotSupport => 'No admito este archivo';

  @override
  String get uninstall => 'Desinstalar';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      '¿Qué problemas encuentras durante el uso?';

  @override
  String get dontUninstallYet => 'No desinstales aún';

  @override
  String get stillWantToUninstall => '¿Aún quieres desinstalar?';

  @override
  String get difficultToUse => 'Difícil de usar';

  @override
  String get tooManyAds => 'Demasiados anuncios';

  @override
  String get others => 'Otros';

  @override
  String get viewFiles => 'Ver archivos';

  @override
  String get unableToReceiveFiles => 'No se pueden recibir los archivos';

  @override
  String get unableToViewTheFile => 'No se puede ver el archivo';

  @override
  String get explore => 'Explorar';

  @override
  String whyUninstallApp(String appName) {
    return '¿Por qué desinstalar $appName?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Por favor, ingresa la razón por la que estás desinstalando $appName.';
  }

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get setAsDefault => 'Usar como predeterminado';

  @override
  String get justOnce => 'Solo una vez';

  @override
  String get always => 'Siempre';

  @override
  String get tip => 'Consejo';

  @override
  String get subTip =>
      'Si no encuentras el ícono de la app, pulsa \"Más\" o los tres puntos para buscarlo';

  @override
  String get documentViewer => 'Visor de documentos';

  @override
  String get allowAccess => 'Permitir acceso para gestionar todos los archivos';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Por favor, permite que $appName acceda a todos tus archivos';
  }

  @override
  String get allowPermission => 'Permitir permiso';

  @override
  String get welcomeTo => 'Bienvenido a';

  @override
  String get yourDataRemain => 'Tus datos permanecen privados';

  @override
  String get weNeedPermission =>
      'Necesitamos permiso para acceder a todos los archivos para \n gestionarlos, verlos y organizarlos de manera eficiente';

  @override
  String get failedToLoadPage => 'No se pudo cargar la página';

  @override
  String get savedSuccessfully => 'Guardado exitosamente';

  @override
  String get editPdf => 'Editar PDF';

  @override
  String get textStyle => 'Estilo de texto';

  @override
  String get more => 'Más';

  @override
  String get searchYourFile => 'Buscar archivos';

  @override
  String get select => 'Seleccionar';

  @override
  String imageExported(Object images) {
    return '$images imagen exportada';
  }

  @override
  String imagesExported(Object images) {
    return '$images imágenes exportadas';
  }

  @override
  String get openGallery => 'Abre \"Galería\" para encontrar un archivo';

  @override
  String get tools => 'Herramientas';

  @override
  String get goStatusBar => 'Ve a la barra de estado para encontrarlas.';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Por favor, permite que el Visor de Todos los Documentos\nacceda a todos tus archivos';

  @override
  String get notificationsTurnedOff =>
      'Las notificaciones están desactivadas. Podrías perder documentos importantes';

  @override
  String get tapToOpenSettings =>
      'Toca aquí para abrir la configuración y activar las notificaciones';

  @override
  String get later => 'Más tarde';

  @override
  String get showNotification => 'Mostrar notificaciones';

  @override
  String get enableNotification => 'Activar notificaciones';

  @override
  String get appName => 'Lector de PDF - Visor de PDF';

  @override
  String get toViewYourFiles => 'Para ver tus archivos, por favor proporciona';

  @override
  String get withAccessToThem => 'acceso a ellos';

  @override
  String get languageOptions => 'Opciones de idioma';

  @override
  String get toContinuePleaseGrant => 'Para continuar, por favor conceda';

  @override
  String get acceptToYourFile => 'acceso a sus archivos.';

  @override
  String get apply => 'Aplicar';

  @override
  String get other => 'Otro';

  @override
  String get startNow => 'Comenzar ahora';

  @override
  String get page => 'Página';

  @override
  String get goToPage => 'Ir a la página';

  @override
  String get pageNumber => 'Número de página';

  @override
  String enterPageNumber(int start, int end) {
    return 'Introduce el número de página ($start - $end)';
  }

  @override
  String get invalid => 'No válido';
}
