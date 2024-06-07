import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:myapp/logger/log_printer.dart';

import '../services/authentication.dart';
import '../user/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';



class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();
   final logger = Logger(printer: SimpleLogPrinter('AuthenticationFlowScreen: '),
  level: Level.all);
  
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUpUser>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
          final UserModel? user =
          await authService.signUpUser(event.email, event.password);
      if (user != null) {
        emit(AuthenticationSuccessState(user));
        
      } else {
        emit(const AuthenticationFailureState('create user failed'));
      }
      } catch (e) {
        logger.e(e.toString());
      }
     emit(AuthenticationLoadingState(isLoading: false));
    });

     on<SignOut>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        authService.signOutUser();
      } catch (e) {
        logger.i('error');
        logger.e(e.toString());
      } 
       emit(AuthenticationLoadingState(isLoading: false));
     });

     on<LoginUser>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user = await authService.signInUser(event.email,event.password);
         if (user != null) {
        emit(AuthenticationSuccessState(user));
        
      } else {
        emit(const AuthenticationFailureState('Login user failed'));
      }
      } catch (e) {
        logger.i('error');
        logger.e(e.toString());
      } 
       emit(AuthenticationLoadingState(isLoading: false));
     });
}
}