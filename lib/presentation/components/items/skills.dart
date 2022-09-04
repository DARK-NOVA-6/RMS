import 'package:flutter/material.dart';

import '../../../domain/usecases/autocomplete/autocomplete_skills.dart';
import '../../../provider/theme.dart';
import '../../controllers/controllers.dart';
import '../components.dart';

class SkillItem extends StatefulWidget {
  const SkillItem({
    Key? key,
    required this.enabled,
    required this.titles,
    required this.index,
    required this.skillsController,
    required this.delete,
  }) : super(key: key);

  final bool enabled;
  final List<String> titles;
  final int index;
  final SkillsControllers skillsController;
  final Function(int) delete;

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  DateTime gDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomeTheme.c2.withAlpha(70),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15).copyWith(right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CustomeAutoComplete(
                controller: widget.skillsController.title,
                autoApi: AutocompleteSkills(),
                label: 'Title',
                enabled: widget.enabled,
                w: widget.enabled ? 0.7 : 0.8,
              ),
            ],
          ),
          if (widget.enabled) ...[
            IconButton(
              padding: const EdgeInsets.only(right: 1, bottom: 2),
              onPressed: () {
                widget.delete(widget.index);
              },
              icon: const Icon(
                Icons.delete,
                size: 40,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
