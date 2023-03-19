import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';

import '../../../../api_constant.dart';
import '../../../../config/app_localizations.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import 'full_elevated_button.dart';
import 'tap_loader.dart';

class PaymentButton extends StatefulWidget {
  final Customer customer;
  final List<PaymentItem> paymentItems;
  final Function(String) onFailed;
  final Function() onSuccess;

  const PaymentButton({
    Key? key,
    required this.customer,
    required this.paymentItems,
    required this.onFailed,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  late Map<dynamic, dynamic> tapSDKResult;
  late String responseID = "";
  late String sdkStatus = "";
  late String sdkErrorCode;
  late String sdkErrorMessage;
  late String sdkErrorDescription;
  late AwesomeLoaderController loaderController = AwesomeLoaderController();

  @override
  void initState() {
    super.initState();
    configureSDK();
  }

  // configure SDK
  Future<void> configureSDK() async {
    configureApp();
    setupSDKSession();
  }

  // configure app key and bundle-id
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
        cardHolderName: widget.customer.firstName,
        // disable changing the card holder name by the user
        allowsToEditCardHolderName: true,
        // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
        paymentType: PaymentType.ALL,
        // Transaction mode
        sdkMode: SDKMode.Sandbox,
      );
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
          widget.onSuccess();
          break;

        default:
          print(tapSDKResult['message']);

          widget.onFailed(tapSDKResult['message'] ?? AppStrings.notFoundError.tr(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FullElevatedButton(
        onPressed: startSDK,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
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
            SizedBox(
              width: AppSize.s10.w,
            ),
            Text(
              AppStrings.pay.tr(context),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
