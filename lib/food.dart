//CS4990 Fridge Tracker App -- by Yunting Wang
class Food{
  String title;
  bool completed;
  DateTime expirationDate;  //helped

  Food({
    this.title,
    this.completed = false,
    this.expirationDate
  });

  Food.fromMap(Map<String, dynamic> map):
        title = map['title'],
        completed = map['completed'],
        expirationDate = map['expirationDate'];

  updateTitle(title){
    this.title = title;
  }

  updateExpirationDate(expirationDate){
    this.expirationDate = expirationDate;
  }

  Map toMap(){
    return{
      'title': title,
      'completed': completed,
      'expirationDate': expirationDate
    };
  }
}


class ScreenArguments {
  final String foodName;
  final DateTime expirationDate;

  ScreenArguments(this.foodName, this.expirationDate);
}