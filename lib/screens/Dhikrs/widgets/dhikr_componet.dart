import 'package:adhan_app/providers/dkhirs_provider.dart';
import 'package:adhan_app/services/hive_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/pallete.dart';

class DhkirComponent extends ConsumerStatefulWidget {
  String? dhkirText;
  String? dhkirCount;
  bool? isPinned;
  DhkirComponent({super.key, this.dhkirText, this.dhkirCount, this.isPinned});

  @override
  ConsumerState<DhkirComponent> createState() => _DhkirComponentConsumerState();
}

class _DhkirComponentConsumerState extends ConsumerState<DhkirComponent> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      height: height * 0.08,
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Pallete.grayColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                widget.dhkirCount == null ? "0" : widget.dhkirCount!,
                style: TextStyle(
                    color: Pallete.purpleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () async {
                  await HiveAPi.increaseDhkirCounter(widget.dhkirText!);
                  int c = int.parse(widget.dhkirCount!);
                  c++;
                  widget.dhkirCount = c.toString();
                  setState(() {});
                },
                icon: Icon(
                  Icons.add,
                  color: Pallete.purpleColor,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await HiveAPi.resetDhkirCounter();
                  widget.dhkirCount = "0";
                },
                icon: Icon(
                  Icons.settings_backup_restore_outlined,
                  color: Pallete.purpleColor,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await HiveAPi.pinDhkir(widget.dhkirText!);
                  widget.isPinned = !widget.isPinned!;
                  setState(() {});
                },
                icon: Icon(
                  widget.isPinned! ? Icons.push_pin : Icons.push_pin_outlined,
                  color: Pallete.purpleColor,
                ),
              ),
            ],
          ),
          Text(
            widget.dhkirText!,
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
