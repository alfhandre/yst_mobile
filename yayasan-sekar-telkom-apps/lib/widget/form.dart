import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';

class CustomFormTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  CustomFormTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.nunitoSans(
            color: Color(0xFF263238),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: GoogleFonts.nunitoSans(
            color: Color(0xFF50504F),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.nunitoSans(
              color: Color(0xFFDEE2E6),
              fontWeight: FontWeight.w600,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFDEE2E6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFDEE2E6)),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

class AnotherCustomFormTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? noteText;

  AnotherCustomFormTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.noteText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.nunitoSans(
            color: Color(0xFF263238),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          style: GoogleFonts.nunitoSans(
            color: Color(0xFF50504F),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
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
          validator: validator,
        ),
        Text(
          noteText ?? '',
          style: GoogleFonts.nunitoSans(
            color: Color(0xFFD3D7DB),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class PasswordCustomTextField extends StatefulWidget {
  final Function(String)? onChanged;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? noteText;
  final Widget? icon;
  final bool isPassword;

  PasswordCustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.noteText,
    this.onChanged,
    this.icon,
    this.isPassword = false,
  });

  @override
  State<PasswordCustomTextField> createState() =>
      _PasswordCustomTextFieldState();
}

class _PasswordCustomTextFieldState extends State<PasswordCustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: GoogleFonts.nunitoSans(
            color: Color(0xFF263238),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          onChanged: widget.onChanged,
          controller: widget.controller,
          obscureText: _isObscure,
          style: GoogleFonts.nunitoSans(
            color: Color(0xFF50504F),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xFF9EA0A3),
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              hintText: widget.hintText,
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
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFEE2E24)))),
          validator: widget.validator,
        ),
        Text(
          widget.noteText ?? '',
          style: GoogleFonts.nunitoSans(
            color: Color(0xFFD3D7DB),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// class PasswordCustomTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final TextStyle hintStyle;
//   final Widget? prefixIcon;
//   final EdgeInsetsGeometry contentPadding;
//   final bool isPassword;

//   const PasswordCustomTextField({
//     Key? key,
//     required this.controller,
//     required this.hintText,
//     required this.hintStyle,
//     this.prefixIcon,
//     this.contentPadding =
//         const EdgeInsets.only(left: 15, bottom: 13, top: 13, right: 15),
//     this.isPassword = false,
//   }) : super(key: key);

//   @override
//   Password_CustomTextFieldState createState() =>
//       Password_CustomTextFieldState();
// }

// class Password_CustomTextFieldState extends State<PasswordCustomTextField> {
//   late bool _isObscure;

//   @override
//   void initState() {
//     super.initState();
//     _isObscure = widget.isPassword;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       style: primaryTextStyle.copyWith(fontSize: 16),
//       obscureText: _isObscure,
//       decoration: InputDecoration(
//         hintText: widget.hintText,
//         hintStyle: widget.hintStyle,
//         contentPadding: widget.contentPadding,
//         prefixIcon: widget.prefixIcon,
//         suffixIcon: widget.isPassword
//             ? IconButton(
//                 icon:
//                     Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
//                 onPressed: () {
//                   setState(() {
//                     _isObscure = !_isObscure;
//                   });
//                 },
//               )
//             : null,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(
//             color: primaryColor, // Use the provided color
//           ),
//         ),
//         errorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//           borderSide: BorderSide(color: Colors.red),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }
// }
