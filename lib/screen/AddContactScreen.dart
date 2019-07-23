import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/screen/HomeScreen.dart';
import 'package:learning_local_database/widget/BaseBackground.dart';
import 'package:learning_local_database/widget/BaseCard.dart';
import 'package:learning_local_database/widget/BaseContainer.dart';
import 'package:learning_local_database/widget/BaseTextFormField.dart';

class AddContactScreen extends StatefulWidget {
  static void push(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (_) => AddContactScreen()));

  @override
  State createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _sizedBox16 = SizedBox(height: 16.0);

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      appBar: AppBar(title: Text(Strings.addContact), backgroundColor: Colors.red),
      body: Hero(
        tag: HomeScreen.pushTag,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            BaseBackground.backgroundRedWhite(),
            _buildAddContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddContactForm() {
    return SingleChildScrollView(
      child: BaseCard(
        child: BaseTextFormField(
          labelText: Strings.phoneNumber,
        ),
      ),
    );
  }
}
