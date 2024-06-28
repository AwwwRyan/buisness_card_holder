import 'package:brightinfotech_new_project/widgits/searchbar.dart';
import 'package:flutter/material.dart';

class reminderpage extends StatefulWidget {
  const reminderpage({super.key});

  @override
  State<reminderpage> createState() => _reminderpageState();
}

class _reminderpageState extends State<reminderpage> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  List<Reminders> remindersList = [
    Reminders(
      name: 'Doctor Appointment',
      date: 'jun 12-17',
      comments: 32,
      status: 'missed',
    ),
    Reminders(
      name: 'Project Deadline',
      date: 'jun 12-17',
      comments: 323,
      status: 'this week',
    ),
    Reminders(
      name: 'Meeting with Client',
      date: 'jun 12-17',
      comments: 12,
      status: 'upcoming',
    ),
    Reminders(
      name: 'Birthday Party',
      date: 'jun 12-17',
      comments: 64,
      status: 'this week',
    ),
    Reminders(
      name: 'Vacation',
      date: 'jun 12-17',
      comments: 45,
      status: 'upcoming',
    ),
    Reminders(
      name: 'Grocery Shopping',
      date: 'jun 12-17',
      comments: 7,
      status: 'missed',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.blue,),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text('Reminders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        actions: [
          IconButton(
            icon: Icon(Icons.library_add_check_outlined),
            color: Colors.blue,
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            color: Colors.blue,
            onPressed: () {
            },
          ),
        ],
      ),

      body: Column(
        children: [
          searchbar(),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            tabs: [
              const Tab(text: 'Missed'),
              const Tab(text: 'This Week'),
              const Tab(text: 'Upcoming'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildRemindersList(remindersList.where((r) => r.status == "missed")),
                buildRemindersList(remindersList.where((r) => r.status == "this week")),
                buildRemindersList(remindersList.where((r) => r.status == "upcoming")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRemindersList(Iterable<Reminders> filteredReminders) {
    return ListView.builder(
      itemCount: filteredReminders.length,
      itemBuilder: (context, index) {
        final reminder = filteredReminders.elementAt(index);
        return GestureDetector(
          onTap: () => print(reminder.name + " tapped"),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0, top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.86,
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0.0)), // Remove border radius here
                            color: Color(0xFFB8C5CD),
                            image: reminder.profileImage != null
                                ? DecorationImage(
                              image: NetworkImage(reminder.profileImage!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: reminder.profileImage == null
                              ? Center(
                            child: Text(
                              reminder.name.split(' ').map((e) => e[0]).join(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF1A3F5A),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                              : null,
                        ),
                      ),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(reminder.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          Row(
                            children: [
                              Icon(Icons.calendar_month,color: Colors.blue,size: 16,),
                              SizedBox(width: 8,),
                              Text(reminder.date,style: TextStyle(color: Colors.blue),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.mode_comment_outlined,color: Colors.grey,size: 16,),
                              SizedBox(width: 8,),
                              Text(reminder.comments.toString()),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_horiz_rounded)
              ],
            ),
          ),
        );
      },
    );
  }

}
class Reminders {
  final String name;
  final String date;
  final int comments;
  final String status;
  final String? profileImage;


  Reminders({
    required this.name,
    required this.date,
    required this.comments,
    required this.status,
    this.profileImage,

  });
}
