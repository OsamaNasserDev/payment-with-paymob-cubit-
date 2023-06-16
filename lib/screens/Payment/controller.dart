import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_with_paymob/screens/Payment/pages/kiosk.dart';
import 'package:payment_with_paymob/screens/Payment/states.dart';
import '../../helper/dio_helper.dart';
import '../../utils/strings_manager.dart';
import 'pages/web_view.dart';


class InfoController extends Cubit<InfoStates> {
  InfoController() : super(InfoInitialState());

  static InfoController get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  final InfoFirstNameController = TextEditingController();
  final InfoLastNameController = TextEditingController();
  final InfoEmailController     = TextEditingController();
  final InfoPhoneController    = TextEditingController();
  final InfoAmountController   = TextEditingController();



  @override
  Future<void> close() {
    InfoFirstNameController.clear();
    InfoLastNameController.clear();
    InfoEmailController.clear();
    InfoPhoneController.clear();
    InfoAmountController.clear();

    return super.close();
  }


  final List<String> titles = <String>[
    'Online Card',
    'Refer Code',
    'Smart Wallets',
  ];
  final List<String> IntegrationsIDs = <String>[
    '3926211',   // online visa
    '3933231',  // kiosk
    '3934121',  // smart wallets

  ];
  String? cardIntegrationIdResult = "";

  //  1. Authentication Request
  // Get First Token
  getFirstToken(context) async{

    emit(GetFirstTokenLoadingState());
    await DioHelper.postData(endPoint: "auth/tokens",data: {
      "api_key": AppStrings.apiKey,
    } )
        .then((value)  {
      print("value is ${value.data}");
      if(value.data != null ){
        AppStrings.PaymobFirstToken =value.data['token'].toString() ;
        emit(GetFirstTokenSuccessState());
        getOrderID().then((value) {
          getLastToken().then((value) {
            if(cardIntegrationIdResult == "3926211"){
              // الدفع بالفيزا
              Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url:"https://accept.paymob.com/api/acceptance/iframes/767502?payment_token=${AppStrings.PaymobLastTokenOnlineCard}" ),));

            }else if(cardIntegrationIdResult == "3933231"){
              // الدفع بالرقم المرجعي
              getKioskPayments().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KioskScreen(RefCode: AppStrings.Refcode),));
              });
            }else if(cardIntegrationIdResult == "3934121"){
              // الدفع بالمحفظة الالكترونية ( فودافون كاش & ...... )
              getSmartWalletsPayments().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url: AppStrings.RedirectionUrl),));
              });

            }
          });
        });
      }

    }).catchError((error){
      emit(GetFirstTokenFailState());
      print('error in Get First Token is ${error.toString()}');});
  }


  // 2. Order Registration API
  // Get Order ID

  Future getOrderID() async{
    emit(GetOrderIDLoadingState());
    await DioHelper.postData(endPoint: "ecommerce/orders",data: {
      "auth_token":  AppStrings.PaymobFirstToken ,
      "delivery_needed": "false",
      "amount_cents": "${int.parse(InfoAmountController.text.trim())*100}",
      "currency": "EGP",
      //  "merchant_order_id": 5,  // A unique alpha-numeric value, example: "E6RR3". Discard it from the request if your don't need it.
      "items": [

      ],

    } )
        .then((value)  {
      print("value is ${value.data}");
      if(value.data != null ){
        AppStrings.PaymobOrderID =value.data['id'].toString() ;

        emit(GetOrderIDSuccessState());
      }

    }).catchError((error){
      emit(GetOrderIDFailState());
      print('error is ${error.toString()}');});
  }


  // 3. Payment Key Request
  // Get Last Token

  Future getLastToken() async {
       emit(GetLastTokenLoadingState());
       await DioHelper.postData(endPoint: "acceptance/payment_keys",data: {
      "auth_token":  AppStrings.PaymobFirstToken ,
      "amount_cents": "${int.parse(InfoAmountController.text.trim())*100}",
      "expiration": 3600,
      "order_id": AppStrings.PaymobOrderID,
      "billing_data": {
        "apartment": "NA",
        "email":  InfoEmailController.text.trim().toString(),
        "floor": "NA",
        "first_name": InfoFirstNameController.text.trim().toString(),
        "street": "NA",
        "building": "NA",
        "phone_number": InfoPhoneController.text.trim().toString(),
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "Faqous",
        "country": "eg",
        "last_name": InfoLastNameController.text.trim().toString(),
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": cardIntegrationIdResult

    } )
        .then((value)  {
      print("value is ${value.data}");
      if(value.data != null ){
        if(cardIntegrationIdResult == "3926211"){
          AppStrings.PaymobLastTokenOnlineCard =value.data['token'].toString() ; // online visa
        }else if(cardIntegrationIdResult == "3933231"){
          AppStrings.PaymobLastTokenKiosk =value.data['token'].toString() ; // kiosk
        }else if(cardIntegrationIdResult == "3934121"){
          AppStrings.PaymobLastTokenSmartWallets =value.data['token'].toString() ; // smart wallets
        }
        emit(GetLastTokenSuccessState());
      }

    }).catchError((error){
      emit(GetLastTokenFailState());
      print('error is ${error.toString()}');});
  }




  //  Kiosk Payments
  Future getKioskPayments() async{

    emit(GetKioskPaymentsLoadingState());
    await DioHelper.postData(endPoint: "acceptance/payments/pay",data: {

        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR"
        },
        "payment_token": AppStrings.PaymobLastTokenKiosk

    } )
        .then((value)  {
      print("value is ${value.data}");
      if(value.data != null ){
        AppStrings.Refcode =value.data['id'].toString() ;
        emit(GetKioskPaymentsSuccessState());
      }

    }).catchError((error){
      emit(GetKioskPaymentsFailState());
      print('error in Kiosk Payments is ${error.toString()}');});
  }


  //  Smart Wallets Payments
  Future getSmartWalletsPayments() async{

    emit(GetSmartWalletsPaymentsLoadingState());
    await DioHelper.postData(endPoint: "acceptance/payments/pay",data: {

        "source": {
          "identifier": "wallet mobile number",
          "subtype": "WALLET"
        },
        "payment_token": AppStrings.PaymobLastTokenSmartWallets


    } )
        .then((value)  {
      print("Smart Wallets Payments");
      print("value is ${value.data['redirection_url']}");
      print("hmac is ${value.data['hmac']}");
      print("data is ${value.data}");
      if(value.data != null ){


        AppStrings.RedirectionUrl =value.data['redirection_url'].toString() ;
        emit(GetSmartWalletsPaymentsSuccessState());
      }

    }).catchError((error){
      emit(GetSmartWalletsPaymentsFailState());
      print('error in SmartWallets Payments is ${error.toString()}');});
  }
}
