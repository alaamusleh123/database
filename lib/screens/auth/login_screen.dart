import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v12_database/providers/user_provider.dart';
import 'package:v12_database/utils/helpers.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  with Helpers{
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController=TextEditingController();
    _passwordTextController=TextEditingController();
  }
  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Welcome Back...',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const Text(
              'Enter email& password',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 16
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.blue
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'password',
                prefixIcon: Icon(Icons.lock),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 1,
                      color: Colors.blue
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async=> await performLogin(),
                child: Text('LOGIN',),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity,50),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: ()=> Navigator.pushNamed(context, '/register_screen'),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> performLogin() async{
    if(checkData()){
      await login();
    }
  }

  bool checkData(){
    if(_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data' , error:  true);
    return false;
    }
  Future<void> login() async{
    bool loggedIn= await Provider.of<UserProvider>(context, listen: false).login(
        email: _emailTextController.text, password: _passwordTextController.text);
    if(loggedIn){
      Navigator.pushReplacementNamed(context, '/notes_screen');
    }else{
      showSnackBar(context, message: 'Login failed try again', error: true);
    }
  }
}
