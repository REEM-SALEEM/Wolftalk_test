import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/constants/size/size.dart';
import 'package:wolf_pack_test/constants/widgets/message_tile.dart';
import 'package:wolf_pack_test/controller/chat_prov.dart';
import 'package:wolf_pack_test/services/database_services.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          arguments['receiverEmail'],
          style: const TextStyle(
            color: kWhite,
          ),
        ),
        backgroundColor: kprimary,
        iconTheme: const IconThemeData(color: kWhite),
      ),
      body: Consumer<ChatProv>(builder: (context, value, child) {
        return Column(
          children: <Widget>[
            // display messages widget
            Expanded(child: chatMessages(arguments['receiverID'])),
            // send messages
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[700],
                child: Row(children: [
                  Expanded(
                      child: TextFormField(
                    controller: Provider.of<ChatProv>(context, listen: false)
                        .messageController,
                    style: const TextStyle(color: kWhite),
                    decoration: const InputDecoration(
                      hintText: "Send a message...",
                      hintStyle: TextStyle(color: kWhite, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  )),
                  kWidth12,
                  GestureDetector(
                    onTap: () {
                      value.sendMessage(arguments['receiverID']);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: kprimary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                    ),
                  )
                ]),
              ),
            )
          ],
        );
      }),
    );
  }

  chatMessages(String? receiverID) {
    String senderID = DatabaseService().getCurrentUser()!.uid;
    return StreamBuilder(
      stream: DatabaseService().getMessage(receiverID!, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (!snapshot.hasData) {
          return const Text('No messages yet.');
        }

        final querySnapshot = snapshot.data as QuerySnapshot;
        final messages = querySnapshot.docs.map<Widget>((doc) {
          return messageTile(context: context, doc: doc);
        }).toList();

        return ListView(children: messages);
      },
    );
  }
}
