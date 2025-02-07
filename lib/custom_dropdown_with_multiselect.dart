import 'package:flutter/material.dart';

class DropDownWithSearchAndMultiSelect extends StatefulWidget {
  final String selectedFilter;
  final List<String> filterList;
  final Function(dynamic) onChange;

  const DropDownWithSearchAndMultiSelect({
    super.key,
    required this.selectedFilter,
    required this.filterList,
    required this.onChange,
  });

  @override
  State<DropDownWithSearchAndMultiSelect> createState() =>
      _DropDownWithSearchAndMultiSelectState();
}

class _DropDownWithSearchAndMultiSelectState
    extends State<DropDownWithSearchAndMultiSelect> {
  final GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  TextEditingController searchController = TextEditingController();
  List<String> searchList = [];
  List<String> actualList = [];
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    actualList.addAll(widget.filterList);
    searchList = actualList;
    searchController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        PopupMenuButton(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          key: _key,
          enabled: false,
          tooltip: "Search",
          offset: const Offset(0, 39),
          icon: const Icon(
            Icons.more_horiz,
            color: Colors.transparent,
          ),
          onSelected: widget.onChange,
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
                padding: EdgeInsets.zero,
                enabled: false,
                child: StatefulBuilder(builder: (context, setStates) {
                  return IntrinsicHeight(
                    //height: 300,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          minHeight: 70.0, maxHeight: 300.0, maxWidth: 210),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            margin: const EdgeInsets.only(bottom: 10, left: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search_rounded,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: searchController,
                                    onChanged: (val) {
                                      setStates(() {
                                        searchList = actualList
                                            .where((item) => item
                                            .toString()
                                            .toLowerCase()
                                            .contains(val.toLowerCase()))
                                            .toList();
                                      });
                                    },
                                    decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: "Search here...",
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actualList.isEmpty
                              ? const Center(
                            child: Text(
                              "No Match Found",
                            ),
                          )
                              : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                  i < searchList.length;
                                  i++) ...[
                                    InkWell(
                                      onTap: () {
                                        setStates(() {
                                          if (selectedItems
                                              .contains(searchList[i])) {
                                            selectedItems
                                                .remove(searchList[i]);
                                          } else {
                                            selectedItems
                                                .add(searchList[i]);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 10),
                                        color: Colors.white,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                searchList[i].toString(),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            selectedItems.contains(
                                                searchList[i])
                                                ? const Icon(
                                              Icons.done,
                                              color:
                                              Colors.blueAccent,
                                            )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Colors.blueAccent),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    // Closing the popupMenu
                                    Navigator.pop(context);
                                    widget.onChange("");
                                    searchController.text = "";
                                    searchList = actualList;
                                    selectedItems.clear();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    color: Colors.blueAccent,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })),
          ],
        ),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // openCloseDropDown;
            _key.currentState?.showButtonMenu();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.grey.shade300)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.selectedFilter),
                const Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
