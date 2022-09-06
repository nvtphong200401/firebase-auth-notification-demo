import 'package:demo_firebase/presentation/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessageScreen(chatGroup: 'group_1',)));
          }, child: Text('Group chat 1')),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessageScreen(chatGroup: 'group_2',)));
          }, child: Text('Group chat 2')),
        ],
      ),
    );
  }
}