import 'package:go_router/go_router.dart';


enum Routes {
  splash,
  login,
  register,
  emailVerifiPage,
  homeScreen,
  calender,
  allDataScreen,
  editProfile,
  home,
  individualFullData,
  mealHistory,
  payment,
}

class MyRouter {
  static GoRouter router = GoRouter(routes: [


    // GoRoute(
    //     path: '/${Routes.allDataScreen.name}/:userId',
    //     builder: (context, state) =>  AllDataScreen(user: state.params['userId']!),
    //     name: Routes.allDataScreen.name),
  ]);
}
