import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/UI/passField.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiLogin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  // String? _password;
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.lightGreen])),
        child: Center(
          child: Container(
            width: 400,
            height: 300,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 40),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                // TextFormField(
                //   controller: password,
                //   obscureText: _obscureText,
                //   decoration: InputDecoration(
                //     labelText: 'Password',
                //     suffix: IconButton(onPressed: (){
                //      _obscureText = !_obscureText;
                //     }, icon: Icon(Icons.lock))
                //   ),
                // ),
                PassField(passwordController: password),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[300],
                        ),
                        onPressed: () async {
                          final login = await ApiLogin().onLogin({
                            'username': username.text,
                            'password': password.text,
                          }, context);
                          print(await login.toString());
                          //  await login.toString() == "500"
                          // ? await Fluttertoast.showToast(
                          //     msg: "Your username or password wrong!",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.CENTER,
                          //     timeInSecForIosWeb: 2,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0)
                          //       : print('logged in');
                          await login == 500
                              ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password or username!')))
                              : print('accsess');
                        },
                        // onPressed: (){
                        //   print('pressed');
                        //   ApiTest().apiTest(context);
                        // },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        )))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
