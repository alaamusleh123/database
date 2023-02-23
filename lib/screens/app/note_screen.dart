import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v12_database/providers/note_provider.dart';
import 'package:v12_database/storage/pref_controller.dart';
import 'package:v12_database/utils/helpers.dart';

import '../../models/note.dart';
class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helpers{
  late TextEditingController _titleTextController;
  late TextEditingController _infoTextController;
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController=TextEditingController(text: widget.note?.title);
    _infoTextController=TextEditingController(text: widget.note?.details);
  }
  @override
  void dispose() {
    _titleTextController.dispose();
    _infoTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Note',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const Text(
              'Enter note details',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _titleTextController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 1,
                      color: Colors.blue
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _infoTextController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'info',
                prefixIcon: Icon(Icons.title),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 1,
                      color: Colors.blue
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: ()async=> await performSave(),
              child: Text('SAVE',),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity,50),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> performSave() async{
    if(checkData()){
      await save();
    }
  }

  bool checkData(){
    if(_titleTextController.text.isNotEmpty &&
        _infoTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data' , error:  true);
    return false;
  }
  Future<void> save() async{
    bool saved=  isCreate()
        ? await Provider.of<NoteProvider>(context ,listen: false).create(note: note)
        : await Provider.of<NoteProvider>(context, listen: false).update(note);
    String message= saved? 'saved successfully' : 'save failed';
    showSnackBar(context, message: message,error: !saved);
    isCreate()? clear() : Navigator.pop(context);
  }

  bool isCreate() => widget.note == null;
  Note get note{
    Note note=Note();
    if(!isCreate()){
      note.id=widget.note!.id;
    }
    note.title =_titleTextController.text;
    note.details=_infoTextController.text;
    note.userId=PrefController().getValueFor<int>(key: PrefKeys.id.toString())!;
    return note;
  }
  void clear(){
    _titleTextController.text='';
    _infoTextController.text='';
  }
}
