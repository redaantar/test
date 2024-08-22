import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/UI/custom_drop_down.dart';
import '../widgets/level_selector_widget.dart';
import '../widgets/show_add_room_dialog.dart';

class ManualAlertScreen extends StatefulWidget {
  const ManualAlertScreen({super.key});

  @override
  ManualAlertScreenState createState() => ManualAlertScreenState();
}

class ManualAlertScreenState extends State<ManualAlertScreen> {
  List<String> sites = ['Site 001', 'Site 002', 'Site 003'];
  List<String> zones = ['Zone 001', 'Zone 002', 'Zone 003'];
  List<String> rooms = ['Room 1.02', 'Room 2.01', 'Room 3.03'];
  List<String> timeExpected = ['30 Minutes', '60 Minutes', '90 Minutes', '120 Minutes'];

  String selectedSite = '';
  String selectedZone = '';
  String selectedRoom = '';
  String selectedTime = '';

  int selectedLevel = 1;
  bool isRoomSelected = true;
  bool isOutside = true;

  bool isSiteFav = false;
  bool isZoneFav = false;
  
  @override
  void initState() {
    super.initState();
    selectedSite = sites[0];
    selectedZone = zones[0];
    selectedRoom = rooms[0];
    selectedTime = timeExpected[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title: const Text('Manual alert'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.back_square),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropDown(
                  label: 'Site',
                  value: selectedSite,
                  isBookmarked: isSiteFav,
                  items: sites,
                  onChanged:(value) => setState(() => selectedSite = value!),
                  onBookmarkToggle:() {
                    setState(() {
                      isSiteFav = !isSiteFav;
                    });
                  },
                  onHelpIconTap: () {
                    // Implement help icon functionality
                  },
                ),
                const SizedBox(height: 16),
                CustomDropDown(
                  label: 'Zone',
                  value: selectedZone,
                  isBookmarked : isZoneFav,
                  items: zones,
                  onChanged: (value) => setState(() => selectedZone = value!),
                  onBookmarkToggle: () {
                    setState(() {
                      isZoneFav = !isZoneFav;
                    });
                  },
                  onHelpIconTap: () {
                    // Implement help icon functionality
                  },
                ),
                const SizedBox(height: 16),
                LevelSelector(
                  initialValue: selectedLevel,
                  minValue: -2,
                  maxValue: 10,
                  onValueChanged: (p0) {
                    setState(() {
                      selectedLevel = p0;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildLocationToggle(),
                const SizedBox(height: 16),
                _buildRoomSection(),
                const SizedBox(height: 16),
                _buildPositionToggle(),
                const SizedBox(height: 16),
                CustomDropDown(
                  label: "Time expected to complete the job",
                  value: selectedTime,
                  isBookmarked: false,
                  items: timeExpected,
                  onChanged: (value) => setState(() => selectedTime = value!)
                ),
                const SizedBox(height: 24),
                _buildSendAlertButton(),
                const SizedBox(height: 16), // Add some padding at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationToggle() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                )
              ),
              backgroundColor: isRoomSelected ? const Color.fromARGB(200, 66, 43, 143) : Colors.white,
            ),
            child: Text(
              'Room',
              style: TextStyle(
                color: isRoomSelected ? Colors.white : Colors.black
                ),
              ),
            onPressed: () => setState(() => isRoomSelected = true),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )
              ),
              backgroundColor: !isRoomSelected ? const Color.fromARGB(200, 66, 43, 143) : Colors.white,
            ),
            child: Text('Equipment', style: TextStyle(color: !isRoomSelected ? Colors.white : Colors.black)),
            onPressed: () => setState(() => isRoomSelected = false),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Room',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
              ),
            InkWell(
              borderRadius: BorderRadius.circular(5),
              child: const Text('+ add', style: TextStyle(color: Colors.blue)),
              onTap: () {
                showAddRoomDialog(context, (roomName, roomNumber) {
                  setState(() {
                    rooms.add('$roomName $roomNumber');
                    selectedRoom = '$roomName $roomNumber';
                  });
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 4),
        CustomDropDown(
          value: selectedRoom,
          isBookmarked: false,
          items: rooms,
          onChanged: (value) => setState(() => selectedRoom = value!)
        ),
      ],
    );
  }

  Widget _buildPositionToggle() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                )
              ),
              backgroundColor: !isOutside ? const Color.fromARGB(200, 66, 43, 143) : Colors.white,
            ),
            child: Text('Inside', style: TextStyle(color: !isOutside ? Colors.white : Colors.black)),
            onPressed: () => setState(() => isOutside = false),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isOutside ? const Color.fromARGB(200, 66, 43, 143) : Colors.white,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )
              ),
            ),
            child: Text('Outside', style: TextStyle(color: isOutside ? Colors.white : Colors.black)),
            onPressed: () => setState(() => isOutside = true),
          ),
        ),
      ],
    );
  }

  Widget _buildSendAlertButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Iconsax.send_2, color: Colors.white),
        label: const Text('Send alert', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.blueAccent
        ),
        onPressed: () {
          // Implement send alert functionality
        },
      ),
    );
  }
}