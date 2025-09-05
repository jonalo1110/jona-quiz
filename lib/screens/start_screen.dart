import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jona_quiz/services/api_service.dart';

class StartScreen extends StatefulWidget {
  const StartScreen(this.startQuiz, {super.key});

  final VoidCallback startQuiz;

  @override
  State<StartScreen> createState() => _StartScreenState(); 
}

class _StartScreenState extends State<StartScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onStartPressed() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name first.')),
      );
      return;
    }

    print(name);

    try {
      await ApiService.sendName(name);
    } catch (e) {
      print('sendName error: $e');
    }

    widget.startQuiz();
  }

  @override
  Widget build(BuildContext context) { 
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              elevation: 6,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/profile.PNG',
                width: 220,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Get To Know Jonathan!',
              style: GoogleFonts.lato(
                fontSize: 25,
                color: Colors.white.withOpacity(0.85),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 315,
              child: TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 165,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: _onStartPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 10, 72, 100),
                ),
                label: const Text('Start Quiz'),
                icon: const Icon(Icons.arrow_right_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
