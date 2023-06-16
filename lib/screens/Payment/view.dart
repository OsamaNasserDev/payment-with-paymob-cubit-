import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:select_card/select_card.dart';

import '../../helper/inputValidator.dart';
import '../../utils/assets_manager.dart';
import '../../utils/color_manager.dart';
import '../baseWidgets/showMotionToast.dart';
import 'controller.dart';
import 'states.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoController(),
      child: BlocConsumer<InfoController, InfoStates>(
        listener: (context, state) {
          // if(state is InfoSuccessState ){
          //
          //   showSuccessToast(context, title: "You are Info is successfully", description: '',);
          //
          // } else if(state is InfoFailState){
          //
          // }
        },
        builder: (context, state) {
          final controller =
              InfoController.get(context); // get object from cubit

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Info",
                              style: TextStyle(
                                  color: Color(0xFF1A132F),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text("Enter You Personal Information",
                              style: TextStyle(
                                color: Color(0xff486776),
                                fontSize: 20,
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: controller.InfoFirstNameController,
                            validator: InputValidator.isNameValid,
                            decoration: const InputDecoration(
                              label: Text("First Name"),
                              hintText: "First Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF1A132F),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: controller.InfoLastNameController,
                            validator: InputValidator.isNameValid,
                            decoration: const InputDecoration(
                              label: Text("last Name"),
                              hintText: "last Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF1A132F),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: controller.InfoEmailController,
                            validator: InputValidator.isEmailValid,
                            decoration: const InputDecoration(
                              label: Text("email"),
                              hintText: "email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFF1A132F),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            controller: controller.InfoPhoneController,
                            validator: InputValidator.isPhoneValid,
                            decoration: const InputDecoration(
                              label: Text("Phone"),
                              hintText: "Phone",
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xFF1A132F),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.InfoAmountController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            validator: InputValidator.isAmountValid,
                            decoration: const InputDecoration(
                              label: Text("Amount"),
                              hintText: "Amount",
                              prefixIcon: Icon(
                                Icons.monetization_on_outlined,
                                color: Color(0xFF1A132F),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Choose Payment Method",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          //this widget returns both title and id
                          SelectGroupCard(context,
                              titles: controller.titles,
                              ids: controller.IntegrationsIDs,
                              images: [
                                ImageAssets.visa,
                                ImageAssets.kiosk,
                                ImageAssets.voda,

                              ],
                              cardBackgroundColor: Colors.white,
                              titleTextColor: Colors.blueGrey,
                              onTap: (title, id) {
                            debugPrint(title);
                            debugPrint(id);
                            controller.cardIntegrationIdResult = id.toString();
                            debugPrint(controller.cardIntegrationIdResult);
                          }),
                          // Text("${cardGroupResult}",style: TextStyle(color: Colors.grey)),
                          const Divider(
                              height: 20,
                              thickness: 3,
                              indent: 20,
                              endIndent: 20,
                              color: Colors.blue),

                          Container(
                            //height: 50,
                            width: double.infinity,
                            child: state is GetFirstTokenLoadingState
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: ColorManager.primary,
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.primary,
                                      //onPrimary: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      fixedSize: const Size.fromHeight(50),
                                    ),
                                    onPressed: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        if(controller.cardIntegrationIdResult ==""){
                                          showErrorToast(context ,title: 'Error', description: 'Pls Choose Payment Method');
                                        }else{
                                          controller.getFirstToken(context);
                                        }
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Pay",
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
