import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/paths.dart';

class PrivacyScreen extends StatefulWidget {
  final PattientSettings? settings;
  const PrivacyScreen({super.key, required this.settings});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  //switch value
  late bool notificationsSwitch = false;
  late bool daitySwitch = false;
  late bool testSwitch = false;

  @override
  void initState() {
    super.initState();
    notificationsSwitch = widget.settings!.notifications;
    daitySwitch = widget.settings!.diaryActivated;
    testSwitch = widget.settings!.testActivated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacidad'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () async {
            final UserProvider userProvider = context.read<UserProvider>();
            await userProvider.changePrivacy(
              userProvider.patientModel!.id,
              notificationsSwitch,
              daitySwitch,
              testSwitch,
            );
            if (context.mounted) Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Notificaciones',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Switch(
                  value: notificationsSwitch,
                  onChanged: (value) {
                    setState(() {
                      notificationsSwitch = value;
                    });
                  },
                  activeColor: const Color(0xff2CB5E0),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diario',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Tus notas se compartirán con tu especialista',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Switch(
                  value: daitySwitch,
                  onChanged: (value) {
                    setState(() {
                      daitySwitch = value;
                    });
                  },
                  activeColor: const Color(0xff2CB5E0),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cuestionarios',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Las respuestas de tus cuestionarios se compartirán con tu especialista',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Switch(
                  value: testSwitch,
                  onChanged: (value) {
                    setState(() {
                      testSwitch = value;
                    });
                  },
                  activeColor: const Color(0xff2CB5E0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
