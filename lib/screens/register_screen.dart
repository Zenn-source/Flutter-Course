import 'package:iguiron_mobprog/constants.dart';
import 'package:iguiron_mobprog/widgets/custom_font.dart';
import 'package:iguiron_mobprog/widgets/custom_inkwell_button.dart';
import 'package:iguiron_mobprog/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'signin_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobilenumController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registration is for demo purposes only. Please sign in with the '
            'demo account: emilys / emilyspass',
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(25),
            ScreenUtil().setHeight(40),
            ScreenUtil().setWidth(25),
            ScreenUtil().setHeight(10),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: ScreenUtil().setHeight(25)),
                CustomFont(
                  text: 'Register Here',
                  fontSize: ScreenUtil().setSp(50),
                  fontWeight: FontWeight.bold,
                  color: FB_DARK_PRIMARY,
                ),
                SizedBox(height: ScreenUtil().setHeight(25)),

                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'First name',
                  validator: (value) =>
                      value!.isEmpty ? 'First name is required' : null,
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: firstnameController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),

                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'Last name',
                  validator: (value) =>
                      value!.isEmpty ? 'Last name is required' : null,
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: lastnameController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),

                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'Username',
                  validator: (value) =>
                      value!.isEmpty ? 'Username is required' : null,
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: usernameController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),

                CustomTextFormField(
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'Mobile Num',
                  validator: (value) {
                    if (value!.isEmpty) return 'Mobile number is required';
                    if (value.length != 11) return 'Must be 11 digits';
                    return null;
                  },
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: mobilenumController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),

                CustomTextFormField(
                  isObscure: !_isPasswordVisible,
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'Password',

                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password is required';
                    String pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) return 'Password too weak';
                    return null;
                  },
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: passwordController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),

                // Helper Text
                Text(
                  '(Password should be 8 characters, a mixture of letter and numbers consisting of at least one special character with Uppercase and Lowercase letters.)',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: ScreenUtil().setSp(10),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),

                CustomTextFormField(
                  isObscure: !_isConfirmPasswordVisible,
                  hintText: 'Confirm Password',
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Confirm your password';
                    if (value != passwordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: confirmpasswordController,
                ),
                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have an account? ',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.popAndPushNamed(context, '/signin'),
                      child: Text(
                        'Login here',
                        style: TextStyle(
                          color: FB_DARK_PRIMARY,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),

                CustomInkwellButton(
                  onTap: () => register(),
                  height: ScreenUtil().setHeight(45),
                  width: ScreenUtil().screenWidth,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                  buttonName: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
