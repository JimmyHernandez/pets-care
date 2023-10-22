import 'package:flutter/material.dart';

import 'feed_pet.dart';

class VaccinePet extends StatefulWidget {
  const VaccinePet({Key? key}) : super(key: key);

  @override
  _Details02BasicLayoutWidgetState createState() =>
      _Details02BasicLayoutWidgetState();
}

class _Details02BasicLayoutWidgetState
    extends State<VaccinePet> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Health Guidelines",
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
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.00, -1.00),
                  child: Image.asset(
                    'assets/images/vaccine.png',
                    // Replace with the actual path to your asset image.
                    height: 340,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                // Image
                // Replace the Image widget with your desired image widget.

                // Guidelines
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Guidelines',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // Guidelines Text
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    "Vaccinating your pets is an important part of responsible pet ownership, ensuring their health and preventing the spread of certain diseases. ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Care Tips
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Care tips:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // List of Care Tips
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(95, 12, 12, 12),
                  child: Column(
                    children: <Widget>[
                      CareListItem("Core Vaccines: These are essential for most pets and protect against common and potentially deadly diseases. For dogs, core vaccines often include rabies, distemper, parvovirus, and adenovirus. Cats typically receive core vaccines for rabies, feline viral rhinotracheitis, calicivirus, and panleukopenia."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Core Vaccines: These are essential for most pets and protect against common and potentially deadly diseases. For dogs, core vaccines often include rabies, distemper, parvovirus, and adenovirus. Cats typically receive core vaccines for rabies, feline viral rhinotracheitis, calicivirus, and panleukopenia."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Vaccination Schedule: Puppies and kittens usually receive a series of vaccinations over several months to build immunity. Afterward, adult pets typically receive booster shots to maintain protection. Your vet will provide a specific schedule."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Lifestyle Considerations: Your pet's lifestyle and environment also play a role. For example, if your dog frequently interacts with other dogs in a dog park, certain vaccines like Bordetella might be advisable. If your cat is strictly indoors, some vaccines may be unnecessary."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Local Regulations: Be aware of local regulations regarding pet vaccinations. Some areas require specific vaccines, like rabies, by law."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Side Effects: While vaccines are generally safe, there can be side effects. Monitor your pet for any unusual reactions and report them to your veterinarian."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Regular Check-ups: Regular vet check-ups are essential for keeping your pet's vaccinations up to date and monitoring their overall health."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Remember that vaccination is just one aspect of pet care. Proper nutrition, exercise, and a loving environment are equally important. Always consult with your veterinarian to create a vaccination plan tailored to your pet's individual needs."),
                      SizedBox(height: 12), // Add space here
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
