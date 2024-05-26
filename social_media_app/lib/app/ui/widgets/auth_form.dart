import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../theme/color_palette.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;
  const AuthForm({Key? key, this.isLogin = true}) : super(key: key);
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  late AuthController _authController;
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String _name = "";
  bool _isHidden = true;



  void toggleView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  @override
  void initState() {
    super.initState();
    _authController = Get.put(AuthController());
  }

  @override
  void dispose() {
    super.dispose();
    _authController.onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (!widget.isLogin)
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white38,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  labelText: "Name",
                  labelStyle: TextStyle(color: ColorPalette.primaryVariant),
                  suffixIcon: const Icon(Icons.person,color: ColorPalette.primaryVariant,),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
                style: const TextStyle(height: 1.0,color: Colors.black),
              ),
            ),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                filled: true,
                fillColor: Colors.white38,
                labelText: "Email",
                labelStyle: TextStyle(color: ColorPalette.primaryVariant),
                suffixIcon: Icon(Icons.email, color: ColorPalette.primaryVariant),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
              style: const TextStyle(color: Colors.black, overflow: TextOverflow.visible),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white38,
                labelStyle: const TextStyle(color: ColorPalette.primaryVariant),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isHidden ? Icons.visibility_off : Icons.visibility,
                    color: ColorPalette.primaryVariant,
                  ),
                  onPressed: toggleView,
                ),
              ),
              obscureText: _isHidden,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              onSaved: (value) {
                _password = value!;
              },
              style: const TextStyle(height: 1.0,color: Colors.black),
            ),
          ),
          if (!widget.isLogin) const SizedBox(height: 10),
          if (!widget.isLogin)
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white38,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(color: ColorPalette.primaryVariant)
                ),
                obscureText: _isHidden,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _confirmPassword = value;
                  });
                },
                style: const TextStyle(height: 1.0,color: Colors.black),
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (widget.isLogin) {
                    _authController.signIn(_email, _password);
                  } else {
                    _authController.signUp(_email, _password, _name);
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(ColorPalette.widgetColor),
              ),
              child: Text(
                widget.isLogin ? "Log In" : "Sign Up",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
