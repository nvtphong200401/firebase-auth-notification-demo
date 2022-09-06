
import 'package:demo_firebase/data/api.dart';
import 'package:demo_firebase/data/data_source/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/controllers/message_controller.dart';

class MessageScreen extends ConsumerWidget {
  MessageScreen({Key? key, required this.chatGroup}) : super(key: key);

  final chatGroup;
  final TextEditingController titleController =
  TextEditingController(text: 'Title');
  final TextEditingController bodyController =
  TextEditingController(text: 'Body123');
  


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(messageController);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height - MediaQuery.of(context).viewInsets.bottom - 250,
              child: ListView.builder(
                itemCount: controller.messageList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(controller.messageList[index].title),
                    subtitle: Text(controller.messageList[index].body),
                  );
                },
              ),
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            ElevatedButton(
              onPressed: () => controller.sendNotification(titleController.text, bodyController.text),
              child: Text('Send notification to all'),
            ),
          ],
        ),
      )
    );
  }


}
