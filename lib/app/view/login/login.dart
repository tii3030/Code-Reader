import 'package:barcodereader/app/model/user.dart';
import 'package:barcodereader/app/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../requests/request_login.dart';
import '../../controller/dao_login.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> with TickerProviderStateMixin {

  DaoLogin daoLogin = DaoLogin();

  Future insert(String code) async {

    User user = User(0, code);
    daoLogin.create(user);

  }

  final myController = TextEditingController();
  final myControllerPass = TextEditingController();
  bool load = false;
  late AnimationController controller;
  bool isValidEmail = false;
  bool isValidPass = false;

  void _handleLoad(bool _load) {
    setState(() {
      load = _load;
    });
  }

  void _handleEmailValid(bool _email) {
    setState(() {
      isValidEmail = _email;
    });
  }

  void _handlePassValid(bool _pass) {
    setState(() {
      isValidPass = _pass;
    });
  }

  @override
  void dispose() {
    // CLEAN UP THE CONTROLLER WHEN THE WIDGET IS DISPOSED
    myController.dispose();
    myControllerPass.dispose();

    dispose();
  }

	@override
	Widget build(BuildContext context) {

		return Scaffold(

      resizeToAvoidBottomInset: false,

			body:

      SingleChildScrollView(

        child: 

        Container(
          height: MediaQuery.of(context).size.height,
          decoration:const BoxDecoration(

            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF00049F),
                Color(0xff004CFF)
              ], 
                              
              begin: Alignment.centerLeft, end: Alignment.centerRight
            ),
          ),

          child:

          Container (
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10.0),
            margin:  const EdgeInsets.all(10.0),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              border: Border.all(style: BorderStyle.none),

              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 10),
                  blurRadius: 200.5,
                  spreadRadius: 0.5,
                  color: Color(0xFF000000)
                )
              ],
            ),

            child:

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
                          
              children: [

                Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: Image.asset("assets/images/12.png"),
                  height: 140,
                  width: MediaQuery.of(context).copyWith().size.width,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(style: BorderStyle.none),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child:

                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },

                    //CONTROLER CODE USER
                    controller: myController,
                    obscureText: false,
                    decoration: InputDecoration(

                      errorText: isValidEmail ? 'Email inválido' : null,

                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color(0xFFD7D9D9),

                      ),

                      labelText: 'Código',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color(0xFFD7D9D9),),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Color(0xFF00049F)),
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                  ),
                ),  

                const SizedBox(height: 16,),

                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),

                  child:
                  
                  TextFormField(
                    
                    //CONTROLER PASS USER
                    controller: myControllerPass,
                    obscureText: false,

                    decoration: InputDecoration(

                      errorText: isValidPass ? 'Senha inválida' : null,

                      prefixIcon: const Icon(
                        Icons.vpn_key,
                        color: Color(0xFFD7D9D9),
                      ),

                      labelText: 'Senha',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color(0xFFD7D9D9)),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Color(0xFF00049F)),
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () async {

                    if((myController.text).isEmpty) {
                      _handleEmailValid(true);
                    }

                    if((myControllerPass.text).isEmpty) {
                      _handlePassValid(true);
                    }
                    
                    if(((myController.text).isNotEmpty) && ((myControllerPass.text).isNotEmpty)) {

                      _handleLoad(true);

                      LoginApi loginApi = LoginApi(myController.text, myControllerPass.text);
                      loginApi.loginApi().then((authenticated) =>  {
                        
                        if(authenticated == true) {

                          insert(myController.text).then((value) => null),

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          ),

                          _handleLoad(false),

                        } else {
                          _handleLoad(false),
                          _handleEmailValid(true),
                          _handlePassValid(true),
                        }

                      });
                    }
                    
                  },

                  child:
                        
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 50,

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFF00049F),
                          Color(0xff0038FF)
                        ], 
                              
                        begin: Alignment.centerLeft, end: Alignment.centerRight
                      ),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                                        
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    child:

                    Column(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: load ? 

                          const SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: 
                              
                              CircularProgressIndicator(
                                color: Colors.white,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                strokeWidth: 3.0
                              )
                            ),
                          )
                            
                          :

                          const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),

                        ),

                      ],
                    )
                          
                  ),
                ),

                // BUTTON TO IMPLEMENTATION FINGERPRINT
                // GestureDetector(
                //   onTap: () async {
                //     bool isAuthenticated = await Authentication.authenticateWithBiometrics();

                //     if (isAuthenticated) {

                //     } else {

                //     }
    
                //   },

                //   child:
                        
                //   Container(
                //     alignment: Alignment.center,
                //     margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                //     padding: const EdgeInsets.only(left: 20, right: 20),
                //     height: 50,

                //     decoration: BoxDecoration(
                //       gradient: const LinearGradient(
                //         colors: <Color>[
                //           Color(0xFF00049F),
                //           Color(0xff0038FF)
                //         ], 
                              
                //         begin: Alignment.centerLeft, end: Alignment.centerRight
                //       ),
                                        
                //       borderRadius: BorderRadius.circular(15.0),

                //     ),

                //     child:
                          
                //     const Text(
                //       "FINGER PRINT",
                //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
              ],
            )
          )
        ),
      )
		);
	}
} 

// CLASS TO IMPLEMENT FINGERPRINT
// class Authentication {
  
//   static Future<bool> authenticateWithBiometrics() async {

//     final LocalAuthentication localAuthentication = LocalAuthentication();
//     bool isBiometricSupported = await localAuthentication.isDeviceSupported();
//     bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

//     bool isAuthenticated = false;

//     if (isBiometricSupported && canCheckBiometrics) {
//       isAuthenticated = await localAuthentication.authenticate(

//         localizedReason: ' ',
//         biometricOnly: true,
//       );
//     }

//     return isAuthenticated;
//   }
// }