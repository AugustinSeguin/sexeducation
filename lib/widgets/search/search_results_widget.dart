import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexeducation/state_management/search/search_cubit.dart';
import 'package:go_router/go_router.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchStateInitial) {
                return const SizedBox.shrink();
              } else if (state is SearchStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchStateError) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal:
                            16.0), // Ajustez la valeur pour définir la marge souhaitée
                    child: Text(state.message),
                  ),
                );
              } else if (state is SearchStateSuccess) {
                return Column(children: [
                  Text(state.posts.isEmpty
                      ? 'Pas de résultats'
                      : 'Résultats des publications'),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) => ListTile(
                      title:
                          Text(state.posts.elementAt(index)?.title ?? 'Titre'),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
