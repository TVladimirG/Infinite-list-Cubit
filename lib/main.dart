import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_example/src/cubit/artistlist_cubit.dart';

import 'src/app.dart';

void main() async {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ArtistlistCubit>(
        create: (context) => ArtistlistCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}
