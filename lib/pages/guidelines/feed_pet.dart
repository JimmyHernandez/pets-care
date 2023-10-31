import 'package:flutter/material.dart';

class FeedPet extends StatefulWidget {
  const FeedPet({Key? key}) : super(key: key);

  @override
  GuidelinesLayoutWidgetState createState() =>
      GuidelinesLayoutWidgetState();
}

class GuidelinesLayoutWidgetState
    extends State<FeedPet> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food Guidelines",
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
                    'assets/images/food.png',
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
                          ),
                        ),
                      ),
                      // Guidelines Text
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 35),
                        child: Text(
                          "Taking care of your pets, including their feeding, is an important responsibility."
                              " Here are some guidelines on how to feed your pets and what every pet owner should know",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // List of Care Tips
              const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(200, 12, 200, 12),
                child: Column(
                        children: <Widget>[
                          CareListItem("Understand Your Pet's Nutritional Needs: Different pets have different dietary requirements. Cats, dogs, birds, and reptiles all have unique nutritional needs. Consult with your veterinarian or do some research to understand what's best for your specific pet."),
                          SizedBox(height: 25), // Add space here
                          CareListItem("High-Quality Food: Choose high-quality pet food. Look for brands that list a meat source as the first ingredient and avoid foods with excessive fillers like corn or wheat. This provides essential nutrients for your pet."),
                          SizedBox(height: 25), // Add space here
                          CareListItem("Portion Control: Overfeeding can lead to obesity, while underfeeding can result in malnutrition. Follow the recommended portion sizes on the pet food packaging, but adjust based on your pet's age, activity level, and any specific dietary requirements."),
                          SizedBox(height: 25), // Add space here
                          CareListItem("Meal Schedule: Establish a consistent meal schedule. Most pets do well with two meals a day, but the frequency may vary depending on the type of pet. Make sure the timing suits your daily routine."),
                          SizedBox(height: 25), // Add space here
                          CareListItem("Fresh Water: Always provide fresh, clean water for your pet. Ensure their water bowl is clean and refilled regularly. Hydration is as important as food."),
                          SizedBox(height: 25),// Add space here
                          CareListItem("Special Dietary Needs: Some pets may have allergies, dietary restrictions, or special health conditions that require a specific diet. Consult with your veterinarian to determine the best food for these cases."),
                          SizedBox(height: 25), // Add space here
                          CareListItem("Treats in Moderation: Treats are a great way to reward your pet, but don't overdo it. Too many treats can lead to weight gain. Use treats sparingly and opt for healthy options when possible."),
                          SizedBox(height: 25), // Add space here
                          CareListItem("Avoid Feeding Table Scraps: Human food can be harmful to pets. Some foods are toxic to them, such as chocolate, onions, and grapes. Avoid giving them table scraps, and educate your family and guests about what not to feed your pets."),
                          SizedBox(height: 25),// Add space here
                          CareListItem("Regular Vet Check-ups: Regular check-ups with a veterinarian are essential. They can help you monitor your pet's weight, assess their overall health, and make dietary recommendations if needed."),
                          SizedBox(height: 25), // Add space here
                          CareListItem("Age-Appropriate Food: As pets age, their nutritional needs change. Consider transitioning to senior or age-appropriate food as your pet gets older. Puppies and kittens also have unique dietary needs."),
                          SizedBox(height: 25),
                          CareListItem("Proper Storage: Store pet food in a cool, dry place, and seal it tightly to maintain freshness. Check the expiration date on the packaging to ensure you're providing fresh food."),
                          SizedBox(height: 25),// Add space here
                          CareListItem("Observe Your Pet: Keep an eye on your pet's eating habits. Sudden changes in appetite or behavior might indicate health issues. If you notice anything unusual, consult your vet."),
                          SizedBox(height: 25),// Add space here
                          CareListItem("Socialization During Feeding: For social animals like dogs, consider feeding them in a designated area to establish a routine. This can help prevent food aggression and ensure a peaceful mealtime."),
                          SizedBox(height: 25),// Add space here
                          CareListItem(
                            "Consult your vet for specific dietary recommendations."),
                           // Add space here
                      ],
                    ),
                  )

                ]
              ),
            ),
        ),
      )
    );
  }
}

class CareListItem extends StatelessWidget {
  final String text;

  const CareListItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            '\u2022', // Bullet point character
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}


