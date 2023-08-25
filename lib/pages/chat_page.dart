import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class ChatPage extends StatefulWidget {

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;
  List<ChatMessage> _messages = [];
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('personal-message', _listenMessage);

    _loadHistory(chatService.userTo!.uid);
    super.initState();
  }

  void _loadHistory(String userId) async {
    List<Message> chat = await chatService.getChat(userId);
    final history = chat.map((m) => ChatMessage(
      text: m.message, 
      uid: m.from, 
      animationController: AnimationController(
        vsync: this, 
        duration: const Duration(milliseconds: 0))..forward()
    ));
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(
      text: payload['message'], 
      uid: payload['from'], 
      animationController: AnimationController(
        vsync: this, 
        duration: const Duration(milliseconds: 400))
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final userTo = chatService.userTo;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget> [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: Text(userTo?.initials, style: const TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 3),
            Text(userTo?.fullName, style: const TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: <Widget> [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (context, index) => _messages[index],
                reverse: true,
              ),
            ),
            const Divider(height: 1),
            _inputChat()
          ],
        )
      )
   );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget> [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                onChanged: (String text) {
                  setState(() {
                    _isWriting = text.trim().isNotEmpty;
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send message'
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _isWriting
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                    child: const Text('Send'),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: const Icon(Icons.send),
                        onPressed: _isWriting
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                      ),
                    ),
                  )
            )
          ],
        ),
      ),
    );
  }

  _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    //print(text);
    _textController.clear();
    _focusNode.requestFocus();
    _messages.insert(0, ChatMessage(
      text: text, 
      uid: authService.user!.uid, 
      animationController: AnimationController(
        vsync: this, 
        duration: const Duration(milliseconds: 400))
    ));
    _messages[0].animationController.forward();
    setState(() {
      _isWriting = false;
    });
    socketService.socket.emit('personal-message', {
      'from': authService.user!.uid,
      'to': chatService.userTo!.uid,
      'message': text
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('personal-message');
    super.dispose();
  }
}