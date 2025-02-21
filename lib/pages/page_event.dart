import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageEvent extends StatefulWidget {
  const PageEvent({super.key});

  @override
  State<PageEvent> createState() => _PageEventState();
}

class _PageEventState extends State<PageEvent> {

 @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Events").snapshots(), 
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData){
              return Text("Aucune Conference");
            }

            List<dynamic> events = [];
            snapshot.data!.docs.forEach((element) {
              events.add(element);
            });

            return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {

            final event = events[index];
            final avatar = event['avatar'].toString().toLowerCase();
            final speaker = event['speaker'];
            final Timestamp timestamp = event['date'];
            final String date = DateFormat.yMd().add_jm().format(timestamp.toDate());
            
            final subject = event['subject'];


            return  Card(
              child: ListTile(
                leading: Image.asset("assets/images/$avatar.png"),
                title: Text('$speaker ($date)'),
                subtitle: Text('$subject'),
                trailing: Icon(Icons.info),
              ),
            );
          },
          
        );
            
          },),
      );
  }
}