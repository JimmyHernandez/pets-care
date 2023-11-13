import 'package:flutter/material.dart';
import 'package:pets_care/pages/my_pet_card/my_pets_page.dart';

import '../../functions/pet_registration.dart';


class PetsProfile extends StatefulWidget {
  const PetsProfile({super.key});
  @override
  PetsProfileState createState() => PetsProfileState();
}

class PetsProfileState extends State<PetsProfile> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _treatsController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1E6FF),
        title: const Text("Pet's Profile",

          style: TextStyle( color: Color(0xFF6F35A5), // Change the title color to black
            // fontFamily: 'YourFontFamily', // Set the desired font family
            fontSize: 35, // Set the desired font size
            fontWeight: FontWeight.bold, // Set the desired font weight Change the title color to black
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFF6F35A5), // Change this color to the one you prefer
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 350) {
                      return Container(
                        width: 600,
                        height: 600,
                        padding: const EdgeInsets.all(8),
                        child: Form(
                          child: Column(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                        TextFormField(
                                        controller: _petNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Pet name',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your Pet name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),
                                      TextFormField(
                                        controller: _breedController,
                                        decoration: const InputDecoration(
                                          labelText: 'Breed',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter breed';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),

                                      TextFormField(
                                        controller: _ageController,
                                        decoration: const InputDecoration(
                                          labelText: 'Age',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter age';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),

                                      TextFormField(
                                        controller: _weightController,
                                        decoration: const InputDecoration(
                                          labelText: 'Weigh',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter weigh';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),

                                      TextFormField(
                                        controller: _foodController,
                                        decoration: const InputDecoration(

                                          labelText: 'Food',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold

                                          ),
                                        ),
                                        keyboardType: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter food';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 1),

                                      TextFormField(
                                        controller: _treatsController,
                                        decoration: const InputDecoration(
                                          labelText: 'Treats',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 1),

                                      TextFormField(
                                        controller: _ownerController,
                                        decoration: const InputDecoration(
                                          labelText: 'Owner',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 1),

                                      TextFormField(
                                        controller: _phoneController,
                                        decoration: const InputDecoration(
                                          labelText: 'Phone Owner',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 25),
                                      // ... Other TextFormField widgets ...

                                      ElevatedButton(
                                        onPressed: () async {
                                          // Call the function to store pet information
                                          // Ensure this function exists and is correctly imported.
                                          PetInformationStorage(
                                            _petNameController,
                                            _ageController,
                                            _breedController,
                                            _weightController,
                                            _foodController,
                                            _treatsController,
                                            _ownerController,
                                            _phoneController,
                                          ).storePetInformation();

                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                              const MyPets(),
                                            ),
                                          );
                                          },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF6F35A5), // Change this color to your preferred one
                                        ),
                                        child: const Text('Save Profile'),
                                      ),
                                      const SizedBox(height: 25),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container(); // Return an empty container if maxWidth is not met.
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
