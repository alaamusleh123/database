import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v12_database/models/user.dart';
import 'package:v12_database/providers/user_provider.dart';
import 'package:v12_database/utils/helpers.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers{
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController=TextEditingController();
    _emailTextController=TextEditingController();
    _passwordTextController=TextEditingController();
  }
  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              'Create Account...',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const Text(
              'Enter new account info',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _nameTextController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 1,
                      color: Colors.blue
                  ),
                ),
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
              onPressed: ()async=> await performRegister(),
              child: Text('Register',),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity,50),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> performRegister() async{
    if(checkData()){
      await register();
    }
  }

  bool checkData(){
    if(_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
    _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data' , error:  true);
    return false;
  }
  Future<void> register() async{
    bool register= await Provider.of<UserProvider>(context, listen: false).creat(user);
    if(register){
      Navigator.pop(context);
   }
  }
  User get user{
    User user= User();
    user.name= _nameTextController.text;
    user.email=_emailTextController.text;
    user.password=_passwordTextController.text;
    return user;
  }
}
