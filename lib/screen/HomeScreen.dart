import 'package:flutter/material.dart';
import 'package:learning_local_database/constant/Strings.dart';
import 'package:learning_local_database/model/Contact.dart';
import 'package:learning_local_database/repository/HomeRepository.dart';
import 'package:learning_local_database/screen/AddContactScreen.dart';
import 'package:learning_local_database/screen/SettingsScreen.dart';
import 'package:learning_local_database/util/AlertDialogUtil.dart';
import 'package:learning_local_database/widget/BaseCircleImage.dart';

class HomeScreen extends StatefulWidget {
  static void pushAndRemoveUntil(BuildContext context, int userID) =>
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen(userID)), (_) => false);

  final int userID;

  HomeScreen(this.userID);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeRepository {
  List<Contact> _contacts = [];
  HomeRepositoryImp _homeRepositoryImp;

  @override
  void initState() {
    _homeRepositoryImp = HomeRepositoryImp(this);
    _homeRepositoryImp.getAllContactsByUserID(widget.userID);
    super.initState();
  }

  @override
  void onError(String message) {
    AlertDialogUtil.showAlertDialog(context, Strings.error, message, () => Navigator.pop(context));
  }

  @override
  void onLoadContactsSuccess(List<Contact> contacts) {
    this._contacts = contacts;
    setState(() {});
  }

  @override
  void onDeleteContactSuccess(String error) {
    AlertDialogUtil.showAlertDialog(context, Strings.congratulation, error, () {
      Navigator.pop(context);
      _homeRepositoryImp.getAllContactsByUserID(widget.userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(child: _buildListView()),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(Strings.home),
      backgroundColor: Colors.red,
      actions: <Widget>[
        IconButton(
          onPressed: () => SettingsScreen.push(context, widget.userID),
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (_) => AddContactScreen(userID: widget.userID)));
        _homeRepositoryImp.getAllContactsByUserID(widget.userID);
      },
      backgroundColor: Colors.green,
      child: Icon(Icons.add),
    );
  }

  Widget _buildListView() {
    return _contacts.isEmpty
        ? Container(
            padding: EdgeInsets.all(64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/image/img_data_center.png'),
                Text(Strings.noContactFound, style: TextStyle(fontSize: 20.0)),
              ],
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(top: 16.0),
            itemCount: _contacts.length,
            itemBuilder: (context, index) => _buildListItem(_contacts[index]),
          );
  }

  Widget _buildListItem(Contact contact) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: ListTile(
        leading: BaseCircleImage(height: 40.0, width: 40.0, imagePath: contact.imagePath),
        trailing: _buildPopUpMenu(contact),
        title: Text(contact.contactName),
        subtitle: Text(contact.contactNumber),
      ),
    );
  }

  Widget _buildPopUpMenu(Contact contact) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(child: Text(Strings.edit), value: Strings.edit),
        PopupMenuItem<String>(child: Text(Strings.delete, style: TextStyle(color: Colors.red)), value: Strings.delete),
      ],
      onSelected: (text) {
        switch (text) {
          case Strings.edit:
            _editContact(contact);
            break;
          case Strings.delete:
            _homeRepositoryImp.deleteContact(contact.contactID);
            break;
        }
      },
    );
  }

  void _editContact(Contact contact) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => AddContactScreen(contact: contact)));
    _homeRepositoryImp.getAllContactsByUserID(widget.userID);
  }
}
