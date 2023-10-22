import 'package:flutter/material.dart';

import 'feed_pet.dart';

class ExercisePet extends StatefulWidget {
  const ExercisePet({Key? key}) : super(key: key);

  @override
  _Details02BasicLayoutWidgetState createState() =>
      _Details02BasicLayoutWidgetState();
}

class _Details02BasicLayoutWidgetState
    extends State<ExercisePet> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Exercise Guidelines",
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
                    'assets/images/playing.png',
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
                    "When it comes to pets and exercise, it's important to keep them healthy and happy. Here are some general guidelines for exercising your pets:",
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
                      CareListItem("Know Your Pet's Needs: Different pets have different exercise requirements. For example, dogs need more physical activity than cats. Consider your pet's age, breed, and health when planning their exercise routine."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Regular Playtime: Spend quality time playing with your pet. Use toys like balls, frisbees, or laser pointers for cats. This interactive playtime not only provides exercise but also strengthens your bond."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Walking Your Dog: If you have a dog, daily walks are essential. The duration and intensity of the walk will depend on your dog's size and energy level. Smaller breeds might need shorter, more frequent walks, while larger dogs require longer walks."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Off-Leash Play: If you have access to a safe, enclosed area, let your dog off the leash to run and play. This is especially important for breeds with high energy levels."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Cats and Indoor Play: Cats can benefit from indoor play sessions. Use toys like feather wands or treat-dispensing puzzles to engage them physically and mentally."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Consider Obstacles: For dogs, agility courses or obstacle courses can be a fun way to combine exercise with mental stimulation. It's also a great bonding activity."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Swimming: If you have a water-loving dog, swimming is an excellent low-impact exercise. Just ensure their safety and use appropriate gear if needed."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Hiking and Outdoor Adventures: For active dog owners, hiking and other outdoor activities can be a fantastic way to exercise together. Just make sure the terrain is suitable for your pet"),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Avoid Overexertion: While exercise is crucial, be mindful not to overexert your pet, especially in extreme weather conditions. Dogs can overheat quickly, and cats can become exhausted."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Consult Your Vet: If you have concerns about your pet's exercise needs or any health issues, consult your veterinarian. They can provide tailored advice."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Routine Matters: Pets thrive on routine. Try to establish a regular exercise schedule to keep them happy and reduce behavioral issues."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Mental Stimulation: In addition to physical exercise, mental stimulation is important for pets. Puzzle toys and training sessions can engage their minds."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Remember that your pet's happiness and well-being are paramount. If your pet enjoys the exercise and it strengthens your bond, then you're on the right track. Make sure to adjust the exercise routine as your pet's needs change with age, and always prioritize their safety and health."),
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
