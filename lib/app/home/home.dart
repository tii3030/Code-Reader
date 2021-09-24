import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:local_auth/local_auth.dart';

class Home extends StatelessWidget {
	const Home({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

    final List<String> items = List<String>.generate(10, (i) => 'Item $i');

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
      backgroundColor: const Color(0xFF011EDB),
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

                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),

                  child: 

                  Container(

                    margin: const EdgeInsets.only(top: 30),
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
                                color: const Color(0xFF011EDB),
                                borderRadius: BorderRadius.circular(20.0),
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
                                color: const Color(0xFF011EDB),
                                borderRadius: BorderRadius.circular(20.0),
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
                  )
                ),

                Expanded(
                  
                child: 
                
                Container(
                  //height: 550,
                  padding: const EdgeInsets.all(20),

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

                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    
                    child: 
                                
                    FloatingActionButton(
                      onPressed: () {
                                    // Add your onPressed code here!
                      },
                        
                      child:
                      
                      const Icon(
                        Icons.add_outlined,
                        size: 40,
                      ),
                      
                      backgroundColor: const Color(0xFF011EDB),
                    )
                  ),

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

                      backgroundColor: const Color(0xFF011EDB),
                    ),
                  ),

                  SizedBox(
                    width: 75.0,
                    height: 75.0,

                    child: FloatingActionButton(
                      onPressed: () {},
                      
                      child:
                    
                      Image.asset("assets/images/barcode.png", height: 40),
                      backgroundColor: const Color(0xFF011EDB),
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
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF011EDB),
              ),

              child: 
              
              Text(
                'Bem Vindo',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                )
              ),
            ),
          ],
        ),
      ),

		);
	}
}