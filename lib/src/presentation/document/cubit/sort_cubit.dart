import 'package:characters/characters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path/path.dart' as p;

import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/utils/localization_util.dart';

enum SortType {
  nameAsc('nameAsc'),
  nameDesc('nameDesc'),
  timeNewOld('timeNewOld'),
  timeOldNew('timeOldNew'),
  sizeSmallBig('sizeSmallBig'),
  sizeBigSmall('sizeBigSmall');

  const SortType(this.code);

  final String code;

  String get title {
    switch (this) {
      case SortType.nameAsc:
        return L10n.tr.name;
      case SortType.nameDesc:
        return L10n.tr.name;
      case SortType.timeNewOld:
        return L10n.tr.lastModified;
      case SortType.timeOldNew:
        return L10n.tr.lastModified;
      case SortType.sizeSmallBig:
        return L10n.tr.fileSize;
      case SortType.sizeBigSmall:
        return L10n.tr.fileSize;
    }
  }

  String get labelString {
    switch (this) {
      case SortType.nameAsc:
        return L10n.tr.aToz;
      case SortType.nameDesc:
        return L10n.tr.zToa;
      case SortType.timeNewOld:
        return L10n.tr.newToOld;
      case SortType.timeOldNew:
        return L10n.tr.oldToNew;
      case SortType.sizeSmallBig:
        return L10n.tr.smallToLarge;
      case SortType.sizeBigSmall:
        return L10n.tr.largeToSmall;
    }
  }

  SvgGenImage get iconWidget {
    switch (this) {
      case SortType.nameAsc:
        return Assets.icons.sortBy.aToZ;
      case SortType.nameDesc:
        return Assets.icons.sortBy.zToA;
      case SortType.timeNewOld:
        return Assets.icons.sortBy.newToOld;
      case SortType.timeOldNew:
        return Assets.icons.sortBy.oldToNew;
      case SortType.sizeSmallBig:
        return Assets.icons.sortBy.smallToLarge;
      case SortType.sizeBigSmall:
        return Assets.icons.sortBy.largeToSmall;
    }
  }

  static SortType fromCode(String code) {
    return SortType.values.firstWhere(
      (e) => e.code == code,
      orElse: () => SortType.timeNewOld,
    );
  }

  static List<FileModel> sortFiles(
      List<FileModel> fileModels, SortType sortType) {
    final List<FileModel> sortedFiles = List<FileModel>.from(fileModels);

    switch (sortType) {
      case SortType.nameAsc:
        sortedFiles.sort((a, b) {
          final nameA = p.basename(a.file.path).toLowerCase();
          final nameB = p.basename(b.file.path).toLowerCase();
          final fA = normalizeFirstChar(nameA);
          final fB = normalizeFirstChar(nameB);
          final cmp = fA.compareTo(fB);
          if (cmp != 0) {
            return cmp;
          }
          return nameA.compareTo(nameB);
        });
        break;

      case SortType.nameDesc:
        sortedFiles.sort((a, b) {
          final nameA = p.basename(a.file.path).toLowerCase();
          final nameB = p.basename(b.file.path).toLowerCase();
          final fA = normalizeFirstChar(nameA);
          final fB = normalizeFirstChar(nameB);
          final cmp = fB.compareTo(fA);
          if (cmp != 0) {
            return cmp;
          }
          return nameB.compareTo(nameA);
        });
        break;

      case SortType.timeNewOld:
        sortedFiles.sort((a, b) {
          if (!b.file.existsSync()) {
            return -1;
          }
          if (!a.file.existsSync()) {
            return 1;
          }
          return b.file.lastModifiedSync().compareTo(a.file.lastModifiedSync());
        });
        break;

      case SortType.timeOldNew:
        sortedFiles.sort((a, b) {
          if (!a.file.existsSync()) {
            return 1;
          }
          if (!b.file.existsSync()) {
            return -1;
          }
          return a.file.lastModifiedSync().compareTo(b.file.lastModifiedSync());
        });
        break;

      case SortType.sizeSmallBig:
        sortedFiles.sort((a, b) {
          if (!a.file.existsSync()) {
            return 1;
          }
          if (!b.file.existsSync()) {
            return -1;
          }
          return a.file.lengthSync().compareTo(b.file.lengthSync());
        });
        break;

      case SortType.sizeBigSmall:
        sortedFiles.sort((a, b) {
          if (!b.file.existsSync()) {
            return -1;
          }
          if (!a.file.existsSync()) {
            return 1;
          }
          return b.file.lengthSync().compareTo(a.file.lengthSync());
        });
        break;
    }

    return sortedFiles;
  }
}

class SortCubit extends HydratedCubit<SortType> {
  SortCubit() : super(SortType.timeNewOld);

  void updateSort(SortType sortType) {
    emit(sortType);
  }

  @override
  SortType fromJson(Map<String, dynamic> json) {
    final code = json['code'] as String?;
    if (code != null) {
      return SortType.fromCode(code);
    }
    return SortType.timeNewOld; // default fallback
  }

  @override
  Map<String, dynamic> toJson(SortType state) {
    return {'code': state.code};
  }
}

String normalizeFirstChar(String input) {
  if (input.isEmpty) return '';
  final first = input.characters.first.toLowerCase();

  const diacritics = {
    'à': 'a',
    'á': 'a',
    'ả': 'a',
    'ã': 'a',
    'ạ': 'a',
    'ă': 'a',
    'ắ': 'a',
    'ằ': 'a',
    'ẳ': 'a',
    'ẵ': 'a',
    'ặ': 'a',
    'â': 'a',
    'ấ': 'a',
    'ầ': 'a',
    'ẩ': 'a',
    'ẫ': 'a',
    'ậ': 'a',
    'đ': 'd',
    'è': 'e',
    'é': 'e',
    'ẻ': 'e',
    'ẽ': 'e',
    'ẹ': 'e',
    'ê': 'e',
    'ế': 'e',
    'ề': 'e',
    'ể': 'e',
    'ễ': 'e',
    'ệ': 'e',
    'ì': 'i',
    'í': 'i',
    'ỉ': 'i',
    'ĩ': 'i',
    'ị': 'i',
    'ò': 'o',
    'ó': 'o',
    'ỏ': 'o',
    'õ': 'o',
    'ọ': 'o',
    'ô': 'o',
    'ố': 'o',
    'ồ': 'o',
    'ổ': 'o',
    'ỗ': 'o',
    'ộ': 'o',
    'ơ': 'o',
    'ớ': 'o',
    'ờ': 'o',
    'ở': 'o',
    'ỡ': 'o',
    'ợ': 'o',
    'ù': 'u',
    'ú': 'u',
    'ủ': 'u',
    'ũ': 'u',
    'ụ': 'u',
    'ư': 'u',
    'ứ': 'u',
    'ừ': 'u',
    'ử': 'u',
    'ữ': 'u',
    'ự': 'u',
    'ỳ': 'y',
    'ý': 'y',
    'ỷ': 'y',
    'ỹ': 'y',
    'ỵ': 'y',
  };

  const cyrillicMap = {
    'а': 'a',
    'б': 'b',
    'в': 'v',
    'г': 'g',
    'д': 'd',
    'е': 'e',
    'ё': 'e',
    'ж': 'zh',
    'з': 'z',
    'и': 'i',
    'й': 'i',
    'к': 'k',
    'л': 'l',
    'м': 'm',
    'н': 'n',
    'о': 'o',
    'п': 'p',
    'р': 'r',
    'с': 's',
    'т': 't',
    'у': 'u',
    'ф': 'f',
    'х': 'kh',
    'ц': 'ts',
    'ч': 'ch',
    'ш': 'sh',
    'щ': 'shch',
    'ъ': '',
    'ы': 'y',
    'ь': '',
    'э': 'e',
    'ю': 'yu',
    'я': 'ya',
    'А': 'a',
    'Б': 'b',
    'В': 'v',
    'Г': 'g',
    'Д': 'd',
    'Е': 'e',
    'Ё': 'e',
    'Ж': 'zh',
    'З': 'z',
    'И': 'i',
    'Й': 'i',
    'К': 'k',
    'Л': 'l',
    'М': 'm',
    'Н': 'n',
    'О': 'o',
    'П': 'p',
    'Р': 'r',
    'С': 's',
    'Т': 't',
    'У': 'u',
    'Ф': 'f',
    'Х': 'kh',
    'Ц': 'ts',
    'Ч': 'ch',
    'Ш': 'sh',
    'Щ': 'shch',
    'Ъ': '',
    'Ы': 'y',
    'Ь': '',
    'Э': 'e',
    'Ю': 'yu',
    'Я': 'ya',
  };

  return diacritics[first] ?? cyrillicMap[first] ?? first;
}
