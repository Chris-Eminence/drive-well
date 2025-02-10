import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("user_id"); // Retrieve user ID

    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final String apiUrl = "http://127.0.0.1:8000/api/get-bookings/$userId";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data["success"] == true) {
          setState(() {
            bookings = data["bookings"];
            isLoading = false;
          });
        }
      }
    } catch (error) {
      print("Error fetching bookings: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Bookings")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : bookings.isEmpty
          ? Center(child: Text("No bookings found"))
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];

          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Booking ID: ${booking['id']}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Duration: ${booking['duration']} hours"),
                  Text("Status: ${booking['status']}"),
                  Text("Amount: ${booking['payment']['amount']} NGN"),
                  Text("Payment Method: ${booking['payment']['method']}"),
                  Text("Payment Status: ${booking['payment']['status']}"),
                ],
              ),
              trailing: booking['payment']['status'] == "pending"
                  ? ElevatedButton(
                onPressed: () {
                  _openPaymentLink(booking['payment']['authorization_url']);
                },
                child: Text("Pay Now"),
              )
                  : Icon(Icons.check, color: Colors.green),
            ),
          );
        },
      ),
    );
  }

  void _openPaymentLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch $url");
    }
  }
}
