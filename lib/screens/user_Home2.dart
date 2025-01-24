import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/screens/drawer/mainDrawer.dart';
// import 'widgets/mydropdown.dart';
import 'package:kaar_e_kamal/core/theme/app_theme.dart';
import '../core/theme/app_theme.dart';

class UserHome2 extends StatelessWidget {
  const UserHome2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'Kaar e Kamal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Use the light theme from AppTheme
      home: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Kaar e Kamal",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary
                ], // Use theme colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                // Implement navigation to profile page
              },
              icon: const Icon(Icons.person),
              color: Colors.white,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).colorScheme.secondary
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Container(
                          height: 150,
                          width: w * 0.85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 6,
                              )
                            ],
                          ),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/Logo/LogoB.png")),
                                        // color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text("Muhammad Saqib"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "Volunteer",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/donation");
                                    },
                                    child: Container(
                                      height: 27,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xFF31511E),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Donate Now",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [Text("Donate To Server Humanity")],
                              ),
                            )
                          ]),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Emergency Features",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          height: h * 0.150,
                          width: w * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 6,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  // color: Colors.lightGreenAccent,
                                  // decoration: BoxDecoration(
                                  //   image: DecorationImage(image: AssetImage("assets/images/Logo/LogoB.png"),
                                  //       fit: BoxFit.fill),
                                  // ),
                                  child: Icon(
                                    Icons.emergency,
                                    size: 40,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.012,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Special Appeal",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: h * 0.005,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/special");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: h * 0.03,
                                      width: w * 0.2,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF31511E),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text("Call",
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          height: h * 0.150,
                          width: w * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 6,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  child: Icon(
                                    Icons.bloodtype,
                                    size: 40,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.012,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Blood Donation",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: h * 0.005,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: h * 0.03,
                                    width: w * 0.2,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF31511E),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text("Call",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          height: h * 0.150,
                          width: w * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 6,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  // color: Colors.lightGreenAccent,
                                  // decoration: BoxDecoration(
                                  //   image: DecorationImage(image: AssetImage("assets/images/Logo/LogoB.png"),
                                  //       fit: BoxFit.fill),
                                  // ),
                                  child: Icon(
                                    Icons.contact_emergency,
                                    size: 40,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.012,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "One Time Case",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: h * 0.005,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: h * 0.03,
                                    width: w * 0.2,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF31511E),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text("Call",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.005,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // MyDropdown(),
                  ],
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Container(
                          height: h * 0.13,
                          width: w * 0.27,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Logo/LogoG.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Text(
                                "Monthly Stats",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          height: h * 0.13,
                          width: w * 0.27,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Logo/LogoB.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Text(
                                "Rashaan Stats",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          height: h * 0.13,
                          width: w * 0.27,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Logo/LogoG.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Text(
                                "Top Volenteers",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.001,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Container(
                          height: h * 0.13,
                          width: w * 0.27,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Logo/LogoB.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Text(
                                "Top Donors",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          height: h * 0.13,
                          width: w * 0.27,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Logo/LogoG.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Text(
                                "BDS Stats",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          height: h * 0.13,
                          width: w * 0.27,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Logo/LogoB.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Text(
                                "Reffer To Friend",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: h * 0.017,
                      width: w * 0.05,
                      decoration: BoxDecoration(
                          color: Color(0xFF31511E), shape: BoxShape.circle),
                    )
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Post Share By Admin",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: h * 0.2,
                    width: w,
                    child: Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                              height: h * 0.5,
                              width: w * 0.7,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/others/img2.jpg",
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(
                            width: w * 0.03,
                          ),
                          Container(
                              height: h * 0.5,
                              width: w * 0.7,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/others/img1.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(
                            width: w * 0.03,
                          ),
                          Container(
                              height: h * 0.5,
                              width: w * 0.7,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/others/img0.jpg",
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: h * 0.1,
            width: w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: h * 0.1,
                  width: w * 0.17,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.home),
                        color: Color(0xFF31511E),
                        iconSize: 18.0, // Set a smaller icon size here
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 5.0), // Set a smaller font size here
                      )
                    ],
                  ),
                ),
                Container(
                  height: h * 0.1,
                  width: w * 0.17,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.emergency),
                        color: Color(0xFF31511E),
                        iconSize: 18.0, // Set a smaller icon size here
                      ),
                      Text(
                        "Emergency",
                        style: TextStyle(
                            fontSize: 5.0), // Set a smaller font size here
                      )
                    ],
                  ),
                ),
                Container(
                  height: h * 0.1,
                  width: w * 0.17,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.volunteer_activism),
                        color: Color(0xFF31511E),
                        iconSize: 18.0, // Set a smaller icon size here
                      ),
                      Text(
                        "Donation",
                        style: TextStyle(
                            fontSize: 5.0), // Set a smaller font size here
                      )
                    ],
                  ),
                ),
                Container(
                  height: h * 0.1,
                  width: w * 0.17,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bloodtype),
                        color: Color(0xFF31511E),
                        iconSize: 18.0, // Set a smaller icon size here
                      ),
                      Text(
                        "Blood Call",
                        style: TextStyle(
                            fontSize: 5.0), // Set a smaller font size here
                      )
                    ],
                  ),
                ),
                Container(
                  height: h * 0.1,
                  width: w * 0.17,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.account_circle),
                        color: Color(0xFF31511E),
                        iconSize: 18.0, // Set a smaller icon size here
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 5.0), // Set a smaller font size here
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
