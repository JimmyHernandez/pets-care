import 'package:flutter/material.dart';
import 'package:pets_care/pages/my_pets.dart';
import '../functions jimmy/pet_registration.dart';

class PetsProfile extends StatefulWidget {
  const PetsProfile({super.key});

  @override
  _PetsProfile createState() => _PetsProfile();
}

class _PetsProfile extends State<PetsProfile> {
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
        title: const Text("Pet's Profile",

          style: TextStyle(
            color: Colors.black, // Change the title color to black
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this color to the one you prefer
        ),
        backgroundColor: Colors.white, // Change this color to the one you prefer
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 1),
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
                                      const CircleAvatar(
                                        radius: 50,
                                        // You can load the user's profile picture here
                                        backgroundImage: NetworkImage("https://example.com/profile_image.jpg"),
                                      ),

                                      TextFormField(
                                        controller: _petNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Pet name',
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: Color(0xff0849ea),
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
                                            color: Color(0xff0849ea),
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
                                            color: Color(0xff0849ea),
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
                                            color: Color(0xff0849ea),
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
                                            color: Color(0xff0849ea),

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
                                            color: Color(0xff0849ea),
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
                                            color: Color(0xff0849ea),
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
                                            color: Color(0xff0849ea),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 1),
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
                                        child: const Text('Save Profile'),
                                      ),
                                      const SizedBox(height: 3),
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
