import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String hint;
  final Function(String) onSubmit;
  
  const InputWidget({
    super.key,
    required this.hint,
    required this.onSubmit,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmit(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: _handleSubmit,
              icon: const Icon(Icons.send),
            ),
          ),
          onSubmitted: (value) => _handleSubmit(),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Get UID'),
          ),
        ),
      ],
    );
  }
}