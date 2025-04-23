import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:payment_gateways_template/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load env file
  await dotenv.load(fileName: '.env');

  // set orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // run app
  runApp(const PaymentGatewaysApp());
}
