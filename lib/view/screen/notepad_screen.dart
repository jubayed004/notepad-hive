import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class NotepadScreen extends StatefulWidget {
  const NotepadScreen({super.key});

  @override
  State<NotepadScreen> createState() => _NotepadScreenState();
}

class _NotepadScreenState extends State<NotepadScreen> {
  Box? notepad;

  @override
  void initState() {
   notepad = Hive.box("notepad");
    super.initState();
  }
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "writing something",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 2, color: Colors.greenAccent))),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async{
                          try{
                            final userInput = _controller.text;
                            await notepad!.add(userInput);
                            Fluttertoast.showToast(msg: 'Added Successfully');
                          }catch(e){
                            Fluttertoast.showToast(msg: e.toString());
                          }
                    },
                    child: Text(
                      "Add New Data",
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(
                child: ListView.builder(
                  itemCount: 16,
              itemBuilder: (BuildContext context, int index) {
               return ListTile();
              },
            ))
          ],
        ),
      ),
    );
  }
}
