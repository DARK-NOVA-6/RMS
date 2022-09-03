import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecases/autocomplete/autocomplete_degrees.dart';
import '../../../domain/usecases/autocomplete/autocomplete_field_edu.dart';
import '../../../domain/usecases/autocomplete/autocomplete_universities.dart';
import '../../../provider/theme.dart';
import '../../controllers/controllers.dart';
import '../components.dart';
import '../custome_auto_complete.dart';

class EduQualificationItem extends StatefulWidget {
  const EduQualificationItem({
    Key? key,
    required this.enabled,
    required this.certificateNames,
    required this.degrees,
    required this.index,
    required this.eduControllers,
    required this.delete,
  }) : super(key: key);

  final bool enabled;
  final List<String> certificateNames;
  final List<String> degrees;
  final int index;
  final EduControllers eduControllers;
  final Function(int) delete;

  @override
  State<EduQualificationItem> createState() => _EduQualificationItemState();
}

class _EduQualificationItemState extends State<EduQualificationItem> {
  DateTime gDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.enabled) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: CustomeTheme.c2.withAlpha(70),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.only(right: 1, bottom: 2),
                  onPressed: () {
                    widget.delete(widget.index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: CustomeTheme.c2.withAlpha(70),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ).copyWith(
              topRight: Radius.circular(widget.enabled ? 0 : 10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              CustomeAutoComplete(
                controller: widget.eduControllers.university,
                autoApi: AutocompleteUniversities(),
                label: 'University',
                enabled: widget.enabled,
                w: 0.8,
              ),
              const SizedBox(height: 10),
              CustomeAutoComplete(
                controller: widget.eduControllers.certificateName,
                autoEduApi: AutocompleteFieldEdu(),
                label: 'Certificate Name',
                enabled: widget.enabled,
                degreeController: widget.eduControllers.degree,
                w: 0.8,
              ),
              const SizedBox(height: 10),
              CustomeAutoComplete(
                controller: widget.eduControllers.degree,
                autoApi: AutocompleteDegrees(),
                label: 'Degree',
                enabled: widget.enabled,
                w: 0.8,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        (widget.enabled ? 0.47 : .8),
                    margin: EdgeInsets.only(right: (widget.enabled ? 10 : 0)),
                    child: RoundedTextField(
                      enabled: false,
                      controller: widget.eduControllers.graduation,
                      color: Theme.of(context).primaryColor,
                      label: 'Graduation',
                    ),
                  ),
                  if (widget.enabled) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: MyElevatedButton(
                        text: 'Pick A Date',
                        press: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2050),
                        ).then(
                          (value) => setState(
                            () {
                              if (value != null && value != gDate) {
                                gDate = value;
                                widget.eduControllers.graduation.text =
                                    DateFormat.yMMMd().format(value);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
