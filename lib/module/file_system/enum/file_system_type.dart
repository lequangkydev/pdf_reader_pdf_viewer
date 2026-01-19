enum FileSystemType {
  all,
  pdf,
  word,
  excel,
  ppt,
  txt,
  image,
  video,
  others,
}

bool isSupportFile(String extension) => allTypeExtension.contains(extension);

final wordsExtension = ['.doc', '.docx'];
final wordsWithoutDot = ['doc', 'docx'];
final pptExtension = ['.ppt', '.pptx'];
final pptWithoutDot = ['ppt', 'pptx'];
final excelsExtension = ['.xls', '.xlsx'];
final excelsWithoutDot = ['xls', 'xlsx'];
final imagesExtension = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
final imagesWithoutDot = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
final allTypeExtension = [
  '.pdf',
  '.doc',
  '.docx',
  '.xls',
  '.xlsx',
  '.ppt',
  '.pptx',
];

List<String> supportExtensions(int index) {
  if (index == 1) {
    return ['pdf'];
  }
  if (index == 2) {
    return wordsWithoutDot;
  }
  if (index == 3) {
    return excelsWithoutDot;
  }
  if (index == 4) {
    return ['txt'];
  }
  if (index == 5) {
    return pptWithoutDot;
  }

  return [
    'pdf',
    'txt',
    ...wordsWithoutDot,
    ...excelsWithoutDot,
    ...pptWithoutDot,
  ];
}
