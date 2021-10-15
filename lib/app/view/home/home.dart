import 'package:barcodereader/app/model/barcode.dart';
import 'package:barcodereader/app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../../controller/dao_login.dart';
import '../../controller/dao_home.dart';
import '../../controller/syncup.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
   
  List<String> items = [];
  String itemsLenght = '';
  DaoLogin daoLogin = DaoLogin();
  DaoHome daoHome = DaoHome();
  bool requestSync = false;

  // GET CODE OF USER
  Future getCode() async {
    List<User> obj = await daoLogin.getUser();
    return obj.last.code;
  }

  // INSERT DATA IN DB
  Future insert(String barcode) async {

    String code = await getCode();
    Barcode barcodeObj = Barcode(0, code, barcode);
    daoHome.create(barcodeObj);
    await getBarcodeList();

  }

  // GET LIST BARCODE AND QRCODE
  Future getBarcodeList() async {
    List<Barcode> foos = await daoHome.getAll();

    List<String> itemsTemp = [];

    foos.asMap().forEach((i, value) {
      itemsTemp.add(value.barcode);
      //print('index=$i, value=$value');
    });

    setState(() {
      items = itemsTemp;
      itemsLenght = itemsTemp.length.toString();
    });

    itemsTemp = [];

    return 1;
  }

  // CONTROLLER SCROLL
  final _controller = ScrollController(); 
  bool bottomPage = true;

  late final AnimationController _controllerT;
  @override
  void initState() {
    super.initState();

    _controllerT = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

    // SETUP THE LISTNER
    _controller.addListener(() {
      
      if (_controller.position.pixels ==_controller.position.maxScrollExtent) {

        setState(() {
          bottomPage = false;
        });

      } else {
        setState(() {
          bottomPage = true;
        });
      }
      
    });
  }

  // SCAN BARCODE AND QRCODE FUNCTION
  Future _scanQR() async {
    //await Permission.camera.request();
    var barcode = await scanner.scan();
    if(barcode != null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          scrollable: true,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 150.0,
          ),
              
          content:

          Column(

            children: [

              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,

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
                  onTap: () {
                    // CALL insert()
                    insert(barcode);
                    Navigator.of(context).pop();               
                  },

                  child:

                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
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
    }else {
      
    }
  }
  
	@override
	Widget build(BuildContext context) {
  
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

                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Color(0xFF00049F),

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
                            padding: const EdgeInsets.all(0),

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

                                    children: [
                                      Text(
                                        itemsLenght,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 24
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

                //const SizedBox(height: 16,),

                Expanded(
                  
                  child: 
                  
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),

                    child:

                    FutureBuilder(
                      future: getBarcodeList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return 
                          ListView.separated(
                            controller: _controller,
                            itemCount: items.length,
                            itemBuilder: (context, index) {

                              return ListTile(
                                title: Text(items[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                              );
                            },

                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          );

                        } else {

                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 3.0
                            ),
                          );
                        }
                      }
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              bottom: 20,
              right: 15,

              child:

              AnimatedOpacity(
                opacity: bottomPage ? 1 : 0,
                duration: const Duration(milliseconds: 200),

                child: 

                Column(

                  children: [

                    Container(
                      margin: const EdgeInsets.only(bottom: 15),

                      child: 
          
                      FloatingActionButton(
                        onPressed: () async {

                          setState(() {
                            requestSync = true;
                          });

                          Syncup syncup = Syncup();

                          await syncup.sendData().then((isSuccess) =>  {
                            setState(() {
                              requestSync = false;

                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  scrollable: true,
                                  insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 150.0,
                                  ),
                                      
                                  content:

                                  Column(

                                    children: [

                                      Container(
                                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                                        width: MediaQuery.of(context).size.width,

                                        child:

                                        Center (
                                          child: isSuccess ?
                                          const Text(
                                            "Sincronizado com a base de dados!",
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ) 
                                          :
                                          const Text(
                                            "Não foi possível sincronizar!",
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ) 
                                        )
                                      ),

                                      Container(
                                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                                        width: MediaQuery.of(context).size.width,

                                        child:

                                        Center (
                                          child: isSuccess ?
                                            Image.asset("assets/images/success.png", height: 70)
                                            :
                                            Image.asset("assets/images/error.png", height: 70)

                                        )
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                          });
                        },

                        child:

                        RotationTransition(
                          turns: Tween(
                            begin: requestSync ? 1.0 : 0.0,
                            end: 0.0
                          ).animate(_controllerT),
                          child: 

                          const Icon(
                            Icons.sync,
                            size: 40,
                          ),

                        ),

                        backgroundColor: const Color(0xFF00049F),
                      ),
                    ),

                    SizedBox(
                      width: 75.0,
                      height: 75.0,

                      child: FloatingActionButton(

                        onPressed: () async {
                          // CALL _scanQR FUNCTION
                          await _scanQR();
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
              )
            ),
          ],
        )
      ),

      drawer: Drawer(

        child: Column(
          //padding: EdgeInsets.zero,
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
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
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

            Expanded(
              child:  

              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                //height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),

                child:

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [

                    const Center(
                    child:
                      Text(
                        "Instruções",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      
                      children: [

                        Container(
                        margin: const EdgeInsets.only(right: 10),

                        child:
                          const Align(
                            alignment: Alignment.topLeft,
                            child:
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )

                        ),

                        const Flexible(
                          child: 
                          Text(
                            "O aplicativo é capaz de escanear códigos de barras e qrcodes.",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      
                      children: [

                        Container(
                        margin: const EdgeInsets.only(right: 10),

                        child:
                          const Align(
                            alignment: Alignment.topLeft,
                            child:
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )
                        ),

                        const Flexible(
                          child: 

                          Text(
                            "Após escanear, é importante verificar o código antes de salvá-lo.",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      
                      children: [

                        const Padding(padding: EdgeInsets.only(top: 70)),

                        Container(
                        margin: const EdgeInsets.only(right: 10),
          
                        child:
                          const Align(
                            alignment: Alignment.topLeft,
                            child:
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )
                        ),

                        const Flexible(
                          child: 
                          Text(
                            "Após salvar todos os códigos, clique sobre o botão 'sincronizar', para sincronizar seus códigos com a base de dados.",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                            ),
                          )
                        )
                      ],
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      
                      children: [

                        const Padding(padding: EdgeInsets.only(top: 70)),

                        Container(
                        margin: const EdgeInsets.only(right: 10),
          
                        child:
                          const Align(
                            alignment: Alignment.topLeft,
                            child:
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )
                        ),

                        const Flexible(
                          child: 
                          Text(
                            "Após sincronizar, seus códigos serão apagados do dispositivo, e você estará pronto para escanear novos códigos.",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                            ),
                          )
                        )
                      ],
                    ),

                    Expanded(
                      child: 
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: 

                        Center(
                          child:

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              const Text(
                                "FEITO PELA EQUIPE INOVAÇÃO",
                                style: TextStyle(
                                  color: Color(0xFF00049F),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              Container(

                                margin: const EdgeInsets.only(left: 10),
                                child: 
                                
                                Image.asset("assets/images/heart.png", height: 12),

                              )

                            ]
                          )
                        ),
                      )
                    )
                  ],
                )
              )
            )
          ],
        ),
      ),
		);
	}
}