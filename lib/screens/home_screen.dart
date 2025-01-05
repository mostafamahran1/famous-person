import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/person_cubit.dart';
import 'favourire_screen.dart';
import 'person_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Famous Persons'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PersonCubit, PersonState>(
        builder: (context, state) {
          if (state is PersonLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PersonLoaded) {
            return ListView.builder(
              itemCount: state.persons.length,
              itemBuilder: (context, index) {
                final person = state.persons[index];
                final isFavorite = context.read<PersonCubit>().favoritePersons.contains(person['id']);
                return ListTile(
                  title: Text(person['name']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://image.tmdb.org/t/p/w200${person['profile_path']}',
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      context.read<PersonCubit>().toggleFavorite(person['id']);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonDetailsScreen(person['id']),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is PersonError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
