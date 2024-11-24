import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/utils/constants/colors.dart';

import '../../../../data/repositories/chat_message/chat_repository.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();
  final NewMessageRepository _messageRepository = NewMessageRepository();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() {
    final enteredMessage = _messageController.text.trim();

    if (enteredMessage.isEmpty) {
      return;
    }

    _messageRepository.sendMessage(enteredMessage);

    // Optionally, clear the input field after sending the message
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onSubmitted: (_) => _submitMessage(),
            ),
          ),
          IconButton(
            color: TColors.primary,
            icon: const Icon(Iconsax.send_2),
            onPressed: _submitMessage,
          ),
        ],
      ),
    );
  }
}
