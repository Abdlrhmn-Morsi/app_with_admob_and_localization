import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'change_lang_state.dart';

class ChangeLangCubit extends Cubit<ChangeLangState> {
  ChangeLangCubit() : super(ChangeLangState());
  SharedPreferences? sharedPreferences;

  final String myKey = 'chosen_lang';
  String theChosenLange = 'en';

  static ChangeLangCubit get(context) => BlocProvider.of(context);

  void saveChoseLange(String chosenLangUser) async {
    await sharedPreferences!.setString(myKey, chosenLangUser);
    getChosenLang();
    emit(ChangeLangState());
  }

  void getChosenLang() async {
    theChosenLange = sharedPreferences!.getString(myKey) ?? 'en';
    emit(ChangeLangState());
  }
}
