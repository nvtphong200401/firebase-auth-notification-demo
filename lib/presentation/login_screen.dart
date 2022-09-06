import 'package:demo_firebase/db/database_auth.dart';
import 'package:demo_firebase/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider = StateProvider((ref) => '');
final loginProvider = StateProvider((ref) => true);
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController txtUserName = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  FirebaseAuthentication auth = FirebaseAuthentication();

  @override
  Widget build(BuildContext context) {
    String message = ref.watch(messageProvider.state).state;
    final isLogin = ref.watch(loginProvider.state).state;

    String btnText = isLogin ? 'Log in' : 'Sign up';
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                child: TextFormField(
                  controller: txtUserName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: 'User Name', icon: Icon(Icons.verified_user)),
                  validator: (text) =>
                  text!.isEmpty ? 'User Name is required' : '',
                )),
            Padding(
                padding: EdgeInsets.only(top: 24),
                child: TextFormField(
                  controller: txtPassword,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'password',
                      icon: Icon(Icons.enhanced_encryption)),
                  validator: (text) =>
                  text!.isEmpty ? 'Password is required' : '',
                )),
            Padding(
                padding: MediaQuery.of(context).padding,
                child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColorLight),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: const BorderSide(color: Colors.red)),
                          ),
                        ),
                        child: Text(
                          btnText,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        onPressed: () async {
                          if(isLogin){
                            final result = await auth.login(txtUserName.text, txtPassword.text);
                              if(result == null){
                                ref.read(messageProvider.notifier).state = 'login failed';
                              }
                              else {
                                ref.read(messageProvider.notifier).state = 'login success';
                                // Navigator.pushReplacementNamed(context, '/detail');
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                              }
                            }
                          else {
                            auth.createUser(txtUserName.text, txtPassword.text).then((value){
                              if(value == null){
                                ref.read(messageProvider.notifier).state = 'registration failed';
                              }
                              else {
                                ref.read(messageProvider.notifier).state = 'registration success';
                              }
                            });
                          }
                        }))),
            TextButton(
              child: Text(btnText),
              onPressed: () {
                ref.read(loginProvider.notifier).state = !isLogin;
              },
            ),
            Text(
              message,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}


