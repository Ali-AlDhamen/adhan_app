import 'package:adhan_app/providers/dkhirs_provider.dart';
import 'package:adhan_app/screens/Dhikrs/widgets/dhikr_componet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import "dhkirs_list.dart";
import '../../theme/pallete.dart';

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
        // add objects with dhkirs name and 0s
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
    final double height = MediaQuery.of(context).size.height;
    

    return ref.watch(dhkirsProvider).when(data: (data) {

      data.sort((a, b) {
        if (a["isPinned"] == true && b["isPinned"] == false) {
          return -1;
        } else if (a["isPinned"] == false && b["isPinned"] == true) {
          return 1;
        } else {
          return 0;
        }
      });
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
      return Center(
        child: Text(
          error.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(
          color: Pallete.purpleColor,
        ),
      );
    });
  }
}
