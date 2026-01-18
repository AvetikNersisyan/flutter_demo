import 'package:mobx/mobx.dart';
import '../data/auth_repo.dart';
import '../data/user.dart';
import '../data/services/storage.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  late final LocalAuthRepository _authRepo;

  AuthStoreBase() {
    _authRepo = LocalAuthRepository(UserStorageService());
  }

  // Form fields
  @observable
  String? email;

  @observable
  String? username;

  @observable
  String? password;

  // Authentication state
  @observable
  User? currentUser;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  void setEmail(String? value) {
    email = value;
  }

  @action
  void setUsername(String? value) {
    username = value;
  }

  @action
  void setPassword(String? value) {
    password = value;
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  @action
  void clearForm() {
    email = null;
    username = null;
    password = null;
    errorMessage = null;
  }

  @action
  Future<bool> register() async {
    if (email == null || username == null || password == null) {
      errorMessage = 'All fields are required';
      return false;
    }

    isLoading = true;
    errorMessage = null;

    try {
      final result = await _authRepo.register(
        username: username!,
        email: email!,
        password: password!,
      );

      if (result.ok && result.user != null) {
        currentUser = result.user;
        clearForm();
        return true;
      } else {
        errorMessage = result.error ?? 'Registration failed';
        return false;
      }
    } catch (e) {
      errorMessage = 'Registration failed: $e';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> login() async {
    if (username == null || password == null) {
      errorMessage = 'Username and password are required';
      return false;
    }

    isLoading = true;
    errorMessage = null;

    try {
      final result = await _authRepo.login(
        username: username!,
        password: password!,
      );

      if (result.ok && result.user != null) {
        print({
          result.user,
          'in_store'
        });
        currentUser = result.user;
        clearForm();
        return true;
      } else {
        errorMessage = result.error ?? 'Login failed';
        return false;
      }
    } catch (e) {
      errorMessage = 'Login failed s: $e';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    isLoading = true;
    try {
      await _authRepo.logout();
      currentUser = null;
      clearForm();
    } catch (e) {
      errorMessage = 'Logout failed: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> checkSession() async {
    isLoading = true;
    try {
      final user = await _authRepo.getCurrentUser();
      currentUser = user;
    } catch (e) {
      currentUser = null;
    } finally {
      isLoading = false;
    }
  }
}

final AuthStore authStore = AuthStore();