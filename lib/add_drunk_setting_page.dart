
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddDrunkSetting extends StatefulWidget {
  final int selectedIndex;
  final VoidCallback? onIncrement;
  const AddDrunkSetting({super.key, required this.selectedIndex, required this.onIncrement});

  @override
  State<AddDrunkSetting> createState() => _AddDrunkSettingState();
}

class _AddDrunkSettingState extends State<AddDrunkSetting> {
  List<String> drunk = <String>['소주','맥주'];
  List<String> drunk2 = <String>['소주','맥주'];
  String dropdownDrunk = "소주";
  String dropdownDrunk2 = "소주";
  List<String> jan = <String>['잔','병'];
  String dropdownJan = "잔";

  final drunkJan = TextEditingController();
  final nickNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                alignment: Alignment.centerLeft,
                child: Text("나의 주종과 주량은?",style: TextStyle(
                    fontFamily: "Prt",
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                ),),
              ),
              Container(
                width: 300,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 25),
                padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("주종 | ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Prt",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                      )
                    ),

                    DropdownButton<String>(
                      value: dropdownDrunk,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black,
                        fontFamily: "Prt",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,),
                      underline: Container(
                        height: 0,
                        color: Colors.black,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownDrunk = value!;
                        });
                      },
                      items: drunk.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                )
              ),
              Container(
                  width: 300,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("주량 | ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Prt",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )
                      ),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                          controller: drunkJan,
                          onChanged: (text)=> {
                            setState(() => {})
                          },
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownJan,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black,
                          fontFamily: "Prt",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,),
                        underline: Container(
                          height: 0,
                          color: Colors.black,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownJan = value!;
                          });
                        },
                        items: jan.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("나의 주종과 주량은?",style: TextStyle(
                      fontFamily: "Prt",
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                  )),
                  Container(
                      width: 300,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 25),
                      padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("주종 | ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Prt",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )
                          ),

                          DropdownButton<String>(
                            value: dropdownDrunk2,
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black,
                              fontFamily: "Prt",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,),
                            underline: Container(
                              height: 0,
                              color: Colors.black,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownDrunk2 = value!;
                              });
                            },
                            items: drunk2.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      )
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: drunkJan.text.isNotEmpty?  () async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('juJong', dropdownDrunk);
                  await prefs.setString('juRang', drunkJan.text);
                  await prefs.setString('favoriteDrink', dropdownDrunk2);
                  // widget.onIncrement?.call();
                } : null,
                child: Text("작성하기"),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(300,50),
                    backgroundColor: Color.fromRGBO(88, 188, 154, 1)
                ),
              )
            ],
          ),
        )
    );
  }
}
