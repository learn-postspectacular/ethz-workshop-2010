class AgeSorter implements Comparator<Mammal> {

  int compare(Mammal a, Mammal b) {
    if (a.age < b.age) {
      return -1;
    }
    if (a.age == b.age) {
      return 0;
    } 
    else {
      return 1;
    }
  }
}

class NameSorter implements Comparator<Human> {

  int compare(Human a, Human b) {
    return a.name.compareToIgnoreCase(b.name);
  }
}


//public interface Comparator<T> {
//
//    int compare(T o1, T o2);
//
//    boolean equals(Object obj);
//}

//
//interface TransportControl {
//  
//  void play();
//  void record();
//  void stop();
//  void ffwd();
//  void pause();
//}

