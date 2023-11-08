import 'package:flutter/material.dart';

import '../../functions - jimmy/care_list_item.dart';

class ExercisePet extends StatefulWidget {
  const ExercisePet({Key? key}) : super(key: key);

  @override
  GuidelinesLayoutWidgetState createState() =>
      GuidelinesLayoutWidgetState();
}

class GuidelinesLayoutWidgetState
    extends State<ExercisePet> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1E6FF),
          title: const Text("Exercise Guidelines",
            style: TextStyle(
              color: Color(0xFF6F35A5), // Change the title color to black
              // fontFamily: 'YourFontFamily', // Set the desired font family
              fontSize: 35, // Set the desired font size
              fontWeight: FontWeight.bold, // Set the desired font weight
              // You can also use other text style properties like letterSpacing, wordSpacing, etc. // Change the title color to black
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
              color: Color(0xFF6F35A5),  // Change the back button color to blue
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
                const Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 35, 16, 16),
                        child: Text(
                          'Guidelines',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF6F35A5),
                          ),
                        ),
                      ),
                      // Guidelines Text
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 35),
                        child: Text(
                          "When it comes to pets and exercise, it's important to keep them healthy and happy. Here are some general guidelines for exercising your pets:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6F35A5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // List of Care Tips
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 35),
                  child: Column(
                    children: <Widget>[
                      CareListItem("Know Your Pet's Needs: Different pets have different exercise requirements. For example, dogs need more physical activity than cats. Consider your pet's age, breed, and health when planning their exercise routine."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Regular Playtime: Spend quality time playing with your pet. Use toys like balls, frisbees, or laser pointers for cats. This interactive playtime not only provides exercise but also strengthens your bond."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Walking Your Dog: If you have a dog, daily walks are essential. The duration and intensity of the walk will depend on your dog's size and energy level. Smaller breeds might need shorter, more frequent walks, while larger dogs require longer walks."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Off-Leash Play: If you have access to a safe, enclosed area, let your dog off the leash to run and play. This is especially important for breeds with high energy levels."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Cats and Indoor Play: Cats can benefit from indoor play sessions. Use toys like feather wands or treat-dispensing puzzles to engage them physically and mentally."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Consider Obstacles: For dogs, agility courses or obstacle courses can be a fun way to combine exercise with mental stimulation. It's also a great bonding activity."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Swimming: If you have a water-loving dog, swimming is an excellent low-impact exercise. Just ensure their safety and use appropriate gear if needed."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Hiking and Outdoor Adventures: For active dog owners, hiking and other outdoor activities can be a fantastic way to exercise together. Just make sure the terrain is suitable for your pet."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Avoid Overexertion: While exercise is crucial, be mindful not to overexert your pet, especially in extreme weather conditions. Dogs can overheat quickly, and cats can become exhausted."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Consult Your Vet: If you have concerns about your pet's exercise needs or any health issues, consult your veterinarian. They can provide tailored advice."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Routine Matters: Pets thrive on routine. Try to establish a regular exercise schedule to keep them happy and reduce behavioral issues."),
                      SizedBox(height: 25), // Add space here
                      CareListItem("Mental Stimulation: In addition to physical exercise, mental stimulation is important for pets. Puzzle toys and training sessions can engage their minds."),
                      SizedBox(height: 25), // Add space here
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
