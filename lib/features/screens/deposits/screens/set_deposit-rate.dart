import 'package:flutter/material.dart';

class SetDepositRateScreen extends StatefulWidget {
  @override
  _SetDepositRateScreenState createState() => _SetDepositRateScreenState();
}

class _SetDepositRateScreenState extends State<SetDepositRateScreen> {
  double depositAmount = 0;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.text = depositAmount.toStringAsFixed(3);
  }

  void setAmount(double value) {
    setState(() {
      depositAmount += value;
      amountController.text = depositAmount.toStringAsFixed(3);
    });
  }

  void clearAmount() {
    setState(() {
      depositAmount = 0;
      amountController.text = '0.000';
    });
  }

  void submitRate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DepositSuccessScreen()),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    nameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.white,
        ), // Set back icon color to white
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Deposit Rate',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Enter Deposit Rate for May 2025',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 250, // Adjust width as needed
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixText: '₦ ',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    final parsed = double.tryParse(value);
                    if (parsed != null) {
                      setState(() => depositAmount = parsed);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Select customer name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                hintText: 'Add notes',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: [500, 1000, 1500, 5000].map((val) {
                return ElevatedButton(
                  onPressed: () => setAmount(val.toDouble()),
                  child: Text('₦$val'),
                );
              }).toList(),
            ),
            Spacer(),
            Text('Last submitted ₦5,000 on April 2, 2025'),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: depositAmount > 0 ? submitRate : null,
                    child: Text('Set Rate'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: clearAmount,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DepositSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.green.shade100,
                child: Icon(Icons.check_circle, color: Colors.green, size: 80),
              ),
              SizedBox(height: 20),
              Text(
                'Great!\nYou have successfully\nSet Deposit Rate',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('Back to dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
