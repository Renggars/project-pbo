class DetailSurah {
  int number;
  int sequence;
  int numberOfVerses;
  Name name;
  Revelation revelation;
  DetailSurahTafsir tafsir;
  PreBismillah preBismillah;
  List<Verse> verses;

  DetailSurah({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
    required this.preBismillah,
    required this.verses,
  });
}

class Name {
  String short;
  String long;
  Translation transliteration;
  Translation translation;

  Name({
    required this.short,
    required this.long,
    required this.transliteration,
    required this.translation,
  });
}

class Translation {
  String en;
  String id;

  Translation({
    required this.en,
    required this.id,
  });
}

class PreBismillah {
  Text text;
  Translation translation;
  Audio audio;

  PreBismillah({
    required this.text,
    required this.translation,
    required this.audio,
  });
}

class Audio {
  String primary;
  List<String> secondary;

  Audio({
    required this.primary,
    required this.secondary,
  });
}

class Text {
  String arab;
  Transliteration transliteration;

  Text({
    required this.arab,
    required this.transliteration,
  });
}

class Transliteration {
  String en;

  Transliteration({
    required this.en,
  });
}

class Revelation {
  String arab;
  String en;
  String id;

  Revelation({
    required this.arab,
    required this.en,
    required this.id,
  });
}

class DetailSurahTafsir {
  String id;

  DetailSurahTafsir({
    required this.id,
  });
}

class Verse {
  Number number;
  Meta meta;
  Text text;
  Translation translation;
  Audio audio;
  VerseTafsir tafsir;

  Verse({
    required this.number,
    required this.meta,
    required this.text,
    required this.translation,
    required this.audio,
    required this.tafsir,
  });
}

class Meta {
  int juz;
  int page;
  int manzil;
  int ruku;
  int hizbQuarter;
  Sajda sajda;

  Meta({
    required this.juz,
    required this.page,
    required this.manzil,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });
}

class Sajda {
  bool recommended;
  bool obligatory;

  Sajda({
    required this.recommended,
    required this.obligatory,
  });
}

class Number {
  int inQuran;
  int inSurah;

  Number({
    required this.inQuran,
    required this.inSurah,
  });
}

class VerseTafsir {
  Id id;

  VerseTafsir({
    required this.id,
  });
}

class Id {
  String short;
  String long;

  Id({
    required this.short,
    required this.long,
  });
}
