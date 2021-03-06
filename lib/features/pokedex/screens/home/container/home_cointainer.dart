import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pokedex_flutter/common/error/failure.dart';
import 'package:pokedex_flutter/common/models/pokemon.dart';
import 'package:pokedex_flutter/common/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/features/pokedex/screens/home/pages/home_error.dart';
import 'package:pokedex_flutter/features/pokedex/screens/home/pages/home_loading.dart';
import 'package:pokedex_flutter/features/pokedex/screens/home/pages/home_page.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer(
      {Key? key,
      required this.repository,
      required Null Function(dynamic route, dynamic arguments) onItemTap})
      : super(key: key);
  final IPokemonRepository repository;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: repository.getAllPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HomeLoading();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return HomePage(
              list: snapshot.data!,
              onItemTap: (String, DetailArguments) {},
            );
          }

          if (snapshot.hasError) {
            return HomeError(
              error: (snapshot.error as Failure).message!,
            );
          }

          return Container();
        });
  }
}
