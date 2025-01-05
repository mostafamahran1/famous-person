import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/person_cubit.dart';
import 'image_screen.dart';

class PersonDetailsScreen extends StatelessWidget {
  final int personId;

  PersonDetailsScreen(this.personId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Details'),
      ),
      body: BlocBuilder<PersonCubit, PersonState>(
        builder: (context, state) {
          if (state is PersonLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PersonDetailsLoaded) {
            final personDetails = state.personDetails;
            final personImages = state.personImages;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    personDetails['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(personDetails['biography'] ?? 'No biography available'),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: personImages.length,
                    itemBuilder: (context, index) {
                      final image = personImages[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(
                                imageUrl: 'https://image.tmdb.org/t/p/w500${image['file_path']}',
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200${image['file_path']}',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
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
