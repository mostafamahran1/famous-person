part of 'person_cubit.dart';

@immutable
abstract class PersonState {}

class PersonInitial extends PersonState {}

class PersonLoading extends PersonState {}

class PersonLoaded extends PersonState {
  final List<dynamic> persons;
  PersonLoaded(this.persons);
}

class PersonDetailsLoaded extends PersonState {
  final Map<String, dynamic> personDetails;
  final List<dynamic> personImages;
  PersonDetailsLoaded(this.personDetails, this.personImages);
}

class PersonError extends PersonState {
  final String message;
  PersonError(this.message);
}

class PersonFavoritesUpdated extends PersonState {
  final List<int> favoritePersons;
  PersonFavoritesUpdated(this.favoritePersons);
}
