// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get saveToAlbum => 'Salvar no álbum';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imagens salvas',
      one: '1 imagem salva',
      zero: '0 imagens salvas',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Sharing this file via $appName – super easy to view & edit. You can try it here: $value';
  }

  @override
  String get searchInPdf =>
      'Pesquisar no <b><span style=\'color:#E01621\'>Leitor de PDF</span></b>';

  @override
  String get searchInDoc =>
      'Pesquisar no <b><span style=\'color:#2979FF\'>Leitor de DOC</span></b>';

  @override
  String get searchInExcel =>
      'Pesquisar no <b><span style=\'color:#388E3C\'>Leitor de XLS</span></b>';

  @override
  String get searchInPpt =>
      'Pesquisar no <b><span style=\'color:#F2590C\'>Leitor de PPT</span></b>';

  @override
  String get unSelect => 'Desmarcar';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value ficheiros',
      one: '1 ficheiro',
      zero: 'Nenhum ficheiro',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Resumo em andamento';

  @override
  String get translationProgress => 'Tradução em andamento';

  @override
  String get tryAnotherFile =>
      'Não foi possível unir este ficheiro. Tente selecionar um ficheiro diferente para continuar.';

  @override
  String get result => 'Resultado';

  @override
  String get scroll => 'Deslizar';

  @override
  String get giveFeedback => 'Dá-me um feedback';

  @override
  String get add => 'Adicionar';

  @override
  String get selectText => 'Selecionar texto';

  @override
  String get pleaseDoNot => 'Por favor, não inclua caracteres acentuados';

  @override
  String get pleaseEnter => 'Por favor, insira algum texto';

  @override
  String get watermark => 'Marca de água';

  @override
  String get enterText => 'Inserir texto';

  @override
  String get color => 'Cor';

  @override
  String get addText => 'Adicionar texto';

  @override
  String get addWatermark => 'Adicionar marca de água';

  @override
  String get watermarkContent => 'Conteúdo da marca de água';

  @override
  String get editSuccess => 'Editado com sucesso!';

  @override
  String get signature => 'Assinatura';

  @override
  String get noSignature => 'Sem assinatura';

  @override
  String get createSignature => 'Criar nova assinatura';

  @override
  String get feedbackTitle => 'Feedback sobre o Assistente de IA';

  @override
  String get feedbackTo => 'Para: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'Assunto: Feedback sobre “PDF Reader & Photo to PDF”.';

  @override
  String get feedbackHint => 'Escreva o seu feedback aqui...';

  @override
  String get feedbackButton => 'Enviar Feedback';

  @override
  String get feedbackEmptyMessage =>
      'Por favor, escreva o seu feedback primeiro';

  @override
  String get feedbackSuccessMessage =>
      'Feedback enviado (ou aplicação de e-mail aberta)';

  @override
  String get feedbackErrorMessage =>
      'Não foi possível abrir a aplicação de e-mail';

  @override
  String get downloadSuccess => 'Transferência concluída com sucesso!';

  @override
  String get noTranslate => 'Nenhum conteúdo traduzido disponível.';

  @override
  String get keyPoint => 'Pontos-chave:';

  @override
  String get conclusion => 'Conclusão';

  @override
  String get summary => 'Resumo';

  @override
  String get type => 'Tipo';

  @override
  String get preview => 'Pré-visualizar';

  @override
  String get startTranslate => 'Iniciar Tradução';

  @override
  String get startSummary => 'Iniciar Resumo';

  @override
  String get translateTo => 'Traduzir para';

  @override
  String get summaryStyle => 'Estilo de resumo';

  @override
  String get selectPage => 'Selecionar página';

  @override
  String get startAISummary => 'Iniciar Resumo de IA';

  @override
  String get startAITranslate => 'Iniciar Tradução de IA';

  @override
  String get aIAssistant => 'Assistente de IA';

  @override
  String get aITranslate => 'Tradução de IA';

  @override
  String get aISummary => 'Resumo de IA';

  @override
  String get ai_translate_description =>
      '<b>Traduza documentos instantaneamente com IA.\n</b> Com um toque, converta todo o seu PDF para outro idioma de forma precisa e natural.';

  @override
  String get ai_summary_description =>
      '<b>Compreenda documentos mais rapidamente com o Resumo por IA.\n</b> Transforme PDFs longos em resumos concisos e bem estruturados usando IA poderosa.';

  @override
  String get translate1 => 'Tradução completa de documentos em segundos';

  @override
  String get translate2 => 'Resultados claros e naturais com IA';

  @override
  String get translate3 => 'Suporte para vários idiomas';

  @override
  String get translate4 => 'Ideal para estudo, trabalho e viagens';

  @override
  String get summary1 => 'Resumos rápidos com um toque';

  @override
  String get summary2 =>
      'Vários formatos de resumo para diferentes estilos de leitura';

  @override
  String get summary3 => 'Destaque claro das ideias mais importantes';

  @override
  String get summary4 =>
      'Excelente para académicos, profissionais e leitura diária';

  @override
  String get convertedSuccess => 'Convertido com sucesso';

  @override
  String get convertPdfSuccess => 'Convertido para PDF com sucesso!';

  @override
  String get imageToPdf => 'Imagem para PDF';

  @override
  String get youCanHold =>
      'Pode segurar e arrastar para reposicionar\nas imagens';

  @override
  String get addImage => 'Adicionar imagem';

  @override
  String get selectImage => 'Selecionar imagem';

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value resultados',
      one: '1 resultado',
      zero: 'Sem resultados',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'A carregar ($value%)...';
  }

  @override
  String get searchOn => 'Pesquisar no All File Viewer';

  @override
  String get detail => 'Detalhes';

  @override
  String get fileSize => 'Tamanho do arquivo';

  @override
  String get name => 'Nome';

  @override
  String get sign => 'Assinar';

  @override
  String get systemLanguage => 'Idioma do sistema';

  @override
  String get done => 'Concluído';

  @override
  String get guideExportImage =>
      'Abra sua galeria para visualizar ou compartilhar suas imagens.';

  @override
  String get textSetDefault =>
      'Defina PDF Reader - PDF Viewer como predefinido para abrir já.';

  @override
  String get enterPassSelect => 'Insira a senha para selecionar este ficheiro.';

  @override
  String get selectThePage =>
      'Selecione a página que quer dividir, toque e mantenha para a reorganizar entre as outras.';

  @override
  String get theFastestWay => 'A forma mais rápida de abrir os seus ficheiros';

  @override
  String get neverMiss =>
      'Nunca perca atualizações importantes dos seus documentos.';

  @override
  String get guideMerge => 'Selecione pelo menos 2 ficheiros para unir.';

  @override
  String get notification => 'Notificações';

  @override
  String get allowAccessTo => 'Permitir acesso para gerir todos os ficheiros';

  @override
  String get useDeviceLanguage => 'Usar a língua do dispositivo';

  @override
  String get previewConvert => 'Pré-visualizar conversão';

  @override
  String get download => 'Baixar';

  @override
  String get pdfToLongImages => 'PDF para imagens longa';

  @override
  String get convertSelect => 'Converter selecionado';

  @override
  String get convertAll => 'Converter tudo';

  @override
  String get searchInFile => 'Pesquisar no arquivo';

  @override
  String get language => 'Idioma';

  @override
  String get thisActionCanContainAds => 'Esta ação pode conter anúncios';

  @override
  String get next => 'Próximo';

  @override
  String get thank => 'Obrigado!';

  @override
  String get start => 'Começar';

  @override
  String get go => 'Ir';

  @override
  String get permission => 'Permissão';

  @override
  String get rate => 'Avaliar';

  @override
  String get share => 'Compartilhar';

  @override
  String get policy => 'Política de Privacidade';

  @override
  String get rateUs => 'Avalie-nos';

  @override
  String get setting => 'Configuração';

  @override
  String get unexpectedError => 'Ocorreu um erro inesperado!';

  @override
  String get alreadyOwnError =>
      'Parece que você já possui este item.\nPor favor, clique em \"Restaurar compra\" para continuar.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get backToHomescreen => 'Voltar para a tela inicial';

  @override
  String get exitApp => 'Sair';

  @override
  String get areYouSureYouWantToExitApp =>
      'Você tem certeza de que deseja sair do aplicativo?';

  @override
  String get pleaseSelectLanguage =>
      'Por favor, selecione um idioma para continuar';

  @override
  String get allDocumentsViewer => 'Visualizador de Todos os Documentos';

  @override
  String get onboardingTitle1 => 'Leia todos os documentos';

  @override
  String get onboardingTitle2 =>
      'Compreenda qualquer documento instantaneamente';

  @override
  String get onboardingTitle3 => 'Edite PDFs como um profissional';

  @override
  String get onboardingContent1 =>
      'Abra PDF, Word, Excel e PPT de forma rápida e contínua';

  @override
  String get onboardingContent2 =>
      'Traduza e resuma ficheiros com IA em segundos';

  @override
  String get onboardingContent3 =>
      'Realce, anote, assine e edite PDFs facilmente';

  @override
  String get requirePermission =>
      'O Visualizador de Todos os Documentos requer permissão!';

  @override
  String get goToSetting => 'Ir para configurações';

  @override
  String get storage => 'Armazenamento';

  @override
  String get camera => 'Câmera';

  @override
  String get grantPermission => 'Conceder permissão depois';

  @override
  String get continuePer => 'Continuar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'Ok';

  @override
  String get save => 'Salvar';

  @override
  String get exit => 'Sair do aplicativo';

  @override
  String get doYouWantExitApp => 'Você deseja sair do aplicativo?';

  @override
  String get home => 'Início';

  @override
  String get document => 'Documento';

  @override
  String get recent => 'Recentes';

  @override
  String get bookmark => 'Marcador';

  @override
  String get searchOnAllDocumentsViewer => 'Pesquisar em Todos os Documentos';

  @override
  String get mergePDF => 'Mesclar PDF';

  @override
  String get splitPDF => 'Dividir PDF';

  @override
  String get unlockPDF => 'Desbloquear PDF';

  @override
  String get lockPDF => 'Bloquear PDF';

  @override
  String get scanPDF => 'Digitalizar PDF';

  @override
  String get pDFToImage => 'PDF para Imagem';

  @override
  String get documentTool => 'Ferramenta de Documento';

  @override
  String get documentReader => 'Leitor de Documentos';

  @override
  String sumFiles(int count) {
    return '$count arquivos';
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
  String get image => 'IMAGEM';

  @override
  String get doYouLikeTheApp => 'Você gosta do aplicativo?';

  @override
  String get rate5 => 'Adoro';

  @override
  String get rate4 => 'Ótimo!';

  @override
  String get rate3 => 'Bom!';

  @override
  String get rate2 => 'Ruim!';

  @override
  String get rate1 => 'Oh não!';

  @override
  String get notNow => 'Não agora';

  @override
  String get print => 'Imprimir';

  @override
  String get renameFile => 'Renomear arquivo';

  @override
  String get pdfConverter => 'Conversor de PDF';

  @override
  String get deleteFromDevice => 'Excluir do Dispositivo';

  @override
  String get fileName => 'Nome do arquivo';

  @override
  String get storagePath => 'Local do arquivo';

  @override
  String get lastView => 'Última visualização';

  @override
  String get lastModified => 'Última modificação';

  @override
  String get size => 'Tamanho';

  @override
  String get rename => 'Renomear';

  @override
  String get all => 'Todos';

  @override
  String get fileNameCannotBeEmpty => 'O nome do arquivo não pode estar vazio';

  @override
  String get pleaseEnterFileName => 'Por favor, insira o nome do arquivo';

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String get last7Day => 'Últimos 7 dias';

  @override
  String get monthAgo => '1 mês atrás';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteIt => 'Você tem certeza de que deseja excluí-lo?';

  @override
  String fileSelected(Object count) {
    return '$count Arquivo selecionado';
  }

  @override
  String get exitAndDiscard => 'Sair e descartar as alterações?';

  @override
  String get files => 'arquivos';

  @override
  String get discard => 'Descartar';

  @override
  String get redOption => 'VERMELHO';

  @override
  String get greenOption => 'VERDE';

  @override
  String get blueOption => 'AZUL';

  @override
  String get displayP3HexColor => 'Exibir Cor Hex P3 #';

  @override
  String get colorsOption => 'Cores';

  @override
  String get gridOption => 'Grade';

  @override
  String get spectrumOption => 'Espectro';

  @override
  String get slidersOption => 'Deslizadores';

  @override
  String get opacityOption => 'Opacidade';

  @override
  String get fontSize => ' Tamanho da fonte:';

  @override
  String get aToz => 'De A a Z';

  @override
  String get zToa => 'De Z a A';

  @override
  String get newToOld => 'De novo para velho';

  @override
  String get oldToNew => 'De velho para novo';

  @override
  String get smallToLarge => 'De pequeno para grande';

  @override
  String get largeToSmall => 'De grande para pequeno';

  @override
  String get title => 'Título';

  @override
  String get time => 'Hora';

  @override
  String get open => 'Abrir';

  @override
  String get empty => 'Vazio';

  @override
  String get goHome => 'Página Inicial';

  @override
  String get merge => 'Mesclar';

  @override
  String get success => 'Sucesso';

  @override
  String get split => 'Dividir';

  @override
  String get remove => 'Remover';

  @override
  String get loading => 'Carregando...';

  @override
  String get sortBy => 'Ordenar por';

  @override
  String get removePwTo =>
      'Remover a senha, o arquivo não estará mais protegido.';

  @override
  String get setPwTo => 'Defina uma senha para proteger seu arquivo PDF.';

  @override
  String get setPassword => 'Definir Senha';

  @override
  String get removePassword => 'Remover Senha';

  @override
  String get longImages => 'Imagens Longas';

  @override
  String get separateImages => 'Separar Imagens';

  @override
  String get unknownError => 'Erro desconhecido';

  @override
  String get pdfToImages => 'PDF para Imagens';

  @override
  String get exportImageSuccess => 'Imagem exportada com sucesso!';

  @override
  String get lockPdfSuccess => 'PDF bloqueado com sucesso!';

  @override
  String get scanPdfSuccess => 'PDF digitalizado com sucesso!';

  @override
  String get mergePdfSuccess => 'PDF mesclado com sucesso!';

  @override
  String get editPdfSuccess => 'PDF editado com sucesso!';

  @override
  String get allDoc => 'Visualizador de Todos os Documentos';

  @override
  String get splitSuccess => 'PDF dividido com sucesso!';

  @override
  String get enterPassword => 'Digite a senha';

  @override
  String get enterThePassword => 'Digite a senha para abrir o arquivo';

  @override
  String get password => 'Senha';

  @override
  String get wrongPassword => 'Senha incorreta, por favor tente novamente';

  @override
  String passwordProtected(Object path) {
    return '$path está protegido por senha';
  }

  @override
  String get unlockPdfSuccess => 'PDF desbloqueado com sucesso!';

  @override
  String get search => 'Pesquisar';

  @override
  String get errorCharacter =>
      'A entrada contém caracteres especiais ou está vazia. Por favor, insira um texto válido sem caracteres especiais.';

  @override
  String get cameraReqPermission =>
      'O acesso à câmera é necessário para digitalizar o PDF';

  @override
  String get storageReqPermission =>
      'O acesso ao armazenamento é necessário para visualizar todos os arquivos';

  @override
  String get reqPermission => 'Solicitar permissões';

  @override
  String get underline => 'Sublinhado';

  @override
  String get brush => 'Pincel';

  @override
  String get highlight => 'Destaque';

  @override
  String get strikethrough => 'Tachado';

  @override
  String get anError => 'Ocorreu um erro: ';

  @override
  String get errorUpdatePw => 'Erro ao atualizar a senha do PDF: ';

  @override
  String get noDocumentFound => 'Nenhum documento encontrado';

  @override
  String get sampleFile => 'Arquivo de amostra';

  @override
  String get thisSampleFile => 'Este é um arquivo de amostra';

  @override
  String get developing => 'Em desenvolvimento';

  @override
  String get doNotSupport => 'Não suporta este ficheiro';

  @override
  String get uninstall => 'Desinstalar';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'Que problemas encontrou durante o uso?';

  @override
  String get dontUninstallYet => 'Ainda não desinstale';

  @override
  String get stillWantToUninstall => 'Ainda quer desinstalar?';

  @override
  String get difficultToUse => 'Difícil de usar';

  @override
  String get tooManyAds => 'Demasiados anúncios';

  @override
  String get others => 'Outros';

  @override
  String get viewFiles => 'Ver ficheiros';

  @override
  String get unableToReceiveFiles => 'Não é possível receber os ficheiros';

  @override
  String get unableToViewTheFile => 'Não é possível visualizar o ficheiro';

  @override
  String get explore => 'Explorar';

  @override
  String whyUninstallApp(String appName) {
    return 'Porque desinstalar $appName?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Por favor, insira o motivo para desinstalar $appName.';
  }

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get setAsDefault => 'Definir como padrão';

  @override
  String get justOnce => 'Apenas uma vez';

  @override
  String get always => 'Sempre';

  @override
  String get tip => 'Dica';

  @override
  String get subTip =>
      'Se não encontrar o ícone, toque em “Mais” ou nos três pontos para procurar';

  @override
  String get documentViewer => 'Visualizador de Documentos';

  @override
  String get allowAccess => 'Permitir acesso para gerir todos os ficheiros';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Por favor, permita que o $appName aceda a todos os seus ficheiros';
  }

  @override
  String get allowPermission => 'Permitir permissão';

  @override
  String get welcomeTo => 'Bem-vindo ao';

  @override
  String get yourDataRemain => 'Os seus dados permanecem privados';

  @override
  String get weNeedPermission =>
      'Precisamos de permissão para acessar todos os arquivos para \n gerenciá-los, visualizá-los e organizá-los de forma eficiente';

  @override
  String get failedToLoadPage => 'Falha ao carregar a página';

  @override
  String get savedSuccessfully => 'Salvo com sucesso';

  @override
  String get editPdf => 'Editar PDF';

  @override
  String get textStyle => 'Estilo de texto';

  @override
  String get more => 'Mais';

  @override
  String get searchYourFile => 'Pesquise seus arquivos';

  @override
  String get select => 'Selecionar';

  @override
  String imageExported(Object images) {
    return '$images imagem exportada';
  }

  @override
  String imagesExported(Object images) {
    return '$images imagens exportadas';
  }

  @override
  String get openGallery => 'Abra a \"Galeria\" para encontrar um arquivo';

  @override
  String get tools => 'Ferramentas';

  @override
  String get goStatusBar => 'Ir para a barra de status para encontrar imagens';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Por favor, permita que o Visualizador de Todos os Documentos\nacesse todos os seus arquivos';

  @override
  String get notificationsTurnedOff =>
      'As notificações estão desativadas! Pode perder documentos importantes';

  @override
  String get tapToOpenSettings =>
      'Toque aqui para abrir as configurações e ativar as notificações';

  @override
  String get later => 'Mais tarde';

  @override
  String get showNotification => 'Mostrar notificações';

  @override
  String get enableNotification => 'Ativar notificações';

  @override
  String get appName => 'Leitor de PDF - Visualizador de PDF';

  @override
  String get toViewYourFiles => 'Para ver os seus ficheiros, por favor forneça';

  @override
  String get withAccessToThem => 'acesso aos mesmos';

  @override
  String get languageOptions => 'Opções de idioma';

  @override
  String get toContinuePleaseGrant => 'Para continuar, por favor conceda';

  @override
  String get acceptToYourFile => 'acesso aos seus arquivos.';

  @override
  String get apply => 'Aplicar';

  @override
  String get other => 'Outro';

  @override
  String get startNow => 'Começar agora';

  @override
  String get page => 'Página';

  @override
  String get goToPage => 'Ir para a página';

  @override
  String get pageNumber => 'Número da página';

  @override
  String enterPageNumber(int start, int end) {
    return 'Insira o número da página ($start - $end)';
  }

  @override
  String get invalid => 'Inválido';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get saveToAlbum => 'Salvar no álbum';

  @override
  String imagesSaved(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imagens salvas',
      one: '1 imagem salva',
      zero: '0 imagens salvas',
    );
    return '$_temp0';
  }

  @override
  String shareMessage(Object appName, Object value) {
    return 'Compartilhando este arquivo via $appName – super fácil de visualizar e editar. Experimente aqui: $value';
  }

  @override
  String get searchInPdf =>
      'Pesquisar no <b><span style=\'color:#E01621\'>Leitor de PDF</span></b>';

  @override
  String get searchInDoc =>
      'Pesquisar no <b><span style=\'color:#2979FF\'>Leitor de DOC</span></b>';

  @override
  String get searchInExcel =>
      'Pesquisar no <b><span style=\'color:#388E3C\'>Leitor de XLS</span></b>';

  @override
  String get searchInPpt =>
      'Pesquisar no <b><span style=\'color:#F2590C\'>Leitor de PPT</span></b>';

  @override
  String get unSelect => 'Desmarcar';

  @override
  String file(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value arquivos',
      one: '1 arquivo',
      zero: 'Nenhum arquivo',
    );
    return '$_temp0';
  }

  @override
  String get summaryProgress => 'Resumo em andamento';

  @override
  String get translationProgress => 'Tradução em andamento';

  @override
  String get tryAnotherFile =>
      'Não foi possível mesclar este arquivo. Tente selecionar outro arquivo para continuar.';

  @override
  String get result => 'Resultado';

  @override
  String get scroll => 'Rolar';

  @override
  String get giveFeedback => 'Dê-me um feedback';

  @override
  String get add => 'Adicionar';

  @override
  String get selectText => 'Selecionar texto';

  @override
  String get pleaseDoNot => 'Por favor, não inclua caracteres acentuados';

  @override
  String get pleaseEnter => 'Por favor, insira algum texto';

  @override
  String get watermark => 'Marca d\'água';

  @override
  String get enterText => 'Insira o texto';

  @override
  String get color => 'Cor';

  @override
  String get addText => 'Adicionar texto';

  @override
  String get addWatermark => 'Adicionar marca d\'água';

  @override
  String get watermarkContent => 'Conteúdo da marca d\'água';

  @override
  String get editSuccess => 'Editado com sucesso!';

  @override
  String get signature => 'Assinatura';

  @override
  String get noSignature => 'Sem assinatura';

  @override
  String get createSignature => 'Criar nova assinatura';

  @override
  String get feedbackTitle => 'Feedback sobre o Assistente de IA';

  @override
  String get feedbackTo => 'Para: kyle@vtn-global.com';

  @override
  String get feedbackSubject =>
      'Assunto: Feedback sobre “PDF Reader & Photo to PDF”.';

  @override
  String get feedbackHint => 'Escreva seu feedback aqui...';

  @override
  String get feedbackButton => 'Enviar Feedback';

  @override
  String get feedbackEmptyMessage => 'Por favor, escreva seu feedback primeiro';

  @override
  String get feedbackSuccessMessage =>
      'Feedback enviado (ou aplicativo de e-mail aberto)';

  @override
  String get feedbackErrorMessage =>
      'Não foi possível abrir o aplicativo de e-mail';

  @override
  String get downloadSuccess => 'Download concluído com sucesso!';

  @override
  String get noTranslate => 'Nenhum conteúdo traduzido disponível.';

  @override
  String get keyPoint => 'Pontos-chave:';

  @override
  String get conclusion => 'Conclusão';

  @override
  String get summary => 'Resumo';

  @override
  String get type => 'Tipo';

  @override
  String get preview => 'Pré-visualização';

  @override
  String get startTranslate => 'Iniciar Tradução';

  @override
  String get startSummary => 'Iniciar Resumo';

  @override
  String get translateTo => 'Traduzir para';

  @override
  String get summaryStyle => 'Estilo do resumo';

  @override
  String get selectPage => 'Selecionar página';

  @override
  String get startAISummary => 'Iniciar Resumo de IA';

  @override
  String get startAITranslate => 'Iniciar Tradução de IA';

  @override
  String get aIAssistant => 'Assistente de IA';

  @override
  String get aITranslate => 'Tradução de IA';

  @override
  String get aISummary => 'Resumo de IA';

  @override
  String get ai_translate_description =>
      '<b>Traduza documentos instantaneamente com IA.\n</b> Com apenas um toque, converta todo o seu PDF para outro idioma com precisão e naturalidade.';

  @override
  String get ai_summary_description =>
      '<b>Entenda documentos mais rápido com o Resumo por IA.\n</b> Transforme PDFs longos em resumos concisos e bem organizados usando IA poderosa.';

  @override
  String get translate1 => 'Tradução de documentos completos em segundos';

  @override
  String get translate2 => 'Resultados claros e naturais com IA';

  @override
  String get translate3 => 'Suporte a vários idiomas';

  @override
  String get translate4 => 'Ideal para estudos, trabalho e viagens';

  @override
  String get summary1 => 'Resumos rápidos com um toque';

  @override
  String get summary2 =>
      'Vários formatos de resumo para diferentes estilos de leitura';

  @override
  String get summary3 => 'Destaque claro das ideias mais importantes';

  @override
  String get summary4 =>
      'Perfeito para estudantes, profissionais e leitura do dia a dia';

  @override
  String get convertedSuccess => 'Convertido com sucesso';

  @override
  String get convertPdfSuccess => 'Convertido para PDF com sucesso!';

  @override
  String get imageToPdf => 'Imagem para PDF';

  @override
  String get youCanHold =>
      'Você pode segurar e arrastar para reposicionar\nas imagens';

  @override
  String get addImage => 'Adicionar imagem';

  @override
  String get selectImage => 'Selecionar imagem';

  @override
  String get selectLanguage =>
      '<b>Selecionar <span style=\'color:#D90000\'>Idioma</span></b>';

  @override
  String valueResults(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value resultados',
      one: '1 resultado',
      zero: 'Sem resultados',
    );
    return '$_temp0';
  }

  @override
  String loadingSplash(Object value) {
    return 'Carregando ($value%)...';
  }

  @override
  String get searchOn => 'Pesquisar no All File Viewer';

  @override
  String get detail => 'Detalhes';

  @override
  String get fileSize => 'Tamanho do arquivo';

  @override
  String get name => 'Nome';

  @override
  String get sign => 'Assinar';

  @override
  String get systemLanguage => 'Idioma do sistema';

  @override
  String get done => 'Concluído';

  @override
  String get guideExportImage =>
      'Abra sua galeria para visualizar ou compartilhar suas imagens.';

  @override
  String get textSetDefault =>
      'Defina PDF Reader - PDF Viewer como padrão para abrir rápido.';

  @override
  String get enterPassSelect => 'Digite a senha para selecionar este arquivo.';

  @override
  String get selectThePage =>
      'Selecione a página que deseja dividir, toque e segure para arrastar e reorganizar.';

  @override
  String get theFastestWay => ' A forma mais rápida de abrir seus arquivos';

  @override
  String get neverMiss =>
      'Nunca perca atualizações importantes dos seus documentos.';

  @override
  String get guideMerge => 'Selecione pelo menos 2 arquivos para mesclar.';

  @override
  String get notification => 'Notificações';

  @override
  String get allowAccessTo =>
      'Permitir acesso para gerenciar todos os arquivos';

  @override
  String get useDeviceLanguage => 'Usar o idioma do dispositivo';

  @override
  String get previewConvert => 'Visualizar conversão';

  @override
  String get download => 'Baixar';

  @override
  String get pdfToLongImages => 'PDF para imagens longas';

  @override
  String get convertSelect => 'Converter selecionados';

  @override
  String get convertAll => 'Converter tudo';

  @override
  String get searchInFile => 'Pesquisar no arquivo';

  @override
  String get language => 'Idioma';

  @override
  String get thisActionCanContainAds => 'Esta ação pode conter anúncios';

  @override
  String get next => 'Próximo';

  @override
  String get thank => 'Obrigado!';

  @override
  String get start => 'Iniciar';

  @override
  String get go => 'Ir';

  @override
  String get permission => 'Permissão';

  @override
  String get rate => 'Avaliar';

  @override
  String get share => 'Compartilhar';

  @override
  String get policy => 'Política de Privacidade';

  @override
  String get rateUs => 'Avalie-nos';

  @override
  String get setting => 'Configurações';

  @override
  String get unexpectedError => 'Ocorreu um erro inesperado!';

  @override
  String get alreadyOwnError =>
      'Parece que você já possui este item.\nClique em \'Restaurar Compra\' para continuar.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get backToHomescreen => 'Voltar para a página inicial';

  @override
  String get exitApp => 'Sair do aplicativo';

  @override
  String get areYouSureYouWantToExitApp =>
      'Tem certeza de que deseja sair do aplicativo?';

  @override
  String get pleaseSelectLanguage => 'Selecione um idioma para continuar';

  @override
  String get allDocumentsViewer => 'Visualizador de Documentos';

  @override
  String get onboardingTitle1 => 'Leia todos os documentos';

  @override
  String get onboardingTitle2 => 'Entenda qualquer documento instantaneamente';

  @override
  String get onboardingTitle3 => 'Edite PDFs como um profissional';

  @override
  String get onboardingContent1 =>
      'Abra PDF, Word, Excel e PPT de forma rápida e fluida';

  @override
  String get onboardingContent2 =>
      'Traduza e resuma arquivos com IA em segundos';

  @override
  String get onboardingContent3 =>
      'Destaque, anote, assine e edite PDFs facilmente';

  @override
  String get requirePermission =>
      'O Visualizador de Documentos requer permissão!';

  @override
  String get goToSetting => 'Ir para Configurações';

  @override
  String get storage => 'Armazenamento';

  @override
  String get camera => 'Câmera';

  @override
  String get grantPermission => 'Conceder permissão mais tarde';

  @override
  String get continuePer => 'Continuar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Salvar';

  @override
  String get exit => 'Sair';

  @override
  String get doYouWantExitApp => 'Deseja sair do aplicativo?';

  @override
  String get home => 'Início';

  @override
  String get document => 'Documento';

  @override
  String get recent => 'Recentes';

  @override
  String get bookmark => 'Marcador';

  @override
  String get searchOnAllDocumentsViewer =>
      'Pesquisar no Visualizador de Documentos';

  @override
  String get mergePDF => 'Mesclar PDF';

  @override
  String get splitPDF => 'Dividir PDF';

  @override
  String get unlockPDF => 'Desbloquear PDF';

  @override
  String get lockPDF => 'Proteger PDF';

  @override
  String get scanPDF => 'Digitalizar PDF';

  @override
  String get pDFToImage => 'Converter PDF para Imagem';

  @override
  String get documentTool => 'Ferramenta de Documentos';

  @override
  String get documentReader => 'Leitor de Documentos';

  @override
  String sumFiles(int count) {
    return '$count arquivos';
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
  String get image => 'Imagem';

  @override
  String get doYouLikeTheApp => 'Você gosta do aplicativo?';

  @override
  String get rate5 => 'Adorei!';

  @override
  String get rate4 => 'Muito bom!';

  @override
  String get rate3 => 'Bom!';

  @override
  String get rate2 => 'Pode melhorar!';

  @override
  String get rate1 => 'Não gostei!';

  @override
  String get notNow => 'Agora não';

  @override
  String get print => 'Imprimir';

  @override
  String get renameFile => 'Renomear Arquivo';

  @override
  String get pdfConverter => 'Conversor PDF';

  @override
  String get deleteFromDevice => 'Excluir do aparelho';

  @override
  String get fileName => 'Nome do Arquivo';

  @override
  String get storagePath => 'Caminho de Armazenamento';

  @override
  String get lastView => 'Última Visualização';

  @override
  String get lastModified => 'Última Modificação';

  @override
  String get size => 'Tamanho';

  @override
  String get rename => 'Renomear';

  @override
  String get all => 'Todos';

  @override
  String get fileNameCannotBeEmpty => 'O nome do arquivo não pode estar vazio';

  @override
  String get pleaseEnterFileName => 'Digite o nome do arquivo';

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String get last7Day => 'Últimos 7 dias';

  @override
  String get monthAgo => 'Mês passado';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteIt => 'Deseja realmente excluir?';

  @override
  String fileSelected(Object count) {
    return '$count arquivos selecionado';
  }

  @override
  String get exitAndDiscard => 'Sair e descartar as alterações?';

  @override
  String get files => 'Arquivos';

  @override
  String get discard => 'Descartar';

  @override
  String get redOption => 'VERMELHO';

  @override
  String get greenOption => 'VERDE';

  @override
  String get blueOption => 'AZUL';

  @override
  String get displayP3HexColor => 'Exibir Cor Hex P3 #';

  @override
  String get colorsOption => 'Cores';

  @override
  String get gridOption => 'Grade';

  @override
  String get spectrumOption => 'Espectro';

  @override
  String get slidersOption => 'Deslizantes';

  @override
  String get opacityOption => 'Opacidade';

  @override
  String get fontSize => ' Tamanho da fonte:';

  @override
  String get aToz => 'De A a Z';

  @override
  String get zToa => 'De Z a A';

  @override
  String get newToOld => 'Do mais novo ao mais antigo';

  @override
  String get oldToNew => 'Do mais antigo ao mais novo';

  @override
  String get smallToLarge => 'Do menor para o maior';

  @override
  String get largeToSmall => 'Do maior para o menor';

  @override
  String get title => 'Título';

  @override
  String get time => 'Tempo';

  @override
  String get open => 'Abrir';

  @override
  String get empty => 'Vazio';

  @override
  String get goHome => 'Voltar ao Início';

  @override
  String get merge => 'Mesclar';

  @override
  String get success => 'Sucesso';

  @override
  String get split => 'Dividir';

  @override
  String get remove => 'Remover';

  @override
  String get loading => 'Carregando...';

  @override
  String get sortBy => 'Ordenar por';

  @override
  String get removePwTo =>
      'Remova a senha para que o arquivo não esteja mais protegido.';

  @override
  String get setPwTo => 'Defina uma senha para proteger seu arquivo PDF.';

  @override
  String get setPassword => 'Defina Senha';

  @override
  String get removePassword => 'Remover Senha';

  @override
  String get longImages => 'Imagens Longas';

  @override
  String get separateImages => 'Imagens Separadas';

  @override
  String get unknownError => 'Erro desconhecido';

  @override
  String get pdfToImages => 'PDF para Imagens';

  @override
  String get exportImageSuccess => 'Exportação de imagem bem-sucedida!';

  @override
  String get lockPdfSuccess => 'PDF bloqueado com sucesso!';

  @override
  String get scanPdfSuccess => 'Digitalização de PDF bem-sucedida!';

  @override
  String get mergePdfSuccess => 'Mesclagem de PDF bem-sucedida!';

  @override
  String get editPdfSuccess => 'Edição de PDF bem-sucedida!';

  @override
  String get allDoc => 'Visualizador de Todos os Documentos';

  @override
  String get splitSuccess => 'Divisão de PDF bem-sucedida!';

  @override
  String get enterPassword => 'Digite a senha';

  @override
  String get enterThePassword => 'Digite a senha para abrir o arquivo';

  @override
  String get password => 'Senha';

  @override
  String get wrongPassword => 'Senha incorreta, tente novamente';

  @override
  String passwordProtected(Object path) {
    return '$path está protegido por senha';
  }

  @override
  String get unlockPdfSuccess => 'Desbloqueio de PDF bem-sucedido!';

  @override
  String get search => 'Pesquisar';

  @override
  String get errorCharacter =>
      'A entrada contém caracteres especiais ou está vazia. Digite um texto válido sem caracteres especiais.';

  @override
  String get cameraReqPermission =>
      'O acesso à câmera é necessário para digitalizar PDFs';

  @override
  String get storageReqPermission =>
      'O acesso ao armazenamento é necessário para visualizar todos os arquivos';

  @override
  String get reqPermission => 'Solicitar permissão';

  @override
  String get underline => 'Sublinhado';

  @override
  String get brush => 'Pincel';

  @override
  String get highlight => 'Realce';

  @override
  String get strikethrough => 'Tachado';

  @override
  String get anError => 'Ocorreu um erro: ';

  @override
  String get errorUpdatePw => 'Erro ao atualizar a senha do PDF: ';

  @override
  String get noDocumentFound => 'Nenhum documento encontrado';

  @override
  String get sampleFile => 'Arquivo de Exemplo';

  @override
  String get thisSampleFile => 'Este é um arquivo de exemplo';

  @override
  String get developing => 'Em desenvolvimento';

  @override
  String get doNotSupport => 'Este arquivo não é suportado';

  @override
  String get uninstall => 'Desinstalar';

  @override
  String get whatProblemsYouEncounterDuringUse =>
      'Quais problemas você encontrou durante o uso?';

  @override
  String get dontUninstallYet => 'Ainda não desinstale';

  @override
  String get stillWantToUninstall => 'Ainda quer desinstalar?';

  @override
  String get difficultToUse => 'Difícil de usar';

  @override
  String get tooManyAds => 'Muitos anúncios';

  @override
  String get others => 'Outros';

  @override
  String get viewFiles => 'Ver arquivos';

  @override
  String get unableToReceiveFiles => 'Não é possível receber os arquivos';

  @override
  String get unableToViewTheFile => 'Não é possível visualizar o arquivo';

  @override
  String get explore => 'Explorar';

  @override
  String whyUninstallApp(String appName) {
    return 'Por que desinstalar $appName?';
  }

  @override
  String pleaseEnterReasonForUninstalling(String appName) {
    return 'Por favor, insira o motivo para desinstalar $appName.';
  }

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get setAsDefault => 'Defina como padrão';

  @override
  String get justOnce => 'Apenas uma vez';

  @override
  String get always => 'Sempre';

  @override
  String get tip => 'Dica';

  @override
  String get subTip =>
      'Se você não encontrar o ícone do aplicativo, toque em \'Mais\' ou nos três pontos para procurá-lo';

  @override
  String get documentViewer => 'Visualizador de Documentos';

  @override
  String get allowAccess => 'Permitir acesso para gerenciar todos os arquivos';

  @override
  String pleaseAllowAll(Object appName) {
    return 'Por favor, permita que o $appName acesse todos os seus arquivos';
  }

  @override
  String get allowPermission => 'Permitir permissão';

  @override
  String get welcomeTo => 'Bem-vindo ao';

  @override
  String get yourDataRemain => 'Seus dados permanecem privados';

  @override
  String get weNeedPermission =>
      'Precisamos de permissão para acessar todos os arquivos para \n gerenciá-los, visualizá-los e organizá-los com eficiência';

  @override
  String get failedToLoadPage => 'Falha ao carregar a página';

  @override
  String get savedSuccessfully => 'Salvo com sucesso';

  @override
  String get editPdf => 'Editar PDF';

  @override
  String get textStyle => 'Estilo de texto';

  @override
  String get more => 'Mais';

  @override
  String get searchYourFile => 'Pesquise seus arquivos';

  @override
  String get select => 'Selecionar';

  @override
  String imageExported(Object images) {
    return '$images imagem exportada';
  }

  @override
  String imagesExported(Object images) {
    return '$images imagens exportadas';
  }

  @override
  String get openGallery => 'Abra a \"Galeria\" para encontrar um arquivo';

  @override
  String get tools => 'Ferramentas';

  @override
  String get goStatusBar =>
      'Acesse a barra de status para encontrar as imagens.';

  @override
  String get pleaseAllowAllDocumentsViewer =>
      'Por favor, permita que o Visualizador de Todos os Documentos\nacesse todos os seus arquivos';

  @override
  String get notificationsTurnedOff =>
      'As notificações estão desativadas! Você pode perder documentos importantes';

  @override
  String get tapToOpenSettings =>
      'Toque aqui para abrir as configurações e ativar as notificações';

  @override
  String get later => 'Depois';

  @override
  String get showNotification => 'Mostrar notificações';

  @override
  String get enableNotification => 'Ativar notificações';

  @override
  String get appName => 'Leitor de PDF - Visualizador de PDF';

  @override
  String get toViewYourFiles => 'Para visualizar seus arquivos, forneça';

  @override
  String get withAccessToThem => 'acesso a eles';

  @override
  String get languageOptions => 'Opções de idioma';

  @override
  String get toContinuePleaseGrant => 'Para continuar, por favor conceda';

  @override
  String get acceptToYourFile => 'acesso aos seus arquivos.';

  @override
  String get apply => 'Aplicar';

  @override
  String get other => 'Outro';

  @override
  String get startNow => 'Começar agora';

  @override
  String get page => 'Página';

  @override
  String get goToPage => 'Ir para a página';

  @override
  String get pageNumber => 'Número da página';

  @override
  String enterPageNumber(int start, int end) {
    return 'Digite o número da página ($start - $end)';
  }

  @override
  String get invalid => 'Inválido';
}
