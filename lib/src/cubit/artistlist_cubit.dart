import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_example/src/models/artist_model.dart';
import 'package:flutter_cubit_example/src/repo/repository.dart';
import 'package:meta/meta.dart';

part 'artistlist_state.dart';

class ArtistlistCubit extends Cubit<ArtistlistState> {
  final List<Artist> artistlist = [];

  ArtistlistCubit() : super(const ArtistlistInitial(StateStatus.init)) {
    // for automatically start downloading data
    //getNextArtist();
  }

  void getNextArtist() async {
    emit(const Artistlist()
        .copyWith(status: StateStatus.loading, artistlist: artistlist));

    List<Artist> tmpList =
        await Repository.getTopArtists(offset: artistlist.length);

    artistlist.addAll(tmpList);

    emit(const Artistlist()
        .copyWith(status: StateStatus.loaded, artistlist: artistlist));
  }
}
