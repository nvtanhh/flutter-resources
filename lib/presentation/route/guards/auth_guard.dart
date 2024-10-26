import 'package:auto_route/auto_route.dart';

import '../../../configs/injector/injection.dart';
import '../../shared_blocs/user/user_cubit.dart';
import '../route.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authenticated = getIt<UserCubit>().state.isLoggedIn;

    if (authenticated) {
      // if user is authenticated we continue
      resolver.next();
    } else {
      resolver.redirect(const SignInWrapperRoute());
    }
  }
}
