import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class PageAddEvent extends StatefulWidget {
  const PageAddEvent({super.key});

  @override
  State<PageAddEvent> createState() => _PageAddEventState();
}

class _PageAddEventState extends State<PageAddEvent> {

  final _formKey = GlobalKey<FormState>();

  final confNameController = TextEditingController();
  final speakerNameController = TextEditingController();
  String selectedConfType = 'Talk';
  DateTime selectedConfDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();

    confNameController.dispose();
    speakerNameController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom Conference',
                  hintText: 'Entre le nom de la conference',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "Tu dois completer ce texte";
                  }
                  return null;
                } ,
                controller: confNameController,
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom Speaker',
                  hintText: 'Entre le nom du Speaker',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "Tu dois completer ce texte";
                  }
                  return null;
                } ,
                controller: speakerNameController,
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    value: 'Talk' ,
                    child: Text("Talk Show")),
                    DropdownMenuItem(
                    value: 'Demo' ,
                    child: Text("Demo de code")),
                    DropdownMenuItem(
                    value: 'Partner' ,
                    child: Text("Partner"))
                ], 
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
                value: selectedConfType,
                onChanged: (value){
                  setState(() {
                    selectedConfType = value!;
                  });
                   
                }),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 25),
  child: DateTimeFormField(
    decoration: const InputDecoration(
      hintStyle: TextStyle(color: Colors.black45),
      errorStyle: TextStyle(color: Colors.redAccent),
      border: OutlineInputBorder(),
      suffixIcon: Icon(Icons.event_note),
      labelText: 'Choisir une date',
    ),
    mode: DateTimeFieldPickerMode.dateAndTime,
    autovalidateMode: AutovalidateMode.always,
    validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
    onDateSelected: (DateTime value) {
      
      setState(() {
        selectedConfDate = value;
      });
    },
  ),
),


            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(

              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Change la couleur ici
              foregroundColor: Colors.white, // Change la couleur du texte

              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Ajuste la taille du bouton
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Arrondi les bords
                     ),
  ),
                onPressed: (){
                  if (_formKey.currentState!.validate()){
                    final confName = confNameController.text;
                    final speakerName = speakerNameController.text;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Envoie en cour..."))
                    );
                    FocusScope.of(context).requestFocus(FocusNode());


                    //Ajout dans la base de données
                    CollectionReference eventsRef = FirebaseFirestore.instance.collection("Events");
                    eventsRef.add({
                      'speaker' : speakerName,
                      'date': selectedConfDate,
                      'subject' :confName,
                      'type': selectedConfType,
                      'avatar': 'user5'
                    });
                  }
                }, 
                child: Text("Envoyer",
                  style: TextStyle(
                  fontSize: 20, // Taille du texte
                  fontWeight: FontWeight.bold, // Gras
                  fontStyle: FontStyle.italic, // Italique
                  color: Colors.white, // Couleur du texte
                  letterSpacing: 1, // Espacement des lettres
                   ),

                )
              ),
            ),
          ],
        )),
    );
  }
}