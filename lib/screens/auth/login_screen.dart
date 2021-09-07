import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'package:supervisor_yemen_glory/screens/Main/main_screen.dart';

import '../../constraints.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late String phoneNumber;
  late String password;

  bool _isPageLoading = true;
  bool _isDataLoading = false;

  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  bool passwordVisible = true;

  final passwordFocusNode = FocusNode();

  final buttonFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'images/logo.png',
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: TextFormField(
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      maxLength: 9,
                      strutStyle: StrutStyle(height: 1.5),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        counterText: '',
                        labelText: 'رقم الهاتف',
                        hintText: "اكتب رقم هاتفك هنا",
                        labelStyle:
                        TextStyle(fontFamily: kPrimaryFont, fontSize: 14.0),
                        hintStyle:
                        TextStyle(fontFamily: kPrimaryFont, fontSize: 12.0),
                        fillColor: kLightGrey,
                        filled: true,
                        errorStyle:
                        TextStyle(fontFamily: kPrimaryFont, fontSize: 12.0),
                      ),
                      style:
                      TextStyle(fontFamily: kPrimaryFont, fontSize: 14.0),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء تعبئة الحقل';
                        }
                        if (value.length < 9) {
                          return 'يجب أن يتكون رقم الهاتف من 9 أرقام';
                        }
                        if (!value.startsWith(new RegExp(r'[7][7|1|3|0]'))) {
                          return 'يجب أن يبدا رقم الهاتف ب 73 او 70 او 71 او 77 ';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30.0),
                    child: TextFormField(
                      cursorColor: kPrimaryColor,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(buttonFocusNode);
                      },
                      keyboardType: TextInputType.text,
                      focusNode: passwordFocusNode,
                      strutStyle: StrutStyle(height: 1.5),
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'كلمة المرور',
                        hintText: "قم بكتابة كلمة المرور ",
                        labelStyle: TextStyle(fontFamily: kPrimaryFont),
                        hintStyle:
                        TextStyle(fontFamily: kPrimaryFont, fontSize: 12.0),
                        fillColor: kLightGrey,
                        filled: true,
                        errorStyle:
                        TextStyle(fontFamily: kPrimaryFont, fontSize: 12.0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      style:
                      TextStyle(fontFamily: kPrimaryFont, fontSize: 14.0),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء تعبئة الحقل';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    child: _isDataLoading
                        ? SpinKitFadingCircle(
                      color: Theme.of(context).accentColor,
                    )
                        : FlatButton(
                      focusNode: buttonFocusNode,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      color: kPrimaryColor,
                      padding: EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                fontFamily: kPrimaryFont,
                                color: Colors.white,
                                fontSize: 17),
                          ),
                        ],
                      ),
                      onPressed: () async {

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isDataLoading = true;
                          });

                          var result = await login(phoneNumber, password);

                          if (result != null) {
                            setState(() {
                              _isDataLoading = false;
                            });
                          }

                          print("result is $result");

                          switch (result) {

                            case 0:
                              await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Dialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 2.0,
                                                      color: Theme.of(
                                                          context)
                                                          .primaryColor))),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 8.0),
                                            child: Column(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.error_outline,
                                                  size: MediaQuery.of(
                                                      context)
                                                      .size
                                                      .width /
                                                      6,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(16.0),
                                                  child: Text(
                                                    "رقم الهاتف أو كلمة المرور غير صحيحة",
                                                    style: TextStyle(
                                                        color: Theme.of(
                                                            context)
                                                            .primaryColor),
                                                    textAlign:
                                                    TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                              break;

                            case -1:
                              await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Dialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 2.0,
                                                      color: Theme.of(
                                                          context)
                                                          .primaryColor))),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 8.0),
                                            child: Column(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.error_outline,
                                                  size: MediaQuery.of(
                                                      context)
                                                      .size
                                                      .width /
                                                      5,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(16.0),
                                                  child: Text(
                                                    " عذرا لم نستطع الاتصال تأكد من اتصالك بالانترنت وحاول مرة أخرى",
                                                    style: TextStyle(
                                                        color: Theme.of(
                                                            context)
                                                            .primaryColor),
                                                    textAlign:
                                                    TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                              break;

                            default:
                              {
                                var y = await SelectDepId(result);

                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            MainScreen(
                                                result, y
                                            )));
                              }

                              break;

                          }
                        } else {
                          setState(() => _autoValidate = true);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
