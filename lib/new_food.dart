//CS4990 Fridge Tracker App -- by Yunting Wang
import 'package:flutter/material.dart';
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

  @override
  void initState(){
    super.initState();
    titleController = new TextEditingController(
        text: widget.item != null ? widget.item.title : null
    );
  }

  @override
  Widget build(BuildContext context){
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
          //========
                    //              controller: _date,
                    //              keyboardType: TextInputType.datetime,
                    //              decoration: InputDecoration(
                    //                hintText: 'Date of Birth',
                    //                prefixIcon: Icon(
                    //                  Icons.dialpad,
                    //                  color: _icon,
                    //                ),
                    //              ),
              //=======

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
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
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
    Navigator.of(context).pop(titleController.text);
  }
}

