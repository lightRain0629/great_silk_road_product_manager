import 'package:flutter/material.dart';
import 'package:great_silk_road_product_manager/apiBYY/apiLogin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 300,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(children: [
              Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                  label: Text('Username'),
                ),
              ),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  label: Text('Password'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                         ApiLogin().onLogin({
                          'username': username.text,
                          'password': password.text,
                        }, context);
                      },
                      // onPressed: (){
                      //   print('pressed');
                      //   ApiTest().apiTest(context);
                      // },
                      child: Text('Login')))
            ]),
          ),
        ),
      ),
    );
  }
}
