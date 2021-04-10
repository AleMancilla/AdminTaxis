import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxis_app/Core/User_Preferens.dart';
import 'package:taxis_app/Pages/MapSendLocation.dart';
import 'package:taxis_app/Widgets/SimpleInputWidget.dart';

class HomePage extends StatelessWidget {
  final UserPreferences prefs = UserPreferences();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("ADMINISTRACION",
                  style: TextStyle(fontSize: 24,color: Colors.blueGrey,fontWeight: FontWeight.w500),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    prefs.userPhotoUrl,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 15,),
                Text(prefs.userName,
                  style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 25,),
                Divider(),
                CupertinoButton(
                  child: Text("Taxis en circulacion"),
                  color: Colors.green, 
                  onPressed: (){
                    // MapSendLocation
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (BuildContext context) => MapSendLocation())
                    );
                  }
                ),
                Divider(),
                Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                  child: SimpleInputWidget(
                    controller: controller,
                    label: "Introduzca matricula a buscar",
                  ),
                ),

                CupertinoButton(
                  child: Text("Buscar uno en particular"),
                  color: Colors.green, 
                  onPressed: (){
                    if(controller.text != null && controller.text != ''){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (BuildContext context) => MapSendLocation(
                          matricula: controller.text,
                        ))
                      );
                    }else{
                      Flushbar(
                        title:  "ERROR",
                        message:  "Debe introducir una matricula",
                        duration:  Duration(seconds: 3),
                        backgroundColor: Colors.red
                      )..show(context);
                    }
                    // MapSendLocation
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}