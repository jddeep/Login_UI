import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
      theme: new ThemeData(primarySwatch: Colors.green),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
//  final textController = new TextEditingController();
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 400)
    );
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }


  @override
  void dispose() {
    super.dispose();
  }

  void _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();

      performLogin();
    }
  }

  void performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Email : $_email, passowrd : $_password "),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 100,
              ),
              new Form(
                key: formKey,
                child: Theme(
                  data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.green,
                      inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                              color: Colors.teal, fontSize: 26.0))),
                  child: Container(
                    padding: const EdgeInsets.all(40.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Email ID",

                          ),

                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => !val.contains('@')?'Invalid Email':null,
                          onSaved: (val) => _email = val,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validator: (val) => val.length<6?'Password too short':null,
                          onSaved: (val) => _password=val,

                        ),
                        new Padding(padding: const EdgeInsets.only(top: 40.0)),
                        new MaterialButton(
                          height: 40.0,
                          minWidth: 100.0,
                          color: Colors.teal,
                            textColor: Colors.white,
                            child: new Icon(Icons.forward),
                            onPressed: _submit,
                          splashColor: Colors.green,
                            ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
