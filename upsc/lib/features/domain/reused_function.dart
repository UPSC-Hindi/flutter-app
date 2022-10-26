import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/main.dart';

void loginRoute(){
  flutterToast('Section Expired');
  navigatorKey.currentState?.popUntil((route) => false); // navigate to login, with null-aware check
  navigatorKey.currentState?.pushNamed('SignIn'); // navigate to login, with null-aware check
}
