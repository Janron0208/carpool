import 'package:flutter/material.dart';

class AccountChangePass extends StatefulWidget {
  const AccountChangePass({super.key});

  @override
  State<AccountChangePass> createState() => _AccountChangePassState();
}

class _AccountChangePassState extends State<AccountChangePass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
        title: Text('เปลี่ยนรหัสผ่าน'),
      ),
      body: Column(),
    );
  }
}
