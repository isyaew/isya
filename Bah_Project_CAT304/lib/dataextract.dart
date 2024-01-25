import 'package:firebase_database/firebase_database.dart';

class Data {
  String key;
  String value;

  Data(this.key, this.value);
}

// ignore: deprecated_member_use
final databaseReference = FirebaseDatabase.instance.reference();

// Function to extract data from the database
Future<List<Data>> getData() async {
  // Query the database for the data
  Stream<DatabaseEvent> events = databaseReference.child("data").onValue;
  // Create a list to store the data
  List<Data> dataList = [];
  // Listen for events and add the data to the list
  await for (DatabaseEvent event in events) {
    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> values =
          event.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        dataList.add(Data(key, value));
      });
    }
  }
  // Return the list
  return dataList;
}

void main() async {
  // Call the getData function to retrieve the data
  List<Data> dataList = await getData();
  // Iterate over the data and print it
  for (var data in dataList) {
    print(data.key + ": " + data.value);
  }
}
