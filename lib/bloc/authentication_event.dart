part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
 
}

class SignUpUser extends AuthenticationEvent {
  final String email;
  final String password;
  final String agentName;

  const SignUpUser(this.email, this.password, this.agentName);

  @override
  List<Object> get props => [email, password, agentName];
}


class LoginUser extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginUser(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthenticationEvent {
  
}