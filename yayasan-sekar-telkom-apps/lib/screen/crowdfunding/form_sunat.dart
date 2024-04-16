import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/main_menu.dart';
import 'package:yayasan_sekar_telkom_apps/widget/form.dart';
import 'package:flutter/services.dart';
import 'package:yayasan_sekar_telkom_apps/widget/modal.dart';
import 'package:yayasan_sekar_telkom_apps/service/post_sunat_service.dart';
import 'package:yayasan_sekar_telkom_apps/model/sunat_model.dart';
import 'package:intl/intl.dart';

class FormSunat extends StatefulWidget {
  const FormSunat({Key? key}) : super(key: key);

  @override
  State<FormSunat> createState() => _FormSunatState();
}

class _FormSunatState extends State<FormSunat> {
  final _namaAnakController = TextEditingController();
  final _umurController = TextEditingController();
  final _tempatlahirController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _alamatController = TextEditingController();
  final _sekolahController = TextEditingController();
  final _kelasController = TextEditingController();
  final _penyakitController = TextEditingController();
  final _namaAyahController = TextEditingController();
  final _pekerjaanAyahController = TextEditingController();
  final _namaIbuController = TextEditingController();
  final _pekerjaanIbuController = TextEditingController();
  final _nomorController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool agreeToTerms = false;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Set tanggal default
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900), // Batas awal tanggal
      lastDate: DateTime.now(), // Batas akhir tanggal (hari ini)
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        // Menggunakan DateFormat untuk memformat tanggal sesuai keinginan
        _tanggalLahirController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.red),
        centerTitle: true,
        title: Text(
          'Form Relawan',
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 14,
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Text(
                      'Data Anak',
                      style: GoogleFonts.nunitoSans(
                        color: Color(0xFFB1B1B1),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Divider(
                      color: Color(0xFFB1B1B1),
                      thickness: 1,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                CustomFormTextField(
                  labelText: 'Nama Anak',
                  hintText: 'Masukkan Nama Anak',
                  controller: _namaAnakController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi nama anak';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Hanya huruf yang diperbolehkan';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Tempat Lahir',
                  hintText: 'Masukkan Tempat Lahir Anak',
                  controller: _tempatlahirController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi TTL anak';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Tanggal Lahir",
                    style: GoogleFonts.nunitoSans(
                      color: Color(0xFF263238),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _tanggalLahirController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      hintText: "Pilih Tanggal Lahir",
                      hintStyle: GoogleFonts.nunitoSans(
                        color: Color(0xFFDEE2E6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDEE2E6)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDEE2E6)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tolong pilih tanggal lahir anak';
                      }
                      return null;
                    },
                  ),
                ]),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Umur Anak',
                  hintText: 'Masukkan Umur Anak',
                  controller: _umurController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi form umur dengan valid';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Alamat Lengkap',
                  hintText: 'Masukan alamat lengkap ',
                  controller: _alamatController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi alamat Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Sekolah',
                  hintText: 'Masukan Sekolah anak anda',
                  controller: _sekolahController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi nama sekolah';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Kelas',
                  hintText: 'Masukkan kelas anak anda',
                  controller: _kelasController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi form kelas dengan valid';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Riwayat Penyakit',
                  hintText: 'Masukan Riwayat Penyakit ',
                  controller: _penyakitController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi Riwayat Penyakit anak';
                    }
                    return null;
                  },
                ),
                Text(
                  'Bila tidak memiliki riwayat penyakit, silahkan diisi "Tidak Ada" ',
                  style: GoogleFonts.nunitoSans(
                    color: Color(0xFFDEE2E6),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      'Data OrangTua/Wali',
                      style: GoogleFonts.nunitoSans(
                        color: Color(0xFFB1B1B1),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Divider(
                      color: Color(0xFFB1B1B1),
                      thickness: 1,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                CustomFormTextField(
                  labelText: 'Nama Ayah/Wali',
                  hintText: 'Masukkan Nama Ayah/Wali',
                  controller: _namaAyahController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi nama Ayah/Wali';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Hanya huruf yang diperbolehkan';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Pekerjaan Ayah/Wali',
                  hintText: 'Masukan Pekerjaan Ayah/Wali ',
                  controller: _pekerjaanAyahController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi alamat Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Nama Ibu/Wali',
                  hintText: 'Masukkan Nama Ibu/Wali',
                  controller: _namaIbuController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi nama Ibu/Wali';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Hanya huruf yang diperbolehkan';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Pekerjaan Ibu/Wali',
                  hintText: 'Masukan Pekerjaan Ibu/Wali ',
                  controller: _pekerjaanIbuController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pekerjaan Ibu/Wali';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'No Telepon / WA',
                  hintText: 'Masukkan No Telepon / WA Anda',
                  controller: _nomorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi Nomor Telefon / WA  Anda';
                    } else if (value.length < 10) {
                      return 'Nomor telepon minimal 10 karakter';
                    } else if (value.length > 13) {
                      return 'Nomor telepon maksimal 13 karakter';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                  ],
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: agreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                agreeToTerms = value ?? false;
                              });
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Saya mematuhi ',
                              style: GoogleFonts.nunitoSans(
                                color: Color(0xFF263238),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Syarat dan Ketentuan',
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Card(
                                                    elevation: 5,
                                                    child: Image.asset(
                                                      'assets/snkdonor.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'TUTUP',
                                                  style: GoogleFonts.nunitoSans(
                                                    color: Color(0xFF263238),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: ' yang berlaku',
                                  style: GoogleFonts.nunitoSans(
                                    color: Color(0xFF263238),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (agreeToTerms) {
                        SunatModel sunat = SunatModel(
                          namaAnak: _namaAnakController.text,
                          tempatLahir: _tempatlahirController.text,
                          tanggalLahir: _tanggalLahirController.text,
                          umur: int.parse(_umurController.text),
                          alamat: _alamatController.text,
                          sekolah: _sekolahController.text,
                          kelas: int.parse(_kelasController.text),
                          riwayatPenyakit: _penyakitController.text,
                          namaAyah: _namaAyahController.text,
                          pekerjaanAyah: _pekerjaanAyahController.text,
                          namaIbu: _namaIbuController.text,
                          pekerjaanIbu: _pekerjaanIbuController.text,
                          noHp: _nomorController.text,
                        );

                        // Panggil layanan posting data sunat
                        bool success =
                            await SunatService().postSunatData(sunat);

                        // Tampilkan notifikasi berdasarkan hasil posting
                        await _showNotificationModal(success);
                      } else {
                        // Jika belum menyetujui syarat dan ketentuan
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Anda harus menyetujui syarat dan ketentuan')),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (_namaAnakController.text.isNotEmpty &&
                          _umurController.text.isNotEmpty &&
                          _tempatlahirController.text.isNotEmpty &&
                          _alamatController.text.isNotEmpty &&
                          _sekolahController.text.isNotEmpty &&
                          _kelasController.text.isNotEmpty &&
                          _penyakitController.text.isNotEmpty &&
                          _namaAyahController.text.isNotEmpty &&
                          _pekerjaanAyahController.text.isNotEmpty &&
                          _namaIbuController.text.isNotEmpty &&
                          _pekerjaanIbuController.text.isNotEmpty &&
                          _nomorController.text.isNotEmpty &&
                          agreeToTerms) {
                        return Color(0xFFEE2E24);
                      } else {
                        return Color(0xFFBBBBBB);
                      }
                    }),
                  ),
                  child: Text(
                    'Daftar',
                    style: GoogleFonts.nunitoSans(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showNotificationModal(bool success) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NotificationModal(context: context, success: success);
      },
    );
    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pop();

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenuNavigator()),
      );
    }
  }
}
