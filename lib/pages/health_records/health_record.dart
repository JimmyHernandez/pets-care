import 'package:flutter/material.dart';

void main() {
  runApp(const MyPetHealthApp());
}

class MyPetHealthApp extends StatelessWidget {
  const MyPetHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Health Records',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PetHealthTable(),
    );
  }
}

class PetHealthTable extends StatefulWidget {
  const PetHealthTable({super.key});

  @override
  _PetHealthTableState createState() => _PetHealthTableState();
}

class _PetHealthTableState extends State<PetHealthTable> {
  // Define a list of sample pet health records. You can replace this with actual data.
  final List<PetHealthRecord> petRecords = [
    PetHealthRecord('Fluffy', 'Dog', '2023-01-10', 'Vaccinated'),
    PetHealthRecord('Whiskers', 'Cat', '2023-02-15', 'Checkup'),
    // Add more records here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Records",
          style: TextStyle(
            color: Colors.black, // Change the title color to black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Chan
        // Change this color to the one you prefer
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the back button color to blue
        ),
        actions: const [SizedBox(width: 1),
        ],
      ),
      body:
      Center(
          child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Status')),
          ],
          rows: petRecords
              .map(
                (record) => DataRow(
              cells: [
                DataCell(Text(record.name)),
                DataCell(Text(record.type)),
                DataCell(Text(record.date)),
                DataCell(Text(record.status)),
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}

class PetHealthRecord {
  final String name;
  final String type;
  final String date;
  final String status;

  PetHealthRecord(this.name, this.type, this.date, this.status);
}
