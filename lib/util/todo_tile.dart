import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:to_do_app/util/custom_showcase.dart';

class ToDoTile extends StatelessWidget {

  final String taskName;
  final bool taskState;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? deleteFunction;
  final GlobalKey keyTwo = GlobalKey();
  final int show;

  ToDoTile({
    super.key ,
    required this.taskName ,
    required this.taskState ,
    required this.onChanged ,
    required this.deleteFunction,
    required this.show,
    required keyTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 0.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(20.0),//BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
              ),
            ],
        ),
        child: Container(
              padding: const EdgeInsets.all(15.0),
              //margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 0.0),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(20.0),//const BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
              ),
              child: Row(
                children: [
                  /*show ==  1 ?
                  CustomShowcaseWidget(
                    globalKey: keyTwo,
                    description: 'Mark completed tasks',
                    borderRadius: 5.0,
                    child: Checkbox(
                        value: taskState,
                        onChanged: onChanged,
                        activeColor: Colors.pink[900],
                    ),
                  )
                  :*/
                  Checkbox(
                    value: taskState,
                    onChanged: onChanged,
                    activeColor: Colors.pink[900],
                  )
                  ,
                  Expanded(
                    child: Text(
                      taskName,
                      style: TextStyle(
                          fontSize: 17,
                          decoration: taskState ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
