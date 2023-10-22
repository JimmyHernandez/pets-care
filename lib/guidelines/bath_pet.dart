import 'package:flutter/material.dart';

import 'feed_pet.dart';

class BathPet extends StatefulWidget {
  const BathPet({Key? key}) : super(key: key);

  @override
  _Details02BasicLayoutWidgetState createState() =>
      _Details02BasicLayoutWidgetState();
}

class _Details02BasicLayoutWidgetState
    extends State<BathPet> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(

        appBar: AppBar(
          title: const Text("Bath Guidelines",
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
                    'assets/images/bath.png',
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
                    "Bathing your pet can be an important part of their overall grooming routine. Here are some steps to help you give your pet a proper bath:",
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
                      CareListItem("Gather Supplies: Before you begin, make sure you have all the necessary supplies on hand. This includes pet-specific shampoo, towels, a brush, a leash, and a non-slip mat to place in the tub or sink."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Brush Your Pet: Start by brushing your pet's fur to remove any tangles and loose hair. This will make the bathing process easier and more effective."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Prepare the Bathing Area: Whether you're using a tub, sink, or an outdoor space, ensure it's clean and free from any hazards. Place the non-slip mat in the bottom to prevent your pet from slipping."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Use Lukewarm Water: Fill the tub or sink with lukewarm water. Make sure it's not too hot or too cold, as extreme temperatures can be uncomfortable for your pet."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Wet Your Pet: Gently wet your pet's fur, starting at the neck and working your way down. Be careful around the face and ears, as you don't want water getting into their eyes or ears."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Apply Pet Shampoo: Use a pet-specific shampoo and lather it into your pet's fur. Be sure to follow the instructions on the shampoo bottle. Avoid using human shampoo, as it can be too harsh for your pet's skin."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Rinse Thoroughly: Rinse your pet's fur thoroughly, making sure to remove all the shampoo. Any leftover residue can irritate their skin."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Towel Dry: Gently towel dry your pet, being careful not to rub too vigorously. Some pets may tolerate a hairdryer on a low, cool setting, but be cautious as it can be loud and frightening for some animals."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Brush Again: After your pet is dry, give them a good brushing to prevent matting and to distribute natural oils through their coat."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Reward and Praise: Once the bath is over, give your pet a treat and lots of praise. This will help them associate bath time with positive experiences."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Regularity: The frequency of baths depends on your pet's breed and activity level. Dogs that spend a lot of time outdoors may need more frequent baths, while some cats are excellent self-groomers and require fewer baths."),
                      SizedBox(height: 12), // Add space here
                      CareListItem("Consult a Vet: If your pet has specific skin conditions or you're unsure about their grooming needs, consult your veterinarian for advice."),
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
