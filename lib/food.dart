//CS4990 Fridge Tracker App -- by Yunting Wang
class Food{
  String title;
  bool completed;

  Food({
    this.title,
    this.completed = false,
  });

  Food.fromMap(Map<String, dynamic> map):
        title = map['title'],
        completed = map['completed'];

  updateTitle(title){
    this.title = title;
  }

  Map toMap(){
    return{
      'title': title,
      'completed': completed,
    };
  }
}

