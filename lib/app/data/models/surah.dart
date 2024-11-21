// API URL : https://api.quran.gading.dev/surah
// Get seluruh data surah

class Surah {
  int number;
  int sequence;
  int numberOfVerses;
  Name name;
  Revelation revelation;
  Tafsir tafsir;

  Surah({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
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

class Tafsir {
  String id;

  Tafsir({
    required this.id,
  });
}
