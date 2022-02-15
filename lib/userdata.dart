import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserListData extends StatefulWidget {
  const UserListData({Key? key}) : super(key: key);

  @override
  _UserListDataState createState() => _UserListDataState();
}

class _UserListDataState extends State<UserListData> {
  final SlidableController slideController = SlidableController();

  final TextEditingController _firstNameTextController = TextEditingController();

  final TextEditingController _lastNameTextController = TextEditingController();

  final _fireStore = FirebaseFirestore.instance.collection('Data');

  final _formKey = GlobalKey<FormState>();

  bool _isEditEnable = false;

  String? _updatedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User's Data"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your First Name';
                  }
                  return null;
                },
                controller: _firstNameTextController,
                decoration: const InputDecoration(hintText: "Enter Your First Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Last Name';
                  }
                  return null;
                },
                controller: _lastNameTextController,
                decoration: const InputDecoration(hintText: "Enter Your Last Name"),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_isEditEnable == true) {
                            Map<String, dynamic> data = {'FirstName': '${_firstNameTextController.text} ', 'LastName': _lastNameTextController.text};
                            _fireStore.firestore.collection("Data").doc(_updatedIndex).set(data);
                            setState(() {
                              _isEditEnable = false;
                            });
                          } else {
                            _fireStore.add({
                              'FirstName': _firstNameTextController.text,
                              'LastName': _lastNameTextController.text,
                            }).then((value) {
                              print(value.id);
                            });
                          }
                        }
                        _lastNameTextController.clear();
                        _firstNameTextController.clear();
                      },
                      child: const Text("Add Data")),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _fireStore.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Center(
                          child: Text("No Data Available"),
                        ),
                      );
                    }

                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Slidable(
                          controller: slideController,
                          actionPane: const SlidableDrawerActionPane(),
                          actionExtentRatio: 0.2,
                          child: Container(
                            color: Colors.amber,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                              child: Row(
                                children: [
                                  Text(
                                    document['FirstName'],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    document['LastName'],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          secondaryActions: [
                            IconSlideAction(
                                caption: 'Edit',
                                color: Colors.blue,
                                icon: Icons.edit,
                                onTap: () {
                                  setState(() {
                                    _firstNameTextController.text = document['FirstName'];
                                    _lastNameTextController.text = document['LastName'];
                                    _isEditEnable = true;
                                    _updatedIndex = document.id;
                                  });
                                }),
                            IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  _fireStore.firestore.collection("Data").doc(document.id).delete();
                                }),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
