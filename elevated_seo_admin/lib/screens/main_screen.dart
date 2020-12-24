import 'package:elevated_seo_admin/components/create_new_user.dart';
import 'package:elevated_seo_admin/screens/existing_users.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add new user"),
        icon: FaIcon(FontAwesomeIcons.userPlus),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CreateNewUser(),
          );
        },
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Drawer(
              child: Material(
                elevation: 5,
                color: Colors.white,
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Center(
                        child: Text(
                          "ElevatedSEO",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    // Material(
                    //   color: currentIndex == 0 ? Colors.blue : Colors.white,
                    //   animationDuration: Duration(milliseconds: 300),
                    //   borderRadius: BorderRadius.horizontal(
                    //     right: Radius.circular(25),
                    //   ),
                    //   child: ListTile(
                    //     leading: Icon(Icons.person),
                    //     title: Text(
                    //       "Users",
                    //       style: TextStyle(
                    //         color: Colors.blueGrey,
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         currentIndex = 0;
                    //       });
                    //     },
                    //   ),
                    // ),
                    // Material(
                    //   color: currentIndex == 1 ? Colors.blue : Colors.white,
                    //   animationDuration: Duration(milliseconds: 300),
                    //   borderRadius: BorderRadius.horizontal(
                    //     right: Radius.circular(25),
                    //   ),
                    //   child: ListTile(
                    //     leading: Icon(Icons.supervised_user_circle),
                    //     title: Text(
                    //       "Manage Users",
                    //       style: TextStyle(
                    //         color: Colors.blueGrey,
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         currentIndex = 1;
                    //       });
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.blue.withOpacity(0.8)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Color.fromRGBO(242, 244, 250, 1),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      child: UsersScreen(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
