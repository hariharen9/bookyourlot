import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Success.dart';

class scratch extends StatefulWidget {
  @override
  _scratchState createState() => _scratchState();
}

class _scratchState extends State<scratch> {
  final _firestore = FirebaseFirestore.instance;
  var x = new Map();
  final _formKey = GlobalKey<FormState>();
  final VehicleNumber = TextEditingController();
  final Timing = TextEditingController();

  void newTry() {
    print(_firestore.collection("CIT - Book your Lot").doc('Availability'));
  }

  // void newTry(){
  //   _firestore.collection("CIT - Book your Lot").doc('Availability').get().then((value)
  //   {
  //     var map = new Map();
  //     dynamic AvailableList =[];
  //     dynamic BookedList =[];
  //     dynamic Alloted;
  //     var listA = new List();
  //     var listB = new List();
  //     map = value.data();
  //     AvailableList = map['Available'];
  //     BookedList = map['Booked'];
  //     Alloted = AvailableList.removeLast();
  //     BookedList.add(Alloted);
  //     listA = AvailableList;
  //     listB = BookedList;
  //     map['Available Number'] = listA.length;
  //     map['Booked Number'] = listB.length;
  //     map['Available'] = AvailableList;
  //     _firestore
  //         .collection("Peelamedu - Book your Lot")
  //         .doc('Availability')
  //         .update(map);
  //     _firestore
  //         .collection("Peelamedu - Book your Lot")
  //         .doc(Alloted.toString())
  //         .update({
  //       'vehicle number': VehicleNumber.toString(),
  //       'time': Timestamp.now(),
  //       'paid': int.parse(Timing.toString()),
  //     },);
  //     _firestore.collection('Peelamedu - Book your Lot').doc('Balance').get().then((value){
  //       var map = new Map();
  //       map = value.data();
  //       dynamic CurrentBal ;
  //       CurrentBal = map['Current Balance'].toString();
  //       CurrentBal = double.parse(CurrentBal) - int.parse(Timing.toString());
  //       map['Current Balance'] = CurrentBal;
  //       _firestore
  //           .collection("Peelamedu - Book your Lot")
  //           .doc('Balance')
  //           .update(map);
  //     });
  //   }
  //   );
  //
  // }
  void ShowStatus() async {
    await for (var snapshot
        in _firestore.collection("CIT - Book your Lot").snapshots()) {
      for (var i in snapshot.docs) {
        x = i.data();
      }
      print(x);
    }
  }

  void Reset() {
    _firestore.collection("CIT - Book your Lot").doc('Availability').update(
      {
        'Available Number': 4,
        'Booked Number': 0,
        'Booked': [],
        'Available': ['1A', '1B', '2A', '2B']
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            child: Text('Show Status'),
            onPressed: () {
              ShowStatus();
            },
          ),
          FlatButton(
            child: Text('Reset'),
            onPressed: () {
              Reset();
            },
          ),
          FlatButton(
            child: Text('Update'),
            onPressed: () {
              newTry();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return Success();
              //     },
              //   ),
              // );
            },
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: VehicleNumber,
                    decoration: InputDecoration(
                      hintText: 'ENTER WITHOUT SPACE',
                      filled: true,
                      fillColor: Colors.blueGrey[250],
                      icon: Icon(
                        Icons.compare_arrows,
                        color: Colors.blue[600],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: Timing,
                    decoration: InputDecoration(
                      hintText: 'ENTER IN MINUTES',
                      filled: true,
                      fillColor: Colors.blueGrey[250],
                      icon: Icon(
                        Icons.access_time,
                        color: Colors.blue[600],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('PAY'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _firestore
                            .collection("CIT - Book your Lot")
                            .doc('Availability')
                            .get()
                            .then((value) {
                          var map = new Map();
                          dynamic AvailableList = [];
                          dynamic BookedList = [];
                          dynamic Alloted;
                          var listA = new List();
                          var listB = new List();
                          map = value.data();
                          AvailableList = map['Available'];
                          BookedList = map['Booked'];
                          Alloted = AvailableList.removeLast();
                          BookedList.add(Alloted);
                          listA = AvailableList;
                          listB = BookedList;
                          map['Available Number'] = listA.length;
                          map['Booked Number'] = listB.length;
                          map['Available'] = AvailableList;
                          _firestore
                              .collection("CIT - Book your Lot")
                              .doc('Availability')
                              .update(map);
                          _firestore
                              .collection("CIT - Book your Lot")
                              .doc(Alloted.toString())
                              .update(
                            {
                              'vehicle number': VehicleNumber.text,
                              'time': Timestamp.now(),
                              'paid': int.parse(Timing.text),
                            },
                          );
                          _firestore
                              .collection('CIT - Book your Lot')
                              .doc('Balance')
                              .get()
                              .then((value) {
                            var map = new Map();
                            map = value.data();
                            dynamic CurrentBal;
                            CurrentBal = map['Current Balance'].toString();
                            CurrentBal = double.parse(CurrentBal) -
                                int.parse(Timing.text) * 0.5;
                            map['Current Balance'] = CurrentBal;
                            _firestore
                                .collection("CIT - Book your Lot")
                                .doc('Balance')
                                .update(map);
                          });
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
