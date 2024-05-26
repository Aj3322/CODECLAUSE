import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_update_controller.dart';

class ProfileUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileUpdateController controller = Get.put(ProfileUpdateController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.userModel.value == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: controller.userModel.value!.profilePicUrl != null
                    ? NetworkImage(controller.userModel.value!.profilePicUrl)
                    : null,
                child: controller.userModel.value!.profilePicUrl == null
                    ? Icon(Icons.person, size: 50)
                    : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                 controller.picImage();
                },
                child: Text('Update Profile Picture'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.contactNumberController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.websiteController,
                decoration: InputDecoration(
                  labelText: 'Website',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.birthdateController,
                decoration: InputDecoration(
                  labelText: 'Birthdate (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.genderController,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.updateUserProfile,
                child: Text('Save Changes'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
