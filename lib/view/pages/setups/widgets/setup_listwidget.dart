import 'package:flowkit/controller/pages/setup/setup_controller.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/services/pages/setups/setupCommon_getapi.dart';
import 'package:flowkit/view/pages/setups/widgets/setup_addcommonWidget.dart';
import 'package:flowkit/view/pages/setups/widgets/setup_delete_box.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class MyWidget extends StatefulWidget {
  const MyWidget(
      {Key? key,
      required this.controller,
      required this.height,
      required this.width,
      this.filterCodeCallBack,
      this.filterDescriptionCallBack,
      this.filterStatusCallBack});
  final SetUpController controller;
  final double width;
  final double height;
  final Function(String)? filterCodeCallBack;
  final Function(String)? filterDescriptionCallBack;
  final Function(String)? filterStatusCallBack;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _MyWidgetState extends State<MyWidget>
    with TickerProviderStateMixin, UIMixin {
  // ItemMasterController? controller;

  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;

  @override
  void initState() {
    _controllerTop = ScrollController();
    _controllerbottom = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              if (scrollingList == ScrollingList.none) {
                scrollingList = ScrollingList.left;
              }
            } else if (notification is ScrollEndNotification) {
              if (scrollingList == ScrollingList.left) {
                scrollingList = ScrollingList.none;
              }
            }
            if (scrollingList == ScrollingList.left) {
              _controllerbottom.jumpTo(_controllerTop.offset);
            }
            return true;
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _controllerTop,
            child: Row(children: [
              // SizedBox(width: width*0.015,),
              // Change 5 to the number of your columns
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: widget.width * 0.25, // Adjust width as necessary
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: ' ',
                        suffixIcon: Icon(
                          LucideIcons.filter,
                          color: Colors.grey[300],
                        )),
                    onChanged: widget.filterCodeCallBack,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: widget.width * 0.40, // Adjust width as necessary
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: ' ',
                        suffixIcon: Icon(
                          LucideIcons.filter,
                          color: Colors.grey[300],
                        )),
                    onChanged: widget.filterDescriptionCallBack,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: widget.width * 0.10, // Adjust width as necessary
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: ' ',
                        suffixIcon: Icon(
                          LucideIcons.filter,
                          color: Colors.grey[300],
                        )),
                    onChanged: widget.filterStatusCallBack,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: widget.width * 0.10, // Adjust width as necessary
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: ' ',
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ]),
          ),
        ),
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              if (scrollingList == ScrollingList.none) {
                scrollingList = ScrollingList.right;
              }
            } else if (notification is ScrollEndNotification) {
              if (scrollingList == ScrollingList.right) {
                scrollingList = ScrollingList.none;
              }
            }
            if (scrollingList == ScrollingList.right) {
              _controllerTop.jumpTo(_controllerbottom.offset);
            }
            return true;
          },
          child: PaginatedDataTable(
            controller: _controllerbottom,
            source: MyData(
                widget.controller.filterdatalist!.isEmpty
                    ? [
                        SetupsCommonData(
                            code: '',
                            color: 0,
                            createdBy: 0,
                            createdOn: '',
                            description: '',
                            id: 0,
                            mastertypeid: 0,
                            parentMasterId: 0,
                            status: -1,
                            updatedBy: 0,
                            updatedOn: '',
                            nextStatus: 0,
                            isFixed: 1)
                      ]
                    : widget.controller.filterdatalist!,
                widget.controller,
                context),
            columns: [
              DataColumn(
                label: MyText.bodyMedium(
                  '     Code',
                  fontWeight: 600,
                ),
              ),
              DataColumn(
                  label: MyText.bodyMedium(
                'Description',
                fontWeight: 600,
              )),
              DataColumn(
                  label: MyText.bodyMedium(
                '  Status',
                fontWeight: 600,
              )),
              DataColumn(
                  label: MyText.bodyMedium(
                'Action',
                fontWeight: 600,
              )),
            ],
            columnSpacing: 10,
            horizontalMargin: 10,
            rowsPerPage: 10,
          ),
        ),
      ],
    );
  }
}

class MyData extends DataTableSource with UIMixin {
  List<SetupsCommonData> data = [];
  SetUpController cnt;
  BuildContext context;
  MyData(
    this.data,
    this.cnt,
    this.context,
  );

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(SizedBox(
            width: width * 0.25,
            child: MyText.bodySmall('      ${data[index].code.toString()}'))),
        DataCell(SizedBox(
            width: width * 0.42,
            child: MyText.bodySmall(data[index].description!.toString()))),
        DataCell(SizedBox(
            width: width * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: data[index].status == 1
                            ? Colors.green
                            : data[index].status == 0
                                ? Colors.red
                                : Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: data[index].status == 1
                        ? MyText.bodySmall(
                            'Active',
                            color: Colors.white,
                          )
                        : data[index].status == 0
                            ? MyText.bodySmall(
                                'Inactive',
                                color: Colors.white,
                              )
                            : Text('')),
              ],
            ))),
        DataCell(
          data[index].status == -1
              ? Row(
                  children: [
                    SizedBox(),
                  ],
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyContainer.bordered(
                        onTap: () => {
                          if (data[index].isFixed == 1)
                            {
                              Get.dialog(AlertBox(
                                msg:
                                    'This information is static and cannot be modified',
                              ))
                            }
                          else
                            {
                              cnt.clearvalidator(),
                              Get.dialog(Dialog(
                                child: SetupAddCommonScreen(
                                  controller: cnt,
                                  height: height,
                                  width: width / 2,
                                  title: 'Update Visit Purpose',
                                  mastertypeId: data[index].mastertypeid!,
                                  type: 'Update',
                                  id: data[index].id!,
                                  code: data[index].code,
                                  description: data[index].description,
                                  status: data[index].status,
                                ),
                              ))
                            }
                        },
                        padding: MySpacing.xy(6, 6),
                        borderColor: contentTheme.primary.withAlpha(40),
                        child: Icon(
                          LucideIcons.pencil,
                          size: 12,
                          color: contentTheme.primary,
                        ),
                      ),
                      MySpacing.width(width * 0.005),
                      MyContainer.bordered(
                        onTap: () => {
                          if (data[index].isFixed == 1)
                            {
                              Get.dialog(AlertBox(
                                msg:
                                    'This information is static and cannot be delete',
                              ))
                            }
                          else
                            {
                              Get.dialog(SetupDeleteBox(
                                controller: cnt,
                                deletId: data[index].id!,
                                masterid: data[index].mastertypeid!,
                              ))
                            }
                        },
                        padding: MySpacing.xy(6, 6),
                        borderColor: contentTheme.primary.withAlpha(40),
                        child: Icon(
                          LucideIcons.trash_2,
                          size: 12,
                          color: contentTheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
