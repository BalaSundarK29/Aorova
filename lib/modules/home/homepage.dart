import 'package:bala_task/data/response_model.dart';
import 'package:bala_task/modules/detailspage/detailspage.dart';
import 'package:bala_task/modules/home/home_controller.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final border = const OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(5)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StackOverflow'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSearchTagwidget(controller),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: controller.isLoading
                        ? Center(
                            child: const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator()),
                          )
                        : controller.model == null ||
                                controller.model!.items.isEmpty
                            ? buildErrorWidget()
                            : ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  Item item = controller.model!.items[index];
                                  return buildListItem(
                                      context, controller, item);
                                },
                                separatorBuilder: (context, index) => Container(
                                      height: 5,
                                    ),
                                itemCount: controller.model!.items.length))
              ],
            ),
          );
        },
      ),
    );
  }

  buildErrorWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.signal_cellular_nodata,
            size: 30,
          ),
          Text('No data found!.')
        ],
      ),
    );
  }

  buildSearchTagwidget(HomeController controller) {
    return Row(children: <Widget>[
      Expanded(
        child: TextField(
          controller: controller.searchController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: 'Search',
            border: border,
            errorBorder: border,
            disabledBorder: border,
            focusedBorder: border,
            focusedErrorBorder: border,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.searchController.clear();
              },
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(10))),
          child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                controller.fetchStackData();
              }),
        ),
      )
    ]);
  }

  buildListItem(cntx, HomeController controller, Item item) {
    return InkWell(
      onTap: () => Get.to(DetailsPage(), arguments: [
        {"detailsView": item.link}
      ]),
      child: Card(
        elevation: 5,
        surfaceTintColor: Colors.transparent,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "edited ${formateDate(item.lastEditDate)}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "answer count: ${item.answerCount}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                "score: ${item.score}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildChipWidget(controller, item),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      // width: MediaQuery.of(cntx).size.width * 0.35,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "asked ${formateDate(item.creationDate)}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade500,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: InkWell(
                                    onTap: () =>
                                        Get.to(DetailsPage(), arguments: [
                                      {"detailsView": item.owner.link}
                                    ]),
                                    child: Image.network(
                                      item.owner
                                          .profileImage!, // this image doesn't exist
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey.shade500,
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.error),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.owner.displayName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        item.owner.reputation.toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String formateDate(value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    var formatter = DateFormat('dd-MM-yyyy hh:mm:a');
    String createDate = formatter.format(date);
    return createDate;
  }

  buildChipWidget(HomeController controller, Item item) {
    int index = controller.model!.items.indexOf(item);
    return Expanded(
      flex: 1,
      child: item.tags.isNotEmpty
          ? ChipsChoice<int>.single(
              key: Key(index.toString()),
              value: index == controller.selectedIndex
                  ? controller.selectedTagIndex.value
                  : null,
              padding: EdgeInsets.all(0),
              onChanged: (val) {
                var tagname = item.tags[val];
                controller.selectedIndex = index;
                controller.updateTagDetails(val, tagname);
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: item.tags,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              wrapped: true,
              choiceStyle: C2ChipStyle.filled(
                  foregroundColor: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  selectedStyle: const C2ChipStyle(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      backgroundColor: Colors.teal),
                  color: Colors.blue[800]),
            )
          : Container(),
    );
  }
}
