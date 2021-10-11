import 'package:barcodereader/app/model/barcode.dart';
import 'package:barcodereader/app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../../model/dao_login.dart';
import '../../model/dao_home.dart';

/// This is the main application widget.
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
   
  DaoLogin daoLogin = DaoLogin();
  User usss = User(0, "Teste");

  DaoHome daoHome = DaoHome();
  Barcode isap = Barcode(0, "Teste", "Barcode");


  Future neverStart() async {
    List<User> usss = await daoLogin.getUser();
    print(usss.last.code);
  }

  Future getsAllFuzzy() async {
    List<Barcode> isss = await daoHome.getAll();
    print(isss.last.code);
  }

  Future _scanQR() async {
    //await Permission.camera.request();
    var barcode = await scanner.scan();
    if (barcode == null) {
      //
    } else {

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          scrollable: true,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 150.0,
          ),
            
          //title: const Text('NOVA CONTAGEM'),
          content:

          Column(

          //mainAxisSize: MainAxisSize.min,

            children: [

              Container(

                margin: const EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    //color: Color(0xFFEDEDED)
                  ),

                child:

                const Text(
                  "Verifique o código abaixo:",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ) 
              ),

              Container(

                margin: const EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    //color: Color(0xFFEDEDED)
                  ),

                child:

                Text(
                  barcode,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),

              Align(
              alignment: Alignment.bottomRight,

              child: 

                GestureDetector(
                  onTap: () {},

                  child:

                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    //padding: const EdgeInsets.only(left: 20, right: 20),

                    height: 45,
                    width: 95,

                    decoration: BoxDecoration(
                      color: const Color(0xFF00049F),                                                    
                      borderRadius: BorderRadius.circular(10.0),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),

                    child:

                    const Text(
                      "Adicionar",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

	@override
	Widget build(BuildContext context) {

    neverStart();

    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>FormLogin()),(Route<dynamic> route) => false);

    final List<String> items = List<String>.generate(10, (i) => 'Item $i');

    List <Widget> carousselItens = <Widget>[
      Text(
        'Bem Vindo',   
        textAlign: TextAlign.center,               
        style: GoogleFonts.libreBarcode128Text(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 70,
          fontWeight: FontWeight.w700,
          color: Colors.white
          //fontStyle: FontStyle.italic,
        ),
      ),

      Container(

        decoration: const BoxDecoration(
          //color: Colors.white,
        ),

        child: 

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Text(
                  'ELETROSOM.COM',
                  textAlign: TextAlign.center,                               
                  style: GoogleFonts.encodeSans(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                    //fontStyle: FontStyle.italic,
                  ),
                ),
              ]
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child:
                    Image.asset("assets/images/qr-code.png", height: 50),
                )
              ]
            )
          ]
        )        
      )
    ];

		return Scaffold(

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   child: const Icon(Icons.add_outlined),
      //   backgroundColor: const Color(0xFF011EDB),
      // ),
      
      //IMPEDE O REDIMENSIONAMENTO DA VIEW AO ACIONAR O INPUT
      resizeToAvoidBottomInset: false,
			appBar: AppBar(
        backgroundColor: const Color(0xFF00049F),
        title: const Text(
          'CONTAGEM DE PRODUTOS',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15)
        ),
      ),

		  body:

      Container(

        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),

        child: 

        Stack(

          children: <Widget>[

            Column(
              
              children: [

                Container(

                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,

                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 3.0,
                      ),
                    ],
                  ),

                  child: 

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      
                      Column(
                      
                        children: [

                          Container(

                            height: 50,
                            width: 150, 
                            padding: const EdgeInsets.all(5),

                            decoration: BoxDecoration(
                              color: const Color(0xFF00049F),
                              borderRadius: BorderRadius.circular(15.0),
                            ),

                            child: 
                            
                            Column(

                              children: [
                                
                                Expanded(
                                  
                                  child: 
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //crossAxisAlignment: CrossAxisAlignment.center,

                                    children: const [
                                      Text(
                                        "PRODUTOS",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12
                                        ),
                                      ),

                                    ],

                                  ),
                                ),

                                Expanded(
                                  
                                  child: 
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: const [
                                      Text(
                                        "6",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 14
                                        ),
                                      ),

                                    ],

                                  ),
                                ),

                              ],
                            )
                          ),
                        ],

                      ),

                      Column(
                      
                        children: [

                          Container(

                            height: 50,
                            width: 150, 
                            padding: const EdgeInsets.all(5),

                            decoration: BoxDecoration(
                              color: const Color(0xFF00049F),
                              borderRadius: BorderRadius.circular(15.0),
                            ),

                            child: 
                            
                            Column(

                              children: [
                                
                                Expanded(
                                  
                                  child: 
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //crossAxisAlignment: CrossAxisAlignment.center,

                                    children: const [
                                      Text(
                                        "QUANTIDADE TOTAL",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12
                                        ),
                                      ),

                                    ],

                                  ),
                                ),

                                Expanded(
                                  
                                  child: 
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: const [
                                      Text(
                                        "12",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 14
                                        ),
                                      ),
                                    ],

                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ],
                  )
                ),

                const SizedBox(height: 16,),

                Expanded(
                  
                  child: 
                  
                  Container(
                    //height: 550,
                    padding: const EdgeInsets.only(left: 20, right: 20),

                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),

                    child:

                    ListView.separated(
                      itemCount: items.length,
                      itemBuilder: (context, index) {

                        return ListTile(
                          title: Text(items[index]),
                        );
                      },

                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                  ),

                ),
              ],
            ),

            Positioned(
              bottom: 20,
              right: 15,

              child:

              Column(

                children: [

                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 15),
                    
                  //   child: 
                                
                  //   FloatingActionButton(
                  //     onPressed: () {
                  //                   // Add your onPressed code here!
                  //     },
                        
                  //     child:
                      
                  //     const Icon(
                  //       Icons.add_outlined,
                  //       size: 40,
                  //     ),
                      
                  //     backgroundColor: const Color(0xFF00049F),
                  //   )
                  // ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 15),

                    child: 
        
                    FloatingActionButton(
                      onPressed: () {
                                  // Add your onPressed code here!
                      },
                      
                      child: const Icon(
                        Icons.sync,
                        size: 40,
                      ),

                      backgroundColor: const Color(0xFF00049F),
                    ),
                  ),

                  SizedBox(
                    width: 75.0,
                    height: 75.0,

                    child: FloatingActionButton(

                      onPressed: () async {
                        _scanQR();
                      },
                      
                      // showDialog<String>(
                      //   context: context,
                      //   builder: (BuildContext context) => AlertDialog(
                      //     scrollable: true,
                      //     insetPadding: const EdgeInsets.symmetric(
                      //       horizontal: 20.0,
                      //       vertical: 150.0,
                      //     ),
                      //     //title: const Text('NOVA CONTAGEM'),
                      //     content:

                      //     Column(

                      //       //mainAxisSize: MainAxisSize.min,

                      //       children: [

                      //         Container(

                      //           margin: const EdgeInsets.only(top: 20, bottom: 20),
                      //           width: MediaQuery.of(context).size.width,
                      //           decoration: const BoxDecoration(
                      //             //color: Color(0xFFEDEDED)
                      //           ),

                      //           child: 
                      //             const Text(
                      //               "Nova Contagem",
                      //               style: TextStyle(
                      //                 color: Colors.black38,
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold
                      //               ),
                      //             )
                      //         ),

                      //         Container(
                      //           padding: const EdgeInsets.only(left: 12.0),
                      //           margin:  const EdgeInsets.only(bottom:10.0, top: 10.0),
                      //           height: 50,

                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10.0),
                      //             color: const Color(0xFFEDEDED)
                      //             //border: Border.all(width: 1.0, color: const Color(0xFFDBDBDB)),
                      //           ),

                      //           child: 
                                      
                      //           const TextField(
                      //             style: TextStyle(
                      //               color: Colors.black45,
                      //             ),
                                    
                      //             obscureText: false,

                      //             decoration: InputDecoration(      
                      //               hintText: "Nome do Produto",
                      //               hintStyle: TextStyle(
                      //                 fontWeight: FontWeight.w400,
                      //                 color: Colors.black45
                      //               ),

                      //               //REMOVE A BORDA E O EFEITO DE FOCO
                      //               enabledBorder: InputBorder.none,
                      //               focusedBorder: InputBorder.none
                      //             ),
                                  
                      //           ),
                      //         ),

                      //         Container(
                      //           padding: const EdgeInsets.only(left: 12.0),
                      //           margin:  const EdgeInsets.only(bottom:10.0, top: 10.0),
                      //           height: 50,

                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10.0),
                      //             color: const Color(0xFFEDEDED)
                      //             //border: Border.all(width: 1.0, color: const Color(0xFFDBDBDB)),
                      //           ),

                      //           child: 
                                      
                      //           const TextField(
                      //             style: TextStyle(
                      //               color: Colors.black45,
                      //             ),
                                    
                      //             obscureText: false,

                      //             decoration: InputDecoration(      
                      //               hintText: "Código de Barras",
                      //               hintStyle: TextStyle(
                      //                 fontWeight: FontWeight.w400,
                      //                 color: Colors.black45
                      //               ),

                      //               //REMOVE A BORDA E O EFEITO DE FOCO
                      //               enabledBorder: InputBorder.none,
                      //               focusedBorder: InputBorder.none
                      //             ),
                                  
                      //           ),
                      //         ),


                      //         Container(
                      //           padding: const EdgeInsets.only(left: 12.0),
                      //           margin:  const EdgeInsets.only(bottom:10.0, top: 10.0),
                      //           height: 50,

                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10.0),
                      //             color: const Color(0xFFEDEDED)
                      //             //border: Border.all(width: 1.0, color: const Color(0xFFDBDBDB)),
                      //           ),

                      //           child: 
                                      
                      //           const TextField(
                      //             style: TextStyle(
                      //               color: Colors.black45,
                      //             ),
                                    
                      //             obscureText: false,

                      //             decoration: InputDecoration(      
                      //               hintText: "Quantidade",
                      //               hintStyle: TextStyle(
                      //                 fontWeight: FontWeight.w400,
                      //                 color: Colors.black45
                      //               ),

                      //               //REMOVE A BORDA E O EFEITO DE FOCO
                      //               enabledBorder: InputBorder.none,
                      //               focusedBorder: InputBorder.none
                      //             ),
                                  
                      //           ),
                      //         ),

                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.end,

                      //           children: [
                      //             GestureDetector(
                      //               onTap: () {},

                      //               child:
                                          
                      //               Container(
                      //                 alignment: Alignment.center,
                      //                 margin: const EdgeInsets.only(top: 20, bottom: 10, right: 10),
                      //                 //padding: const EdgeInsets.only(left: 20, right: 20),

                      //                 height: 40,
                      //                 width: 80,

                      //                 decoration: BoxDecoration(
                      //                   color: const Color(0xFF00049F),                                                    
                      //                   borderRadius: BorderRadius.circular(10.0),

                      //                 ),

                      //                 child:

                      //                 const Text(
                      //                   "Cancelar",
                      //                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //             ),

                      //             GestureDetector(
                      //               onTap: () {},

                      //               child:

                      //               Container(
                      //                 alignment: Alignment.center,
                      //                 margin: const EdgeInsets.only(top: 20, bottom: 10),
                      //                 //padding: const EdgeInsets.only(left: 20, right: 20),

                      //                 height: 40,
                      //                 width: 80,

                      //                 decoration: BoxDecoration(
                      //                   color: const Color(0xFF00049F),                                                    
                      //                   borderRadius: BorderRadius.circular(10.0),

                      //                 ),

                      //                 child:
                                            
                      //                 const Text(
                      //                   "Adicionar",
                      //                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //             ),

                      //           ]
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      
                      child:
                    
                      Image.asset("assets/images/barcode.png", height: 40),
                      backgroundColor: const Color(0xFF00049F),
                    ),
                  ),

                ],
                          
              )
            ),
            
          ],
        )
      ),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [

            DrawerHeader(
              margin: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                color: Color(0xFF00049F),
              ),

              child: 
              
              Center(
                
                child: 

                CarouselSlider(
                  options: CarouselOptions(
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    height: MediaQuery.of(context).size.height,
                    autoPlay: true,
                    scrollDirection: Axis.vertical
                  ),

                  items: carousselItens.map((i) {

                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            //color: Colors.amber
                          ),
                          child: i
                        );
                      },
                    );

                  }).toList(),
                )
              )
            ),

            Container(
              padding: const EdgeInsets.all(20),
              height: 7,

              decoration: const BoxDecoration(
                color: Colors.yellow,
              ),

            ),

            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,

              decoration: const BoxDecoration(
                color: Colors.white,
              ),

            )
          ],
        ),
      ),

		);
	}
}