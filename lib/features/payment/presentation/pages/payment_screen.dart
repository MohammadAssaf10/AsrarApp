import 'package:flutter/material.dart';

import '../../data/repositorys/tap_payment_repository.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  final String currency;

  const PaymentScreen({required this.amount, required this.currency});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TapPaymentService _tapPaymentService = TapPaymentService();

  String _cardNumber = '';
  String _expiryMonth = '';
  String _expiryYear = '';
  String _cvv = '';
  String _name = '';
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Payment"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter card number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cardNumber = value!;
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Expiry Month',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter expiry month';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _expiryMonth = value!;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Expiry Year',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter expiry year';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _expiryYear = value!;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter CVV';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _cvv = value!;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name on Card',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name on card';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: ElevatedButton(
                          onPressed: _makePayment,
                          child: const Text(
                            'Make Payment',
                            style: TextStyle(fontSize: 20),
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

  void _makePayment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // setState(() {
      //   _isLoading = true;
      // });

      // Call the TapPaymentService to create a charge
      final charge = await _tapPaymentService.makePayment(
        address: '',
        amount: 1,
        city: '',
        countryCode: '',
        currency: 'USD',
        description: 'test from flutter',
        email: 'mehsen2222@gmail.com',
        phone: '',
        zip: '',
        // amount: widget.amount,
        // currency: widget.currency,
        number: _cardNumber,
        expMonth: int.parse(_expiryMonth),
        expYear: int.parse(_expiryYear),
        cvc: _cvv,
        name: _name,
      );

      // setState(() {
      //   _isLoading = false;
      // });

      // Show a dialog to indicate success or failure of the charge
      // if (charge.status == 'succeeded') {
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: const Text('Payment Successful'),
      //         content: Text('Your payment of ${charge.amount} ${charge.currency} was successful.'),
      //         actions: <Widget>[
      //           TextButton(
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //               Navigator.of(context).pop();
      //             },
      //             child: const Text('OK'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // } else {
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: const Text('Payment Failed'),
      //         content:
      //             const Text('There was an error processing your payment. Please try again later.'),
      //         actions: <Widget>[
      //           TextButton(
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //             child: const Text('OK'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // }
    }
  }
}
