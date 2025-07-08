import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/organization/edit_organization_screen.dart';
import '../../services/organization_services.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final OrganizationModel org = Get.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
        child: Column(
          children: [
            _appBar(org),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    _orgInfo(width, org: org),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    _joinCodeSection(width, org.joinCode),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    // add owner section
                    _isOwnerAddButton(width, org),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    _ownersInfo(width, org.owners!),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    (org.users == null || org.users!.isEmpty)
                        ? SizedBox()
                        : _usersInfo(width, org.users!)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _appBar(OrganizationModel org) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: CircleAvatar(
              backgroundColor: Colors.white, child: Icon(Icons.arrow_back)),
        ),
        Text(
          'My Organization',
          style: TextStyle(
              color: Constants.pageNameColor,
              fontFamily: Constants.primaryFont,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        isOwner(org.owners!)
            ? IconButton(
                onPressed: () {
                  Get.to(() => EditOrganizationScreen(), arguments: org);
                },
                icon: CircleAvatar(
                    backgroundColor: Constants.primaryColor,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    )))
            : SizedBox(
                width: 30,
              ),
      ],
    );
  }

  Widget _infoRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: Constants.primaryFont,
                      color: Colors.black,
                      fontWeight: FontWeight.w700))),
          const SizedBox(width: 10),
          Expanded(
              child: Text(content,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Constants.primaryFont,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87))),
        ],
      ),
    );
  }

  _orgInfo(double width, {required OrganizationModel org}) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _picturePart(org),
          const SizedBox(height: 10),
          Text(
            org.name!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            org.industry!,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _infoRow("Contact Email", org.contactEmail ?? 'null'),
          _infoRow("Phone", org.contactPhone.toString()),
          _infoRow("Address", org.address.toString()),
          _infoRow("Created At",
              DateFormat('MMM d, y').format(DateTime.parse(org.createdAt!))),
          _infoRow('Size Range', org.sizeRange!),
          _infoRow('Website', org.website ?? 'Null'),
        ],
      ),
    );
  }
  _ownerRow(Owner owner) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          _ownerPic(owner),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  owner.name!,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: Constants.primaryFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  owner.email!,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: Constants.primaryFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ]))
        ],
      ),
    );
  }

  _ownersInfo(double width, List<Owner> owners) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Owners',
            style: TextStyle(
                color: Colors.black,
                fontFamily: Constants.primaryFont,
                fontSize: 18,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 10),
          ...List.generate(
            owners.length,
            (index) {
              return _ownerRow(owners[index]);
            },
          )
        ]));
  }

  _picturePart(OrganizationModel org) {
    if (org.logoUrl != null && org.logoUrl!.trim().isNotEmpty) {
      return CircleAvatar(
        radius: 45,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 43,
          backgroundImage: NetworkImage(org.logoUrl!),
        ),
      );
    } else {
      return const CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xFFFFE3C5),
        child:
            Icon(Icons.account_balance_rounded, size: 50, color: Colors.white),
      );
    }
  }

  _ownerPic(Owner owner) {
    if (owner.profileImage != null) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(owner.profileImage!),
        ),
      );
    } else {
      return const CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xFFFFE3C5),
        child: Icon(Icons.person, size: 30, color: Colors.white),
      );
    }
  }

  _usersInfo(double width, List<User> users) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Users',
            style: TextStyle(
                color: Colors.black,
                fontFamily: Constants.primaryFont,
                fontSize: 18,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 10),
          ...List.generate(
            users.length,
            (index) {
              if (users[index].isOwner == false) {
                return _userRow(users[index]);
              }
              return SizedBox();
            },
          )
        ]));
  }

  _userRow(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          _userPic(user),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  "${user.firstName!} ${user.lastName!}",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: Constants.primaryFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  user.email!,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: Constants.primaryFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ]))
        ],
      ),
    );
  }

  _userPic(User user) {
    if (user.profilePic != null) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(user.profilePic!),
        ),
      );
    } else {
      return const CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xFFFFE3C5),
        child: Icon(Icons.person, size: 30, color: Colors.white),
      );
    }
  }

  Widget _joinCodeSection(double width, String? joinCode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join Code',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: Constants.primaryFont,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    joinCode ?? 'No Code Available',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: Constants.primaryFont,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  if (joinCode != null) {
                    Clipboard.setData(ClipboardData(text: joinCode));
                    Get.snackbar('Copied', 'Join code copied to clipboard!',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                icon: const Icon(Icons.copy, color: Colors.black),
              )
            ],
          ),
        ],
      ),
    );
  }

  _isOwnerAddButton(width, OrganizationModel org) {
    return isOwner(org.owners!)
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Owner',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constants.primaryFont,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddOwnerDialog(org);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(Icons.person_add, color: Colors.white),
                  label:
                      Text('Add Owner', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )
        : SizedBox();
  }

  void _showAddOwnerDialog(OrganizationModel org) {
    final users = org.users ?? [];
    User? selectedUser;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Select User to Add as Owner',
            style: TextStyle(
              fontFamily: Constants.primaryFont,
              fontWeight: FontWeight.bold,
            )),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<User>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.white,
                  hint: Text('Select User'),
                  value: selectedUser,
                  isExpanded: true,
                  items: users
                      .where((user) => user.isOwner == false)
                      .map((user) => DropdownMenuItem<User>(
                            value: user,
                            child: Row(
                              children: [
                                user.profilePic != null
                                    ? CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundImage:
                                              NetworkImage(user.profilePic!),
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Color(0xFFFFE3C5),
                                        child: Icon(Icons.person,
                                            size: 15, color: Colors.white),
                                      ),
                                SizedBox(width: 10),
                                Text('${user.firstName} ${user.lastName}'),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (User? value) {
                    setState(() {
                      selectedUser = value;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Constants.primaryColor,
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.primaryColor,
            ),
            onPressed: () {
              if (selectedUser != null) {
                OrganizationServices.addOwner(userId: selectedUser!.id!,);
                print('Selected User: ${selectedUser!.firstName}');
              }
            },
            child: Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  bool isOwner(List<Owner> owners) {
    String? userId = CacheHelper().getData(key: 'id');
    for (var owner in owners) {
      if (owner.id == userId) {
        return true;
      }
    }
    return false;
  }
}
