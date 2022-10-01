import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(SvgImages.backgroung),
              fit: BoxFit.values[0],
              repeat: ImageRepeat.noRepeat,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 40),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.account_circle,
                        size: 70,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Pratik Gaur',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text('UPSC Aspirant')
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed('editprofilescreen'),
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.account_circle_outlined),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Edit Phone, Email, Profile Name')
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorResources.textWhite,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.bookmark),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Test Series',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('See your enrolled tests')
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorResources.textWhite,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.auto_stories),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Courses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('See your enrolled courses')
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorResources.textWhite,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.logout),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
