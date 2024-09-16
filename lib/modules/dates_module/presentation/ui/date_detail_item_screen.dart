import 'package:provider/provider.dart';
import '../../../../helpers/paths.dart';

class DateDetail extends StatefulWidget {
  final int speciaistId;
  final DateModel date;
  const DateDetail({super.key, required this.date, required this.speciaistId});

  @override
  State<DateDetail> createState() => _DateDetailState();
}

class _DateDetailState extends State<DateDetail> {
  bool isloading = false;
  bool aceptedLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(
        title: 'Cita de: ${widget.date.patient!.name}',
        isForReturn: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFE3EDF3),
        ),
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Expanded(
                          child: Text(
                            'Paciente: ${widget.date.patient!.name}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Expanded(
                          child: Text(
                            "Telefono: ${widget.date.patient!.phone}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Expanded(
                          child: Text(
                            "Fecha: ${widget.date.date.day}/${widget.date.date.month}/${widget.date.date.year} ${widget.date.hour}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Expanded(
                          child: Text(
                            "Descripcion: ${widget.date.description}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    aceptedLoading = true;
                  });

                  final bool res = await context
                      .read<PattientsDatesCubit>()
                      .aceptDateBySpecialist(
                          widget.speciaistId, widget.date.id!);

                  if (res && context.mounted) {
                    await context
                        .read<ScheduleCubit>()
                        .getDatesForSpecialist(widget.speciaistId);
                  }

                  setState(() {
                    aceptedLoading = false;
                  });

                  if (context.mounted) Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                ),
                child: aceptedLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Aceptar cita',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isloading = true;
                  });

                  await context
                      .read<PattientsDatesCubit>()
                      .rejectDate(widget.speciaistId, widget.date.id!);

                  setState(() {
                    isloading = false;
                  });

                  if (context.mounted) Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 5,
                ),
                child: isloading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Cancelar cita',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
