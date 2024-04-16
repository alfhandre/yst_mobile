import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:yayasan_sekar_telkom_apps/model/donor_model.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/main_menu.dart';
import 'package:yayasan_sekar_telkom_apps/service/post_donor_service.dart';
import 'package:yayasan_sekar_telkom_apps/widget/form.dart';
import 'package:flutter/services.dart';
import 'package:yayasan_sekar_telkom_apps/widget/modal.dart';

class FormRelawan extends StatefulWidget {
  const FormRelawan({Key? key}) : super(key: key);

  @override
  State<FormRelawan> createState() => _FormRelawanState();
}

class _FormRelawanState extends State<FormRelawan> {
  final _nameController = TextEditingController();
  final _nomorController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _KTPController = TextEditingController();
  final _karyawanController = TextEditingController();
  final _lainnyaController =
      TextEditingController(); // Controller untuk opsi "Lainya"

  final _formKey = GlobalKey<FormState>();
  String selectedLoker = '';
  bool agreeToTerms = false;
  final FocusNode _lainnyaFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _nomorController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    _KTPController.dispose();
    _karyawanController.dispose();
    _lainnyaController.dispose();
    _lainnyaFocusNode.dispose();

    super.dispose();
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
                CustomFormTextField(
                  labelText: 'Nama Lengkap',
                  hintText: 'Masukkan Nama Anda',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi nama Anda';
                    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Hanya huruf dan spasi yang diperbolehkan';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
                  ],
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
                CustomFormTextField(
                  labelText: 'Email',
                  hintText: 'Masukkan Email Anda',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi alamat email Anda';
                    } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Masukkan alamat email yang valid';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Alamat',
                  hintText: 'Masukkan Alamat anda',
                  controller: _alamatController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi alamat Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loker',
                      style: TextStyle(
                        color: Color(0xFF263238),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildRadioOption('TCUC'),
                    _buildRadioOption('DDB'),
                    _buildRadioOption('Infomedia'),
                    _buildRadioOption('Lainya'),
                    // Menampilkan TextField "Lainya" jika showTextField true
                    // if (selectedLoker == 'Lainya') _buildLainyaTextField(),
                  ],
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Nomor Induk Kependudukan KTP',
                  hintText: 'Masukkan NIK KTP Anda',
                  controller: _KTPController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi NIK KTP Anda';
                    } else if (!RegExp(r'^\d{16}$').hasMatch(value)) {
                      return 'NIK KTP harus terdiri dari 16 digit angka';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Nomor Induk Karyawan',
                  hintText: 'Masukkan NIK Karyawan',
                  controller: _karyawanController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi NIK KTP Anda';
                    }
                    return null;
                  },
                ),
                Text(
                  'Bila tidak memiliki NIK Karyawan, silahkan diisi "0" ',
                  style: GoogleFonts.nunitoSans(
                    color: Color(0xFFDEE2E6),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
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
                        if (selectedLoker.isNotEmpty) {
                          DonorModel donor = DonorModel(
                            domisili: _alamatController.text,
                            namaLengkap: _nameController.text,
                            noHp: int.parse(_nomorController.text),
                            tgldaftar: DateTime.now().toString(),
                            email: _emailController.text,
                            noKtp: int.parse(_KTPController.text),
                            noKaryawan: int.parse(_karyawanController.text),
                            loker: selectedLoker == 'Lainya'
                                ? _lainnyaController.text
                                : selectedLoker,
                            // createdAt: '21222021',
                            // updatedAt: '21222021',
                            // createdBy: '21222021',
                            // updatedBy: '21222021',
                          );

                          bool submissionSuccess =
                              await DonorService().postDonorData(donor);

                          await _showNotificationModal(submissionSuccess);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pilih opsi Loker terlebih dahulu'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Centang Syarat dan Ketentuan terlebih dahulu'),
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (_nameController.text.isNotEmpty &&
                          _nomorController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _alamatController.text.isNotEmpty &&
                          _KTPController.text.isNotEmpty &&
                          _karyawanController.text.isNotEmpty &&
                          selectedLoker.isNotEmpty &&
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

  Widget _buildRadioOption(String text) {
    return Column(
      children: [
        Row(
          children: [
            Radio(
              value: text,
              groupValue: selectedLoker,
              onChanged: (value) {
                setState(() {
                  selectedLoker = value.toString();
                });
              },
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF50504F),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        if (text == 'Lainya' && selectedLoker == 'Lainya')
          _buildLainyaTextField(),
      ],
    );
  }

  Widget _buildLainyaTextField() {
    return TextFormField(
      controller: _lainnyaController,
      focusNode: _lainnyaFocusNode,
      decoration: InputDecoration(
        labelText: 'Lainya',
        hintText: 'Masukkan loker lainnya',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tolong isi loker Lainnya';
        }
        return null;
      },
      onChanged: (value) {
        // Perbarui nilai selectedLoker ketika teks berubah
        // setState(() {
        //   selectedLoker = value;
        // });
      },
    );
  }
}
