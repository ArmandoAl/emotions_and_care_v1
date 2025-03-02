import '../../../../helpers/paths.dart';
import '../logic/patient_request_cubit.dart';

class PatientRequestDetail extends StatefulWidget {
  final int specialistId;
  final PatientRequest patientRequest;
  const PatientRequestDetail(
      {super.key, required this.specialistId, required this.patientRequest});

  @override
  State<PatientRequestDetail> createState() => _PatientRequestDetailState();
}

class _PatientRequestDetailState extends State<PatientRequestDetail> {
  bool isloading = false;
  bool aceptedLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(
        title: "",
        isForReturn: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFE3EDF3),
        ),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Text(
                      widget.patientRequest.patient.name!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "Fecha de solicitud: ***",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                widget.patientRequest.patient.age.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.015,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              //genero
                              const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                widget.patientRequest.patient.sex!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.mail_rounded,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Correo electrónico",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      widget.patientRequest.patient.email!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Teléfono",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      widget.patientRequest.patient.phone!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });

                      await context
                          .read<PatientsRequestCubit>()
                          .rejectPatientRequest(
                            widget.specialistId,
                            widget.patientRequest.patient.id!,
                            widget.patientRequest.id,
                          );

                      setState(() {
                        isloading = false;
                      });

                      if (context.mounted) Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                    ),
                    child: isloading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                          )
                        : Text(
                            'Rechazar',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        aceptedLoading = true;
                      });

                      final bool res = await context
                          .read<PatientsRequestCubit>()
                          .acceptPatientRequest(
                            widget.specialistId,
                            widget.patientRequest.patient.id!,
                            widget.patientRequest.id,
                          );

                      if (res && context.mounted) {
                        await showMessageDialog(
                            context, "", "Paciente aceptado correctamente");

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }

                      setState(() {
                        aceptedLoading = false;
                      });

                      if (context.mounted) Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: aceptedLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : Text(
                            'Aceptar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
