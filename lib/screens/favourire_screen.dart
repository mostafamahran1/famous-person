import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/person_cubit.dart';
import 'person_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritePersons = context.watch<PersonCubit>().favoritePersons;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Persons'),
      ),
      body: BlocBuilder<PersonCubit, PersonState>(
        builder: (context, state) {
          if (favoritePersons.isEmpty) {
            return Center(child: Text('No favorites added yet.'));
          } else {
            return ListView.builder(
              itemCount: favoritePersons.length,
              itemBuilder: (context, index) {
                final personId = favoritePersons[index];
                return ListTile(
                  title: Text('Person ID: $personId'), // استخدم API لجلب البيانات الحقيقية
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      context.read<PersonCubit>().toggleFavorite(personId);
                    },
                    tooltip: 'Remove from favorites',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonDetailsScreen(personId),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
