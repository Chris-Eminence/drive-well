import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drive_well/constants.dart'; // Ensure constants are imported

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Placeholder for total price, could be dynamic based on cart data
  final double totalPrice = 5000.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kPrimaryColor, // Set your preferred color
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Billing Information
                Text(
                  'Billing Information',
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField('Full Name'),
                const SizedBox(height: 16),
                _buildTextField('Email Address'),
                const SizedBox(height: 16),
                _buildTextField('Phone Number'),
                const SizedBox(height: 16),
                _buildTextField('Address'),
                const SizedBox(height: 16),

                // Payment Information
                Text(
                  'Payment Information',
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField('Card Number'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildTextField('Expiry Date (MM/YY)')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField('CVV')),
                  ],
                ),
                const SizedBox(height: 16),

                // Order Summary
                Text(
                  'Order Summary',
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildOrderSummaryItem('Driving Lessons (2 hours)', '₦10,000'),
                _buildOrderSummaryItem('Discount', '-₦2,000'),
                const Divider(),
                _buildOrderSummaryItem('Total', '₦8,000', isBold: true),
                const SizedBox(height: 32),

                // Payment Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Handle payment submission here
                      print('Proceed to payment');
                    },
                    child: Text(
                      'Proceed to Payment',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String labelText) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  // Helper method to build order summary items
  Widget _buildOrderSummaryItem(String title, String price, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
