import 'package:flutter/material.dart';

class VaccineGuide extends StatefulWidget {
  const VaccineGuide({Key? key}) : super(key: key);
  @override
  GuidelinesLayoutWidgetState createState() =>
      GuidelinesLayoutWidgetState();
}

class GuidelinesLayoutWidgetState
    extends State<VaccineGuide> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(

        appBar: AppBar(
          title: const Text("Vaccine Guidelines",
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
                const Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text(
                          'Cats and Dogs Vaccination Guides',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // Guidelines Text
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text(
                          "A vaccine guide to keep your pet healthy",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(200, 0, 200, 0),
                    child: Column(
                      children: <Widget>[
                        Image(
                            image: AssetImage('assets/images/cat_vaccine.png'), // Replace with the actual URL of your image
                          width: 700, // Set the width as per your requirements
                          height: 700, // Set the height as per your requirements
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(200, 15, 200, 15),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/dog_vaccine.png'), // Replace with the actual URL of your image
                          width: 700, // Set the width as per your requirements
                          height: 700, // Set the height as per your requirements
                        ),
                      ],
                    ),
                  ),
                )
                // List of Care Tips
              ],
            ),
          ),
        ),
      ),
    );
  }
}
