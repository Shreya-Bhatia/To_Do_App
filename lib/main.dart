import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:to_do_app/data/database.dart';
//import 'package:to_do_app/util/custom_showcase.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';
import 'onboarding_screen.dart';

int? isViewed;

Future<void> main() async{

  // trying alarm
  /*final alarmSettings = AlarmSettings(
    id: 42,
    dateTime: ,
    assetAudioPath: 'assets/alarm.mp3',
    loopAudio: true,
    vibrate: true,
    volumeMax: true,
    fadeDuration: 3.0,
    notificationTitle: 'This is the title',
    notificationBody: 'This is the body',
    enableNotificationOnKill: true,
  );*/

  // onBoarding only one time
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');

  // init the hive
  await Hive.initFlutter();

  // trying alarm
  /*await Alarm.init();
  await Alarm.set(alarmSettings: alarmSettings);*/

  // open a box
  var box = await Hive.openBox('mybox');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isViewed != 0 ?
    const OnBoardingScreen()
        :
    ShowCaseWidget(
      builder: Builder(
          builder : (context)=> const MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  // for showing intro to elements... showCaseView
  GlobalKey keyOne = GlobalKey();
  GlobalKey keyTwo = GlobalKey();

  // for showCaseView of listView
  int count = 0;


  @override
  void initState() {

    // if this is the 1st time ever opening this app then create default data
    if(_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }
    else {
      // there already exists data
      db.loadData();
    }

    super.initState();

    /*WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([
          keyOne,keyTwo,
        ]),
    );*/

  }

  // text controller
  final _controller = TextEditingController();

  // list of to do tasks
  /*List toDoList = [
    ["Call bro", false],
    ["Help a friend", true],
  ];*/

  // checkBox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // creates a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
    },);
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.pink[900],
          title: const Text('TO DO'),
        ),

        floatingActionButton: //isViewed != 0 ?
        /*CustomShowcaseWidget(
          globalKey: keyOne,
          description: 'Add new To Do',
          borderRadius: 100.0,
          child: FloatingActionButton(
              onPressed: createNewTask,
              backgroundColor: Colors.pink[900],
              child: const Icon(Icons.add),
          ),
        )
        :*/
        FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.pink[900],
          child: const Icon(Icons.add),
        )
        ,

        body: Column(
          children: [
            Container(
              color: Colors.pink[900],
              child: const TabBar(
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white,width: 3),
                  ),
                ),
                tabs: [
                Tab(
                  child: Text("Active Tasks"),
                ),
                Tab(
                  child: Text("Completed Tasks"),
                )
              ],),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //count == 0 ?
                  ListView.builder(
                  itemCount: db.toDoList.length,
                  itemBuilder: (context,index) {
                    if (db.toDoList[index][1] == false) {
                      count = count + 1;
                    return ToDoTile(
                        show: count-1,
                        keyTwo: keyTwo,
                        taskName: db.toDoList[index][0],
                        taskState: db.toDoList[index][1],
                        onChanged: (value) => checkBoxChanged(value,index),
                        deleteFunction: (context) => deleteTask(index),
                    );}
                    else
                    {
                      return const SizedBox.shrink();}
                  },
                  )
                  /*:
                  ListView.builder(
                    itemCount: db.toDoList.length,
                    itemBuilder: (context,index) {
                      if (db.toDoList[index][1] == false) {
                        return ToDoTile(
                          show: count,
                          keyTwo: keyTwo,
                          taskName: db.toDoList[index][0],
                          taskState: db.toDoList[index][1],
                          onChanged: (value) => checkBoxChanged(value,index),
                          deleteFunction: (context) => deleteTask(index),
                        ); }
                      else
                      {
                        return const SizedBox.shrink();}
                    },
                  )*/
                  ,
                  ListView.builder(
                    itemCount: db.toDoList.length,
                    itemBuilder: (context,index) {
                      if (db.toDoList[index][1] == true) {
                        return ToDoTile(
                          show: 1,
                          keyTwo: keyTwo,
                          taskName: db.toDoList[index][0],
                          taskState: db.toDoList[index][1],
                          onChanged: (value) => checkBoxChanged(value,index),
                          deleteFunction: (context) => deleteTask(index),
                        ); }
                      else
                      {
                        return const SizedBox.shrink();}
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}