import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_example/src/cubit/artistlist_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const scrollPosition = PageStorageKey('ScrollPosition');
    bool loadingInProgress = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Endless List with Cubit'),
      ),
      body: Column(
        children: [
          BlocBuilder<ArtistlistCubit, ArtistlistState>(
            builder: (context, state) {
              if (state is ArtistlistInitial) {
                return const Expanded(
                    child: Center(child: Text('Click the button to download')));
              }

              if (state is Artistlist) {
                final length = state.artistlist.length;
                loadingInProgress = state.status == StateStatus.loading;

                if (state.artistlist.isEmpty) {
                  return const Expanded(
                      child: Center(
                    child: MyCircularProgressIndicator(),
                  ));
                }

                return Expanded(
                  child: ListView.builder(
                    key: scrollPosition,
                    itemCount: length,
                    itemBuilder: (context, index) {
                      final nameArt = state.artistlist[index].name;

                      if (state.status == StateStatus.loading &&
                          index == length - 1) {
                        return Column(
                          children: [
                            ArtistListItem(nameArt: nameArt),
                            const MyCircularProgressIndicator(),
                          ],
                        );
                      }

                      return ArtistListItem(nameArt: nameArt);
                    },
                  ),
                );
              }

              return const MyCircularProgressIndicator();
            },
          ),
          // Button 'Load more'
          Center(
            child: Padding(
              padding: const EdgeInsets.all(64.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (!loadingInProgress) {
                      BlocProvider.of<ArtistlistCubit>(context).getNextArtist();
                      loadingInProgress = true;
                    }
                  },
                  child: const Text('Load more')),
            ),
          )
        ],
      ),
    );
  }
}

class ArtistListItem extends StatelessWidget {
  const ArtistListItem({
    Key? key,
    required this.nameArt,
  }) : super(key: key);

  final String nameArt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.auto_awesome_outlined,
        size: 28.0,
      ),
      title: Text(nameArt),
      subtitle: Text('Details about the $nameArt'),
    );
  }
}

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
          height: 28.0, width: 28.0, child: CircularProgressIndicator()),
    ));
  }
}
