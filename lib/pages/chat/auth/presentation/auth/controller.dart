import 'package:flutter_modular/flutter_modular.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobx/mobx.dart';
import '../../export.dart';

part 'controller.g.dart';
part 'controller.freezed.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  final authRepo = Modular.get<AuthRepository>();
  final userRepo = Modular.get<UserRepository>();

  @observable
  User currentUser;

  @observable
  AuthState authState = AuthState.initial();

  Stream<User> userStream(String userId) => userRepo.getUserStream(userId);

  @action
  Future<void> addEvent(AuthEvent event) async {
    print('AuthEvent $event');
    await event.when(
      appStarted: () async {
        try {
          final uid = await authRepo.getTokenOrUid();
          if (uid == null) {
            authState = AuthState.unauthenticated();
          } else {
            currentUser = await userRepo.fetchUserData(uid);
            if (currentUser == null) {
              await AuthModule.toRegister();
            } else {
              authState = AuthState.authenticated();
              await Modular.get<NotificationsHelper>()
                  .registerNotification(uid, false);
              await setUserOnline(true);
            }
          }
        } catch (e, s) {
          authState = AuthState.unauthenticated();
        }
      },
      loggedIn: (uid) async {
        currentUser = await userRepo.fetchUserData(uid);
        authState = AuthState.authenticated();
        await setUserOnline(true);
        await Modular.get<NotificationsHelper>()
            .registerNotification(uid, true);
      },
      logout: () async {
        print('----LoggedOut');
        await setUserOnline(false);
        await authRepo.logOut();
        authState = AuthState.unauthenticated();
        currentUser = null;
      },
    );
  }

  Future<void> setUserOnline(bool active) =>
      userRepo.setUserAsActive(currentUser.id, active);

  void logUserId() {}
}

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStarted() = _AppStarted;
  const factory AuthEvent.loggedIn(String uid) = _LoggedIn;
  const factory AuthEvent.logout() = _Logout;
}

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _AuthInitial;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
}
