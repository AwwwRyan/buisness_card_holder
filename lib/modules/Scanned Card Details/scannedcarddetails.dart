import 'dart:io';

import 'package:brightinfotech_new_project/modules/scannedcardslist/scannedcardslist.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class scannedcarddetails extends StatefulWidget {
  const scannedcarddetails({super.key});

  @override
  State<scannedcarddetails> createState() => _scannedcarddetailsState();
}

class _scannedcarddetailsState extends State<scannedcarddetails> {
  String name_card = "firstname lastname";
  int scanid = 029302;
  final TextEditingController _groupController = TextEditingController();
  late List<String> _groups = [];
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateontroller = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  File ? _selectedimage;

  void initState() {
    super.initState();
    _imagePicker();
    _loadGroups();
  }

  Future<void> _imagePicker() async {
    final imagereturned = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagereturned == null) return;
    cropImage(File(imagereturned.path));
  }

  Future<void> cropImage(File imagePath) async {
    final imageCropped = await ImageCropper().cropImage(
      sourcePath: imagePath.path,
      aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
    );
    setState(() {
      _selectedimage = imageCropped == null ? null : File(imageCropped.path);
    });
  }

  void _showAddGroupDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Groups',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_groups.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _groups
                        .map((group) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffEAEEFF),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      group,
                                      style: TextStyle(
                                          color: Color(0xff415FB5),
                                          fontSize: 14),
                                    ),
                                  )),
                            ))
                        .toList(),
                  ),
                ),
              TextField(
                controller: _groupController,
                decoration: InputDecoration(
                  hintText: 'Add Group',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ],
          ),
          //save and cancel
          actions: [
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff9AB1FF),
                  side: BorderSide(color: Color(0xff3366FF), width: 0.5),
                ),
                onPressed: () {
                  setState(() {
                    _groups.add(_groupController.text);
                    _groupController.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 8,
            ),
            Container(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xff9AB1FF),
                        backgroundColor: Colors.white,
                        elevation: 0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'))),
          ],
        );
      },
    );
  }
  void _saveGroups() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedGroups', _groups);
  }
  void _loadGroups() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _groups = prefs.getStringList('savedGroups') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF8F8F8),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Color(0xff3366FF),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => scannedcardslist()));
            },
          ),
          title: Center(
            child: Text(
              name_card,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            GestureDetector(child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Text("Done",style: TextStyle(fontSize: 14,color: Colors.blue),),
            ),onTap: (){
              _saveGroups();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => scannedcardslist()));
            },)
          ],
        ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff3366FF),
        foregroundColor: Colors.black,
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //add the image and click image button in the container
              Padding(
                padding: const EdgeInsets.only(right: 18.0,left: 18.0,bottom: 8.0,),
                child: Container(height: MediaQuery.of(context).size.height * 0.31,

                    child: _selectedimage != null?Image.file(_selectedimage!):Text("select an image")
                ),
              ),
              //information buttons
              Padding(
                padding:
                    const EdgeInsets.only(left: 40.0, right: 40, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomIconButton(
                      icon: Icon(
                        Icons.call,
                        color: Colors.blue,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      icon: Icon(
                        Icons.messenger,
                        color: Colors.blue,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      icon: Icon(
                        Icons.email,
                        color: Colors.blue,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      icon: Icon(
                        Icons.link_rounded,
                        color: Colors.blue,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              //group and note
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Groups',
                          style: TextStyle(
                              fontSize: 14.0, color: Color(0xff737373)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                        if (_groups.isEmpty)
                          Container(
                            height: 35,
                            child: ElevatedButton(
                              onPressed: _showAddGroupDialog,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Color(0xff3366FF),
                                backgroundColor:
                                    Colors.white, // Text color black
                                side: BorderSide(
                                    color: Color(0xff3366FF), width: 0.5),
                              ),
                              child: Text(
                                '+ Add',
                                style: TextStyle(
                                  color: Color(0xff3366FF), // Text color black
                                ),
                              ),
                            ),
                          ),
                        if (_groups.isNotEmpty)
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _groups
                                    .map((group) => GestureDetector(
                                        onTap: _showAddGroupDialog,
                                        child: Padding(
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
                                                      fontSize: 14),
                                                ),
                                              )),
                                        )))
                                    .toList(),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    informationsection(
                      controller: _noteController,
                      hintText: 'Where you met, their interests',
                      labelText: 'Note',
                    ),
                  ],
                ),
              ),
              Container(
                height: 16,
              ),
              //information
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    informationsection(
                      controller: _nameController,
                      hintText: 'Enter Name',
                      labelText: 'Full Name',
                    ),
                    informationsection(
                      controller: _companyController,
                      hintText: 'Enter Company Name',
                      labelText: 'Company',
                    ),
                    informationsection(
                      controller: _jobController,
                      hintText: 'Enter Job Title',
                      labelText: 'Job',
                    ),
                    informationsection(
                      controller: _addressController,
                      hintText: 'Enter Address',
                      labelText: 'Address',
                    ),
                    //phone
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  "Phone",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xff737373),
                                  ),
                                ),
                                GestureDetector(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: TextField(
                                    controller: _phoneController,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: "enter phone number",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //email website
                    emailwebsite(
                      controller: _emailController,
                      hintText: 'Enter Email',
                      labelText: 'Email',
                    ),
                    emailwebsite(
                      controller: _websiteController,
                      hintText: 'Enter Website',
                      labelText: 'Website',
                    ),
                  ],
                ),
              ),
              Container(
                height: 16,
              ),
              //date
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.only(left: 20.0,right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: informationsection(
                  controller: _dateontroller,
                  hintText: 'Enter Date',
                  labelText: 'Date',
                ),
              ),
              //ad?
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Image.network(
                                "https://t4.ftcdn.net/jpg/02/51/02/71/360_F_251027105_S0c356N68e2y9RMJ4BKJmxhl5IpyBH9U.jpg", fit: BoxFit.cover,),
                          ),
                        ),
                        SizedBox(width: 8), // Add some spacing between the image and the text
                        Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce non fermentum nunc. Aenean pulvinar fringilla pulvinar. Nunc feugiat rutrum libero, nec mattis lacus mattis sit amet. Nam eu tellus eget tortor tincidunt consequat eu quis felis. Aliquam pellentesque vel tellus at cursus. Integer et arcu tincidunt velit viverra condimentum ac viverra nisi. Nunc tempus justo eget enim blandit bibendum. Aliquam interdum pellentesque faucibus. Sed cursus sapien eu odio finibus, nec posuere felis ultricies.",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3, // Adjust the number of lines as needed
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue, backgroundColor: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textStyle: TextStyle(fontSize: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.grey,width: 0.5)
                        ),
                        elevation: 0,
                      ),
                      child: Text("Learn More",),
                    ),
                  ],
                )
              ),
              //footer
              Container(
                height: 32,
              ),
              Container(
                color: Colors.white,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Scan ID:"+scanid.toString(),style: TextStyle(color: Colors.grey),)
                  ],
                )
              )

            ],
          ),
        ),
        );
  }
}

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  CustomIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF1F1F1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}

class informationsection extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  const informationsection({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              labelText,
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xff737373),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: TextField(
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//add ontap as attribute
class emailwebsite extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  const emailwebsite({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              labelText,
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xff737373),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
