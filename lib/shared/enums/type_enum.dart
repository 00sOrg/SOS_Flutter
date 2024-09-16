enum PostType {
  fire,
  typhoon,
  earthquake,
  war,
  flood,
  accident,
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
      case PostType.other:
        return 'OTHER';
      case PostType.none:
        return 'NONE';
    }
  }
}
