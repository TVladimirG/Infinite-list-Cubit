part of 'artistlist_cubit.dart';

enum StateStatus { init, loading, loaded }

@immutable
abstract class ArtistlistState {
  const ArtistlistState();
}

@immutable
class ArtistlistInitial extends ArtistlistState {
  const ArtistlistInitial(StateStatus init);
}

@immutable
class Artistlist extends ArtistlistState {
  const Artistlist({
    this.status = StateStatus.init,
    this.artistlist = const <Artist>[],
  });

  final StateStatus status;
  final List<Artist> artistlist;

  Artistlist copyWith({
    StateStatus? status,
    List<Artist>? artistlist,
  }) {
    return Artistlist(
      status: status ?? this.status,
      artistlist: artistlist ?? this.artistlist,
    );
  }
}
