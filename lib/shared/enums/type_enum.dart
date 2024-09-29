enum PostType {
  fire,
  typhoon,
  earthquake,
  war,
  flood,
  accident,
  carAccident,
  other,
  none,
}

extension PostTypeExtension on PostType {
  String get name {
    switch (this) {
      case PostType.fire:
        return 'FIRE';
      case PostType.typhoon:
        return 'TYPHOON';
      case PostType.earthquake:
        return 'EARTHQUAKE';
      case PostType.war:
        return 'WAR';
      case PostType.flood:
        return 'FLOOD';
      case PostType.accident:
        return 'ACCIDENT';
      case PostType.carAccident:
        return 'CAR_ACCIDENT';
      case PostType.other:
        return 'OTHER';
      case PostType.none:
        return 'NONE';
    }
  }
}

extension PostTypeKoreanExtension on PostType {
  String get koreanName {
    switch (this) {
      case PostType.fire:
        return '화재';
      case PostType.typhoon:
        return '태풍';
      case PostType.earthquake:
        return '지진';
      case PostType.war:
        return '전쟁';
      case PostType.flood:
        return '홍수';
      case PostType.accident:
        return '사고';
      case PostType.carAccident:
        return '교통사고';
      case PostType.other:
        return '기타';
      case PostType.none:
        return '기타';
    }
  }
}

PostType getPostTypeFromString(String eventType) {
  switch (eventType.toUpperCase()) {
    case 'FIRE':
      return PostType.fire;
    case 'TYPHOON':
      return PostType.typhoon;
    case 'EARTHQUAKE':
      return PostType.earthquake;
    case 'WAR':
      return PostType.war;
    case 'FLOOD':
      return PostType.flood;
    case 'ACCIDENT':
      return PostType.accident;
    case 'CAR_ACCIDENT':
      return PostType.carAccident;
    case 'OTHER':
      return PostType.other;
    case 'NONE':
      return PostType.none;
    default:
      return PostType.none; // Default case
  }
}
