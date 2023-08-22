import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/show_alert.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SafeArea(
        
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Logo(title: 'Messenger'),
                _Form(),
                Labels(question: 'Don\'t have an account?', linkText: 'Create one now!', route: 'register'),
                Text('Terms and conditions of use', style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          
          CustomInput(
            icon: Icons.mail_outline, 
            placeholder: 'Email', 
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress, 
          ),

          CustomInput(
            icon: Icons.mail_outline, 
            placeholder: 'Password', 
            textController: passwordCtrl,
            isPassword: true
          ),

          BlueButton(
            text: 'Login', 
            onPressed: authService.authenticating ? null : () async {
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailCtrl.text.trim(), passwordCtrl.text.trim());
              if(loginOk) {
                Navigator.pushReplacementNamed(context, 'users');
              } else {
                showAlert(context, 'Login incorrect', 'Please check your credentials');
              }
            }
          ),

        ],
      ),
    );
  }
}