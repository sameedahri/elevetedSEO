import 'package:elevated_seo_admin/components/confirm_dialog.dart';
import 'package:elevated_seo_admin/models/users_model.dart';
import 'package:elevated_seo_admin/services/auth_service.dart';
import 'package:elevated_seo_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamProvider<List<GMBUser>>.value(
        value: getUsers,
        builder: (context, child) {
          List<GMBUser> _dataList = Provider.of<List<GMBUser>>(context);

          if (_dataList != null && _dataList.length > 0)
            return Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Account Name')),
                  DataColumn(label: Text('Email Address')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions'))
                ],
                rows: _dataList.map(
                  (data) {
                    return DataRow(
                      cells: [
                        DataCell(Text(data.accountName ?? "-")),
                        DataCell(Text(data.email)),
                        DataCell(data.accountNumber != null
                            ? Text("Business Account Linked!")
                            : Text("No Business Account Linked")),
                        DataCell(
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.times),
                            onPressed: () => removeAdmin(context, data),
                            color: Colors.red,
                            tooltip: 'Delete',
                          ),
                        )
                      ],
                    );
                  },
                ).toList(),
              ),
            );
          else
            return Center(child: Text('No Data Available.'));
        },
      ),
    );
  }

  removeAdmin(BuildContext context, GMBUser gmbUser) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ConfirmDialog(
        title: 'Remove ${gmbUser.email}?',
        confirmBtnCallback: () async {
          await deleteUser(gmbUser);
          showMessage("Removed ${gmbUser.email}.");
          Navigator.pop(context);
        },
      ),
    );
  }
}
