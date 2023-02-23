import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v12_database/providers/note_provider.dart';
import 'package:v12_database/screens/app/note_screen.dart';
import 'package:v12_database/utils/helpers.dart';
class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helpers{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NoteProvider>(context,listen: false).read();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notes'),
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NotesScreen(),),);
          }, icon: Icon(Icons.create))
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context,NoteProvider value,child){
          if(value.loading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(value.notes.isNotEmpty){
            return ListView.builder(
              itemCount: value.notes.length,
              itemBuilder: (context,index){
                return ListTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>NoteScreen(
                          note: value.notes[index],
                        ),),);
                  },
                  leading: Icon(Icons.note),
                  title: Text(value.notes[index].title),
                  subtitle: Text(value.notes[index].details),
                  trailing: IconButton(
                    onPressed: ()=> deletedNote(index),
                    icon: Icon(Icons.delete),
                  ),
                );
              },);
          }else{
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning,
                    size: 80,
                  ),
                  Text(
                    'No DATA',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
  void deletedNote(int index) async{
    bool _deleted= await Provider.of<NoteProvider>(context, listen: false).delete(index);
    String message =_deleted? 'Note deleted successfully' : 'Note delete failed';
    showSnackBar(context, message: message,error: !_deleted);
  }
}
