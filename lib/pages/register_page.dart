import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class RegisterPage extends StatelessWidget {

  const RegisterPage({super.key});

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
                Logo(title: 'Messenger register'),
                _Form(),
                Labels(question: 'Do you have an account?', linkText: 'Login here', route: 'login'),
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

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          
          CustomInput(
            icon: Icons.supervised_user_circle, 
            placeholder: 'First name', 
            textController: firstNameCtrl
          ),

          CustomInput(
            icon: Icons.supervised_user_circle, 
            placeholder: 'Last name', 
            textController: lastNameCtrl
          ),

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

          CustomInput(
            icon: Icons.mail_outline, 
            placeholder: 'Confirm password', 
            textController: confirmPasswordCtrl,
            isPassword: true
          ),

          BlueButton(text: 'Login', onPressed: () {
            print(firstNameCtrl.text);
            print(lastNameCtrl.text);
            print(emailCtrl.text);
            print(passwordCtrl.text);
            print(confirmPasswordCtrl.text);
          }),

        ],
      ),
    );
  }
}