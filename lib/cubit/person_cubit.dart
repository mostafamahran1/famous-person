import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../services/api_service.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  final ApiService apiService;
  List<int> favoritePersons = [];

  PersonCubit(this.apiService) : super(PersonInitial());

  void fetchPopularPersons() async {
    try {
      emit(PersonLoading());
      final persons = await apiService.getPopularPersons();
      emit(PersonLoaded(persons));
    } catch (e) {
      emit(PersonError(e.toString()));
    }
  }

  void fetchPersonDetails(int id) async {
    try {
      emit(PersonLoading());
      final personDetails = await apiService.getPersonDetails(id);
      final personImages = await apiService.getPersonImages(id);
      emit(PersonDetailsLoaded(personDetails, personImages));
    } catch (e) {
      emit(PersonError(e.toString()));
    }
  }

  void toggleFavorite(int personId) {
    if (favoritePersons.contains(personId)) {
      favoritePersons.remove(personId);
    } else {
      favoritePersons.add(personId);
    }
    emit(PersonFavoritesUpdated(favoritePersons));
  }
}
