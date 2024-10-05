// import 'package:flowkit/controller/pages/itemmaster_controller.dart';
// import 'package:flowkit/helpers/theme/app_theme.dart';
// import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
// import 'package:flowkit/helpers/utils/my_shadow.dart';
// import 'package:flowkit/helpers/utils/utils.dart';
// import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
// import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
// import 'package:flowkit/helpers/widgets/my_card.dart';
// import 'package:flowkit/helpers/widgets/my_container.dart';
// import 'package:flowkit/helpers/widgets/my_list_extension.dart';
// import 'package:flowkit/helpers/widgets/my_spacing.dart';
// import 'package:flowkit/helpers/widgets/my_text.dart';
// import 'package:flowkit/services/pages/itemMaster.dart/itemmaster_api.dart';
// import 'package:flowkit/view/layouts/layout.dart';
// import 'package:flowkit/widgets/alertdialog_box.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_lucide/flutter_lucide.dart';

// class ItemMasterTable extends StatefulWidget {
//   const ItemMasterTable({super.key});

//   @override
//   State<ItemMasterTable> createState() => _ItemMasterTableState();
// }

// class _ItemMasterTableState extends State<ItemMasterTable>
//     with SingleTickerProviderStateMixin, UIMixin {
//   late ItemMasterController controller;

//   @override
//   void initState() {
//     controller = ItemMasterController(this);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       child: GetBuilder(
//         init: controller,
//         builder: (controller) {
//           return Column(
//             children: [
//               Padding(
//                 padding: MySpacing.x(flexSpacing),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MyText.titleMedium("Other", fontSize: 18, fontWeight: 600),
//                     MyBreadcrumb(
//                       children: [
//                         MyBreadcrumbItem(name: 'Other'),
//                         MyBreadcrumbItem(name: 'Basic Table', active: true)
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               MySpacing.height(flexSpacing),
//               Padding(
//                 padding: MySpacing.x(flexSpacing),
//                 child: Column(
//                   children: [
//                     PaginatedDataTable(
//                       header: Row(
//                         children: [
//                           MyText.titleMedium("Product List",
//                               fontWeight: 600, fontSize: 20)
//                         ],
//                       ),
//                       arrowHeadColor: contentTheme.primary,
//                       source: controller.data!,
//                       columns: [
//                         DataColumn(
//                             label: MyText.bodyMedium(
//                           'Item Code',
//                           fontWeight: 600,
//                         )),
//                         DataColumn(
//                             label: MyText.bodyMedium(
//                           'Item Name',
//                           fontWeight: 600,
//                         )),
//                         DataColumn(label: MyText.bodyMedium('Brand')),
//                         DataColumn(label: MyText.bodyMedium('Category')),
//                         DataColumn(label: MyText.bodyMedium('Sub Category')),
//                         DataColumn(label: MyText.bodyMedium('Status')),
//                       ],
//                       columnSpacing: 230,
//                       horizontalMargin: 28,
//                       rowsPerPage: 10,
//                     ),
//                     MySpacing.height(12),
//                     buildVisitorByChannel()
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget buildVisitorByChannel() {
//     return MyCard(
//       width: double.infinity,
//       shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
//       borderRadiusAll: 8,
//       paddingAll: 23,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           MyText.titleMedium("Visitors By Channel", fontWeight: 600),
//           MySpacing.height(12),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//                 sortAscending: true,
//                 columnSpacing: 60,
//                 onSelectAll: (_) => {},
//                 headingRowColor:
//                     WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
//                 dataRowMaxHeight: 60,
//                 showBottomBorder: true,
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 border: TableBorder.all(
//                     borderRadius: BorderRadius.circular(8),
//                     style: BorderStyle.solid,
//                     width: .4,
//                     color: Colors.grey),
//                 columns: [
//                   DataColumn(
//                       label: MyText.labelLarge(
//                     'S.No',
//                     color: contentTheme.primary,
//                   )),
//                   DataColumn(
//                       label: MyText.labelLarge(
//                     'Channel',
//                     color: contentTheme.primary,
//                   )),
//                   DataColumn(
//                       label: MyText.labelLarge(
//                     'Session',
//                     color: contentTheme.primary,
//                   )),
//                   DataColumn(
//                       label: MyText.labelLarge(
//                     'Bounce Rate',
//                     color: contentTheme.primary,
//                   )),
//                   DataColumn(
//                       label: MyText.labelLarge(
//                     'Session Duration',
//                     color: contentTheme.primary,
//                   )),
//                   DataColumn(
//                       label: MyText.labelLarge(
//                     'Target Reached',
//                     color: contentTheme.primary,
//                   )),
//                   DataColumn(
//                       label: MyText.labelLarge(
//                     'Page Per Session',
//                     color: contentTheme.primary,
//                   )),
//                   DataColumn(
//                       label: MyText.labelLarge(
//                     'Action',
//                     color: contentTheme.primary,
//                   )),
//                 ],
//                 rows: controller.visitorByChannel
//                     .mapIndexed((index, data) => DataRow(cells: [
//                           DataCell(MyText.bodyMedium('${data.id}')),
//                           DataCell(SizedBox(
//                             width: 250,
//                             child: MyText.labelLarge(
//                               data.channel,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           )),
//                           DataCell(SizedBox(
//                               width: 100,
//                               child: MyText.bodySmall('${data.session}',
//                                   fontWeight: 600))),
//                           DataCell(SizedBox(
//                             width: 100,
//                             child: MyText.bodySmall('${data.bounceRate}%',
//                                 fontWeight: 600),
//                           )),
//                           DataCell(SizedBox(
//                             width: 250,
//                             child: MyText.bodySmall(
//                                 '${Utils.getDateTimeStringFromDateTime(data.sessionDuration)}',
//                                 fontWeight: 600),
//                           )),
//                           DataCell(
//                             MyContainer(
//                               borderRadiusAll: 4,
//                               clipBehavior: Clip.antiAliasWithSaveLayer,
//                               padding: MySpacing.xy(8, 8),
//                               color: contentTheme.primary.withAlpha(32),
//                               child: MyText.bodySmall(
//                                 '${data.targetReached}',
//                                 fontWeight: 600,
//                                 color: contentTheme.primary,
//                               ),
//                             ),
//                           ),
//                           DataCell(SizedBox(
//                               width: 100,
//                               child:
//                                   MyText.bodyMedium('${data.pagePerSession}'))),
//                           DataCell(SizedBox(
//                             width: 130,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 MyContainer(
//                                   onTap: () => {},
//                                   padding: MySpacing.xy(8, 8),
//                                   color: contentTheme.primary.withAlpha(36),
//                                   child: Icon(
//                                     LucideIcons.pencil,
//                                     size: 14,
//                                     color: contentTheme.primary,
//                                   ),
//                                 ),
//                                 MyContainer(
//                                   onTap: () => {},
//                                   padding: MySpacing.xy(8, 8),
//                                   color: contentTheme.success.withAlpha(36),
//                                   child: Icon(
//                                     LucideIcons.pencil,
//                                     size: 14,
//                                     color: contentTheme.success,
//                                   ),
//                                 ),
//                                 MyContainer(
//                                   onTap: () => controller.removeData(index),
//                                   padding: MySpacing.xy(8, 8),
//                                   color: contentTheme.danger.withAlpha(36),
//                                   child: Icon(
//                                     LucideIcons.trash_2,
//                                     size: 14,
//                                     color: contentTheme.danger,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )),
//                         ]))
//                     .toList()),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyData extends DataTableSource with UIMixin {
//   List<ItemMasterNewData> data = [];

//   MyData(this.data);

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => data.length;

//   @override
//   int get selectedRowCount => 0;

//   @override
//   DataRow getRow(int index) {
//     // final  double height=MediaQuery.of(context).size.height;
//     return DataRow(
//       cells: [
//         DataCell(
//             onTap: () {},
//             SizedBox(
//               width: 300,
//               child: MyText.bodySmall(
//                 data[index].itemcode.toString(),
//                 // fontWeight: 600,
//               ),
//             )),
//         DataCell(SizedBox(
//           width: 300,
//           child: MyText.bodySmall(
//             '  ${data[index].itemName!}',
//             // fontWeight: 600,
//           ),
//         )),
//         DataCell(SizedBox(
//             width: 140, child: MyText.bodySmall(data[index].Brand.toString()))),
//         DataCell(SizedBox(
//             width: 140,
//             child: MyText.bodySmall(data[index].Category.toString()))),
//         DataCell(SizedBox(
//             width: 140,
//             child: MyText.bodySmall(data[index].Segment!.toString()))),
//         DataCell(SizedBox(
//             width: 140,
//             child: Row(
//               children: [
//                 Container(
//                     padding: EdgeInsets.all(3),
//                     decoration: BoxDecoration(
//                         color:data[index].status == '1'
//                         ? Colors.green:Colors.red,
//                         borderRadius: BorderRadius.circular(5)),
//                     child: data[index].status == '1'
//                         ? MyText.bodySmall('Active',color: Colors.white,)
//                         : MyText.bodySmall('Deactive',color: Colors.white,)),
//               ],
//             ))),
//         DataCell(
//           Align(
//             alignment: Alignment.center,
//             child: Row(
//               children: [
//                 // MyContainer.bordered(
//                 //   onTap: () => {},
//                 //   padding: MySpacing.xy(6, 6),
//                 //   borderColor: contentTheme.primary.withAlpha(40),
//                 //   child: Icon(
//                 //     LucideIcons.pencil,
//                 //     size: 12,
//                 //     color: contentTheme.primary,
//                 //   ),
//                 // ),
//                 // MySpacing.width(12),
//                 MyContainer.bordered(
//                   onTap: () => {},
//                   padding: MySpacing.xy(6, 6),
//                   borderColor: contentTheme.primary.withAlpha(40),
//                   child: Icon(
//                     LucideIcons.trash_2,
//                     size: 12,
//                     color: contentTheme.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
