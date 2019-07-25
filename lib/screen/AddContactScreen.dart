import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/model/Contact.dart';
import 'package:learning_local_database/repository/AddContactRepository.dart';
import 'package:learning_local_database/util/AlertDialogUtil.dart';
import 'package:learning_local_database/widget/BaseBackground.dart';
import 'package:learning_local_database/widget/BaseCard.dart';
import 'package:learning_local_database/widget/BaseCircleImage.dart';
import 'package:learning_local_database/widget/BaseContainer.dart';
import 'package:learning_local_database/widget/BaseRaisedButton.dart';
import 'package:learning_local_database/widget/BaseTextFormField.dart';

class AddContactScreen extends StatefulWidget {
  final int userID;
  final Contact contact;

  AddContactScreen({this.userID, this.contact});

  @override
  State createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> implements AddContactRepository {
  final _formKey = GlobalKey<FormState>();
  final _sizedBox16 = SizedBox(height: 16.0);
  AddContactRepositoryImp _contactRepositoryImp;
  bool _isEditContact = false;
  String _imagePath = 'assets/image/ic_unknown_user.png';
  FocusNode _contactNameFocusNode = FocusNode();
  FocusNode _contactNumberFocusNode = FocusNode();
  TextEditingController _contactNameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();

  @override
  void initState() {
    _contactRepositoryImp = AddContactRepositoryImp(this);
    _isEditContact = widget.contact != null;
    if (_isEditContact) {
      _imagePath = widget.contact.imagePath;
      _contactNameController.text = widget.contact.contactName;
      _contactNumberController.text = widget.contact.contactNumber;
    }
    super.initState();
  }

  @override
  void onError(String message) {
    AlertDialogUtil.showAlertDialog(context, Strings.error, message, () => Navigator.pop(context));
  }

  @override
  void onAddContactSuccess() {
    _imagePath = 'assets/image/ic_unknown_user.png';
    _contactNameController.text = '';
    _contactNumberController.text = '';
    setState(() {});
  }

  @override
  void onUpdateContactSuccess(String message) {
    AlertDialogUtil.showAlertDialog(context, Strings.congratulation, message, () {
      _imagePath = 'assets/image/ic_unknown_user.png';
      _contactNameController.text = '';
      _contactNumberController.text = '';
      _isEditContact = false;
      Navigator.pop(context);
      Navigator.pop(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      appBar: AppBar(title: Text(Strings.addContact), backgroundColor: Colors.red),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          BaseBackground.backgroundRedWhite(),
          _buildAddContactForm(),
        ],
      ),
    );
  }

  Widget _buildAddContactForm() {
    return SingleChildScrollView(
      child: BaseCard(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () => AlertDialogUtil.showSelectDialog(
                  context,
                  Strings.selectImageSource,
                  Strings.selectImageSourceContent,
                  () {
                    _getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  () {
                    _getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                child: BaseCircleImage(height: 200.0, width: 200.0, imagePath: _imagePath),
              ),
              _sizedBox16,
              BaseTextFormField(
                labelText: Strings.contactName,
                controller: _contactNameController,
                focusNode: _contactNameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => BaseTextFormField.switchNode(context, _contactNameFocusNode, _contactNumberFocusNode),
                validator: (text) => text.isEmpty ? Strings.pleaseInputContactName : null,
              ),
              _sizedBox16,
              BaseTextFormField(
                labelText: Strings.contactNumber,
                controller: _contactNumberController,
                focusNode: _contactNumberFocusNode,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                validator: (text) => text.isEmpty ? Strings.pleaseInputContactNumber : null,
              ),
              Container(
                margin: EdgeInsets.only(top: 64.0),
                height: 48.0,
                width: double.infinity,
                child: BaseRaisedButton(
                  text: Strings.save,
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    _contactNumberFocusNode.unfocus();
                    if (!_isEditContact) {
                      var contact = Contact(
                        userID: widget.userID,
                        imagePath: _imagePath,
                        contactName: _contactNameController.text.trim(),
                        contactNumber: _contactNumberController.text,
                      );
                      _contactRepositoryImp.insertContact(contact);
                      return;
                    }
                    widget.contact.imagePath = _imagePath;
                    widget.contact.contactName = _contactNameController.text.trim();
                    widget.contact.contactNumber = _contactNumberController.text;
                    _contactRepositoryImp.updateContact(widget.contact);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _getImage(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    if (image == null) return;
    this._imagePath = image.path;
    setState(() {});
  }
}
