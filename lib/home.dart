import 'package:chessy/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final input = TextEditingController();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/chess.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('lib/images/ches.png'),
                  width: 400,
                  height: 200,
                ),
                const SizedBox(height: 27),
                const Text(
                  'Enter Duration :',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 249, 243),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: input,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(233, 251, 238, 223),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.brown.shade300,
                          )),
                      hintText: 'Enter time in minutes',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 57, 36, 19),
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    final value = input.text;
                    if (value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please enter a valid duration'),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(duration: value),
                          ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 251, 238, 223),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Colors.brown.shade300,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Start Game',
                    style: TextStyle(
                      color: Color.fromARGB(255, 70, 43, 22),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Card(
                    color: const Color.fromARGB(235, 251, 238, 223),
                    child: Padding(
                      // This padding inside the card makes the card adjust based on text size
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: Text(
                        'Tip: Tapping with two fingers will play the check sound!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 109, 67, 35),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
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
