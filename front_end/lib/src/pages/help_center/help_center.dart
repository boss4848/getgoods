import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/help_center/widgets/IssueType.dart';

class HelpCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Handles the back button press
          },
        ),
        title: const Text('GetGoods Help Center'),
      ),
      body: HelpCenterPage(),
    );
  }
}

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenterPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _FQA(),
          const SizedBox(
            height: 10,
          ),
          _ContactUs(),
        ],
      ),
    );
  }

  Container _FQA() {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "FAQ",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              IssueTypeWidget(),
            ],
          ),
        ));
  }

  Container _ContactUs() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Contact Us",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w800,
                  fontSize: 20)),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: const [
              Icon(
                Icons.call,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "0643285827",
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: const [
              Icon(Icons.email, size: 20),
              SizedBox(
                width: 10,
              ),
              Text(
                "getgoods@goose.com",
                style: TextStyle(fontSize: 16),
              )
            ],
          )
        ]),
      ),
    );
  }
}
