import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/services/user_service.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DocumentEdit extends StatefulWidget {
  const DocumentEdit({Key? key}) : super(key: key);

  @override
  State<DocumentEdit> createState() => _DocumentEditState();
}

class _DocumentEditState extends State<DocumentEdit> {
  final _documentKey = GlobalKey<FormState>();
  XFile? citizenship;
  XFile? bluebook;
  XFile? license;
  XFile? profileImg;
  String profileUrl = '';
  List documents = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      documents = Provider.of<ProfileProvider>(context, listen: false)
          .getUserData
          .documents;
      profileUrl = Provider.of<ProfileProvider>(context, listen: false)
          .getUserData
          .profileUrl;
    });
  }

  final ImagePicker _imagePicker = ImagePicker();
  final UserService _userService = UserService();

  final cloudinary = Cloudinary.full(
    apiKey: dotenv.env['IMAGE_API_KEY'] ?? '',
    apiSecret: dotenv.env['IMAGE_API_SECRET'] ?? '',
    cloudName: dotenv.env['IMAGE_CLOUD_NAME'] ?? '',
  );

  Widget _handlePreview(String url, String typeText) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Center(
        child: url != '' ? Image.network(url) : Text("Add $typeText Image"),
      ),
    );
  }

  void updateImage({
    bool isProfile = false,
    String url = '',
    String type = '',
    int index = 0,
  }) async {
    XFile? newImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    try {
      Fluttertoast.showToast(
        msg: 'Uploading....',
        backgroundColor: Colors.orange[700],
      );

      final cloudinaryResource = CloudinaryUploadResource(
        filePath: newImage?.path,
        uploadPreset: '',
      );
      CloudinaryResponse response =
          await cloudinary.uploadResource(cloudinaryResource);

      if (response.isSuccessful && response.secureUrl!.isNotEmpty) {
        if (!isProfile) {
          documents[index] = response.secureUrl!;
        } else {
          profileUrl = response.secureUrl!;
        }
        Fluttertoast.showToast(
          msg: 'Upload complete',
          backgroundColor: Colors.green[700],
        );

        await cloudinary.deleteResource(url: url);
      } else {
        Fluttertoast.showToast(
            msg: 'Error uploading', backgroundColor: Colors.red[600]);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), backgroundColor: Colors.red[600]);
    }

    setState(() {
      switch (type) {
        case 'citizen':
          citizenship = newImage;
          break;
        case 'bluebook':
          bluebook = newImage;
          break;
        case 'license':
          license = newImage;
          break;
        case 'profile':
          profileImg = newImage;
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Document'),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (context, profile, value) => SingleChildScrollView(
            child: Form(
              key: _documentKey,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Citizenship',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateImage(
                          url: profile.getUserData.documents[0],
                          type: 'citizen',
                          index: 0,
                        );
                      },
                      child: _handlePreview(
                          profile.getUserData.documents[0], "Citizenship"),
                    ),
                    Center(
                      child: Text(
                        'License',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateImage(
                          url: profile.getUserData.documents[1],
                          type: 'license',
                          index: 1,
                        );
                      },
                      child: _handlePreview(
                          profile.getUserData.documents[1], "License"),
                    ),
                    Center(
                      child: Text(
                        'Bluebook',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateImage(
                          url: profile.getUserData.documents[2],
                          type: 'bluebook',
                          index: 2,
                        );
                      },
                      child: _handlePreview(
                          profile.getUserData.documents[2], "Bluebook"),
                    ),
                    Center(
                      child: Text(
                        'Profile',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateImage(
                          isProfile: true,
                          url: profile.getUserData.profileUrl,
                          type: 'profile',
                        );
                      },
                      child: _handlePreview(
                          profile.getUserData.profileUrl, "Profile Image"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(8.0),
                        ),
                        onPressed: () {
                          if (_documentKey.currentState!.validate()) {
                            _userService.updateDocument(
                              profileUrl: profileUrl,
                              documents: documents,
                              context: context,
                            );
                          }
                        },
                        child: const Text('Edit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
