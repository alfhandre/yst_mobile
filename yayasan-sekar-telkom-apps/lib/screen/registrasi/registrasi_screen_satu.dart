import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/screen/registrasi/registrasi_screen_dua.dart';
import 'package:yayasan_sekar_telkom_apps/widget/form.dart';

class RegistrasiScreenSatu extends StatefulWidget {
  const RegistrasiScreenSatu({super.key});

  @override
  State<RegistrasiScreenSatu> createState() => _RegistrasiScreenSatuState();
}

class _RegistrasiScreenSatuState extends State<RegistrasiScreenSatu> {
  final namaLengkapController = TextEditingController();
  final noIndukKaryawanController = TextEditingController();
  int? selectedOption = 1;
  String? _selectedWilayah;
  bool isFieldsFilled = false;
  List<DropdownMenuItem<String>> get wilayahRegionalItems {
    List<DropdownMenuItem<String>> wilayahRegional = [
      DropdownMenuItem(child: Text("DPW Sekar Sumatera"), value: "1"),
      DropdownMenuItem(child: Text("DPW Sekar Jakarta 1"), value: "2"),
      DropdownMenuItem(child: Text("DPW Sekar Jakarta 2"), value: "3"),
      DropdownMenuItem(child: Text("DPW Sekar Jawa Barat 1"), value: "4"),
      DropdownMenuItem(child: Text("DPW Sekar Jawa Barat 2"), value: "5"),
      DropdownMenuItem(
          child: Text("DPW Sekar Jawa Tengah dan DIY"), value: "6"),
      DropdownMenuItem(child: Text("DPW Sekar Jawa Timur"), value: "7"),
      DropdownMenuItem(child: Text("DPW Sekar Kalimantan"), value: "8"),
      DropdownMenuItem(
          child: Text("DPW Sekar Kawasan Timur Indonesia"), value: "9"),
    ];
    return wilayahRegional;
  }

  void checkFields() {
    setState(() {
      if (namaLengkapController.text.isNotEmpty &&
          noIndukKaryawanController.text.isNotEmpty &&
          _selectedWilayah != null) {
        isFieldsFilled = true;
      } else {
        isFieldsFilled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget lanjutButton = isFieldsFilled
        ? Container(
            height: 48,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFEE2E24),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RegistrasiScreenDua(
                      namaLengkap: namaLengkapController.text,
                      noIndukKaryawan: noIndukKaryawanController.text,
                      jenisKelamin: selectedOption.toString(),
                      wilayahRegional: _selectedWilayah.toString());
                }));
              },
              child: Center(
                child: NunitoSans.custom(
                  text: 'Lanjut',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: 48,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFD7D7D7),
            ),
            child: Center(
              child: NunitoSans.custom(
                text: 'Lanjut',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8A8A8A),
              ),
            ),
          );

    Widget konten() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Ink(
                      height: 20,
                      width: 20,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFFEE2E24),
                          size: 12,
                        ),
                      ),
                    ),
                    NunitoSans.custom(
                        text: 'Kembali',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFEE2E24))
                  ],
                ),
              ),
              NunitoSans.custom(
                  text: 'Registrasi Akun',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF50504F)),
              SizedBox(height: 8),
              NunitoSans.custom(
                  text: 'Langkah 1 dari 2',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFB5BCC2)),
              SizedBox(height: 28),
              AnotherCustomFormTextField(
                  labelText: 'Nama Lengkap',
                  hintText: 'Masukan Nama Lengkap',
                  controller: namaLengkapController,
                  onChanged: (_) => checkFields()),
              NunitoSans.custom(
                  text: 'Jenis Kelamin',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263238)),
              SizedBox(height: 8),
              Row(
                children: [
                  Radio<int>(
                    fillColor: MaterialStateColor.resolveWith(
                      (states) =>
                          selectedOption == 1 ? Color(0xFFEE2E24) : Colors.grey,
                    ),
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value ?? 0;
                        print("Button value: $value");
                      });
                    },
                  ),
                  NunitoSans.custom(
                      text: 'Laki - Laki',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF50504F)),
                  SizedBox(width: 8),
                  Radio<int>(
                    fillColor: MaterialStateColor.resolveWith(
                      (states) =>
                          selectedOption == 2 ? Color(0xFFEE2E24) : Colors.grey,
                    ),
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value ?? 0;
                        print("Button value: $value");
                      });
                    },
                  ),
                  NunitoSans.custom(
                      text: 'Perempuan',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF50504F)),
                ],
              ),
              SizedBox(height: 22),
              AnotherCustomFormTextField(
                labelText: 'Nomer Induk Karyawan',
                hintText: 'Masukkan Nomor Induk Karyawan',
                controller: noIndukKaryawanController,
                noteText: 'Bila tidak punya bisa diisi dengan “0”',
                onChanged: (_) => checkFields(),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 14),
              NunitoSans.custom(
                  text: 'Wilayah Regional',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263238)),
              DropdownButtonFormField<String>(
                // menuMaxHeight: 160,
                isExpanded: false,
                value: _selectedWilayah,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedWilayah = newValue;
                    checkFields();
                  });
                },
                style: GoogleFonts.nunitoSans(
                  color: Color(0xFF50504F),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                items: wilayahRegionalItems,
                decoration: InputDecoration(
                  hintText: 'Pilih Wilayah Regional',
                  hintStyle: GoogleFonts.nunitoSans(
                    color: Color(0xFFDEE2E6),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFDEE2E6)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFDEE2E6)),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: lanjutButton,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
            ),
            konten(),
          ],
        ),
      ),
    );
  }
}
