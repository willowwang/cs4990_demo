//CS4990 Fridge Tracker App -- by Yunting Wang
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'food.dart';

class NewFoodView extends StatefulWidget{
  //Food is a class, item is the object, Food is in the food.dart file
  final Food item;

  NewFoodView({ this.item });

  @override
  _NewFoodViewState createState() => _NewFoodViewState();
}

class _NewFoodViewState extends State<NewFoodView>{
  TextEditingController titleController;
        //added timer counter
       //   int _counter = 10;
  DateTime _date = DateTime.now();  //this give us the current date

  Future<Null> selectDate(BuildContext context) async{
    final DateTime _selDate = await showDatePicker(
        context: context,
        initialDate: _date,   //this is current date
        firstDate: DateTime(2019),
        lastDate: DateTime(2022),
        builder: (context, child){
          return SingleChildScrollView(child: child,);
        }
    );

    if (_selDate != null){
      setState(() {
        _date = _selDate;
        print(_date.toString());
      });
    }
  }

  @override
  void initState(){
    super.initState();
    titleController = new TextEditingController(
        text: widget.item != null ? widget.item.title : null
    );
  }

  @override
  Widget build(BuildContext context){
    String _formatteDate = new DateFormat.yMMMd().format(_date);
    //without above line the date format was pretty raw
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item != null ? 'Edit food' : 'New food',
          key: Key('new-item-title'),

        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: titleController,
              autofocus: true,
              onEditingComplete: submit,  //submit is a void function
              style: TextStyle(fontSize: 25.0),
              decoration: InputDecoration(labelText: 'Eat 🍅🥦🍒🥑🥩🍨and more'),
            ),
            SizedBox(height: 14.0,),
            Align(
              alignment: Alignment.centerLeft,
                child: Text(
                  'Pick an Expiration Date: ',

                  style: TextStyle(
                      fontSize: 19.0,
                      color: Theme.of(context).primaryColor
                  ),
                ),
            ),
//            Text(
//              'Pick an Expiration Date: ',
//              style: TextStyle(
//                  fontSize: 20.0,
//                  color: Theme.of(context).primaryColor
//              ),
//            ),
//            IconButton(
//              icon: Icon(Icons.calendar_today),
//              onPressed: (){
//                selectDate(context);
//              },
//            ),
            SizedBox(height: 14.0,),

            Align(
              alignment: Alignment.centerLeft,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    '$_formatteDate',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).primaryTextTheme.title.color
                    ),
                  ),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                      )
                  ),
                  onPressed: (){
                    selectDate(context);
                  },
                ),
        ),
            SizedBox(height: 14.0,),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Save',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).primaryTextTheme.title.color
                ),
              ),
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )
              ),
              onPressed: () => submit(),
            )
          ],
        ),
      ),
    );
  }

  //the submit button to navigate to the next page
  void submit(){
    Navigator.of(context).pop(
        ScreenArguments(titleController.text, _date)
    );
    //    Navigator.of(context).pop(titleController.text);
  }
}

