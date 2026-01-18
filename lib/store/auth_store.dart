import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  String? email;

  @observable
  String? username;

  @observable
  String? password;

  @action
  void setEmail(String? value) {
    email = value;
  }

  @action
  void setUsername(String? value) {
    username = value;
  }

  @action setPassword(String? value) {
    password = value;
  }


}