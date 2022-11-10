import 'package:cabavenue_drive/services/area_service.dart';
import 'package:cabavenue_drive/widgets/custom_text_field.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    Key? key,
    required this.modelController,
    required this.colorContoller,
    required this.plateController,
    required this.areaIDController,
    required this.areaNameController,
    required this.provideEmergencyService,
    required this.provideEmergencyServiceCallback,
  }) : super(key: key);

  final TextEditingController modelController;
  final TextEditingController colorContoller;
  final TextEditingController plateController;
  final TextEditingController areaIDController;
  final TextEditingController areaNameController;
  final bool provideEmergencyService;
  final Function provideEmergencyServiceCallback;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final FocusNode _areaFocus = FocusNode();
  List<SelectedListItem> areas = [];

  void getAreas(BuildContext context) async {
    List data = await AreaServices().getAreas(context);
    for (var element in data) {
      areas.add(SelectedListItem(name: element['name'], value: element['_id']));
    }
  }

  @override
  void initState() {
    super.initState();
    getAreas(context);
  }

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          'Areas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        data: areas,
        selectedItems: (List<dynamic> selectedList) {
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              widget.areaNameController.text = item.name;
              widget.areaIDController.text = item.value.toString();
            }
          }
        },
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: widget.modelController,
          hintText: 'Vehicle Model: Maruti, Hudson',
          icon: Iconsax.car,
          borderType: 'full',
        ),
        CustomTextField(
          controller: widget.colorContoller,
          hintText: 'Color: red, white',
          icon: Iconsax.color_swatch,
          keyboardType: TextInputType.emailAddress,
          borderType: 'full',
        ),
        CustomTextField(
          controller: widget.plateController,
          icon: Iconsax.money,
          hintText: 'Plate Number: Ga 10 Pa 1111',
          borderType: 'full',
        ),
        CustomTextField(
          controller: widget.areaNameController,
          icon: Iconsax.location,
          hintText: 'Area',
          focusNode: _areaFocus,
          onTap: () {
            _areaFocus.unfocus();
            onTextFieldTap();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                'Provide Emergency Service?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Switch(
                value: widget.provideEmergencyService,
                onChanged: (val) {
                  setState(() {
                    widget.provideEmergencyServiceCallback();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
