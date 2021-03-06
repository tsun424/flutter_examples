import 'package:flutter/material.dart';

class FormDemo extends StatelessWidget {
  static const String routeName = '/form_demo';
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text("Login"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (val) => _validateEmail(val),
                onSaved: (val) => _email = val,
              ),
              new TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                validator: (val) => _validatePwd(val),
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              new Container(
                margin: EdgeInsets.only(top: 10.0),
                child: new RaisedButton(
                  onPressed: _login,
                  child: new Text('Login'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _performLogin();
    }
  }

  void _performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Email: $_email, password: $_password"),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  String _validateEmail(String email) {
    RegExp exp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return !exp.hasMatch(email) ? "Invalid Email" : null;
  }

  String _validatePwd(String pwd) {
    return pwd.length < 5 ? "Invalid Password" : null;
  }
}
