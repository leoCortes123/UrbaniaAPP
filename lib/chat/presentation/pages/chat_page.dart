import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/shared/widgets/app_bottom_nav.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: 'Buenos días, ¿en qué puedo ayudarle?',
      isFromAdmin: true,
      time: '09:30',
    ),
    _ChatMessage(
      text: 'Buenos días, quería saber cuándo vuelven a activar el ascensor.',
      isFromAdmin: false,
      time: '09:35',
    ),
    _ChatMessage(
      text: 'Buenos días, el ascensor estará funcionando desde mañana. Estamos realizando mantenimiento preventivo.',
      isFromAdmin: true,
      time: '09:40',
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(
        text: _messageController.text,
        isFromAdmin: false,
        time: 'Ahora',
      ));
    });
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Administración'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.gutter),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _ChatBubble(
                  text: message.text,
                  isFromAdmin: message.isFromAdmin,
                  time: message.time,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border(
                top: BorderSide(color: AppColors.outlineVariant),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.surfaceContainerLow,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.send, color: AppColors.primaryContainer),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isFromAdmin;
  final String time;

  _ChatMessage({
    required this.text,
    required this.isFromAdmin,
    required this.time,
  });
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isFromAdmin;
  final String time;

  const _ChatBubble({
    required this.text,
    required this.isFromAdmin,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isFromAdmin ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isFromAdmin
              ? AppColors.surfaceContainerLow
              : AppColors.primaryContainer.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isFromAdmin ? Radius.zero : const Radius.circular(16),
            bottomRight: isFromAdmin ? const Radius.circular(16) : Radius.zero,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppTypography.bodyMD.copyWith(
                color: isFromAdmin
                    ? AppColors.onSurface
                    : AppColors.primaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: AppTypography.labelSM.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}