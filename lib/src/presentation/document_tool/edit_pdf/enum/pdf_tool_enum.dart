enum PdfToolEnum { add, style, sign }

enum DetailToolEditEnum {
  //add: addText, addImage, waterMark
  addText,
  addImage,
  waterMark,

  //style: highlight, unline, strike, brush
  highlight,
  unline,
  strike,
  brush,

  //sign: sign
  sign
}

extension DetailToolEditEnumX on DetailToolEditEnum {
  bool get isStyle {
    switch (this) {
      case DetailToolEditEnum.highlight:
      case DetailToolEditEnum.unline:
      case DetailToolEditEnum.strike:
        return true;
      default:
        return false;
    }
  }

  bool get isHide {
    switch (this) {
      case DetailToolEditEnum.addText:
      case DetailToolEditEnum.addImage:
      case DetailToolEditEnum.waterMark:
      case DetailToolEditEnum.sign:
        return true;
      default:
        return false;
    }
  }
}
