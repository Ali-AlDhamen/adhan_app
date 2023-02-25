import 'package:adhan_app/providers/dkhirs_provider.dart';
import 'package:adhan_app/screens/Dhikrs/widgets/dhikr_componet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../common/helper.dart';
import '../../common/spinkit.dart';
import "dhkirs_list.dart";
import '../../common/error.dart';

class Dhikrs extends ConsumerStatefulWidget {
  const Dhikrs({super.key});

  @override
  ConsumerState<Dhikrs> createState() => _DhikrsConsumerState();
}

class _DhikrsConsumerState extends ConsumerState<Dhikrs> {
  void check() async {
    final box = await Hive.openBox('dhkirs');
    if (box.isEmpty) {
      for (var i = 0; i < dhkirs.length; i++) {
        box.add({'dhkirName': dhkirs[i], 'dhkirCount': 0, 'isPinned': false});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return ref.watch(dhkirsProvider).when(data: (data) {
      Helper.sortDhikrs(data);
      return Center(
        child: SizedBox(
          width: width * 0.9,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return DhkirComponent(
                      dhkirText: data[index]["dhkirName"],
                      dhkirCount: "${data[index]["dhkirCount"]}",
                      isPinned: data[index]["isPinned"],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    }, error: (error, stackTrace) {
      return const Error();
    }, loading: () {
      return const Center(child: spinKit);
    });
  }
}
