//CS4990 Fridge Tracker App -- by Yunting Wang
import 'package:flutter/material.dart';
import 'new_food.dart';
import 'food.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fridge Tracker',
      home: MyHomePage(title: 'Flutter Tracker Home'),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        //primarySwatch: Colors.purple[300],
        //Container(color: Colors.red[200])
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
//below class line added with trickerprociderstateminxin
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  //final bgColor = const Color(#badc57);

  List<Food> items = new List<Food>();
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  AnimationController emptyListController;

  @override
  void initState(){
    emptyListController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    emptyListController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fridge Food',
            key: Key('main-app-title'),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => goToNewItemView(),
        ),
        body: renderBody()
    );
  }

  Widget renderBody(){
    if(items.length > 0){
      return buildListView();
    }else{
      return emptyList();
    }
  }

  Widget emptyList(){
    //String myString = '🙃';
    return Center(
        child: FadeTransition(


            opacity: emptyListController,
            child: Text(
              'No food 🙃',
              style: TextStyle(fontSize: 18.0),
            )
        )
    );
  }

  Widget buildListView(){
    return AnimatedList(
      key: animatedListKey,
      initialItemCount: items.length,
      itemBuilder: (BuildContext context, int index, animation){
        return SizeTransition(
          sizeFactor: animation,
          child: buildItem(items[index], index),
        );
      },
    );
  }

  Widget buildItem(Food item, int index){


    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(color: Colors.lime),
      //background: bgColor,
      onDismissed: (direction) => removeItemFromList(item, index),
      direction: DismissDirection.startToEnd,
      child: buildListTile(item, index),
    );
  }

  Widget buildListTile(item, index){
    return ListTile(
      onTap: () => changeItemCompleteness(item),
      onLongPress: () => goToEditItemView(item),
      title: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
            color: item.completed ? Colors.grey:Colors.black,
            decoration: item.completed ? TextDecoration.lineThrough : null
        ),
      ),
      trailing: Icon(item.completed
          ? Icons.check_box
          : Icons.check_box_outline_blank,
        key: Key('completed-icon-$index'),
      ),
    );
  }

  void changeItemCompleteness(Food item){
    setState(() {
      item.completed = !item.completed;
    });
  }

  void goToNewItemView(){
    //push the new food items to the navigator stack. by using a
    //MaterialPageRoute we get standard behaviour of a Material app, which will
    //show a back button automatically for each platform on the left top corner
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return NewFoodView();
    })).then((title){
      if(title != null){
        addItem(Food(title:title));
      }
    });
  }

  void addItem(Food item){
    //insert a food item into the top of the list on index zero
    items.insert(0, item);
    if(animatedListKey.currentState != null)
      animatedListKey.currentState.insertItem(0);
  }

  void goToEditItemView(Food item) {
    //here reuse the NewFoodView class and push it to the navigator stack just
    //like before, but now we send the title of the item on the class constructor
    //and expect a new title to be returned so that we can edit the item
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return NewFoodView(item: item);
    })).then((title){
      if(title != null){
        editItem(item, title);
      }
    });
  }

  void editItem(Food item, String title){
    item.title = title;
  }

  void removeItemFromList(Food item, int index){
    animatedListKey.currentState.removeItem(index, (context, animation){
      return SizedBox(width: 0, height: 0,);
    });
    deleteItem(item);
  }

  void deleteItem(Food item){
    //Dart objects are uniquely identified by a hascode. Need to pass our
    //object on the remove method of the list. No need to search for our item
    //on the list
    items.remove(item);
    if(items.isEmpty){
      emptyListController.reset();
      setState(() {
      });
      emptyListController.forward();

    }

  }


}

