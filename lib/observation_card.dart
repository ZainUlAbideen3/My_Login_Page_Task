import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ObservationCard extends StatefulWidget {
  const ObservationCard({super.key});
  @override
  State<ObservationCard> createState() => _ObservationCardState();
}

class _ObservationCardState extends State<ObservationCard> {
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 500;
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 500;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int crossAxisCount;
    // if (screenWidth <= 640) {
    //   crossAxisCount = 1;
    // } else if (screenWidth > 640 && screenWidth < 875) {
    //   crossAxisCount = 2;
    // } else if (screenWidth >= 875 && screenWidth < 1100) {
    //   crossAxisCount = 3;
    // } else {
    //   crossAxisCount = 4;
    // }

    final int crossAxixCount = screenWidth <= 680
        ? 1
        : screenWidth > 680 && screenWidth < 900
            ? 2
            : screenWidth >= 900 && screenWidth < 1125
                ? 3
                : 4;

    return Scaffold(
      body: SafeArea(
        child: isMobile(context)
            ? Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        MyCardWidget(),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              )
            : Row(children: [
                if (isDesktop(context))
                  Container(
                    color: Colors.blue,
                    width: 200,
                    height: screenHeight,
                    child: Center(
                        child: Text("SideBar\n"
                            "$screenWidth, $screenHeight")),
                  ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: 20,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxixCount,
                        childAspectRatio: 1 / .34,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                    mainAxisExtent: 75),
                    itemBuilder: (context, index) {
                      return const MyCardWidget();
                    },
                  ),
                ),

                // Wrap(
                //   alignment: WrapAlignment.start,
                //   direction:  Axis.vertical,
                //   spacing: 2.h,
                //   runSpacing: 1.w,
                //   children: [
                //     MyCardWidget(),  MyCardWidget(), MyCardWidget(), MyCardWidget(), MyCardWidget(),  MyCardWidget(), MyCardWidget(),  MyCardWidget(), MyCardWidget()
                //   ],
                // ),
              ]),
      ),
    );
  }
}

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.px),
      // width: 280,
      // height: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.2.h), color: Colors.grey),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "THGD-I",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 1.4.w,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "In review",
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  )
                ],
              ),
              const Icon(Icons.more_horiz)
            ],
          ),
          SizedBox(
            height: .5.h,
          ),
          Text(
            "Name form",
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 1.1.h,
                  ),
                  SizedBox(
                    width: 0.6.w,
                  ),
                  Text(
                    "Community Name",
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Text(
                "Edited 01 Jan 2024",
                style: TextStyle(fontSize: 10.sp),
              ),
            ],
          )
        ],
      ),
    );
  }
}
