import 'package:flutter/material.dart';

class KioskScreen extends StatelessWidget {
   KioskScreen({Key? key, required this.RefCode}) : super(key: key);
  String? RefCode ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("الرقم المرجعي", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            Text("يمكنك الدفع من خلال ماكينة فوري"),
            SizedBox(height: 20,),
            Text("${RefCode}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
          ],
        ),
      ),
    );
  }
}
