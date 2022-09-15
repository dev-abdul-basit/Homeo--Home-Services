import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/home_screen/components/provider_home_menu.dart';

import '../../../../../helper/global_config.dart';
import '../../../provider_constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.amber.withOpacity(0.5),
                title: Text(
                  box!.get('status') == 'pending'
                      ? 'Profile Under Review'
                      : 'Profile Verified',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kTextColor,
                      fontSize: 15),
                ),
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: box!.get('status') == 'pending'
                        ? Colors.amber.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: box!.get('status') == 'pending'
                      ? const Icon(
                          Icons.info,
                          color: kTextColor,
                        )
                      : const Icon(
                          Icons.verified,
                          color: Colors.green,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                box!.get('status') == 'pending'
                    ? 'Once the Profile is approved, you will be able to Add Services'
                    : 'Add Your Services',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: kTextColor,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const HomeMenu(),
          ],
        ),
      ),
    );
  }
}
