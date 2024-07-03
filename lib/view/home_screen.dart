import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/constants/widgets/drawer_widget.dart';
import 'package:wolf_pack_test/constants/widgets/connections_tile.dart';
import 'package:wolf_pack_test/controller/home_prov.dart';
import 'package:wolf_pack_test/services/database_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProv>(context, listen: false).getUsername(context);
    });
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        elevation: 0,
        centerTitle: true,
        backgroundColor: kprimary,
        title: const Text(
          "Connections",
          style: TextStyle(
              color: kWhite, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      drawer: drawerWidget(),
      body: Center(
        child: Consumer<HomeProv>(builder: (context, value, child) {
          return StreamBuilder(
            stream: DatabaseService().getUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return snapshot.hasData
                  ? ListView(
                      children: snapshot.data!
                          .map<Widget>((userData) => connectionsTile(
                              context: context, userData: userData))
                          .toList())
                  : const Text('No Connections');
            },
          );
        }),
      ),
    );
  }
}
