import 'dart:io';

import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appColors.contentContainerBgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: context.appColors.primary),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: context.appColors.primary,
              ),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The background will automatically adjust based on your Theme config
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- PRO CUSTOM SLIVER APP BAR ---
          _buildProProfileAppBar(context),

          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Column(
                children: [
                  // --- Form Sections ---
                  _buildSectionHeader("Personal Details", context),
                  _buildTextField("Name", "Dev Agarwal", context),
                  _buildTextField(
                    "Email Address",
                    "agarwaldev626@gmail.com",
                    context,
                  ),
                  _buildTextField(
                    "Password",
                    "**********",
                    context,
                    isPassword: true,
                  ),

                  Divider(color: context.theme.dividerColor.withOpacity(0.1)),

                  _buildSectionHeader("Business Address Details", context),
                  _buildTextField("Pincode", "", context),
                  _buildTextField("Address", "", context),
                  _buildTextField("City", "", context),
                  _buildTextField("State", "", context),
                  _buildTextField("Country", "", context),

                  Divider(color: context.theme.dividerColor.withOpacity(0.1)),

                  _buildSectionHeader("Bank Account Details", context),
                  _buildTextField("Bank Account Number", "", context),
                  _buildTextField(
                    "Account Holder's Name",
                    "Dev Agarwal",
                    context,
                  ),
                  _buildTextField("IFSC Code", "", context),

                  const SizedBox(height: 30),

                  // --- Save Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.appColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Extra space for bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProProfileAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180.0, // Height for the profile image area
      pinned: true,
      stretch: true,
      backgroundColor: context.appColors.scaffoldBg,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: context.theme.brightness == Brightness.light
              ? const Color(0XFFF2F2F2)
              : const Color(0XFF2A2A2A),
          child: BackButton(color: context.theme.iconTheme.color),
        ),
      ),
      centerTitle: true,
      title: Text(
        "Profile",
        style: TextStyle(
          color: context.theme.textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 80,
            ), // Push it down below the title
            child: _buildProfileAvatar(context),
          ),
        ),
      ),
    );
  }

  // Widget _buildProfileAvatar(BuildContext context) {
  //   return Stack(
  //     alignment: Alignment.center,
  //     children: [
  //       Hero(
  //         tag: 'profile_pic',
  //         child: Container(
  //           padding: const EdgeInsets.all(3),
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             border: Border.all(color: context.appColors.primary, width: 2),
  //           ),
  //           child: const CircleAvatar(
  //             radius: 50,
  //             backgroundImage: AssetImage(MediaResources.profile),
  //           ),
  //         ),
  //       ),
  //       Positioned(
  //         bottom: 0,
  //         right: 0,
  //         child: Container(
  //           padding: const EdgeInsets.all(6),
  //           decoration: BoxDecoration(
  //             color: context.appColors.primary,
  //             shape: BoxShape.circle,
  //             border: Border.all(
  //               color: context.theme.scaffoldBackgroundColor,
  //               width: 3,
  //             ),
  //           ),
  //           child: const Icon(Icons.edit, color: Colors.white, size: 16),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildProfileAvatar(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: 'profile_pic',
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.appColors.primary, width: 2),
            ),
            child: CircleAvatar(
              radius: 50,
              // LOGIC: If _selectedImage is not null, show FileImage, else show Asset
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!) as ImageProvider
                  : const AssetImage(MediaResources.profile),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _showImageSourceSheet, // Trigger the picker
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: context.appColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.theme.scaffoldBackgroundColor,
                  width: 3,
                ),
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  // --- Helper Widgets ---
  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.appColors.primaryTextColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    BuildContext context, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: context.appColors.primaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: hint,
            obscureText: isPassword,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: CustomColors.primaryColor),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              filled: true,
              fillColor: context.appColors.formFieldFillColor,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: context.appColors.primaryTextColor,
              ),
            ),
          ),
          if (isPassword)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Change Password",
                  style: TextStyle(
                    color: CustomColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
