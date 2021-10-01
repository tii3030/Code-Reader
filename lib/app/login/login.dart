import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:local_auth/local_auth.dart';
import 'requests.dart';

class FormLogin extends StatelessWidget {

	const FormLogin({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

    final myController = TextEditingController();
    final myControllerPass = TextEditingController();

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      myController.dispose();
      dispose();
    }
    
		return Scaffold(

      //IMPEDE O REDIMENSIONAMENTO DA VIEW AO ACIONAR O INPUT
      resizeToAvoidBottomInset: false,
			// appBar: AppBar(
			//     title: const Text('WWW'),
			// ),

			body:

      SingleChildScrollView(

        child: 

        Container(

          height: MediaQuery.of(context).size.height,

          decoration:const BoxDecoration(
            //color: Color(0xFF00049F),

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

              //ALINHAMENTO DA COLUNA
              mainAxisAlignment: MainAxisAlignment.center,
                          
              children: [

                Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: Image.asset("assets/images/img_marca.png"),
                  height: 120,
                  width: MediaQuery.of(context).copyWith().size.width,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(style: BorderStyle.none),
                  ),
                ),
                      
                Container(
                  padding: const EdgeInsets.only(left: 12.0),
                  margin:  const EdgeInsets.all(10.0),
                  height: 50,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    border: Border.all(width: 1.0, color: const Color(0xFFDBDBDB)),
                  ),

                  child: 
                        
                  TextFormField(

                    //CONTROLER CODE USER
                    controller: myController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                              
                      hintText: "Código",
                      //REMOVE A BORDA E O EFEITO DE FOCO
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 12.0),
                  margin:  const EdgeInsets.all(10.0),
                  height: 50,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    border: Border.all(width: 1.0, color: const Color(0xFFDBDBDB)),
                  ),

                  child:
                        
                  TextFormField(

                    //CONTROLER CODE USER
                    controller: myControllerPass,
                    obscureText: true,
                    decoration: const InputDecoration(
                            
                      icon: Icon(
                        Icons.vpn_key,
                        color: Colors.grey,
                      ),

                      hintText: "Senha",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {

                    LoginApi loginApi = new LoginApi();
                    loginApi.loginApi();

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
                                        
                      borderRadius: BorderRadius.circular(15.0),

                    ),

                    child:
                          
                    const Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
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