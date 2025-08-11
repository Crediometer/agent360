import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentProfilePage extends StatelessWidget {
  const AgentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 8),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green, // Change based on status
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.edit, size: 16, color: Colors.blue),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Center(
            child: Column(
              children: const [
                Text(
                  "Roberta-Anna Smith",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Agent", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                children: const [
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.red),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "robertaa76@crediometer.com",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.red),
                      SizedBox(width: 12),
                      Text("(619) 555-7890", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        const CumulativeIncomeTile(),


          ExpansionTile(
            title: const Text(
              "KPI",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row: Total Transactions & Customer Satisfaction
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Total transactions processed:"),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "256",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                Text(
                                  "1.3%",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text("Customer satisfaction:"),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.speed, color: Colors.blue),
                                SizedBox(width: 6),
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Customer Acquisition Rate
                    const Text(
                      "Customer acquisition rate: 22",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 150,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'Sun',
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                  ];
                                  return Text(
                                    days[value.toInt() % 7],
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                                interval: 1,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: 6,
                          minY: 0,
                          maxY: 50,
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 5),
                                FlSpot(1, 8),
                                FlSpot(2, 15),
                                FlSpot(3, 25),
                                FlSpot(4, 20),
                                FlSpot(5, 18),
                                FlSpot(6, 22),
                              ],
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Average Transaction Rate
                    const Text(
                      "Average transaction rate: 372K",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 140,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 50,
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'Sun',
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                  ];
                                  return Text(
                                    days[value.toInt() % 7],
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          barGroups: [
                            _barGroup(0, 12),
                            _barGroup(1, 15),
                            _barGroup(2, 25),
                            _barGroup(3, 35),
                            _barGroup(4, 28),
                            _barGroup(5, 26),
                            _barGroup(6, 40),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _timeRangeChip("1W", true),
                        _timeRangeChip("1M", false),
                        _timeRangeChip("6M", false),
                        _timeRangeChip("1Y", false),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),

          ExpansionTile(
            title: Row(
              children: const [
                Text(
                  "Notifications",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Chip(
                  label: Text("new", style: TextStyle(fontSize: 12)),
                  backgroundColor: Colors.red,
                  labelStyle: TextStyle(color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    _notificationCard(
                      title: "High Advance Alert",
                      description:
                          "An unusually high advance has been requested, exceeding the system threshold.",
                      time: "10:44",
                    ),
                    const SizedBox(height: 12),
                    _notificationCard(
                      title: "Customer Feedback Received",
                      description:
                          "A customer has left feedback regarding your service.",
                      time: "10:44",
                    ),
                  ],
                ),
              ),
            ],
          ),

          ExpansionTile(
            title: const Text(
              "Upload file",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select and upload the files of your choice",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red.shade200),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red.shade50,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_circle, color: Colors.red, size: 28),
                          SizedBox(width: 8),
                          Text("Upload file", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _uploadedFileTile(
                      fileName: "Lorem ipsum dolor1.pdf",
                      subtitle: "644 MB of 687 MB (456 KB/sec)",
                      isCompleted: false,
                    ),
                    const SizedBox(height: 12),
                    _uploadedFileTile(
                      fileName: "Lorem ipsum dolor1.pdf",
                      subtitle: "Completed",
                      isCompleted: true,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),
          Center(
            child: TextButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                "Log out",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _timeRangeChip(String label, bool isSelected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.grey[300],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(color: isSelected ? Colors.white : Colors.black),
    ),
  );
}

BarChartGroupData _barGroup(int x, double y) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: Colors.blue,
        width: 14,
        borderRadius: BorderRadius.circular(4),
      ),
    ],
  );
}

Widget _notificationCard({
  required String title,
  required String description,
  required String time,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Icon(Icons.circle, color: Colors.red, size: 8),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    ),
  );
}

Widget _uploadedFileTile({
  required String fileName,
  required String subtitle,
  required bool isCompleted,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
      ],
    ),
    child: Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_checked,
          color: Colors.red,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          isCompleted ? Icons.close : Icons.cancel,
          size: 20,
          color: Colors.black54,
        ),
      ],
    ),
  );
}



void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.logout, size: 40, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              "You’re leaving.. Are you sure?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 160,
              height: 40,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close dialog
                  
                  // ✅ Logout logic
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('token');

                  // Redirect to login
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 1,
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  "Yes, log me out",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.63,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 131,
              height: 40,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFB11226),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}



class CumulativeIncomeTile extends StatefulWidget {
  const CumulativeIncomeTile({super.key});

  @override
  State<CumulativeIncomeTile> createState() => _CumulativeIncomeTileState();
}

class _CumulativeIncomeTileState extends State<CumulativeIncomeTile> {
  String selectedRange = "1W";

  List<FlSpot> get chartData {
    switch (selectedRange) {
      case "1M":
        return const [
          FlSpot(0, 8),
          FlSpot(1, 12),
          FlSpot(2, 9),
          FlSpot(3, 14),
          FlSpot(4, 17),
          FlSpot(5, 18),
          FlSpot(6, 20),
        ];
      case "6M":
        return const [
          FlSpot(0, 5),
          FlSpot(1, 10),
          FlSpot(2, 15),
          FlSpot(3, 12),
          FlSpot(4, 20),
          FlSpot(5, 23),
          FlSpot(6, 25),
        ];
      case "1Y":
        return const [
          FlSpot(0, 2),
          FlSpot(1, 4),
          FlSpot(2, 6),
          FlSpot(3, 10),
          FlSpot(4, 15),
          FlSpot(5, 18),
          FlSpot(6, 22),
        ];
      default:
        return const [
          FlSpot(0, 5),
          FlSpot(1, 7),
          FlSpot(2, 10),
          FlSpot(3, 15),
          FlSpot(4, 12),
          FlSpot(5, 11),
          FlSpot(6, 13),
        ];
    }
  }

  Widget _timeRangeChip(String label) {
    final selected = label == selectedRange;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() => selectedRange = label);
      },
      selectedColor: Colors.blue,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Cumulative Income",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "₦22,373",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 5,
                          reservedSize: 32,
                          getTitlesWidget: (value, _) => Text('₦${value.toInt()}'),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                            return Text(
                              days[value.toInt() % 7],
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                          interval: 1,
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 25,
                    lineBarsData: [
                      LineChartBarData(
                        spots: chartData,
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.blue,
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _timeRangeChip("1W"),
                  _timeRangeChip("1M"),
                  _timeRangeChip("6M"),
                  _timeRangeChip("1Y"),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
