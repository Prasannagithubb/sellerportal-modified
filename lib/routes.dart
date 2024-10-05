import 'package:flowkit/helpers/services/auth_service.dart';
import 'package:flowkit/view/apps/calendar/calendar_screen.dart';
import 'package:flowkit/view/apps/chat_screen.dart';
import 'package:flowkit/view/apps/contact/member_list_screen.dart';
import 'package:flowkit/view/apps/contact/profile_screen.dart';
import 'package:flowkit/view/apps/ecommerce/add_product_screen.dart';
import 'package:flowkit/view/apps/ecommerce/product_detail_screen.dart';
import 'package:flowkit/view/apps/ecommerce/products_grid_screen.dart';
import 'package:flowkit/view/apps/ecommerce/review_screen.dart';
import 'package:flowkit/view/apps/file/file_manager_screen.dart';
import 'package:flowkit/view/apps/job/job_detail_screen.dart';
import 'package:flowkit/view/apps/job/job_list_screen.dart';
import 'package:flowkit/view/apps/kanban_board_screen.dart';
import 'package:flowkit/view/apps/pos_screen.dart';
import 'package:flowkit/view/auth/forgot_password_screen.dart';
import 'package:flowkit/view/auth/login_screen.dart';
import 'package:flowkit/view/auth/reset_password_screen.dart';
import 'package:flowkit/view/auth/sign_up_screen.dart';
import 'package:flowkit/view/dashboard/analytics_screen.dart';
import 'package:flowkit/view/dashboard/crm_screen.dart';
import 'package:flowkit/view/dashboard/ecommerce_screen.dart';
import 'package:flowkit/view/dashboard/food_screen.dart';
import 'package:flowkit/view/dashboard/job_screen.dart';
import 'package:flowkit/view/dashboard/nft_screen.dart';
import 'package:flowkit/view/error_pages/coming_soon_screen.dart';
import 'package:flowkit/view/error_pages/error_404_screen.dart';
import 'package:flowkit/view/error_pages/error_500_screen.dart';
import 'package:flowkit/view/extra_pages/faqs_screen.dart';
import 'package:flowkit/view/extra_pages/pricing_screen.dart';
import 'package:flowkit/view/extra_pages/time_line_screen.dart';
import 'package:flowkit/view/forms/basic_input_screen.dart';
import 'package:flowkit/view/forms/custom_option_screen.dart';
import 'package:flowkit/view/forms/editor_screen.dart';
import 'package:flowkit/view/forms/file_upload_screen.dart';
import 'package:flowkit/view/forms/mask_screen.dart';
import 'package:flowkit/view/forms/slider_screen.dart';
import 'package:flowkit/view/forms/validation_screen.dart';
import 'package:flowkit/view/other/basic_table_screen.dart';
import 'package:flowkit/view/other/map_screen.dart';
import 'package:flowkit/view/other/syncfusion_chart_screen.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/screens/itemmaster_screen.dart';
import 'package:flowkit/view/pages/Inventories/itemStocks&Price/screens/itemStocks&Price_screen.dart';
import 'package:flowkit/view/pages/Inventories/offersetup/screens/offer_setup.dart';
import 'package:flowkit/view/pages/presales/customer_data/screens/customer_data.dart';
import 'package:flowkit/view/pages/setups/age_group/screens/age_group_screen.dart';
import 'package:flowkit/view/pages/setups/came_as/screens/came_as.dart';
import 'package:flowkit/view/pages/setups/cancel_api/screens/cancel_reason_screen.dart';
import 'package:flowkit/view/pages/setups/customer_tag/screens/customer_tag_screen.dart';
import 'package:flowkit/view/pages/setups/designations/screens/designations_screens.dart';
import 'package:flowkit/view/pages/setups/enquiry_status/screens/enquiry_status_screen.dart';
import 'package:flowkit/view/pages/setups/enquiry_type/screens/enquiry_type_screen.dart';
import 'package:flowkit/view/pages/setups/feeds/screens/feeds_screen.dart';
import 'package:flowkit/view/pages/setups/followup_mode/screens/followup_mode_screen.dart';
import 'package:flowkit/view/pages/setups/followup_status/screens/followup_status.dart';
import 'package:flowkit/view/pages/setups/followup_type/screens/followup_type_screen.dart';
import 'package:flowkit/view/pages/setups/interest_level/screens/interest_level_screen.dart';
import 'package:flowkit/view/pages/setups/lead_check_list/screens/lead_checklist.dart';
import 'package:flowkit/view/pages/setups/lead_status/screens/lead_status_screen.dart';
import 'package:flowkit/view/pages/setups/mode_of_payment/screens/mode_of_payment.dart';
import 'package:flowkit/view/pages/setups/order_type/screens/order_type_screen.dart';
import 'package:flowkit/view/pages/setups/purpose_type/screens/purpose_type_screen.dart';
import 'package:flowkit/view/pages/setups/referal_type/screens/referal_type_screen.dart';
import 'package:flowkit/view/pages/setups/settle_type/screens/settle_type_screen.dart';
import 'package:flowkit/view/pages/setups/store/screens/store_screen.dart';
import 'package:flowkit/view/pages/setups/trans_type/screens/trans_type_screen.dart';
import 'package:flowkit/view/pages/setups/visit_checklist/screens/visit-checklist_screen.dart';
import 'package:flowkit/view/pages/setups/visit_purpose/screens/visit_purpose_screen.dart';
import 'package:flowkit/view/pages/user_configuration/absense_list/screens/absense_list_screen.dart';
import 'package:flowkit/view/pages/user_configuration/attendance_details/screens/attendance_details_screen.dart';
import 'package:flowkit/view/pages/user_configuration/dashboard_mapping/screens/dashboard_mapping.dart';
import 'package:flowkit/view/pages/user_configuration/logs/screens/logs_screen.dart';
import 'package:flowkit/view/pages/user_configuration/restriction_master/screens/restriction_master_screen.dart';
import 'package:flowkit/view/pages/user_configuration/site_in&Out/screens/site_in&out_screen.dart';
import 'package:flowkit/view/pages/user_configuration/user_authorization/screens/user_athorizationscreen.dart';
import 'package:flowkit/view/pages/user_configuration/user_heirarichy/screens/user_heirarchy_screen.dart';
import 'package:flowkit/view/pages/user_configuration/user_list.dart/screens/user_list_screen.dart';
import 'package:flowkit/view/pages/user_configuration/user_types/screens/usertype_screen.dart';
import 'package:flowkit/view/ui/buttons_screen.dart';
import 'package:flowkit/view/ui/cards_screen.dart';
import 'package:flowkit/view/ui/carousels_screen.dart';
import 'package:flowkit/view/ui/dialogs_screen.dart';
import 'package:flowkit/view/ui/drag_n_drop_screen.dart';
import 'package:flowkit/view/ui/loaders_screen.dart';
import 'package:flowkit/view/ui/modal_screen.dart';
import 'package:flowkit/view/ui/notification_screen.dart';
import 'package:flowkit/view/ui/tabs_screen.dart';
import 'package:flowkit/view/ui/toast_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn ? null : RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  var routes = [
    GetPage(name: '/auth/login', page: () => LoginScreen()),
    GetPage(name: '/auth/forgot_password', page: () => ForgotPasswordScreen()),
    GetPage(name: '/auth/reset_password', page: () => ResetPasswordScreen()),
    GetPage(name: '/auth/register_account', page: () => SignUpScreen()),
    GetPage(
      name: '/',
      page: () => EcommerceScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/dashboard/analytics',
      page: () => AnalyticsScreen(),
      // //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/dashboard/nft_dashboard',
      page: () => NFTScreen(),
      // //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/dashboard/ecommerce',
      page: () => EcommerceScreen(),
      // //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/dashboard/crm',
      page: () => CRMScreen(),
      // //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dashboard/job',
      page: () => JobScreen(),
      // //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dashboard/food',
      page: () => FoodScreen(),
      // //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/toast',
      page: () => ToastMessageScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/buttons',
      page: () => ButtonsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/modal',
      page: () => ModalScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/tabs',
      page: () => TabsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/cards',
      page: () => CardsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/loader',
      page: () => LoadersScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/dialog',
      page: () => DialogsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/carousel',
      page: () => CarouselsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/drag_n_drop',
      page: () => DragNDropScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/widget/notification',
      page: () => NotificationScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/form/basic_input',
      page: () => BasicInputScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/form/custom_option',
      page: () => CustomOptionScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/form/editor',
      page: () => EditorScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/form/file_upload',
      page: () => FileUploadScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/form/slider',
      page: () => SliderScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/form/validation',
      page: () => ValidationScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/form/mask',
      page: () => MaskScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/calendar',
      page: () => CalendarScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/chat',
      page: () => ChatScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/contact/member_list',
      page: () => MemberListScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/contact/profile',
      page: () => ProfileScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/ecommerce/products_grid',
      page: () => ProductsGridScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/ecommerce/add_product',
      page: () => AddProductScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/ecommerce/product_detail',
      page: () => ProductDetailScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/ecommerce/review',
      page: () => ReviewScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/file_manager',
      page: () => FileManagerScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/kanban_board',
      page: () => KanBanBoardScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/pos',
      page: () => PosScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/error/coming_soon',
      page: () => ComingSoonScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/error/500',
      page: () => Error500Screen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/error/404',
      page: () => Error404Screen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/extra/time_line',
      page: () => TimeLineScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/extra/pricing',
      page: () => PricingScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/extra/faqs',
      page: () => FaqsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/other/basic_table',
      page: () => BasicTableScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/other/map',
      page: () => MapScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/other/syncfusion_chart',
      page: () => SyncFusionChartScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/job_list',
      page: () => JobListScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/app/job_detail',
      page: () => JobDetailScreen(),
      //middlewares: [AuthMiddleware()]
    ),

//New Sellerkit Pages

    GetPage(
      name: '/sellerkit/itemMaster',
      page: () => ItemMasterScren(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/itemMaster_StocksPrice',
      page: () => ItemStocksPriceScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/offer_setup',
      page: () => OfferSetupScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/user_list',
      page: () => UserListScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/user_heiirarchy',
      page: () => UserHeirarchy(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/site_in&Out',
      page: () => SiteInOutScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/user_authorization',
      page: () => UserAuthorizationScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/user_types',
      page: () => UserTypeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/attendance_details',
      page: () => AttendanceDetails(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/absense_list',
      page: () => AbsenseList(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/dashboard_mapping',
      page: () => DashboardMapping(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/restriction_master',
      page: () => RestrictionMaster(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/logs',
      page: () => LogsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/customerdata',
      page: () => CustomerData(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/age_group',
      page: () => AgeGroupScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/came_as',
      page: () => CameasScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/cancel_reason',
      page: () => CancelReasonScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/customer_tag',
      page: () => CustomerTagScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/enquiry_type',
      page: () => EnquiryTypeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/referal_type',
      page: () => ReferalTypeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/feeds',
      page: () => FeedsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/followup_mode',
      page: () => FollowUpModeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/enquiry_status',
      page: () => EnquiryStatusScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/visit_checklist',
      page: () => VisitCheckListScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/followup_status',
      page: () => FollowUpStatusScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/trans_type',
      page: () => TransTypeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/mode_of_payment',
      page: () => ModeOfPaymentScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/settle_type',
      page: () => SettleTypeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/interest_level',
      page: () => InterestLevelScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/order_type',
      page: () => OrderTypeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/designations',
      page: () => DesignationScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/followup_type',
      page: () => FollowupTypeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/lead_checklist',
      page: () => LeadCheckLIstScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/lead_status',
      page: () => LeadStatusScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/purpose_type',
      page: () => PurposeTypeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/visit_purpose',
      page: () => VisitPurposeScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/sellerkit/store',
      page: () => StoreScreen(),
      //middlewares: [AuthMiddleware()]
    ),
  ];
  return routes
      .map((e) => GetPage(
          name: e.name,
          page: e.page,
          //middlewares: e.//middlewares,
          transition: Transition.noTransition))
      .toList();
}
