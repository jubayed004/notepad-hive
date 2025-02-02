import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.import_contacts),
                    suffixIcon: Icon(Icons.insert_comment_sharp),
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () async {
                        try {
                          final userInput = _controller.text;
                          await notepad!.add(userInput);
                          _controller.clear();
                          Fluttertoast.showToast(msg: 'Added Successfully');
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      },
                      child: Text(
                        "Add New Data",
                        style: TextStyle(color: Colors.white),
                      ))),
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: Hive.box('notepad').listenable(),
                      builder: (context, box, widget) {
                        return ListView.builder(
                          itemCount: notepad!.keys.toList().length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                textColor: Colors.pink,
                                title: Text(notepad!.getAt(index).toString()),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Inter update  data"),
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {},
                                                            child:
                                                                Text("Update"))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                           await notepad!.deleteAt(index);
                                           Fluttertoast.showToast(msg: 'Deleted Successfully');
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
