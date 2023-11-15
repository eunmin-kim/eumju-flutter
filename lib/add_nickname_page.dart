import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddNickName extends StatefulWidget {
  final int selectedIndex;
  final VoidCallback? onIncrement;
  const AddNickName( {super.key, required this.selectedIndex, required this.onIncrement});
  @override
  State<AddNickName> createState() => _AddNickNameState();

}

class _AddNickNameState extends State<AddNickName> {
  final nickNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // print(widget.selectedIndex);
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            alignment: Alignment.centerLeft,
            child: Text("안녕하세요.",style: TextStyle(
              fontFamily: "Prt",
              fontSize: 25,
              fontWeight: FontWeight.w600
            ),),
          ),
          Icon(Icons.account_circle,size: 250),
          Container(
            width: 300,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: "사용하실 닉네임을 입력해주세요."
              ),
              controller: nickNameController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('nickName', nickNameController.text);
              widget.onIncrement?.call();
            },
            child: Text("작성하기"),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300,50),
              backgroundColor: Color.fromRGBO(88, 188, 154, 1)
            ),
          )
        ],
      ),
    );
  }
}
