import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_generator/add_pass.dart';
import 'package:random_password_generator/random_password_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PasswordGenerator());
}

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  double passLen = 15;
  List<String> dictionary = [
    "continue45-",
    "DaubMoorBlurred84",
    "NobilityUbiquityKerosene83",
    "CashierUlteriorTuxedo11",
    "SkipBrandishGames17",
    "RaspyClobberSatin62",
    "PoundCarpetedChum86",
    "WaterPaydayDough71",
    "BacklogDrinkingTurtle52",
    "ObsceneInfantMisled83",
    "CompactReclineMorning50",
    "FlankVesselTabulate90",
    "BrazenlyHutchSilly35",
    "SecretlyWaddleYawn41",
    "S0ftTh!ngRuby",
    "M!judg3Tru3L@v@t0ry",
    "F3c@lCl!ffP@rtn3r",
    "Cr@v3M0n0t0nyG@v3",
    "N@vyC0@r3lyTubul@r",
    "PonderChiefFanfare16",
    "Cr0@kM0b!l!tyV3rm!n",
    "C0v3tZ@nySm@h3d",
    "R3f!n3dT33thStr@nd",
    "C@mp@!gnWh3tN03d!v3"
  ];
  int MAX = 23;

  bool isMemorable = false;
  void changeMemIcon() {
    setState(() {
      isMemorable = !isMemorable;
      isRandom = false;
      isDashed = false;
    });
  }

  String memPass = '';
  void changeMemorable() {
    setState(() {
      memPass = dictionary[Random().nextInt(MAX)];
    });
  }

  String hyp = "-";
  bool isRandom = false;
  void changeRandom() {
    setState(() {
      isRandom = !isRandom;
      isMemorable = false;
      isDashed = false;
    });
  }

  bool isDashed = false;
  void changeDashed() {
    setState(() {
      isDashed = !isDashed;
      isMemorable = false;
      isRandom = false;
    });
  }

  void generate() {
    newPassword = password.randomPassword(
        letters: _isWithLetters,
        numbers: _isWithNumbers,
        passwordLength: passLen,
        specialChar: _isWithSpecial,
        uppercase: _isWithUppercase);
    double passwordstrength = password.checkPassword(
      password: newPassword,
    );
    if (passwordstrength < 0.3) {
      Text(isOk = 'This Password is weak', style: TextStyle(color: Colors.red));
    } else if (passwordstrength < 0.7) {
      isOk = 'This password is Good';
    } else {
      isOk = 'This passsword is Strong';
    }

    setState(() {});
    if (passwordstrength < 0.1) {
      Text(dur = 'Days', style: TextStyle(color: Colors.red));
    } else if (passwordstrength < 0.3) {
      dur = '5 Years';
    } else if (passwordstrength < 0.5) {
      dur = '15 Years';
    } else if (passwordstrength < 0.7) {
      dur = '50 Years';
    } else if (passwordstrength < 0.9) {
      dur = '99 Years';
    } else {
      dur = 'Centuries';
    }

    setState(() {});
  }

  bool _isWithLetters = true;
  bool _isWithUppercase = false;
  bool _isWithNumbers = false;
  bool _isWithSpecial = false;
  String newPassword = '';
  String isOk = '';

  String dur = '';
  final password = RandomPasswordGenerator();
  TextEditingController _passwordLength = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(children: [
                      Icon(Icons.arrow_back_ios),
                      Text(
                        "Password Generator",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Builder(
                          builder: (context) => TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddPass(),
                                ));
                              },
                              child: Icon(Icons.add)))
                    ]),
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 50,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  isDashed
                                      ? newPassword
                                          .replaceFirst(newPassword[3], '-')
                                          .replaceFirst(newPassword[8], '-')
                                          .replaceFirst(newPassword[12], '-')
                                      : newPassword,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          newPassword.contains(RegExp(r'[A-Z]'))
                                              ? Colors.green
                                              : Colors.red)),
                            ),
                          ),
                          const Divider(
                            height: 10,
                          ),
                          newPassword.isNotEmpty
                              ? Text("Password will take $dur to crack")
                              : const Text(""),
                          Text(isOk),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green[200]),
                                  onPressed: () {
                                    changeMemorable();
                                    if (isMemorable)
                                      newPassword = memPass;
                                    else
                                      generate();
                                    setState(() {});
                                  },
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      Icons.add_box,
                                      color: Colors.green,
                                    ),
                                  ),
                                  label: const Padding(
                                    padding: EdgeInsets.only(
                                      top: 12,
                                      bottom: 12,
                                      right: 15,
                                    ),
                                    child: Text(
                                      "Generate",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue[100]),
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: newPassword));
                                      Fluttertoast.showToast(
                                          msg: "Password copied to clipboard!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1);
                                    },
                                    icon: const Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: Icon(
                                        Icons.copy,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    label: const Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.0, top: 12, bottom: 12),
                                      child: Text(
                                        "Copy",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Password type",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isRandom)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Password Length: $passLen",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                ),
                                Slider(
                                  divisions: 5,
                                  max: 30,
                                  label: "Password length:${passLen.round()}",
                                  value: passLen,
                                  onChanged: (newValue) {
                                    setState(() {
                                      passLen = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          Divider(),
                          GestureDetector(
                            onTap: () {
                              changeRandom();
                              if (isRandom) {}
                            },
                            child: ListTile(
                              title: Text("Random",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle:
                                  const Text("Randomly generated characters"),
                              trailing: isRandom
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                            ),
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: () {
                              changeMemIcon();
                            },
                            child: ListTile(
                              title: Text("Memorable",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("Words from dictionary"),
                              trailing: isMemorable
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              changeDashed();
                            },
                            child: ListTile(
                              title: const Text("Dashed",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle:
                                  const Text("Pattern like xxxx-xxxx-xxxx"),
                              trailing: isDashed
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Include following",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text("Alphabet lowercase",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Use lowercase alphabets form a-z"),
                            trailing: Switch(
                              value: _isWithLetters,
                              onChanged: (newValue) {
                                setState(() {
                                  _isWithLetters = newValue;
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Alphabet uppercase",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Use uppercase alphabets form A-Z"),
                            trailing: Switch(
                              value: _isWithUppercase,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isWithUppercase = newValue;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Digits",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Use digits from 0-9"),
                            trailing: Switch(
                              value: _isWithNumbers,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isWithNumbers = newValue;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Special Characters",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Use special characters !@#?%^&*?/"),
                            trailing: Switch(
                              value: _isWithSpecial,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isWithSpecial = newValue;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
