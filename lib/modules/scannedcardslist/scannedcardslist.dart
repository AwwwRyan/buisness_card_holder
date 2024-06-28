import 'package:brightinfotech_new_project/modules/Scanned%20Card%20Details/scannedcarddetails.dart';
import 'package:brightinfotech_new_project/widgits/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class scannedcardslist extends StatefulWidget {
  const scannedcardslist({super.key});

  @override
  State<scannedcardslist> createState() => _scannedcardslistState();
}

class _scannedcardslistState extends State<scannedcardslist> {
  List<String> _groups = [];
  List<CardInfo> cardList = [
    CardInfo(
      image: 'https://marketplace.canva.com/EAFUXb9i_OM/1/0/1600w/canva-green-and-white-modern-business-card-rU-gq1vTReM.jpg',
      name: 'Sazzat Zilan',
      email: 'hello@example.com',
      number: '+123-456-7890',
      groups: ['DEV', 'DEV'],
    ),
    CardInfo(
      image: 'https://marketplace.canva.com/EAFUXb9i_OM/1/0/1600w/canva-green-and-white-modern-business-card-rU-gq1vTReM.jpg',
      name: 'Ghani Himada',
      email: 'yourcompany@mail.com',
      number: '+000 321 8766',
      groups: ['DEV'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  void _loadGroups() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _groups = prefs.getStringList('savedGroups') ?? [];
    });
  }

  void _saveGroups() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedGroups', _groups);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff3366FF),
        foregroundColor: Colors.black,
        onPressed: () {
          _saveGroups();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => scannedcarddetails()));
        },
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(backgroundColor: Color(0xffF8F8F8),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white, // Set the background color to pink
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Reminders",
                        hintStyle: TextStyle(color: Color(0xffA3A3A3)),
                        prefixIcon:
                        Icon(Icons.menu_rounded, color: Color(0xffA3A3A3)),
                        border: InputBorder.none, // Remove the border
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //filter and groups
          if (_groups.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffffffff),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.filter_list_rounded,size: 16,),
                            Text(
                              "group",
                              style: TextStyle(
                                  color: Color(0xff000000), fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: _groups
                        .map((group) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffffffff),
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    group,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
          //cards
          Container(
            height: 24,color: Colors.white  ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                      child: Text('${cardList.length} pages'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: GestureDetector(
                    onTap: () {
                      print("date tapped");
                      },
                    child: Row(
                      children: [
                        Text('Date'),
                        Icon(Icons.arrow_drop_down,size: 24,),
                      ],
                    ),
                  ),
                ),
              ],

            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cardList.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4,top: 4,left: 10,right: 10 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              //image widget
                              Container(
                                  height: 80,width: 140, child: Image.network(cardList[index].image)),
                              SizedBox(width: 8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cardList[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  Text(cardList[index].email,style: TextStyle(color: Colors.grey),),
                                  Text(cardList[index].number,style: TextStyle(color: Colors.grey),),
                                  Wrap  (
                                    children: cardList[index].groups.map((group) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              color: Color(0xffEAEEFF),
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                group,
                                                style: TextStyle(
                                                    color: Color(0xff415FB5),
                                                    fontSize: 10),
                                              ),
                                            )),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,size: 14,))
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class CardInfo {
  final String image;
  final String name;
  final String email;
  final String number;
  final List<String> groups;

  CardInfo({
    required this.image,
    required this.name,
    required this.email,
    required this.number,
    required this.groups,
  });
}
