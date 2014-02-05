class Human extends Mammal {

  String name;

  Human(String name, int age) {
    super(age);
    this.name=name;
  }
  
  public String toString() {
    return name+": "+age+","+isFemale+","+hairColor;
  }
}

class Mammal {
  
  int age;
  String hairColor;
  boolean isFemale;
  
  Mammal(int age) {
    this.age=age;
  }
}


ArrayList<Mammal> people;

void setup() {
  size(100,100);
  Human me = new Human("toxi",35);
  me.isFemale=false;
  me.hairColor="gray (soon)";

  Human you = new Human("mihye",99);
  you.isFemale=true;
  you.hairColor="blackbrown";

  Human other = new Human("jesper",26);
  other.isFemale=false;
  other.hairColor="blondish";

  people=new ArrayList<Mammal>();
  people.add(me);
  people.add(you);
  people.add(other);

  println(people.size()); // array equivalent: people.length
  printPeople();
  
  Collections.sort(people,new AgeSorter());

  println("---sorted---");
  printPeople();
}

void printPeople() {
  for(int i=0; i<people.size(); i++) {
    println(i+": "+people.get(i)); // array equivalent: people[i]
  }
}

