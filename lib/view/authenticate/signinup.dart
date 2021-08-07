import 'package:elok_lagi_restaurant/controller/auth.dart';
import 'package:elok_lagi_restaurant/view/screen/startup.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignInUp extends StatefulWidget {
  @override
  _SignInUpState createState() => _SignInUpState();
}

class _SignInUpState extends State<SignInUp> {
  bool isSignupScreen = false;

  String name = ''; 
  String phoneNum = '';
  String location = '';
  String email = '';
  String password = '';
  String cpassword = '';
  String category = '';

  final List<String> categoryList = [
    'Western Food',
    'Malaysian Food',
    'Fusion',
    'Italian',
    'Desserts',
  ];

  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF3F9),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/elok_lagi_merchant_transparent.png"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xff76a973).withOpacity(.5),
              ),
            ),
          ),
          buildBottomHalfContainer(true),
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.easeInOutBack,
            top: isSignupScreen ? 100 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOutBack,
              height: isSignupScreen ? 600 : 250,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() => isSignupScreen = false);
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Color(0xFF09126C)
                                        : Color(0XFFA7BCC7)),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => isSignupScreen = true);
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Color(0xFF09126C)
                                        : Color(0XFFA7BCC7)),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          buildBottomHalfContainer(false),
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailTextField(Icons.email, "Email"),
            buildPasswordTextField(Icons.lock, "Password"),
          ],
        ),
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildNameTextField(Icons.house_siding, "Restaurant Name"),
            buildPhoneTextField(Icons.phone_android, "Phone Number"),
            buildLocationTextField(Icons.phone_android, "Location"),
            profileUpdateDropDown("Category"),
            buildEmailTextField(Icons.email, "Email"),
            buildPasswordTextField(Icons.lock, "Password"),
            buildCPasswordTextField(Icons.lock, "Confirm Password"),
            Container(
              width: 200,
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(
                    color: Color(0XFF9BB3C0),
                  ),
                  children: [
                    TextSpan(
                      text: "terms & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOutBack,
      top: isSignupScreen ? 650 : 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1.5,
                  blurRadius: 10,
                )
            ],
          ),
          child: !showShadow
              ? GestureDetector(
                  onTap: () async {
                    if (isSignupScreen) {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password, name, phoneNum, location, category);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            // error = 'Please supply a valid email';
                          });
                        }
                      }
                    } else {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Startup()),
                        );
                        if (result == null) {
                          setState(() {
                            loading = false;
                            // error = 'Cannot sign in with those creds';
                          });
                        }
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.orange[200],
                        Colors.red[400],
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              : Center(),
        ),
      ),
    );
  }

  Widget buildNameTextField(IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
          onChanged: (val) => setState(() => name = val),
          validator: RequiredValidator(errorText: 'Please enter your name'),
          keyboardType: TextInputType.emailAddress,
          decoration: textInputDecoration(icon, hintText)),
    );
  }

  Widget buildLocationTextField(IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
          onChanged: (val) => setState(() => location = val),
          validator: RequiredValidator(errorText: 'Please enter your location'),
          keyboardType: TextInputType.emailAddress,
          decoration: textInputDecoration(icon, hintText)),
    );
  }

  Widget buildPhoneTextField(IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
          onChanged: (val) => setState(() => phoneNum = val),
          validator: MultiValidator([
            RequiredValidator(errorText: 'Please enter your phone number'),
            MinLengthValidator(10,
                errorText: "Please enter a valid phone number")
          ]),
          keyboardType: TextInputType.number,
          decoration: textInputDecoration(icon, hintText)),
    );
  }

  Padding profileUpdateDropDown(String initVal) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 8),
      child: DropdownButtonFormField(
        decoration:
            textInputDecoration(Icons.category_outlined, null).copyWith(),
        hint: Text(initVal),
        items: categoryList.map((cat) {
          return DropdownMenuItem(value: cat, child: Text(cat));
        }).toList(),
        validator: (val) {
          String error;
          if (val == null) error = 'Choose restaurant category';
          return error;
        },
        onChanged: (val) => setState(() => category = val),
      ),
    );
  }

  Widget buildEmailTextField(IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
          onChanged: (val) => setState(() => email = val),
          validator: MultiValidator([
            RequiredValidator(errorText: 'Please enter an email'),
            EmailValidator(errorText: 'Email must be valid'),
          ]),
          keyboardType: TextInputType.emailAddress,
          decoration: textInputDecoration(icon, hintText)),
    );
  }

  Widget buildPasswordTextField(IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
          onChanged: (val) => setState(() => password = val),
          controller: passwordController,
          validator: (val) {
            String error;
            if (val.isEmpty)
              error = 'Please enter a password';
            else if (val.length < 6)
              error = 'Password must consist at least 6 characters';
            return error;
          },
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: textInputDecoration(icon, hintText)),
    );
  }

  Widget buildCPasswordTextField(IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
          onChanged: (val) => setState(() => cpassword = val),
          controller: cpasswordController,
          validator: (val) {
            String error;
            if (val.isEmpty)
              error = 'Please enter a password';
            else if (val.length < 6)
              error = 'Password must consist at least 6 characters';
            else if (val != passwordController.text)
              error = 'Password does not match';
            return error;
          },
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: textInputDecoration(icon, hintText)),
    );
  }
}
