import 'package:flutter_cubit_example/src/models/artist_model.dart';

// Fake repository
class Repository {
  static Future<List<Artist>> getTopArtists({required int offset}) async {
    await Future.delayed(const Duration(seconds: 5));

    if (DataArtist.dataArt.isEmpty) {
      DataArtist.initItems();
    }

    try {
      return DataArtist.dataArt.getRange(offset, offset + 10).toList();
    } catch (e) {
      return <Artist>[];
    }
  }
}

// for example, 30 elements are enough
class DataArtist {
  static List<Artist> dataArt = [];

  static initItems() {
    for (var i = 1; i < 31; i++) {
      dataArt.add(Artist('Artist $i'));
    }
  }
}
