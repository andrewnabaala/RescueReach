import 'package:rescuereach/api_calls/dummy_server.dart';
import 'package:rescuereach/components/my_button.dart';
import 'package:rescuereach/services/auth/bloc/auth_bloc.dart';
import 'package:rescuereach/services/auth/bloc/auth_event.dart';
import 'package:rescuereach/utilities/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rescuereach/views/chat_list_view.dart';

import '../utils/config.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

enum MenuAction { logout }

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 176, 255, 1),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromRGBO(224, 176, 255, 1),
      //   toolbarHeight: 120, // Adjust the height value as per your requirement
      //   leading: Padding(
      //     padding: EdgeInsets.all(8.0),
      //     child: Container(
      //       height: 0,
      //       width: 0,
      //       child: Image.asset(
      //         Config.resreach_icon,
      //         fit: BoxFit.contain,
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  Config.resreach_icon,
                  width: 150,
                  height: 150,
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: const Color.fromARGB(255, 191, 166, 233),
                      child: const Stack(
                        children: [
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              backgroundColor: Color(0xffE6E6E6),
                              radius: 50,
                              child: Icon(
                                Icons.person,
                                color: Color(0xffCCCCCC),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatListView(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: const Color.fromARGB(255, 191, 166, 233),
                        child: const Stack(
                          children: [
                            Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Text(
                                "Connect",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.chat,
                                // Replace with the desired icon for "Connect"
                                color: Colors.white, // Set the desired color for the icon
                                size: 80,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: const Color.fromARGB(255, 191, 166, 233),
                      child: const Stack(
                        children: [
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Text(
                              "Resources",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.info, // Use the "info" icon for "Resources"
                              color: Colors.white, // Set the desired color for the icon
                              size: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: const Color.fromARGB(255, 191, 166, 233),
                      child: const Stack(
                        children: [
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Text(
                              "Reports",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.bookmarks_sharp, // Use the "info" icon for "Resources"
                              color: Colors.white, // Set the desired color for the icon
                              size: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 191, 166, 233),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_alert), label: 'Alert'),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout_outlined), label: 'Log out'),
          ],
          onTap: (index) {
            if (index == 1) {
              fetchUsers;
            }
            if (index == 2) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Log out'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: const Text('Log out'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              ).then((shouldLogout) {
                if (shouldLogout != null && shouldLogout) {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                }
              });
            }
          }),
    );
  }
}
