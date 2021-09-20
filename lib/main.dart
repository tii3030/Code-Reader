import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

    Widget titleSection = Container(
        //PROPRIEDADE DO CONTAINER
        padding: const EdgeInsets.all(32),
        height: double.infinity,
        width: double.infinity,

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
            ),

            boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                ),
            ],
        ),

        child: Row(
            children: [

                //DEVE SER FILHO DE ROW, FLEX OU COLUMN. FAZ O ELEMENTO FILHO PREENCHER O ESPAÇO TOTAL DISP
                Expanded(
                    /*1*/
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            /*2*/
                            Container(
                                //PROPRIEDADE DO CONTAINER
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                    "Produtos",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                ),
                            ),

                            Text(
                                '12',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                ),
                            ),
                        ],
                    ),
                ),

                Expanded(
                    /*2*/
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            /*2*/
                            Container(
                                //PROPRIEDADE DO CONTAINER
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                    "Quantidade Total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                ),
                            ),

                            Text(
                                '21',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                ),
                            ),
                        ],
                    ),
                ),
                
            ],
        ),
    );

    Column _buildButtonColumn(Color color, IconData icon, String label) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
                Icon(
                    icon,
                    color: color,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                        label,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: color
                        ),
                    ),
                ),
            ],
        );
    }

    Widget textSection = const Padding(
        padding: EdgeInsets.all(32),
        child: Text(
            'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',

            softWrap: true,
        ),
    );

    @override
    Widget build(BuildContext context) {

        Widget buttonSection = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
                _buildButtonColumn(Colors.blue, Icons.near_me, 'CALL'),
                _buildButtonColumn(Colors.blue, Icons.share, 'CALL'),
            ],
        );

        return MaterialApp(
            title: 'Leitor de Códigos de Barras',
            home: Scaffold(
                body: Column(
                    children: [
                        titleSection,
                        buttonSection,
                        textSection
                    ],
                )
            ),
        );
    }

}

