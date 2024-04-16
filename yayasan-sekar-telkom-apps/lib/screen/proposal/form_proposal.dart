import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:yayasan_sekar_telkom_apps/model/donor_model.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/main_menu.dart';
import 'package:yayasan_sekar_telkom_apps/service/post_donor_service.dart';
import 'package:yayasan_sekar_telkom_apps/widget/form.dart';
import 'package:flutter/services.dart';
import 'package:yayasan_sekar_telkom_apps/widget/modal.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class FormProposal extends StatefulWidget {
  const FormProposal({Key? key}) : super(key: key);

  get onChanged => null;

  @override
  State<FormProposal> createState() => _FormProposalState();
}

class _FormProposalState extends State<FormProposal> {
  final _namaProgramController = TextEditingController();
  final _DanaController = TextEditingController();
  final _penerimaController = TextEditingController();
  final _pjController = TextEditingController();
  final _deskripsiController = TextEditingController();
  File? _imageFile;
  String? _pdfFileName;
  String? _pdfPath;
  File? _pdfFile;
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory;

  @override
  void _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFileName = path.basename(result.files.single.name);
        _pdfPath = result.files.single.path;
        _pdfFile = File(_pdfPath!);
      });
    }
  }

  void dispose() {
    _namaProgramController.dispose();
    _DanaController.dispose();
    _penerimaController.dispose();
    _pjController.dispose();
    _deskripsiController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.red),
        centerTitle: true,
        title: Text(
          'Form Proposal',
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
                  labelText: 'Nama Program',
                  hintText: 'Masukkan Nama Program',
                  controller: _namaProgramController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi nama Program';
                    } else if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                      return 'Hanya huruf dan angka yang diperbolehkan';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z0-9\s]+$'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori Program',
                      style: GoogleFonts.nunitoSans(
                        color: Color(0xFF263238),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(newValue);
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'Category 1',
                          child: Text(
                            'Kategori 1',
                            style: GoogleFonts.nunitoSans(
                              color: Color(0xFF263238),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Category 2',
                          child: Text(
                            'Kategori 2',
                            style: GoogleFonts.nunitoSans(
                              color: Color(0xFF263238),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                      decoration: InputDecoration(
                        hintText: "Pilih Kategori Program",
                        hintStyle: GoogleFonts.nunitoSans(
                          color: Color(0xFF50504F),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(0xFFDEE2E6)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(0xFFDEE2E6)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Kebutuhan Dana (Rp.)',
                  hintText: 'Masukkan Kebutuhan Dana',
                  controller: _DanaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi Kebutuhan Dana';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Penerima',
                  hintText: 'Masukkan Penerima',
                  controller: _penerimaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi Penerima';
                    } else if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                      return 'Hanya huruf dan angka yang diperbolehkan';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z0-9\s]+$'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomFormTextField(
                  labelText: 'Penanggung Jawab',
                  hintText: 'Masukkan Penanggung Jawab',
                  controller: _pjController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Penanggung Jawab';
                    } else if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                      return 'Hanya huruf dan angka yang diperbolehkan';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z0-9\s]+$'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deskripsi Program',
                      style: GoogleFonts.nunitoSans(
                        color: Color(0xFF263238),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _deskripsiController,
                      decoration: InputDecoration(
                        hintText: "Masukkan Deskripsi Program",
                        hintStyle: GoogleFonts.nunitoSans(
                          color: Color(0xFF50504F),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(0xFFDEE2E6)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(0xFFDEE2E6)),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 5,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unggah Gambar',
                      style: GoogleFonts.nunitoSans(
                        color: Color(0xFF263238),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFDEE2E6)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              color: Color(0xFF50504F),
                            ),
                            SizedBox(width: 8),
                            Text(
                              _imageFile != null
                                  ? 'Gambar Dipilih'
                                  : 'Pilih Gambar',
                              style: GoogleFonts.nunitoSans(
                                color: Color(0xFF50504F),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unggah PDF',
                      style: GoogleFonts.nunitoSans(
                        color: Color(0xFF263238),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickPdf,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFDEE2E6)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_file,
                              color: Color(0xFF50504F),
                            ),
                            SizedBox(width: 8),
                            Text(
                              _pdfFileName != null
                                  ? 'PDF Dipilih'
                                  : 'Pilih PDF',
                              style: GoogleFonts.nunitoSans(
                                color: Color(0xFF50504F),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Tombol kirim hanya bisa ditekan jika semua form telah diisi
                      // Tambahkan logika untuk mengirim data ke server dan print data yang diisi
                      print('Nama Program: ${_namaProgramController.text}');
                      print('Kategori Program: $_selectedCategory');
                      print('Kebutuhan Dana: ${_DanaController.text}');
                      print('Penerima: ${_penerimaController.text}');
                      print('Penanggung Jawab: ${_pjController.text}');
                      void _pickImage() async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowedExtensions: ['jpg', 'jpeg', 'png'],
                        );

                        if (result != null) {
                          setState(() {
                            _imageFile = File(result.files.single.path!);
                          });
                        }
                      }

                      print('Deskripsi Program: ${_deskripsiController.text}');
                      if (_imageFile != null) {
                        print('Gambar: ${_imageFile!.path}');
                      }
                      if (_pdfFile != null) {
                        print('PDF: ${_pdfFile!.path}');
                      }

                      // Tampilkan modal notifikasi
                      _showNotificationModal(true);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Form Belum Lengkap'),
                            content: Text(
                                'Harap lengkapi semua form sebelum mengirim.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('Daftar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  // void _pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowedExtensions: ['jpg', 'jpeg', 'png'],
  //   );

  //   if (result != null) {
  //     if (result.files.single.extension == 'jpg' ||
  //         result.files.single.extension == 'jpeg' ||
  //         result.files.single.extension == 'png') {
  //       setState(() {
  //         _imageFile = File(result.files.single.path!);
  //       });
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Format Gambar Tidak Valid'),
  //             content: Text(
  //                 'Format gambar tidak valid. Pilih file JPG, JPEG, atau PNG.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  // }

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
