import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controller.dart';

class PhoneFormWidget extends StatefulWidget {
  @override
  _PhoneFormWidgetState createState() => _PhoneFormWidgetState();
}

class _PhoneFormWidgetState extends State<PhoneFormWidget> {
  final controller = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          //Phone Code
          SizedBox(
            width: 75,
            child: TextFormField(
              controller: controller.codeController,
              keyboardType: TextInputType.number,
              maxLength: 3,
              decoration: InputDecoration(
                labelText: '',
                counter: SizedBox.shrink(),
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 30,
                      child: GestureDetector(
                        onTap: _countryPickerTapped,
                        child: Observer(
                          builder: (_) => controller.country.name.isEmpty
                              ? Icon(
                                  Icons.bug_report,
                                  color: Colors.transparent,
                                )
                              : CountryPickerUtils.getDefaultFlagImage(
                                  controller.country),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Align(alignment: Alignment(0, -10), child: Text('+'))
                  ],
                ),
              ),
              onChanged: (str) {
                if (str.length == 3) {
                  FocusScope.of(context).nextFocus();
                }
                try {
                  controller.country =
                      CountryPickerUtils.getCountryByPhoneCode(str);
                } catch (e) {
                  controller.country = Country(
                      name: '', phoneCode: str, isoCode: '', iso3Code: '');
                }
              },
            ),
          ),

          SizedBox(width: 12),
          //Phone Number Main TextField
          Flexible(
            flex: 4,
            child: TextFormField(
              controller: controller.phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counter: SizedBox.shrink(),
                labelText: 'Phone Number',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _countryPickerTapped() {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: CountryPickerDialog(
          titlePadding: EdgeInsets.all(8.0),
          searchCursorColor: Colors.pinkAccent,
          searchInputDecoration: InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: Text('Select your phone code'),
          onValuePicked: (_selectedDialogCountry) {
            controller.codeController.text =
                '+${_selectedDialogCountry.phoneCode}';
            controller.country = _selectedDialogCountry;
          },
          itemBuilder: (country) => ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text('+${country.phoneCode}  (${country.name})'),
            leading: CountryPickerUtils.getDefaultFlagImage(country),
          ),
        ),
      ),
    );
  }
}
