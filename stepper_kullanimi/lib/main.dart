// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "AnaSayfa": (context) => AnaSayfa(),
      },
      home: StepperKulanimi(),
    );
  }
}

class StepperKulanimi extends StatefulWidget {
  const StepperKulanimi({super.key});

  @override
  State<StepperKulanimi> createState() => _StepperKulanimiState();
}

class _StepperKulanimiState extends State<StepperKulanimi> {
  int tiklanmaSayisi = 0;
  int aktifStep = 0;
  bool dogrula = false;
  bool sifreGizle = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String? isim, mail, sifre;
  var key0 = GlobalKey<FormState>();
  var key1 = GlobalKey<FormState>();
  var key2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Stepper Kullanimi"),
      ),
      body: SingleChildScrollView(
        child: Stepper(
          steps: _tumStepler(),
          currentStep: aktifStep,
          /*onStepTapped: (value) {
            setState(() {
              aktifStep = value;
            });
          },*/
          onStepContinue: () {
            setState(() {});
            _ileriButonu();
          },
          onStepCancel: () {
            setState(() {
              if (aktifStep > 0) {
                aktifStep--;
              }
            });
          },
        ),
      ),
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      Step(
        subtitle: Text("orn: Ahmet21"),
        state: oankiStepiayarla(0),
        isActive: true,
        title: Text("Kullanici Adi"),
        content: Form(
          key: key0,
          child: TextFormField(
            controller: username,
            decoration: InputDecoration(
                labelText: "Username",
                hintText: "Kullanici adi gir",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            validator: (String? girilenDeger) {
              if (girilenDeger != null && girilenDeger.length < 6) {
                return "En az 6 karekterli bir kullanici adi girin";
              }
              return null;
            },
            onSaved: (girilenDeger) {
              isim = girilenDeger;
            },
          ),
        ),
      ),
      Step(
        subtitle: Text("orn: ahmet21@gmail.com"),
        state: oankiStepiayarla(1),
        isActive: true,
        title: Text("Mail"),
        content: Form(
          key: key1,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: "Mail",
                hintText: "Mail gir",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            validator: (girilenDeger) {
              if ((girilenDeger != null && girilenDeger.length < 6) ||
                  (!girilenDeger!.contains("@") ||
                      !girilenDeger.contains(".com"))) {
                return "Gecerli bir mail girin";
              }
              return null;
            },
            onSaved: (girilenDeger) {
              mail = girilenDeger;
            },
          ),
        ),
      ),
      Step(
        state: oankiStepiayarla(2),
        isActive: true,
        title: Text("Sifre "),
        content: Form(
          key: key2,
          child: TextFormField(
            obscureText: sifreGizle,
            keyboardType: TextInputType.visiblePassword,
            validator: (girilenDeger) {
              if (girilenDeger != null && girilenDeger.length < 6) {
                return "En az 6 karekterli bir sifre gir";
              }
              return null;
            },
            onSaved: (girilenDeger) {
              sifre = girilenDeger;
            },
            decoration: InputDecoration(
                suffix: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _arttir();
                      });

                      sifreGizle = tiklanmaSayisi % 2 == 0 ? false : true;
                    },
                    child: Icon(tiklanmaSayisi % 2 == 0
                        ? Icons.visibility
                        : Icons.visibility_off)),
                labelText: "Sifre",
                hintText: "Sifreni gir",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
        ),
      ),
    ];
    return stepler;
  }

  StepState oankiStepiayarla(int oAnkiStep) {
    if (aktifStep == oAnkiStep) {
      if (dogrula == false) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  void _ileriButonu() {
    switch (aktifStep) {
      case 0:
        if (key0.currentState!.validate()) {
          key0.currentState!.save();
          dogrula = true;
          aktifStep++;
        } else {
          dogrula == false;
        }
        break;
      case 1:
        if (key1.currentState!.validate()) {
          key1.currentState!.save();
          dogrula = true;
          aktifStep++;
        } else {
          dogrula == false;
        }
        break;
      case 2:
        if (key2.currentState!.validate()) {
          key2.currentState!.save();
          dogrula = true;

          Navigator.pushNamed(context, "AnaSayfa");
        } else {
          dogrula = false;
        }
        break;
    }
  }

  void _arttir() {
    tiklanmaSayisi++;
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ANASAYFA"),
      ),
      body: Center(
        child: Text("AnaSayfa"),
      ),
    );
  }
}
