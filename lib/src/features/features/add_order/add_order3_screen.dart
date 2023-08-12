import 'package:courier_app/src/components/custom_list.dart';
import 'package:courier_app/src/components/custom_radio.dart';
import 'package:courier_app/src/core/config/routes.dart';
import 'package:courier_app/src/features/features/add_order/add_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../components/custom_textfield.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'add_order4_screen.dart';

class AddOrderThreeScreen extends StatefulWidget {
  const AddOrderThreeScreen({super.key});

  @override
  State<AddOrderThreeScreen> createState() => _AddOrderThreeScreenState();
}

class _AddOrderThreeScreenState extends State<AddOrderThreeScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemWeightController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController(text: 'Documents');
  TextEditingController itemCategoryController = TextEditingController(text: 'Classified');
  TextEditingController itemDeliveryRequiredController = TextEditingController();
  TextEditingController itemChargesController = TextEditingController();
  TextEditingController itemImageController = TextEditingController();

  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AddOrderController addOrderController = Get.put(AddOrderController());

  int _currentStep = 3;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    itemNameController.text = addOrderController.itemName;
    itemImageController.text = addOrderController.itemImageUrl;
    itemWeightController.text = addOrderController.itemWeight;
    itemDeliveryRequiredController.text = addOrderController.deliveryRequired;
    itemChargesController.text = addOrderController.itemCharges;
    lengthController.text = addOrderController.itemLength;
    widthController.text = addOrderController.itemWidth;
    heightController.text = addOrderController.itemHeight;

    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        title: strItemDetail,
        containerColor: AppColors.transparent,
        text: '',
        color: AppColors.transparent,
      ),
      body: SafeArea(
          child: Form(
        key: formKey,
        child: ListView(padding: EdgeInsets.symmetric(horizontal: margin_15), children: [
          Container(
            width: double.infinity, //// Take full width of the screen
            height: height_70,
            decoration: BoxDecoration(
              color: AppColors.transparent,
            ),
            child: Stepper(
              currentStep: _currentStep,
              type: StepperType.horizontal,
              steps: [
                Step(
                  title: Text(''),
                  content: Text(''),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: Text(''),
                  content: Text(''),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: Text(''),
                  content: Text(''),
                  isActive: _currentStep >= 2,
                ),
                Step(
                  title: Text(''),
                  content: Text(''),
                  isActive: _currentStep >= 3,
                ),
              ],
              elevation: 0,
              onStepTapped: (index) {
                // setState(() {
                //   _currentStep = index;
                // });
              },
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: CustomText(
                text: strPackageDetails, color1: AppColors.black, fontWeight: fontWeight700, fontSize: font_20),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CustomText(
                text: strEnterDetBelow, color1: AppColors.greyColor, fontWeight: fontWeight400, fontSize: font_13),
          ),

          CustomTextField(
            labelText: strEnterItemName,
            prefixIcon: const Image(
              image: AssetImage(ImgAssets.boxItem),
            ),
            obscure: false,
            height: height_15,
            textInputType: TextInputType.text,
            controller: itemNameController,
            validator: ValidationBuilder().required().build(),
          ), //user text-field
          CustomTextField(
            labelText: strUploadItemImg,
            prefixIcon: const Image(
              image: AssetImage(ImgAssets.image),
            ),
            obscure: false,
            height: height_15,
            textInputType: TextInputType.text,
            controller: itemImageController,
            readOnly: true,
            validator: ValidationBuilder().required().build(),
            onTap: () async {
              await addOrderController.getImage();
              itemImageController.text = addOrderController.imagePath.value;
            },
            suffixIcon: Obx(() {
              final imagePath = addOrderController.imagePath.value;
              return Visibility(
                visible: itemImageController.text.isNotEmpty,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    itemImageController.clear();
                  },
                ),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width_150,
                child: Column(
                  children: [
                    const Text(
                      'Size (LxWxH)',
                      style: TextStyle(fontSize: 12),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyColor.withOpacity(.3)),
                        borderRadius: BorderRadius.circular(radius_10),
                      ),
                      child: Row(
                        children: [
                          // Add spacing between label and text fields
                          Expanded(
                            child: TextFormField(
                              controller: lengthController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'L',
                                labelStyle:
                                    TextStyle(fontSize: font_14, fontFamily: 'Mukta', fontWeight: fontWeight400),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(radius_10),
                                    borderSide: BorderSide(color: AppColors.greyColor.withOpacity(.3))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(radius_10),
                                    borderSide: BorderSide(color: AppColors.greyColor.withOpacity(.3))),
                              ),
                              validator: ValidationBuilder().required().build(),
                            ),
                          ),
                          const SizedBox(width: 2), // Add spacing between text fields
                          const Text('x'),
                          const SizedBox(width: 2), // Add spacing between 'x' and text fields
                          Expanded(
                            child: TextFormField(
                              controller: widthController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'W',
                                labelStyle:
                                    TextStyle(fontSize: font_14, fontFamily: 'Mukta', fontWeight: fontWeight400),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(radius_10),
                                    borderSide: BorderSide(color: AppColors.greyColor.withOpacity(.3))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(radius_10),
                                    borderSide: BorderSide(color: AppColors.greyColor.withOpacity(.3))),
                              ),
                              validator: ValidationBuilder().required().build(),
                            ),
                          ),
                          const SizedBox(width: 2), // Add spacing between text fields
                          Text('x'),
                          SizedBox(width: 2), // Add spacing between 'x' and text fields
                          Expanded(
                            child: TextFormField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'H',
                                labelStyle:
                                    TextStyle(fontSize: font_14, fontFamily: 'Mukta', fontWeight: fontWeight400),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(radius_10),
                                    borderSide: BorderSide(color: AppColors.greyColor.withOpacity(.3))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(radius_10),
                                    borderSide: BorderSide(color: AppColors.greyColor.withOpacity(.3))),
                              ),
                              validator: ValidationBuilder().required().build(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CustomDivider(
                    height: height_15,
                  ),
                  SizedBox(
                    width: width_150,
                    //height: height_80,
                    child: CustomTextField(
                      labelText: strItemWeight,
                      prefixIcon: const Image(
                        image: AssetImage(ImgAssets.itemWeight),
                      ),
                      obscure: false,
                      height: height_15,
                      textInputType: TextInputType.number,
                      controller: itemWeightController,
                      validator: ValidationBuilder().required().build(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          CustomDivider(height: height_15),
          CustomDropdown(
            name: 'item type',
            labelText: strSelectItemType,
            labelColor: AppColors.greyColor,
            fontSize: font_12,
            fontWeight: fontWeight400,
            radius: radius_10,
            inputType: TextInputType.name,
            textColor: AppColors.orange,
            fillColor: AppColors.white,
            borderColor: AppColors.greyColor,
            suffixIcon: Image(
              image: AssetImage(ImgAssets.scroll),
              height: height_10,
            ),
            prefixIcon: Image(
              image: AssetImage(ImgAssets.boxItem),
              height: height_10,
            ),
            options: addOrderController.itemTypes,
            initialValue: 'Documents',
            onChanged: (String value) {
              itemTypeController.text = value;
            },
          ),

          CustomDivider(
            height: height_15,
            isDivider: false,
          ),

          CustomDropdown(
            name: 'item category',
            labelText: strSelectItemCateg,
            labelColor: AppColors.greyColor,
            fontSize: font_12,
            fontWeight: fontWeight400,
            radius: radius_10,
            inputType: TextInputType.name,
            textColor: AppColors.orange,
            fillColor: AppColors.white,
            borderColor: AppColors.greyColor,
            suffixIcon: Image(
              image: AssetImage(ImgAssets.scroll),
              height: height_10,
            ),
            prefixIcon: Image(
              image: AssetImage(ImgAssets.itemCategory),
              height: height_10,
            ),
            options: addOrderController.itemCategories,
            initialValue: 'Classified',
            onChanged: (String value) {
              itemCategoryController.text = value;
            },
          ),

          CustomDivider(
            height: height_15,
            isDivider: false,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: CustomText(
                text: strDeliveryRequired, color1: AppColors.greyColor, fontWeight: fontWeight400, fontSize: font_13),
          ),
          CustomDivider(
            height: height_5,
            isDivider: false,
          ),

          Container(
            height: height_45,
            decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(radius_10),
                border: Border.all(color: AppColors.greyColor.withOpacity(.3))),
            child: Row(
              children: [
                Row(
                  children: [
                    Obx(
                      () => Radio<String>(
                        activeColor: AppColors.orange,
                        value: 'Yes',
                        groupValue: addOrderController.itemDeliveryRequired.value,
                        onChanged: (value) {
                          addOrderController.itemDeliveryRequired.value = value.toString();
                          itemDeliveryRequiredController.text = value.toString();
                        },
                      ),
                    ),
                    CustomText(text: 'Yes', color1: AppColors.greyColor, fontWeight: fontWeight400, fontSize: font_13),
                  ],
                ),
                Row(
                  children: [
                    Obx(
                      () => Radio<String>(
                        activeColor: AppColors.orange,
                        value: 'No',
                        groupValue: addOrderController.itemDeliveryRequired.value,
                        onChanged: (value) {
                          addOrderController.itemDeliveryRequired.value = value.toString();
                          itemDeliveryRequiredController.text = value.toString();
                        },
                      ),
                    ),
                    CustomText(text: 'No', color1: AppColors.greyColor, fontWeight: fontWeight400, fontSize: font_13),
                  ],
                )
              ],
            ),
          ),

          CustomDivider(
            height: height_15,
            isDivider: false,
          ),
          CustomTextField(
            labelText: strCharges,
            prefixIcon: const Image(
              image: AssetImage(ImgAssets.charges),
            ),
            obscure: false,
            height: height_15,
            textInputType: TextInputType.number,
            controller: itemChargesController,
            validator: ValidationBuilder().required().build(),
          ),
          CustomDivider(
            height: height_25,
            isDivider: false,
          ),

          Obx(
            () => addOrderController.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.orange,
                  ))
                : CustomButton(
                    text: strContinue,
                    color: AppColors.white,
                    fontWeight: fontWeight800,
                    font: font_16,
                    onPress: () async {
                      if (formKey.currentState!.validate()) {
                        String deliveryRequired = '';
                        if (itemDeliveryRequiredController.text == 'Yes') {
                          deliveryRequired = '1';
                        } else if (itemDeliveryRequiredController.text == 'No') {
                          deliveryRequired = '0';
                        }

                        // print(itemNameController.text);
                        // print(itemImageController.text);
                        // print('${lengthController.text}x${widthController.text}x${heightController.text}');
                        // print(itemWeightController.text);
                        print('*******');
                        print(itemTypeController.text);
                        print(itemCategoryController.text);
                        print('*******');

                        // print(deliveryRequired);
                        // print(itemChargesController.text);

                        addOrderController.setItemDetails(
                            itemNameController.text,
                            itemImageController.text,
                            lengthController.text,
                            widthController.text,
                            heightController.text,
                            itemWeightController.text,
                            itemTypeController.text,
                            itemCategoryController.text,
                            deliveryRequired,
                            itemChargesController.text);
                        // if (orderId.isNotEmpty) {
                        Get.toNamed(AppRoutes.addOrderFour);
                        // }
                      }
                    },
                  ),
          ),
        ]),
      )),
    );
  }
}
