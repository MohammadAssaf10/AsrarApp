import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';

import '../../../../api_constant.dart';
import '../widgets/tap_loader.dart';

class PaymentScreen extends StatefulWidget {
  final Customer customer;
  final List<PaymentItem> paymentItems;
  final Function(String) sdkResults;

  const PaymentScreen({
    Key? key,
    required this.customer,
    required this.paymentItems,
    required this.sdkResults,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Map<dynamic, dynamic> tapSDKResult;
  late String responseID = "";
  late String sdkStatus = "";
  late String sdkErrorCode;
  late String sdkErrorMessage;
  late String sdkErrorDescription;
  late AwesomeLoaderController loaderController = AwesomeLoaderController();
  late Color _buttonColor;

  @override
  void initState() {
    super.initState();
    _buttonColor = const Color(0xff2ace00);
    configureSDK();
  }

  // configure SDK
  Future<void> configureSDK() async {
    // configure app
    configureApp();
    // sdk session configurations
    setupSDKSession();
  }

  // configure app key and bundle-id (You must get those keys from tap)
  Future<void> configureApp() async {
    GoSellSdkFlutter.configureApp(
        bundleId: Platform.isAndroid ? kAndroidBundleId : kIosBundleId,
        productionSecreteKey: Platform.isAndroid ? kTapAndroidProdKey : kTapIosProdKey,
        sandBoxsecretKey: Platform.isAndroid ? kTapAndroidTestKey : kTapIosTestKey,
        lang: "ar");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setupSDKSession() async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          transactionCurrency: "sar",
          // its not the cost
          amount: '1',
          customer: widget.customer,
          paymentItems: widget.paymentItems,
          taxes: [],
          // List of shippnig
          shippings: [],
          postURL: "https://tap.company",
          // Payment description
          paymentDescription: "paymentDescription",
          // Payment Metadata
          paymentMetaData: {},
          // Payment Reference
          paymentReference: Reference(),
          // payment Descriptor
          paymentStatementDescriptor: "paymentStatementDescriptor",
          // Save Card Switch
          isUserAllowedToSaveCard: true,
          // Enable/Disable 3DSecure
          isRequires3DSecure: true,
          // Receipt SMS/Email
          receipt: Receipt(true, false),
          // Authorize Action [Capture - Void]
          authorizeAction: AuthorizeAction(type: AuthorizeActionType.CAPTURE, timeInHours: 10),
          // merchant id
          merchantID: "",
          // Allowed cards
          allowedCadTypes: CardType.ALL,
          allowsToSaveSameCardMoreThanOnce: true,
          // pass the card holder name to the SDK
          cardHolderName: "Card Holder NAME",
          // disable changing the card holder name by the user
          allowsToEditCardHolderName: true,
          // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
          paymentType: PaymentType.ALL,
          // Transaction mode
          sdkMode: SDKMode.Sandbox);
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      tapSDKResult = {};
    });
  }

  Future<void> startSDK() async {
    setState(() {
      loaderController.start();
    });

    tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;
    loaderController.stopWhenFull();
    print('>>>> ${tapSDKResult['sdk_result']}');

    setState(() {
      switch (tapSDKResult['sdk_result']) {
        case "SUCCESS":
          sdkStatus = "SUCCESS";
          handleSDKResult();
          break;
        case "FAILED":
          sdkStatus = "FAILED";
          handleSDKResult();
          break;
        case "SDK_ERROR":
          print('sdk error............');
          print(tapSDKResult['sdk_error_code']);
          print(tapSDKResult['sdk_error_message']);
          print(tapSDKResult['sdk_error_description']);
          print('sdk error............');
          sdkErrorCode = tapSDKResult['sdk_error_code'].toString();
          sdkErrorMessage = tapSDKResult['sdk_error_message'];
          sdkErrorDescription = tapSDKResult['sdk_error_description'];
          break;

        case "NOT_IMPLEMENTED":
          sdkStatus = "NOT_IMPLEMENTED";
          break;
      }
    });
  }

  void handleSDKResult() {
    print('>>>> ${tapSDKResult['trx_mode']}');

    switch (tapSDKResult['trx_mode']) {
      case "CHARGE":
        widget.sdkResults("CHARGE");
        printSDKResult('Charge');
        break;

      case "AUTHORIZE":
        widget.sdkResults("Authorize");

        printSDKResult('Authorize');
        break;

      case "SAVE_CARD":
        widget.sdkResults("SAVE_CARD");

        printSDKResult('Save Card');
        break;

      case "TOKENIZE":
        print('TOKENIZE token : ${tapSDKResult['token']}');
        print('TOKENIZE token_currency  : ${tapSDKResult['token_currency']}');
        print('TOKENIZE card_first_six : ${tapSDKResult['card_first_six']}');
        print('TOKENIZE card_last_four : ${tapSDKResult['card_last_four']}');
        print('TOKENIZE card_object  : ${tapSDKResult['card_object']}');
        print('TOKENIZE card_exp_month : ${tapSDKResult['card_exp_month']}');
        print('TOKENIZE card_exp_year    : ${tapSDKResult['card_exp_year']}');

        responseID = tapSDKResult['token'];
        break;
    }
  }

  void printSDKResult(String trxMode) {
    print('$trxMode status                : ${tapSDKResult['status']}');
    print('$trxMode id               : ${tapSDKResult['charge_id']}');
    print('$trxMode  description        : ${tapSDKResult['description']}');
    print('$trxMode  message           : ${tapSDKResult['message']}');
    print('$trxMode  card_first_six : ${tapSDKResult['card_first_six']}');
    print('$trxMode  card_last_four   : ${tapSDKResult['card_last_four']}');
    print('$trxMode  card_object         : ${tapSDKResult['card_object']}');
    print('$trxMode  card_brand          : ${tapSDKResult['card_brand']}');
    print('$trxMode  card_exp_month  : ${tapSDKResult['card_exp_month']}');
    print('$trxMode  card_exp_year: ${tapSDKResult['card_exp_year']}');
    print('$trxMode  acquirer_id  : ${tapSDKResult['acquirer_id']}');
    print('$trxMode  acquirer_response_code : ${tapSDKResult['acquirer_response_code']}');
    print('$trxMode  acquirer_response_message: ${tapSDKResult['acquirer_response_message']}');
    print('$trxMode  source_id: ${tapSDKResult['source_id']}');
    print('$trxMode  source_channel     : ${tapSDKResult['source_channel']}');
    print('$trxMode  source_object      : ${tapSDKResult['source_object']}');
    print('$trxMode source_payment_type : ${tapSDKResult['source_payment_type']}');

    responseID = tapSDKResult['charge_id'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Positioned(
        bottom: Platform.isIOS ? 0 : 10,
        left: 18,
        right: 18,
        child: SizedBox(
          height: 45,
          child: ElevatedButton(
            clipBehavior: Clip.hardEdge,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_buttonColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            onPressed: startSDK,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: AwesomeLoader(
                    outerColor: Colors.white,
                    innerColor: Colors.white,
                    strokeWidth: 3.0,
                    controller: loaderController,
                  ),
                ),
                const Spacer(),
                const Text(
                  'PAY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
