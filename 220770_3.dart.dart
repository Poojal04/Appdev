// Animal class
class Animal {
  String name;
  int age;
  String healthStatus;
  String type; // Added type for the animal

  Animal({required this.name, required this.age, this.healthStatus = 'Healthy', required this.type});

  void displayDetails() {
    print('$type - Name: $name, Age: $age, Health Status: $healthStatus');
  }
}

// FeedingSchedule class
class FeedingSchedule {
  String animalName;
  String time;
  String foodType;
  String quantity;

  FeedingSchedule({
    required this.animalName,
    required this.time,
    required this.foodType,
    required this.quantity,
  });
}

// Exhibit class
class Exhibit {
  String name;
  List<Animal> animals;
  List<FeedingSchedule> feedingSchedules;

  Exhibit({required this.name}) : animals = [], feedingSchedules = [];

  void addAnimalToExhibit(Animal animal) {
    animals.add(animal);
  }

  void addFeedingSchedule(FeedingSchedule schedule) {
    feedingSchedules.add(schedule);
  }

  void displayDetails() {
    print('Exhibit Name: $name');
    print('Animals:');
    animals.forEach((animal) => animal.displayDetails());
    print('Feeding Schedules:');
    feedingSchedules.forEach((schedule) {
      print(
          '${schedule.animalName} - ${schedule.time} - ${schedule.foodType} - ${schedule.quantity}');
    });
  }
}

// Zoo class
class Zoo {
  List<Animal> animals;
  List<Exhibit> exhibits;
  List<FeedingSchedule> feedingSchedules;
  List<Visitor> visitors;

  Zoo()
      : animals = [],
        exhibits = [],
        feedingSchedules = [],
        visitors = [];

  void addAnimal(Animal animal) {
    animals.add(animal);
  }

  void addExhibit(Exhibit exhibit) {
    exhibits.add(exhibit);
  }
void transferAnimal(String animalName, String fromExhibit, String toExhibit) {
  Exhibit sourceExhibit = exhibits.firstWhere(
    (exhibit) => exhibit.name == fromExhibit,
    orElse: () => Exhibit(name: 'DefaultExhibit'),
  );

  Exhibit targetExhibit = exhibits.firstWhere(
    (exhibit) => exhibit.name == toExhibit,
    orElse: () => Exhibit(name: 'DefaultExhibit'),
  );

  Animal animalToTransfer = Animal(name:animalName, age: 0, type: ''); // Default Animal instance
 targetExhibit.animals.add(animalToTransfer);
  for (var exhibit in exhibits) {
    animalToTransfer = exhibit.animals.firstWhere(
      (animal) => animal.name == animalName,
      orElse: () => Animal(name: '', age: 0, type: ''), // Default Animal instance
    );
    // if (animalToTransfer.name.isNotEmpty) {
    //   exhibit.animals.remove(animalToTransfer);
    //   break;
    // }
  }

  if (animalToTransfer.name.isNotEmpty) {
    targetExhibit.animals.add(animalToTransfer);
    // print('Successfully transferred $animalName from $fromExhibit to $toExhibit');
  } 
}

void moveAnimalToExhibit(String animalName, String toExhibit) {
  Exhibit targetExhibit = exhibits.firstWhere(
    (exhibit) => exhibit.name == toExhibit,
    orElse: () => Exhibit(name: 'DefaultExhibit'),
  );

  Animal animalToMove = Animal(name: animalName, age: 0, type: ''); // Default Animal instance
 targetExhibit.animals.add(animalToMove);
  // for (var exhibit in exhibits) {
  //   animalToMove = exhibit.animals.firstWhere(
  //     (animal) => animal.name == animalName,
  //     orElse: () => Animal(name: '', age: 0, type: ''), // Default Animal instance
  //   );
  //   if (animalToMove.name.isNotEmpty) {
  //     exhibit.animals.remove(animalToMove);
  //     break;
  //   }
  // }

  // if (animalToMove.name.isNotEmpty) {
    // targetExhibit.animals.add(animalToMove);
    // print('Successfully moved $animalName to $toExhibit');
  // } 
}

  void addFeedingSchedule(FeedingSchedule schedule) {
    feedingSchedules.add(schedule);
  }

  void updateFeedingSchedule(
  String animalName, String time, String foodType, String quantity) {
  int scheduleIndex = feedingSchedules.indexWhere(
    (schedule) => schedule.animalName == animalName,
  );

  if (scheduleIndex != -1) {
    feedingSchedules[scheduleIndex].time = time;
    feedingSchedules[scheduleIndex].foodType = foodType;
    feedingSchedules[scheduleIndex].quantity = quantity;
    // print('Updated feeding schedule for $animalName');
  } 
}


  void displayAllAnimals() {
    print('Details of All Animals:');
    animals.forEach((animal) => animal.displayDetails());
  }

  void displayExhibits() {
    print('Details of All Exhibits:');
    exhibits.forEach((exhibit) {
      print('${exhibit.name}: ${exhibit.animals.map((animal) => animal.name).join(', ')}');
    });
  }

  void displayFeedingSchedule() {
    print('Details of All Feeding Schedules:');
    feedingSchedules.forEach((schedule) {
      print('${schedule.animalName} - ${schedule.time} - ${schedule.foodType} - ${schedule.quantity}');
    });
  }

  void displayVisitors() {
    print('Details of All Visitors:');
    visitors.forEach((visitor) {
      print('${visitor.name} (Age: ${visitor.age}) - Visited Exhibits: ${visitor.visitedExhibits.join(', ')}');
    });
  }
}

// Visitor class
class Visitor {
  String name;
  int age;
  List<String> visitedExhibits;

  Visitor({required this.name, required this.age}) : visitedExhibits = [];

  void visitExhibit(Zoo zoo, String exhibitName) {
    visitedExhibits.add(exhibitName);
    zoo.visitors.add(this);
  }
}

void main() {
  Zoo myZoo = Zoo();

  myZoo.addAnimal(Animal(name: 'Simba', age: 5, type: 'Lion'));
  myZoo.addAnimal(Animal(name: 'Gerald', age: 3, type: 'Giraffe'));

  myZoo.addExhibit(Exhibit(name: 'Savannah Exhibit'));
  myZoo.addExhibit(Exhibit(name: 'Rainforest Exhibit'));

  myZoo.addFeedingSchedule(
      FeedingSchedule(animalName: 'Simba', time: '10:00 AM', foodType: 'Meat', quantity: '2 kg'));
  myZoo.addFeedingSchedule(
      FeedingSchedule(animalName: 'Gerald', time: '12:30 PM', foodType: 'Leaves', quantity: '5 kg'));

  myZoo.transferAnimal('Simba', 'General Exhibit', 'Savannah Exhibit');

  myZoo.moveAnimalToExhibit('Gerald', 'Rainforest Exhibit');

  myZoo.updateFeedingSchedule('Simba', '10:00 AM', 'Meat', '3 kg');

  Visitor johnDoe = Visitor(name: 'John Doe', age: 25);
  johnDoe.visitExhibit(myZoo, 'Savannah Exhibit');

  myZoo.displayAllAnimals();
  myZoo.displayExhibits();
  myZoo.displayFeedingSchedule();
  myZoo.displayVisitors();
}
