import 'dart:convert';
import 'dart:io';

import 'package:msq_translation_editor/msq_translation_editor.dart';

import 'package:dart_eval/dart_eval.dart';

class FileManager{
  static List<File> openLanguageFile({required String directoryPath, required ScriptType type}){
    final dir = Directory(directoryPath);
    final files = dir.listSync();
    List<File> result = [];
    for (final file in files) {
      bool isFile = file.absolute.toString().split(":")[0] == "File";
      if(!isFile) continue;

      final references = Di.languages.map((e) => e.twoLetter).toList();
      bool isLanguageFile = references.contains(getFileName(File(file.path)).replaceAll("_", "-"));
      
      if(!isLanguageFile){
        final shortReferences = references.map((e) => e.split("-").first);
        isLanguageFile = shortReferences.contains(getFileName(File(file.path)));
      }

      final fileExtention = getFileName(File(file.path), withExtention: true).split('.').last;

      bool isSelectedExtention = false;
      if(fileExtention.toLowerCase() == type.name){
        isSelectedExtention = true;
      }

      if(isLanguageFile && isSelectedExtention){
        result.add(File(file.path));
      }
    }
    return result;
  }

  static String getFileName(File file, {bool withExtention = false}){
    String pathSeparator = "/";
    if(Platform.isWindows) pathSeparator = "\\";
    if(withExtention){
      return file.path.split(pathSeparator).last;
    }
    return file.path.split(pathSeparator).last.split(".").first;
  }
  Map<String, Map<String, String>> languages = {};

  static Future<Map<String, Map<String, String>>> getLanguages(List<File> files) async {
    final Map<String, Map<String, String>> lang = {};
    for(final file in files){
      final fileName = getFileName(file, withExtention: true).split(".");
      final jsonString = await file.readAsString();

      dynamic jsonData;
      if(fileName.last.toUpperCase() == "JSON"){
        jsonData = jsonDecode(jsonString);
      }else if(fileName.last.toUpperCase() == "DART"){
        jsonData = jsonDecode(_dartEncode(jsonString, fileName.first));
      }
      if(jsonData is Map<String, dynamic>){
        lang[fileName.first] = jsonData.map((key, value) => MapEntry(key, value.toString()));
      }
    }
    return lang;
  }

  static dynamic _dartEncode(String script, String lang){
    final langKey = lang.replaceAll(RegExp(r'[-_]'), "");
    String? variableName;
    if(script.contains(" _$langKey")){
      variableName = "_$langKey";
    }else if(script.contains(" $langKey")){
      variableName = langKey;
    }

    if(variableName == null) return;

    List<String> lines = script.split('\n');
    List<String> modifiedLines = [];

    for (final line in lines) {
      if (!line.contains("part of ")) {
        modifiedLines.add(line);
      }
    }

    String modifiedScript = modifiedLines.join('\n');
    
    final program = '''
      import 'dart:convert';
      String main() {
        return jsonEncode($variableName);
      }

      $modifiedScript

    ''';

    return eval(program, function: 'main');
  }


  static Future<void> saveFiles(Translation translation) async {
    String separator = "/";
    if(Platform.isWindows) separator = "\\";

    translation.languages.forEach((key, value) async { 
      final output = File("${translation.path}$separator$key.json");
      await output.create();
      await output.writeAsString(_getPrettyJSONString(value));
    });
  }

  static String _getPrettyJSONString(jsonObject){
    var encoder = const JsonEncoder.withIndent("    ");
    return encoder.convert(jsonObject);
  }
}

const String exampleScript = r'''
  part of 'languages.dart';

const Map<String, String> _enUS = {
  'participation_complete_first': 'Want to participate\nin SUPER SAVE?',
  'participation_complete_second': 'Click Join SUPER SAVE below!',
  'join_super_save': 'Join SUPER SAVE',
  'cash_transfer_capture_file_missing':
  'Cash transfer capture file missing.',
  'coin_transfer_capture_file_missing':
  'Coin transfer capture file missing.',
  'total_percentage_cannot_be_more_than_100':
  'Total percentage cannot be more than 100%',
  'new_balance': 'New',
  'previous_balance': 'Previous',
  'apply': 'Apply',
  'discount': 'Discount Percentage',
  'add_payment_method': '⏳ Connect Card',
  'request_id_copied': 'Request ID Copied',
  'request_id': 'Request ID',
  'super_save_ownership_received':
  'You have successfully received SUPER SAVE ownership.',
  'super_save_transfer_success':
  'SUPER SAVE ownership transfer was successful.',
  'enter_valid_email_address': 'Enter valid email address',
  'email_address_cannot_be_empty': 'Email value cannot be empty',
  'transfer_of_ownership_super_save_request':
  'This will transfer ownership of SUPER SAVE request to the new user',
  'new_user_email': 'New user email',
  'un_authorized': 'Unauthorized\nPlease login again',
  'enter_email_address': 'Enter email address',
  'submit': 'Submit',
  'transfer_ownership': 'Transfer Ownership',
  'reason': 'Reason',
  'this_transaction_old_than_card_added':
  'This transaction is older than the card addition.',
  'this_transaction_cash_dispenser_service':
  'This transaction is a cash dispenser service.',
  'this_transaction_was_mined_by_another_user':
  'This transaction was mined by another user.',
  'mining_time_is_not_within_threshold':
  'Mining time is not within the threshold period.',
  'skip': 'Skip',
  'skip_phone': 'Skip',
  'skip_phone_msg':
  'If you skip, your SUPER SAVE registration must be approved in order to get P2U airdrop.',
  'system_problem': 'Problem in some services',
  'code': 'Code',
  'reported': 'Reported',
  'verify': 'Verify',
  'verify_email': 'Verify Email',
  'verify_phone': 'Verify Phone Number',
  'phone': 'Phone Number',
  'email': 'Email',
  'mining_failed': 'Mining Failed',
  'p2u_mining_not': 'P2U mining was not completed!',
  'card_issue':
  'Your @cardName has issues, you must resolve this first to continue mining.',
  'i_read': 'I’ve read and understood',
  'you_are_corporate_member': 'You are a corporate member.',
  'you_are_individual_member': 'You are an individual member.',
  'account_holder_name': 'Account Holder Name',
  'enter_account_holder_name': 'Enter Account Holder Name',
  'person_charge_number': 'Contact Phone Number',
  'enter_name': 'Enter Name',
  'phone_number_must_be_11_digits': 'Phone number must be 11 digits',
  'member_type': 'Membership Type',
  'indv_member': 'Individual Member',
  'corp_member': 'Corporate Member',
  'corp_popup': 'No access to individual transactions.',
  'indv_n_corp_member': 'Individual / Corporate Member',
  'accumulated_by': 'Accumulated by',
  'transaction_draft_tooltip':
  'You will see all information including missed P2U earnings.',
  'mined_by': 'Mined by',
  'mining_denied': 'Mining denied!',
  'missed_threshold_period': 'Mining timing has missed!',
  'company_policy': 'Company Policy',
  'use_inquiry': 'If you have question, please use 1:1 Inquiry menu.',
  'details': 'Details',
  'card_number': 'Card Number',
  'store': 'Store',
  'mining_percentage': 'Mining Percentage',
  'earned_p2u': 'Earned P2U',
  'threshold': 'Threshold',
  'day(s)': 'Day(s)',
  'payment_status': 'Payment Status',
  'mining_threshold': 'Mining Threshold',
  'paid': 'Paid',
  'refund': 'Refund',
  'affiliated': 'Affiliated',
  'not_affiliated': 'Not Affiliated',
  'enable_fingerprint_auth': 'Enable Fingerprint Authentication',
  'finger_auth_enabled':
  'Fingerprint authentication is successfully enabled',
  'finger_auth_fail': 'Fingerprint authentication is cancelled',
  'forgot_pass': 'Forgot Password?',
  'reset_pass_header_text':
  'To reset your password, enter the new password and the OTP sent on your email.',
  'reset_pass_header_text_phone':
  'To reset your password, enter the new password and the OTP sent on your phone.',
  'enter_6_digit_otp': 'Enter 6 digits OTP',
  'reset_password': 'Reset Transaction Password',
  'add_payment_method_error': 'Connect Card',
  'metastar_clients': 'MetaStar Clients',
  'waiting': 'Waiting',
  'complete_buying': 'Complete Buying @token',
  'buy_token': 'Buy @token',
  'sell_token': 'Sell @token',
  'no_p2p_orders': 'No @type orders for @token',
  'p2p_order_conv': '@rate @token per @txToken',
  'complete_p2p_trade': 'Complete P2P Trade',
  'transfer_to_your_accnt': 'will be transferred to your wallet.',
  'select_wallet_to_pay': 'Select wallet to pay',
  'connect_wallet_to_pay': 'Connect wallet to pay',
  'you_will_pay': 'You will pay',
  'with_your_wallet': 'with your wallet',
  'amount_n_fee': '(amount + fee)',
  'promotion_period': 'It is promotion period!',
  'fee_will_not_be_charged': '\nThe fee will not be charged.',
  'you_need_pay': 'You need pay a',
  'a': 'A',
  'service_fee': '@val% service fee',
  'of_amnt_4_tx': '\nof @token amount for the transaction.',
  'will_add_to_amnt': 'will be added to\n@token amount you will pay.',
  'complete': 'Complete',
  'enter_wallet_address_for_p2p_sell':
  'Enter wallet address you want to\n receive @token from:',
  'enter_wallet_address': 'Enter Wallet Address',
  'will_be_charged_from_bal':
  'will be charged\nfrom your @token balance',
  'continue': 'Continue',
  'notification_save': 'Save',
  'tx_already_done': 'Transaction already completed',
  'points': 'Points',
  'location_permission': 'Location Permission',
  'current_location': 'Current Location',
  'no_img_avail': 'No Image Available',
  'location': 'Location',
  'store_near_your_location': 'Stores near your location',
  'stores_in_city': 'Stores in @city',
  'no_stores_found': 'Store Not Found',
  'search_by_address': 'Search by name',
  'select_city': 'Select City/County',
  'city': 'City/County',
  'search_city': 'Search city/county',
  'all_cities': 'All Cities',
  'city_not_found': 'City not found',
  'copied': 'Copied',
  'gps_required': 'GPS Required',
  'no_store_found': 'No store found',
  'gps_msg': 'Please turn on the GPS to search stores near you.',
  'restart_now': 'Restart Now',
  'update_avail': 'New Update Ready',
  'ota_msg':
  'The app has been updated successfully to version @version, please restart to use the new version.',
  'bio_disable_fail': 'Disable Fingerprint Failed',
  'bio_disable_success': 'Disable Fingerprint Success',
  'set_bio_auth': 'Set Fingerprint Authentication',
  'select_wallet': 'Select Wallet',
  'User rejected the transaction': 'You have rejected the transaction.',
  'User rejected methods': 'You have rejected connection request.',
  'tx_req_sent_check_wallet':
  'Transaction request has been sent, please check your wallet.',
  'tx_in_progress': 'Transaction In Progress',
  'wallet_not_exist': 'No such wallet found',
  'super_save_tx': 'Super Save Transaction',
  'search': 'Search',
  'other_wallets': 'Other Wallets...',
  'wallet_connection': '@token Wallet Connection',
  'tx_fail': 'Transaction Failed',
  'tx_success': 'Transaction Success',
  'tx_id_received': 'Transaction ID received.',
  'btn_desc': 'Button Description',
  'resident_registration': 'Resident Registration',
  'foreign_registration': 'Foreign Registration',
  'reg_only_seven_digits': 'Registration must have only 7 digits',
  'plz_select_country_code': 'Please select country code',
  'plz_select_your_country': 'Please select your country',
  'wallet_withdrawal': 'Wallet Withdrawal',
  'wallet_withdrawal_completed': 'Complete @token Wallet Withdrawal',
  'select_wallet_for_tx': 'Select Wallet for Transaction',
  'and': 'and',
  'plz_send_msq_for_credit_sale':
  'Please send@other@and @deposit_token for which you applied for credit sale.',
  'plz_send_deposit_for_credit_sale':
  'Send @num_of_deposit_token @deposit_token which you applied.\nYou will be approved @total_payout_amount @payment_currency.',
  'plz_send_deposit_for_super_save':
  'Send @num_of_deposit_token @deposit_token which you applied.\nYou will be approved @total_payout_amount @payment_currency.',
  'participate_wallet_address': '@token Deposit Address',
  'enter_transmit_txid': 'Enter @token Transaction Hash',
  'no_image_found': 'No image found.',
  'credit_sale_tool_tip':
  'The price depends on the OTC market and can change due to block trading solution.',
  'change': 'Change',
  'go_back': 'Go Back',
  'con_success': 'Connection Success',
  'con_fail': 'Connection Failure',
  'wallet_con_success': 'Wallet Connection Success',
  'wallet_con_req': 'Wallet Connection Request',
  'wallet_con_req_done': 'Wallet Connection Request Already Done',
  'wallet_con_req_received': 'has requested for Wallet Connection',
  'wallet_con_req_warning': 'Please make sure the user is correct.',
  'currency': 'Currency',
  'default': 'default',
  'change_currency': 'Change Currency',
  'change_token': 'Change Token',
  'deposit_wallet': 'Deposit Wallet',
  'plz_provide_reason_txtbox': 'Please provide the reason in text box',
  'new_connected_wallet_added': 'New connected wallet added',
  'wallet_deleted': 'Connected wallet successfully deleted',
  'my_connected_wallets': 'My Connected Wallets',
  'add_connected_wallet': 'Add Connected Wallet',
  'connected_wallet': 'Connected Wallet',
  'delete_wallet': 'Delete Wallet',
  'main_wallet_not_del': 'Main connected wallet cannot be deleted',
  'set_main_wallet': 'Set Main Wallet',
  'main_connected_wallet_changed': 'Main connected wallet changed',
  'pls_reg_a_wallet': 'Please register a wallet.',
  'wallet_type': 'Wallet Type',
  'wallet_id': 'Wallet Address',
  'wallet_balance': 'Wallet Balance',
  'enter_your_wallet': 'Enter Your Wallet',
  'wallet_id_length_check':
  'You must enter a valid USDT (Polygon Network) wallet address.',
  'add_wallet': 'Add Wallet',
  'wrng_wallet_id': 'Incorrect wallet address.',
  'align_area_20': '↖️ Align the card with the box area.',
  'box_19': '↕️ ↔️ Match the area around the box.',
  'hold_on_here': '👀 Hold on here',
  'its_done': "🆗✅ It's done",
  'pic_taken': '✅ Photo Taken',
  'pic_selected': '✅ Photo Selected',
  'invalid_qr_code': 'Invalid QR Code',
  'msq_lock_vol': 'Asset Status',
  'otc_msqx_market_cap': 'MSQ OTC, MSQX Market Cap',
  'description': 'Description',
  's_trust_mem_price':
  'Super Trust Member Price 1@token=@amount @currency',
  'p2u_field_label': 'Credit Sale P2U Quantity',
  'otc_msqx_market_cap_tooltip':
  'OTC Market Capitalization\nMSQ OTC Holding Market Cap + MSQX Holding Market Cap',
  'g_quantity': 'Company Holding Quantity',
  'current_price': 'Current Price',
  'g_market_cap': 'Company Holding Market Cap',
  'otc_market_cap': 'OTC Current Price',
  'otc_market_cap_tooltip': 'OTC Current Price',
  'otc_g_market_cap': 'MSQ, MSQX Market Cap',
  'otc_g_market_cap_tooltip':
  'MSQ Holding Market Cap + MSQX Holding Market Cap',
  'coming_soon': 'Coming Soon',
  'captured_image': 'Captured image',
  'capture_the_image_before': 'Capture the image before',
  'put_the_card_in_the_box': 'Place the card in the box',
  'fail': 'Fail',
  'there_is_image_21': 'There is no id card in the selected image.',
  'transfer_credit': 'Transfer @token',
  'enter_recipient_mail': 'Enter recipient email',
  'enter_your_amount': 'Enter your amount',
  'token_transferred': 'Token Transferred',
  'token_not_transferred': 'Token Not Transferred',
  'alert': 'Alert',
  'please_unfold': 'Please unfold the phone to use camera.',
  'select_photo': 'Select Photo',
  'today': 'Today',
  'won_transfer_title': 'To @bankname\nWe send 1 won',
  'confirm_won_auth_title':
  'Please enter 3 digits of your verification number (exclude MSQ)',
  'verification_number': 'Verification Number',
  'authenticate_with_different_account':
  'Authenticate with a different account',
  'enter_verification_number': '3-digit verification number',
  'supersave_registration_at_add_bank_account':
  'You must have a SUPER SAVE registration to add a bank account.',
  'otp_length_warning': 'Verification number must be 3 digits.',
  '100_million_krw': '+100 Million KRW',
  '100_million_krw_br': '+100 Million KRW',
  '10_million_krw': '+10 Million KRW',
  '10_million_krw_br': '+10 Million KRW',
  '10k_usdt': '+10000 USDT',
  '100k_usdt': '+100000 USDT',
  '100_thousand_krw': '+100,000 KRW',
  '100_thousand_krw_dialog': '+100,000\nKRW',
  '100_thousand_krw_br': '+100,000 KRW',
  '100_thousand_krw_dialog_br': '+100,000\nKRW',
  '1_million_krw': '+1 Million KRW',
  '1_million_krw_br': '+1 Million KRW',
  '1_k_usdt': '+1000 USDT',
  '100_usdt': '+100 USDT',
  '211_88th_seoul_18':
  '917, A-dong, 167, Songpa-daero, Songpa-gu, Seoul',
  'x_days_y_perc': '@x Days (@y%)',
  'Amount': 'Amount',
  'entitlement_amount': 'Right Amount',
  'Buy': 'Buy',
  'Fee': 'Fee',
  'My_Assets': 'My Assets',
  'Price': 'Price',
  'Sell': 'Sell',
  'change_log': 'Changelog',
  'Token': 'Token',
  'monday': 'Monday',
  'tuesday': 'Tuesday',
  'wednesday': 'Wednesday',
  'thursday': 'Thursday',
  'friday': 'Friday',
  'saturday': 'Saturday',
  'sunday': 'Sunday',
  'january': 'January',
  'february': 'February',
  'march': 'March',
  'april': 'April',
  'may': 'May',
  'june': 'June',
  'july': 'July',
  'august': 'August',
  'september': 'September',
  'october': 'October',
  'november': 'November',
  'december': 'December',
  'Tokens': 'Tokens',
  'total_balance_in': 'Total Balance in ',
  'accept': 'Accept',
  'user_canceled': 'User Canceled',
  'sendersut': 'Sender',
  'auto': 'A',
  'manual': 'M',
  'accept_pass_agreement': 'I accept Password loss agreement',
  'account': 'Account',
  'account_balance': 'Account Balance',
  'account_holder': 'Account Holder',
  'account_number': 'Account Number',
  'account_numbers_length_warning':
  'Account Number must be between 11 to 16-digits.',
  'account_registration': 'Account Registration',
  'add_card': 'Add Card',
  'add_card_info': 'Connect card',
  'add_new_platform': 'Add new platform',
  'address': 'Address',
  'agree': 'Agree',
  'agree_to_the_agreement_v001': 'Agree to Agreement v0.0.1',
  'agreement': 'Agreement',
  'agreement_is_required': 'Agreement is required.',
  'airdrop_success': '🎉 100,000 P2U coin added to your wallet.',
  'airdrop_previously_received':
  '🚫 You previously received 100,000 P2U coin.',
  'alien_identity_verification': 'Foreign Identity Verification',
  'amount_in': 'Amount in @token',
  'amount_in_krw': 'Amount in KRW',
  'amount_in_usdt': 'Amount in USDT',
  'amount_in_msq': 'Amount in MSQ',
  'amount_not_swapped': 'You do not have enough MATIC in your wallet',
  'amount_swapped': 'Amount Swapped',
  'and_final_proceedings_11': 'And Final Approval Decision Proceedings',
  'announcement': 'Announcement',
  'add_document': 'Add document',
  'add_family_document': 'Add family relationship document',
  'app_language': 'Language',
  'application_date': 'Application Date',
  'apply_for_super_save': 'Apply for SUPER SAVE',
  'super_trust_tool_tip_content':
  'Super Trust is program that was started to give benefits and perks to our loyal users.',
  'super_trust_tool_tip_label': 'What’s Super Trust?',
  'woohoo': 'Re-invest over 50% has reached 🥳',
  'super_trust_bottom_sheet_content':
  'You have been recognized as a loyal\nmember and we’re happy to give you our\nSuper Trust badge.',
  'apply_for_super_save_helper_service':
  'Apply for SUPER SAVE helper service',
  'approval_date': 'Approval Date',
  'approved': 'Approved',
  'are_you_sure_you_want_to_cancel': 'Are you sure you want to cancel?',
  'participation_cancel_dialog_title':
  'You didn’t complete participation. Are you sure?',
  'super_save_participation_cancel_dialog_title':
  'You didn’t complete participation. Are you sure want to cancel?',
  'complete_later': 'Complete Later',
  'as_monday_1':
  '- As for the payment method for credit sales, the payment for the selected credit sales is paid in daily installments during the payment period, and is paid in '
      'batches after weekly settlement every Monday.',
  'at_the_repayment_12':
  'At the same time as the transaction is completed, the seller (person) incurs receivables (collected in installments for 365 days) on credit payments, and MSQUARE '
      'GLOBAL Co. Ltd understands that debts will arise and clearly recognizes that there are risk factors for non-payment of debts. are doing it is agreed '
      'that the KRW rule is to consult with each other as much as KRW for issues that arise in the process of debt repayment.',
  'attempts_remaining': 'attempts remaining',
  'available_balances': 'Available Balance',
  'available_token': 'Available @token',
  'back_to_home': 'Back to home',
  'back_to_home_page': 'Back to Home Page',
  'balance_certificate': 'Balance Certificate',
  'balance_certificate_img': 'Balance certificate img',
  'balance_check': 'Balance Check',
  'balance_sync': 'P2U Mining',
  'balance_sync_details': 'Balance Sync Details',
  'balance_sync_details_subtitle':
  'Your card history was processed for these dates',
  'balance_sync_info':
  'Scan period from 00:00:00 AM to last mining time.',
  'balance_sync_date': '@start_date to @end_date',
  'balance_sync_last_updated': 'Last: @last_updated',
  'balance_sync_not_processed_yet': 'Not processed yet!',
  'balance_sync_msg':
  "Request queued you will notified when it's completed.",
  'company_card': 'You need to add card company information.',
  'bank': 'Bank Name',
  'bank_account': 'Bank Account',
  'bank_account_deleted': 'Bank Account deleted.',
  'bank_account_not_added': 'Bank Account not added.',
  'bank_account_not_deleted': 'Bank Account not deleted.',
  'bank_account_not_found':
  'Account Number not found. Please check again.',
  'bank_choice': 'Select Bank',
  'bank_transfer_paypal_and_more': 'Bank Transfer, PayPal and more',
  'being_paid': 'Payment In Progress',
  'card_management': 'Card Management',
  'birth_date': 'Birth Date',
  'boarding_screen_tagline_1':
  'Buy any product from our supported stores and Pay with your MSQ Wallet',
  'boarding_screen_tagline_2':
  'Handle all your digital assets simple & easy. Store, Transfer & even Trade.',
  'boarding_screen_tagline_3':
  'With our MFA Auth System stay in control of your transactions and assets management',
  'boarding_screen_tagline_4':
  'Earn points and use them as cashback at our affiliated stores',
  'bug_report': 'Bug Report',
  'bug_report_msg':
  'You can send us your problems or feedback for SUPER SAVE.',
  'bug_report_title': 'Having a problem with SUPER SAVE?',
  'buy_products': 'Buy Products',
  'byungho_choi': 'Byungho Choi',
  'calculation_of_amount_18':
  'Credit Sale Settlement Amount Calculation',
  'calculation_of_amount_18_usdt':
  'Credit Sale Settlement Amount Calculation',
  'calculation_of_amount_tooltip':
  '(USDT Purchase @token + Deposited @token)',
  'calculation_of_payable_21':
  'Credit Sale Daily Equal Payout Calculation',
  'camera_rotation': 'Camera Rotation',
  'cancel': 'Cancel',
  'cancel_ad_creating': 'Cancel Ad Creating?',
  'cancel_participation': 'Cancel',
  'modify': 'Modify',
  'cancellation': 'Cancellation',
  'cancellation_is_complete': 'Cancellation is complete',
  'cannot_be_canceled': 'Cannot be canceled',
  'card_added': 'Your card information is being checked...',
  'card_company': 'Card Company',
  'card_company_cannot_be_empty': 'Card Company cannot be empty',
  'card_not_added': 'Your card could not be added, please try again.',
  'card_password': 'Card Website Login PW',
  'case': 'Case',
  'category': 'Category',
  'change_password': 'Change Transaction Password',
  'characters': 'Characters',
  'charge': 'Charge',
  'bank_fee': 'Bank Fee',
  'check': 'Confirm',
  'check_balance_certificate': 'Check balance certificate',
  'check_super_details_10': 'Check Wallet Transfer Details',
  'check_minimum_Requirements': 'Check Minimum Requirements',
  'children_under_save_2':
  'Children under the age of 14 cannot use SUPER SAVE.',
  'choose_a_lookup_period': 'Choose a lookup period',
  'clear_filters': 'Clear Filters',
  'click_to_picture_7':
  'Click to activate the camera, place your ID card under your face and take a picture.',
  'click_to_picture_8':
  'Push camera button, put ID card beside of your face.',
  'click_to_yourself_5':
  'Click to activate the camera and take a picture yourself.',
  'close': 'Close',
  'coin_price': 'Coin Price',
  'comment': 'Comment',
  'currency_change': 'Change Currency',
  'company_registration_number': 'Company Registration Number',
  'add_p2u_store_photo_invalid': 'Store Photo is required.',
  'add_p2u_company_document_invalid': 'Company Document is required.',
  'add_p2u_store_name_invalid': 'Store Name is required.',
  'add_p2u_store_category_invalid': 'Store Category is required.',
  'add_p2u_store_detail_invalid': 'Store Detail is required.',
  'add_p2u_store_city_invalid': 'City/County is required.',
  'enter_company_registration_number':
  'Enter Company Registration Number',
  'completed': 'Complete',
  'confirm': 'Confirm',
  'country_code': 'Country Code',
  'phone_num': 'Phone Number',
  'usdt_conset_title': 'Consent is required to use the service',
  'participation_usdt':
  '[Required] SUPER SAVE USDT Terms and Conditions',
  'registration_usdt':
  '[Required] Identification Service Terms and Conditions of Agreement',
  'confirm_change_password_1':
  'Confirm your identity to change the password of MSQUARE MARKET wallet.',
  'confirm_change_password_2':
  'After you log in, you can change the password that you use for your transactions.',
  'confirm_new_password': 'Confirm New Password',
  'confirm_pass': 'Confirm Password',
  'confirm_payment': 'Confirm Payment',
  'confirm_traded_19':
  '- Confirm that the above information was normally traded.',
  'confirmation_date': 'Confirmation Date',
  'connect_bank_account_complete_dialog_title':
  'Account registration \nis complete.',
  'connect_bank_account_complete_result_second':
  'The person in charge checks the registered \ninformation within 1 business day, and SUPER SAVE \nis available upon completion of registration.',
  'connect_bank_account_subtitle':
  'Required for payment deposit and capital gains tax settlement.',
  'connect_bank_account_title': 'Please register an account.',
  'connected_platforms': 'Connected Platforms',
  'consent_to_use_of_service': 'Consent to Use of Service',
  'consent_to_use_of_service_v001': 'Consent to Use of Service v0.0.1',
  'contact_us': 'Contact Us',
  'contact_us_error_1': 'Thank you for reaching us out',
  'contact_us_error_2': 'Unable to get your response. Try again',
  'contact_us_error_3': 'Subject value is empty',
  'contact_us_error_4': 'Email value is empty',
  'contact_us_error_5': 'Message value is empty',
  'contact_us_error_6': 'Invalid Email! Try again',
  'contact_us_msg':
  'If you have any queries and problems, please get in touch with us.',
  'contact_us_title': 'How can we help you?',
  'copy': 'Copy',
  'copy_address': 'Copy Address',
  'copy_and_send_referral_code':
  'Copy and send the referral code to a friend and get the extra benefits. Tap to copy or share with your friends.',
  'create': 'Create',
  'create_id': 'Create User ID',
  'create_p2p_ad': 'Create P2P Listing',
  'create_pass': 'Create Wallet Password',
  'create_pass_agreement_label_1':
  'MSQUARE MARKET is a decentralized wallet based on blockchain technology and does not store users password.',
  'create_pass_agreement_label_2':
  'User is responsible for passwords management, passwords cannot be recovered in case of loss, and all digital assets in MSQUARE MARKET wallet will not be '
      'available to access.',
  'create_pass_agreement_label_3':
  'Note: MSQUARE cannot help with the loss of password. Please take a moment and save the password on your notepad.',
  'create_pass_agreement_title':
  'User is responsible for password loss',
  'credit_payment_rate': 'Credit Payment Rate',
  'credit_sale_amount_4':
  '@deposit_token @standardcurrency Conversion Amount',
  'credit_sale_amount_pm': '@token @pm Conversion Amount',
  'credit_sale': 'Credit Sale',
  'credit_sale_application': 'Credit Sale Application',
  'credit_sale_application_modify': 'Credit Sale Application Modify',
  'super_save_application': 'SUPER SAVE Application',
  'super_save_application_modify': 'SUPER SAVE Application Modify',
  'super_save_shared_mesage':
  'My SUPER SAVE referral code is: @code Download MSQUARE MARKET: https://onelink.to/mq2g22',
  'super_save_shared_mesage_fb':
  'My SUPER SAVE referral code is: @code Download MSQUARE MARKET From Playstore/Appstore',
  'c_r_modify_msg': 'You can only change credit sale amount.',
  'c_r_modify_done':
  'Your modification request has\nbeen sent successfully.',
  'c_r_modify_done_title': 'Modify request received.',
  'credit_sale_daily_equal_payment': 'Daily Equal Payment',
  'credit_sale_msq_pairs_quantity': 'Credit Sale @token Pairs Quantity',
  'credit_sale_total_msq_quantity': 'Credit Sale Total @token Quantity',
  'credit_sale_quantity_11': 'Credit Sale @token Quantity',
  'credit_sale_quantity_10': 'Credit Sale @token Quantity',
  'total_credit_sale_amount': 'Total Credit Sale @token Amount',
  'cash_buy_total_amount': 'SUT Purchased by Cash Deposit + SUT Sent Directly',
  'total_credit_sale_amount_cr_s': '(!) Notice',
  'cash_buy_total_amount_cr_s': 'SUT purchased directly after depositing cash to the company',
  'credit_sale_rate_12': 'Credit Sale Payment Period (Payment Rate)',
  'credit_sale_rate_7': 'Payment Period \n(Payment Rate)',
  'credit_sales_method_9': 'Payment Method',
  'credit_sales_payment': 'Settlement Amount',
  'credit_sales_payment_amount': 'Credit Sale Amount',
  'credit_sales_payment_method': 'Credit Sale Payment Method',
  'credit_sell_request_msq_quantity': '@token Quantity',
  'credit_transaction_credit_6':
  'Credit transaction refers to a transaction in which a sales contract is established and the product is delivered, but the price for it is settled '
      'after a certain period of time. it is also called credit transaction or credit transaction. these credit transactions create a loan-to-debt '
      'relationship that pays future debts based on credit.',
  'criteria_during_participation': 'Criteria during participation',
  'cumulative_payment': 'Cumulative Payment',
  'cumulative_payment_1': 'Cumulative payment',
  'current_password': 'Current Password',
  'current_price_1msq': 'Current Price 1@token=@standardamount@mode',
  'otc_current_price_1msq':
  'OTC Current Price 1@token=@standardamount@mode',
  'open_market_price_1msq':
  'Open Market Current Price 1@token=@marketamount@mode',
  'currently_unavailable': 'Currently unavailable.',
  'currency_selection': 'Currency Selection',
  'daily_equal_payment': 'Daily Equal Payment',
  'daily_payment': 'Daily Payout',
  'daily_payout': 'Daily Payout',
  'date_and_time_of_foreign_sale': 'Credit Sale Date',
  'date_and_time_of_payment': 'Completion Date',
  'date_of_birth': 'Date of Birth',
  'date_of_transaction': 'Transaction Date',
  'day': 'Day',
  'deadline': 'Deadline',
  'decline_approval': 'Declined by Company',
  'delete_account': 'Delete Account',
  'delete_store': 'Are you sure you want to delete store?',
  'delete_store_msg': 'Please do not delete for edit information!',
  'delete_card': 'Are you sure you want to Delete Card?',
  'delete_platform': 'Are you sure you want to Delete Platform?',
  'denied': 'Denied',
  'deposit': 'Deposit',
  'deposit_account': 'Deposit Account',
  'device_default': 'Device Default',
  'deposit_complete': 'Deposit Complete',
  'deposit_scheduled': 'Deposit Scheduled',
  'details_of_my_participation_amount': 'My Participation Details',
  'disconnect': 'Disconnect',
  'discounted_products': 'Discounted Products',
  'done': 'Done',
  'email_address': 'Email Address',
  'enter_account_number': 'Enter Account Number',
  'enter_amount': 'Enter Amount',
  'enter_card_password': 'Enter Your Login Password',
  'enter_login_id': 'Enter Your Login ID',
  'enter_message': 'Enter message',
  'enter_numbers_only': 'Entetesr Numbers Only',
  'enter_pass': 'Enter Your MSQUARE MARKET Password',
  'enter_the_transmitted_txid_value': 'Enter Transmitted TXID Value',
  'enter_user_id': 'Enter user ID for your wallet.',
  'error': 'Error',
  'error_404': 'Page Not Found',
  'error_500': 'Internal Server Error',
  'error_500_msg': 'Traffic may high at the moment',
  'error_502': 'Bad Gateway',
  'exit_app': 'Exit App',
  'exit_app_msg': 'Do you want to exit the app?',
  'expected_payment_amount': 'Expected Payment',
  'expiry_': 'Expiry:',
  'education_notice': 'Notice',
  'education_add_photo': 'Add photo',
  'education_credit_Sales': 'Credit Sale Education',
  'education_done': ' Education Done!',
  'education_tooltip_message':
  'Without verified education,\nyou can not proceed with \ncredit sale right.',
  'education_issued_date': 'Issued Date',
  'education_current_period': 'Current Education Period',
  'month_schedule': ' Schedule',
  'education_next_period': 'Next Education Period',
  'education_verify': 'Verify Education',
  'education_waiting_approval': 'Under Review',
  'education_reattach': 'Reattach',
  'education_completed': 'Education Completed',
  'education_denied': 'Denied, Try Again',
  'education_document': 'Please add your photo here.',
  'add_education_document': 'Add education photo',
  'super_save': 'SUPER SAVE',
  'file_upload': 'File Upload',
  'upload': 'Upload',
  'file_uploaded': 'File Uploaded',
  'file_size_warning': 'File size greater than 10MB',
  'file_upload_waiting': 'File is uploading, please wait...',
  'fingerprint_authentication': 'Fingerprint Authentication',
  'fingerprint_failed': 'Fingerprint Authentication Failed',
  'fingerprint_popup':
  'Enter Password to enable fingerprint authentication',
  'fingerprint_text':
  'Use your fingerprint to process payments instead of password.',
  'first_must_be_lower': 'First character must be lowercase',
  'family_relationship_document': 'Family Relationship Document',
  'for_msq_service_15':
  'For MSQ credit transactions, you need to apply for P2P transactions and credit transactions using msq. if you want to entrust all procedures to "helper '
      'service" to prevent accidents such as deception, fraud, and theft that may occur due to your inexperience in the method do. you agree not to ask the company '
      'for any legal responsibility for using the helper service.',
  'for_transfer_28':
  '- For transfers after settlement, a fee is charged per transfer.',
  'foreigner_registration_number': 'Foreigner Registration Number',
  'foreigners_residing_korea_5':
  'Foreigners residing or visiting Korea',
  'from': 'From',
  'no_transaction_of_p2u_mining': 'There are no transaction to mining.',
  'get_involved': 'Continue',
  'go_to_super_save': 'Go to SUPER SAVE',
  'go_to_credit_sale': 'Go to Credit Sale',
  'great': 'Great',
  'having_problems_with_super_save': 'Having problems with SUPER SAVE?',
  'hello': 'Hello',
  'history': 'History',
  'history_list_empty': 'Your History List is Empty!',
  'home': 'Home',
  'hong_gil_dong': 'Hong gil dong',
  'hundred_million': '(100 MM)',
  'i_agree_content_24':
  'I agree to the MSQ credit sale with the requested content.',
  'i_clearly_transaction_11':
  'I clearly understand that SUPER SAVE is an MSQ credit transaction.',
  'i_sure': 'Yes, I am sure',
  'id_verification_verification_3':
  'ID verification is required for identity verification.',
  'idpassport__face_photo': 'ID/Passport + Face Photo',
  'idpassport_photo': 'ID/Passport Photo',
  'if_234_21':
  '- If you forge or falsify this certificate at will, you may be punished according to the Criminal Act (Articles 251 and 234).',
  'if_change_23':
  '- If Monday is a holiday, the amount will be paid on the next business day without change.',
  'if_charged_43':
  '- If you participate in 2 or more SUPER SAVE, only 1 fee will be charged.',
  'if_you_choose_to_cancel':
  'If you choose to cancel, the details you’ve entered will be lost',
  'if_you_photographed_2':
  'If you match your ID card within the area, it will be automatically photographed.',
  'if_you_quotes_10':
  'If you have deposited MSQ to apply for SUPER SAVE participation, but request a return due to a simple change of heart, you will be refunded to MSQ within 10 '
      'days by referring to the exchange price reported and accepted under the special financial transactions act.\n(example) return MSQ = initial application amount '
      '/ exchange MSQ quotes',
  'image_successfully_saved_in_gallery':
  'Image successfully saved in gallery.',
  'image_upload': 'Image Upload',
  'id_photo_upload': 'ID Photo Upload',
  'percent': 'Percent',
  'profile_photo_upload': 'Profile Photo Upload',
  'photo_uploaded': 'Photo uploaded.',
  'document_uploaded': 'Document uploaded.',
  'stores': 'P2U Stores',
  'p2u_store': 'P2U Stores',
  'p2u_stores_title': 'P2U Stores',
  'my_p2u_store': 'My P2U Stores @s@n@e',
  'p2u_store_business_number_txt1': 'Business number is not enough.',
  'registered_p2u_store': 'Registered P2U Stores (@stores)',
  'p2u_store_near': 'Store near you',
  'p2u_store_payment_error':
  'Looks like there was an error while processing your payment, please try again',
  'p2u_find_in_this_area': 'Find In This Area',
  'p2u_quantity': 'P2U Quantity',
  'p2u_krw_conversion_amount': 'P2U KRW Conversion Amount',
  'filters': 'Filters',
  'add_p2u_store': 'Add P2U Store',
  'add_p2u_page_title': 'Register P2U Store',
  'add_p2u_page_title_update': 'Update P2U Store',
  'update_p2u_popup_title': 'P2U Store Registration Duplicate Confirmation',
  'update_p2u_popup_subtitle': 'This company registration number already exists at P2U stores.',
  'p2u_store_verfied': 'This company registration number can be registered.',
  'add_p2u_first_description': 'Please fill in store details.',
  'add_p2u_second_description':
  'The store you added will be visible to all users.',
  'add_p2u_guide': 'P2U Store Registration Guide',
  'add_p2u_store_photo_title': 'Store Photo',
  'add_p2u_store_photo': 'Add Photo',
  'add_p2u_store_photo_uploaded': 'Store Photo Upload',
  'add_p2u_store_document_upload': 'Store Document Upload',
  'add_p2u_company_document_title': 'Company Document',
  'add_p2u_company_document': 'Add Company Document',
  'add_p2u_store_name_title': 'Store Name',
  'add_p2u_store_name': 'Enter Store Name',
  'add_p2u_merchant_code_title': 'Merchant Code',
  'add_p2u_merchant_code': 'Enter Merchant Code',
  'add_p2u_store_category_title': 'Store Category',
  'add_p2u_store_category': 'Select Category',
  'add_p2u_store_detail_title': 'Store Detail',
  'add_p2u_store_detail': 'Enter Store Detail',
  'add_p2u_store_select_city': 'Select City/County',
  'add_p2u_store_city': 'City/County',
  'map_link': 'Naver Search Link',
  'optional': 'Optional',
  'store_web_link': 'Enter Naver Search Link',
  'invalid_map_link': 'Naver Search Link is invalid.',
  'no_store_detail': 'No Details Available',
  'add_p2u_store_address': 'Enter Address',
  'add_p2u_store_address_invalid_message': 'Please select an address from the dropdown.',
  'add_p2u_store_added_successfully':
  'Your P2U Store added successfully.',
  'add_p2u_store_updated_successfully':
  'Your P2U Store updated successfully.',
  'add_p2u_store_store_added': 'You already added P2U store before.',
  'add_p2u_store_submit': 'Register Store',
  'filter_p2u_store_distance_input_label': 'Map Distance',
  'filter_p2u_store_distance_input_label2': 'KM Radius',
  'add_p2u_store_submit_update': 'Update Store',
  'total_store': 'store',
  'all_store': 'All Stores',
  'all_store_in_location': 'Stores in @x KM',
  'all_store_in_city': 'Stores in @city',
  'in': 'In',
  'in_progress': 'In Progress',
  'incorrect_password': 'Incorrect Password',
  'index__1_month': '@index Month',
  'information_on_participation_11':
  'Information on Possible Participation',
  'input_cannot_be_empty': 'Input cannot be empty.',
  'internet_restored': 'Internet Restored',
  'invalid_password': 'Invalid Password',
  'invalid_token_type': 'Invalid Token Type',
  'invoices_to_this_mail': 'Invoices will be sent to this email',
  'it_means_deadline_8':
  'It means that the user will have a receivable for the credit transaction payment, and the MSquare head office will incur a debt, and mutually agree to '
      'complete the payment within the agreed upon payment deadline.',
  'koreans_aged_14_and_over': 'Koreans aged 14 and over',
  'krw': 'KRW',
  'last': 'Last',
  'last_7_digits': 'Last 7 digits',
  'learn_more': 'Learn More',
  'let_go': 'Submit',
  'listing_type': 'Listing Type',
  'login_id': 'Card Website Login ID',
  'logout': 'Logout',
  'logout_msg': 'Going back will logout current',
  'm_square_global_co_ltd': 'SUPER TRUST Co. Ltd',
  'm_square_market': 'MSQUARE MARKET',
  'main_account': 'Main Account',
  'main_account_cannot_deleted': 'Main Account cannot be deleted. Solution: Add alternative account and change main account then delete current account. ',
  'main_bank_account_changed': 'Main Bank Account changed.',
  'main_bank_account_not_changed': 'Main Bank Account not changed.',
  'match_your_photographed_3':
  'Match your face and id to the area\nIt will be automatically photographed.',
  'make_a_payment': 'Make a Payment',
  'max': 'Max',
  'message': 'Message',
  'msq_market_selling_11': 'Credit Sale Amount',
  'msq_price_sale_17': '@token Price',
  'msq_transmission_date': '@token (Sent Date @date)',
  'msq_wallet_address': '@curr Wallet Address',
  'must_include_special': 'Must include special character & number',
  'must_include_upper_lower':
  'Must include uppercase & lowercase letters',
  'mutual_confidentiality_problem_13':
  'Mutual confidentiality regarding this MSQ credit transaction (including details) is the krw rule, and occurs due to violation of '
      'confidentiality, such as an act of informing others or other companies without prior consent, an act of informing an unspecified number of '
      'people such as internet communities, bulletin boards, and sns I agree that the violating party has unlimited legal responsibility in civil and '
      'criminal matters for the problem.',
  'mute_push_notifications': 'Mute Push Notifications',
  'mute_notifications': 'Mute Notifications',
  'my_account': 'My Bank Accounts',
  'my_bank_accounts_note1.':
  'Transactions are executed in the account registered as the main account.',
  'my_contribution': 'My Participation',
  'my_daily_equal_payout': 'My Daily Equal Payout',
  'my_points': 'My P2U Holdings',
  'my_remaining_balance': 'My Remaining Balance',
  'my_wallet': 'My Wallet',
  'mobile_phn_verification': 'Mobile Phone Verification',
  'n_week_of_month': ' Month @w Week',
  'name': 'Name',
  'name_of_bank': 'Bank Name',
  'no_companies': 'No Companies',
  'no_bank_account':
  'You need to add a bank account to complete your Super Save participation',
  'no_usdt_wallet':
  'You need to add a wallet to complete your Super Save participation',
  'national_identity_verification': 'National Identity Verification',
  'nationality': 'Nationality',
  'nationality_selection': 'Select Nationality',
  'nearest': 'Nearest',
  'new_notification': 'New Notifications',
  'new_member_only_can_add_referral':
  'New member only can add referral.',
  'new_password': 'New Password',
  'newest': 'Newest',
  'news': 'News',
  'next': 'Next',
  'no_card':
  '⚠️ There is no card detected in image, do you still want to proceed with this photo?',
  'no_card_added': 'No Card Added',
  'no': 'No',
  'no_file_selected': 'No File Selected',
  'no_internet_connection': 'No Internet Connection',
  'no_news': 'No News',
  'no_permission': 'No Permission',
  'no_permission_permanent':
  'Permission permanently denied, please go to setting and allow it.',
  'no_platform_added': 'No Platform Added',
  'no_record_found': 'No record found.',
  'no_registered_accounts': 'There are no registered accounts.',
  'no_result': 'There are no results.',
  'no_tokens': 'No Tokens',
  'not_enough_balance': 'Insufficient funds',
  'not_enough_msq': 'Not enough MSQ in the wallet',
  'not_enough_msqp': 'Not enough MSQP in the wallet',
  'not_enough_p2up': 'Not enough P2UP in the wallet',
  'not_enough_tokens': 'Not enough @token in the wallet',
  'nothing_to_show': 'Nothing to show',
  'notification_supersave_payout_approved':
  'Your SUPER SAVE payout request has been approved.',
  'notification_supersave_title_approved':
  'Your SUPER SAVE participation request has been approved.',
  'notification_supersave_title_declined':
  'Your SUPER SAVE participation request has been declined.',
  'notifications': 'Notifications',
  'notifications_for_settings': 'Notifications',
  'notification_credit_success':
  'You received new Credit Sale right. Don\'t forget to complete participation.',
  'notification_credit_failed': 'Credit Sale transaction were failed.',
  'notifications_from': 'From',
  'notifications_to': 'To',
  'notifications_sound': 'Notification Sound',
  'notification_setting': 'Notification Settings',
  'notification_super_save': 'Super Save',
  'notification_device_default': 'Device Default',
  'np_cp_not_match': 'New Password and Confirm Password Does Not Match',
  'same_cp_np': 'New Password cannot be the same as Current Password',
  'null_value': 'The value can not be empty',
  'number_of_people': 'Number of people',
  'ok': 'OK',
  'okay': 'Okay',
  'btn_check': 'Check',
  'we_r_sorry': 'We’re sorry!',
  'req_not_fulfil':
  'You do not meet the minimum requirements for SUPER TRUST NFT!',
  'nft_available': 'NFT Benefits Available',
  'nft_not_available': 'NFT Benefits Not Available',
  'nft_benefits_lost': 'NFT Benefits Lost',
  'nft_requirements': 'NFT Requirements',
  'nft_requirements_txt1': 'Minimum Requirements',
  'nft_requirements_txt2':
  'Following are the minimum requirements you need to fulfil to be eligible for Super Trust benefits.',
  'nft_requirements_txt3':
  "Returning participant membership of 50% or more of Super Save's weekly settlement amount.",
  'nft_paused': 'You no longer have SUPER TRUST NFT.',
  'nft_paused_det':
  'You have lost your SUPER TRUST NFT benefits due to not meeting the minimum requirements.',
  'one_two_bank_11011234': 'One two bank 1101******1234',
  'or': 'OR',
  'on': 'On',
  'off': 'Off',
  'order_cannot_be_deleted': 'Order Cannot be Deleted',
  'order_completed': 'Order Completed',
  'order_not_placed': 'Your order cannot be placed. Please try again',
  'order_successfully_deleted': 'Order Successfully Deleted',
  'our_products': 'MSQUARE Platform / SNS',
  'other': 'Other',
  'out': 'Out',
  'p2p_listings': 'My P2P Listings',
  'p2p_listings_empty': 'P2P Listings are empty',
  'p2p_trade': 'P2P Trade',
  'p2p_trading': 'P2P Trading',
  'p2p_trading_msg': 'Trade your digital assets',
  'paid_out': 'Payment Completed',
  'paid_with': 'Paid with',
  'participant_num': 'Total @n Participation',
  'participate_in_super_save': 'SUPER SAVE Participation',
  'participation_complete': 'View Pending / Approved List',
  'applied_lists': 'Applied List',
  'applied_list_empty': 'Your Applied List Is Empty!',
  'pass': 'Password',
  'pass_change_fail': 'Password Not Changed',
  'pass_change_success': 'Password Changed Successfully',
  'pass_limit_reached':
  'Password attempts limit reached. Try again after 5 minutes',
  'pass_not_match': 'Password does not match',
  'pass_verify': 'Password Verification',
  'payment_amount': 'Payment Amount',
  'payment_completed_amount': 'Payment Completed',
  'payment_details': 'Payment Details',
  'get_card_management': 'Get Card Management',
  'payment_mondays_11':
  '- Payment is made in daily installments during the payment period, and is paid weekly on mondays.',
  'payment_status_by_case': 'Payment Status by Case Total @n Cases',
  'permissible_to_sale_2': 'Permissible to apply for foreign sale',
  'phone_number': 'Phone Number',
  'phone_number_1': 'Phone number',
  'place_your_card_5':
  'Place your ID card on the left or right\n of your face and take a picture according to the area. Be careful not to reflect light on your ID card.',
  'platform': 'Platform',
  'please_add_family_relationship_document':
  'Please add your family relationship document here.',
  'please_check_complete_3':
  'Please check carefully as it cannot be modified once the application is complete.',
  'please_check_information_2': 'Please check application information.',
  'please_enter_application_2':
  'Please enter the information required for credit sale application.',
  'please_enter_information_2': 'Please enter applicant information.',
  'please_enter_number_2':
  'Please enter your resident registration number.',
  'please_enter_phone': 'Please enter your mobile phone number.',
  'please_enter_payment_information':
  'Please enter payment information.',
  'please_enter_valid_amount': 'Please enter valid amount',
  'please_enter_6_digit':
  'Please enter a six-digit verification number.',
  'please_note': 'Please Note',
  'please_note_1': 'Please note.',
  'please_note_approval_5':
  'Please note that after applying for SUPER SAVE, approval may be rejected due to circumstances at the head office. super save application (MSQ credit '
      'transaction application) does not guarantee SUPER SAVE approval (MSQ credit transaction approval).',
  'please_prepare_your_id': 'Please prepare your ID.',
  'please_read_agree_2':
  'Please read the information below and enter "agree".',
  'please_read_agree_22':
  'Please read the information below and enter "agree".',
  'please_register_clear_3':
  'Please register after checking that the letters on your ID are clear.',
  'please_register_clear_4':
  'Please register after checking that the letters on your face and ID are clear.',
  'please_send_sale_3':
  'Please send MSQ for which you have applied for credit sale.',
  'please_send_save_3':
  'Please send us any problems or feedback about SUPER SAVE.',
  'please_set_id_4':
  'Please set it within the area so that the light does not reflect on the ID.',
  'pls_create_pass': 'Please create password for transactions.',
  'possibility_to_participate': 'Possibility to Participate',
  'possible_to_participate': 'Possible to Participate',
  'price_integration': 'Price Integration',
  'privacy_policy': 'Privacy Policy',
  'privacy_settings': 'Privacy Settings',
  'open_setting': 'Open Setting',
  'proceed_transaction':
  'Do you want to proceed with this transaction?',
  'proceed_wallet_termination':
  'In order to proceed with wallet termination, Enter the password below',
  'really_sure':
  'Are you sure you want to proceed with the transaction',
  'recipient': 'Recipient',
  'recommended': 'Recommended',
  'refresh': 'Refresh',
  'refresh_balance': 'Refresh balance',
  'refuse': 'Refuse',
  'reserved_cash': '(Reserved Cash)',
  'register_bank_account': 'Register Bank Account',
  'change_bank_account': 'Change Bank Account',
  'change_bank_account_req': 'Change bank account request.',
  'has_pending_req': 'You have already pending change request.',
  'registration': 'Registration',
  'registration_date': 'Registration Date',
  'registration_number_digits_7':
  'Registration number must be 7 digits.',
  'representative_name': 'Representative Name',
  'request_confirmation': 'Registration Complete',
  'request_confirmation_msg': 'Wallet address has been created.',
  'request_for_address_and_balance':
  'has requested for address & balance',
  'request_for_krw_10':
  'Credit Sale @token @standardcurrency Conversion Amount',
  'request_for_krw_3': 'Credit Sale @token @mode Conversion Amount',
  'transfer_krw': 'Send\tto Buy @token',
  'transfer_token': 'Send',
  'transfer_credit_sale_right_title': 'Credit Sale Right Transfer',
  'transfer_credit_sale_right_txt1': 'Transfer to ',
  'transfer_credit_sale_right_txt2':
  ', do you agree transfer credit sale right?',
  'settlement_amount': 'Approved\tAmount',
  'request_for_krw_ss': 'Credit Sale Participation Amount',
  'request_for_krw_cs': 'Credit Sale Right',
  'won_cs': ' KRW',
  'referral': 'Referral',
  'referral_code_social': 'Referral Code',
  'requested_by': 'Requested by',
  'requested_help': 'Help Requested',
  'guide_title_1': 'SUPER SAVE Credit Commerce Briefing Session',
  'guide_line_1_1':
  'Location\t167, Songpa-daero, Songpa-gu, Seoul, Korea\nRoom 1303, Building A, Terra Tower, Munjeong Station',
  'guide_line_1_2':
  'Schedule\tAs it is held every other week, please check the detailed information session schedule.\nPlease contact customer service.',
  'guide_line_1_3': 'Course Duration\t2-3 hours',
  'guide_title_2': 'MSQUARE Community\nNational Office',
  'guide_line_2_1':
  '일산\t1st floor, 1765 Jungang-ro, Seo-gu, Ilsan, Goyang-si\n010-7987-5995',
  'guide_line_2_2':
  '광진구\t#314, Hangang Park Building, 7 Neungdong-ro, Gwangjin-gu, Seoul\n010-4965-3910',
  'guide_line_2_3':
  '시흥\t#118, Building C, Megapolis, 281 Hyeop-ro, Siheung-si\n010-3731-7553',
  'guide_line_2_4':
  '당진\tRoom 201, Venture Week, 531-4 Eupnae-dong, Dangjin-si, Chungcheongnam-do\n010-8567-8084',
  'guide_line_2_5':
  '대전\t#204, Sufelis, 26 Tanbang-ro, Seo-gu, Daejeon\n010-2825-8652',
  'guide_line_2_6':
  '광주\t#413, 89 Sangmupyeonghwa-ro, Seo-gu, Gwangju\n010-3104-2468',
  'guide_line_2_7':
  '속초\tCentum Park, 28, Jungang-ro 121beon-gil, Sokcho-si\nLotte Cinema Room 134\n010-7621-5856',
  'guide_line_2_8':
  '수원\tAce Smart, 253 Samsung-ro, Yeongtong-gu, Suwon-si\nYeongtong Knowledge Industry Center Room 914\n010-6654-8523',
  'guide_line_2_9':
  '용인\t341 Dongbaekjukjeon-daero, Giheung-gu, Yongin-si\nDongbaek Medicine Tower B104\n010-4013-0984',
  'guide_line_2_10':
  '포항\tRoom 402, Deukryang Building, 69 Idong-ro, Buk-gu, Pohang\n010-3500-8551',
  'guide_line_2_11':
  '부산\t137 Dongseong-ro, Jin-gu, Busan\n서면동원오피스텔 1202호\n010-2780-8699',
  'guide_line_2_12':
  '창원\tHyundai, 161-1 Sarim-dong, Uichang-gu, Changwon-si\nRoom 203, Building F, Sun & Builders Square\n010-3747-1747/ 070-8657-4717',
  'guide_line_2_13':
  '광양\t2F, 61, Guma-gil, Gwangyang-si, Jeonnam\n010-3993-2667',
  'guide_line_2_14':
  '세종\tRoom 805, NS Tower, 792, Naseong-dong, Sejong-si, Sejong\n010-6425-8819',
  'guide_line_2_15':
  '진주\t1104, Wingtower B, 69-3, Chungmu-gong, Jinju-si, Korea\n010-9301-0803',
  'guide_line_2_16':
  '사천\t50-53, Oksan-ro, Jeongdong-myeon, Sacheon-si, Sacheon-do 2F, Maehwa-vil\n010-3780-8215',
  'guide_title_3': 'SUPER SAVE Application Process',
  'home_ban_title': "World's First",
  'home_ban_subtitle':
  'Blockchain Real Economy-Based Coin\nForeign Exchange Platform',
  'requested_msq_minutes_7': 'Requested SUT Within 10 Minutes',
  'reserve_reserve_consumption_rate': 'Reserve Consumption Rate',
  'reserves': 'Reserves',
  'resend': 'Resend',
  'reset': 'Reset',
  'resident_registration_number': 'Resident Registration Number',
  'resolve_errors': 'Please resolve the errors.',
  'retry': 'Retry',
  'Register_a_supersave_transaction':
  'Register a SUPER SAVE transaction',
  'save_transaction_confirmation': 'Save Transaction Confirmation',
  'scan_finger': 'Scan finger to continue',
  'scan_finger_to_connect':
  'Scan your fingerprint to confirm transaction',
  'scan_qr_code': 'Scan QR Code',
  'secure_layer': 'Secure Layer',
  'see_details': 'See details',
  'see_more': 'See more',
  'see_exam': 'See Example',
  'review': 'Review',
  'add_cash_transfer': 'Add cash transfer screenshot',
  'add_coin_transfer': 'Add coin transfer screenshot',
  'add_more': '+ Add more',
  'cash_trans_sample': 'Cash Transfer Sample',
  'coin_trans_sample': 'Coin Transfer Sample',
  'recommend_to': 'Credit Sales',
  'recommend_to_be': 'People You Introduced',
  'apply_ss': 'SUPER SAVE Application',
  'apply_credit_sale': 'Credit Sale Application',
  'super_save_user': 'SUPER SAVE User',
  'credit_sale_user': 'Credit Sale User',
  'application_type': 'Application Type',
  'review_attachment': 'Review Attachment',
  'txid_error': 'This is a TXID that has already been registered.',
  'err_trans_cap': 'Please attach both transfer screenshot.',
  'err_txid': 'Please validate your TXID.',
  'tx_id_fine': 'This TXID is usable.',
  'unable_to_upload': 'Unable to upload screenshot.',
  'select_an_accounts_13': 'Deposit Bank Account',
  'select_bank': 'Select Bank',
  'select_identity_verification_type':
  'Select identity verification type',
  'select_your_card': 'Select Your Card',
  'send': 'Send',
  'sender': 'Sender',
  'sensitive_information_act_3':
  'Sensitive information is encrypted and safely protected in accordance with the personal information protection act.',
  'sent_date': '(Sent Date @date)',
  'sent_successfully': 'Sent successfully.',
  'service_withdrawal': 'Withdrawal From Service',
  'service_withdrawal_apply': 'Apply for Withdrawal',
  'service_withdrawal_complete_dialog_title':
  'Your withdrawal request is complete,\nYou will be logged out.',
  'service_withdrawal_deposit_into_account':
  'The remaining balance will be deposited into your registered account.',
  'service_withdrawal_input_hint': 'Enter Reason',
  'service_withdrawal_irreversible':
  'The application for withdrawal cannot be withdrawn, so please make your decision carefully.',
  'service_withdrawal_reason_1': "Don't want to using the app anymore",
  'service_withdrawal_reason_2': 'Inconvenient to use due to errors',
  'service_withdrawal_reason_3': 'App is difficult to use',
  'service_withdrawal_reason_4': 'Others, Please input',
  'service_withdrawal_reason_title':
  'Please enter reason why you leaving us.',
  'service_withdrawal_rules_1':
  'If you cancel the service, all personal information will be destroyed.',
  'service_withdrawal_rules_2':
  'Other compulsory storage information is stored separately and destroyed for a certain period of time in accordance with relevant laws and regulations.',
  'service_withdrawal_rules_3':
  'Upon re-registration, member information and account information are not automatically restored.',
  'service_withdrawal_rules_4a':
  'Request for withdrawal is processed within 24 hours on business days,',
  'service_withdrawal_rules_4b':
  'and re-registration is not possible within 6 months after withdrawal.',
  'service_withdrawal_rules_5a':
  'When applying for membership withdrawal,',
  'service_withdrawal_rules_5b': 'you will be logged out,',
  'service_withdrawal_rules_5c': 'and you will be unable to log in',
  'service_withdrawal_rules_5d': 'and use all services.',
  'service_withdrawal_rules_title': 'Please check before you leave us',
  'set_as_main_account': 'Set as Main Account',
  'settings': 'Settings',
  'sound': 'Sound',
  'super_save_approval_rejection': 'Super Save Approval/Rejection',
  'super_save_daily_payouts': 'Super Save Daily Payouts',
  'p2u_auto_mining_results': 'P2U Auto Mining Results',
  'date': 'Date',
  'date_': 'Date:',
  'settlement_date': 'Settlement Date',
  'settlement_date_1': '(Settlement Date)',
  'shall_we_on_2': 'Shall I participate in SUPER SAVE from now on?',
  'shall_we_sale_20':
  'Shall I participate in SUPER SAVE from now on?\nYou can participate within 10 minutes \nafter applying for credit sale.',
  'shooting_number': 'Shooting @number',
  'six_digit': '6 digit number',
  'sign_in_with': 'Sign with',
  'sign_in_with_apple': 'Sign with Apple',
  'sign_in_with_facebook': 'Sign with Facebook',
  'sign_in_with_google': 'Sign with Google',
  'sort_by': 'Sort by',
  'subject': 'Subject',
  'success': 'Success',
  'sorry': 'Sorry',
  'successful': 'Successful',
  'super_save_act_9':
  'SUPER SAVE is not a financial product that can be protected by the capital markets act or the financial consumer protection act.',
  'super_save_charge_1':
  'SUPER SAVE can be used after confirmation from the person in charge.',
  'super_save_charge_13':
  'SUPER SAVE can be used after confirmation from the person in charge.',
  'super_save_corpo_reg_title': 'Corporate Registration',
  'super_save_corpo_business_license_header': 'Business Registration',
  'super_save_corpo_business_license_subtitle':
  'Please register your business registration number and certificate.',
  'ss_corp_acc_change':
  'Please enter bank account details to change bank account.',
  'super_save_corpo_name': 'Company Name',
  'super_save_corpo_name_hint': 'Enter Company Name',
  'super_save_corpo_business_license_number':
  'Business Registration Number',
  'super_save_corpo_business_license_number_hint': 'Enter Numbers Only',
  'super_save_corpo_business_license_cert':
  'Business Registration Certificate',
  'super_save_corpo_business_license_cert_hint': 'Select a file',
  'super_save_corpo_account_header':
  'Please register a corporate account.',
  'super_save_corpo_account_header_subtitle':
  'It is required for payment deposit and capital gains tax settlement.',
  'super_save_corpo_account': 'Select Bank',
  'super_save_corpo_account_number': 'Enter Account Number',
  'super_save_corpo_account_number_hint': 'Enter Numbers Only',
  'super_save_corpo_account_bank_book': 'Corporate Bankbook Copy',
  'super_save_corpo_account_bank_hint': 'Select a file',
  'super_save_day_12':
  'SUPER SAVE has ended. you can apply from 10:00 to 16:00 every day.',
  'super_save_ended':
  'SUPER SAVE has ended. You can apply from @start to @end every day.',
  'super_save_information_1': 'SUPER SAVE Registration Information',
  'super_save_is_a_credit_transaction':
  'SUPER SAVE is a credit transaction.',
  'super_save_iscomplete_18': 'SUPER SAVE application\nhas completed.',
  'super_save_iscomplete_19': 'SUPER SAVE application\nhas completed.',
  'credit_sale_iscomplete_18': 'Credit Sale application\nhas completed.',
  'super_save_payment_details': 'SUPER SAVE Payment Details',
  'super_save_transaction_registration': 'SUPER SAVE Registration',
  'supersave_corporate_transaction_1':
  'Upon completion of the transaction registration,\nthe registration information will be updated\nin your profile,',
  'supersave_corporate_transaction_2':
  'SUPER SAVE is available after confirmation \nfrom a representative',
  'supersave_corporate_transaction_3': 'for the first time.',
  'supersave_corporate_transaction_registration_info':
  'SUPER SAVE Corporate Registration Information',
  'super_save_only_requires':
  'SUPER SAVE only requires transaction registration for\nthe first use and will not be required for subsequent\nengagements.',
  'super_save_user_guide': 'SUPER SAVE User Guide',
  'super_save_referral_code': 'SUPER SAVE Referral Code',
  'super_save_when_registration_transaction':
  'When registering a SUPER SAVE corporate registration, a business registration certificate and corporate account registration are required.',
  'super_save_corporate_reg': 'SUPER SAVE Corporate Registration',
  'super_save_corporate_contact_info':
  'Corporate Registration Contact Information',
  'super_save_corporate_contact_info_sub':
  'Please register the correct information of the person in charge.',
  'super_save_corporate_contact_name_label': 'Contact Name',
  'super_save_corporate_contact_name_hint_text': 'Name',
  'super_save_corporate_contact_person_in_charge_label':
  'Contact Phone Number',
  'super_save_corporate_contact_person_in_charge_hint_text':
  'Numbers only',
  'super_save_corporate_identity_verification_cta_label':
  'Identity Verification',
  'super_save_corporate_contact_email_label': 'Contact Email',
  'super_save_corporate_contact_email_hint_text': 'Enter Email',
  'super_save_corporate_contact_email_cta_label': 'Email Verification',
  'super_save_corporate_next_cta_label': 'Next',
  'super_save_corporate_success_title':
  'Corporate registration \nis completed.',
  'super_save_corporate_success_subtitle':
  'The person in charge checks the registered \ninformation within 1 business day, and SUPER SAVE \nis available upon completion of registration.',
  'swap': 'Swap',
  'swap_token': 'Swap Token',
  'swipe_left_to_next_page': 'Swipe left to Next page',
  'take_again': 'Take Again',
  'take_me_to_listings': 'TAKE ME TO LISTINGS',
  'take_pictures': 'Take Photo',
  'ten_k': '(10 K)',
  'terms_and_conditions': 'Terms & Conditions',
  'the_account_application_4':
  'SUPER SAVE foreign transactions will be purchased at a significantly higher price, reflecting the current and future value of SUT.',
  'the_account_use_3':
  "SUPER SAVE aims to increase the global user base of MSQUARE's real economy platform ecosystem and expand the real-world fixed purchase tax of SUT as a payment method.",
  'the_account_use_4':
  'SUPER SAVE is an exciting platform that will accelerate the user growth of the MSQUARE real economy platform into a steep upward curve.',
  'the_application_exceeded_5':
  'The application limit has been exceeded.',
  'the_change_7':
  '- The payment method for credit sales is paid in daily installments during the payment period for the selected credit sales, and is paid in batches after weekly '
      'settlement every Monday. \n - If Monday is a holiday, the amount will be paid on the next business day without change.',
  'the_credit_completed_1': 'The credit sale request is \ncompleted.',
  'the_credit_completed_19':
  'The credit sale request\n has been completed.',
  'msquare_team': 'MSQUARE\nIn-House\nDev Team',
  'msquare_team_1':
  "Must Fintech is a multi-platform development company that oversees the development of MSQUARE's real economy platform.",
  'msquare_team_2': 'Go to Must Crew YouTube',
  'ss_inquiry': 'National SUPER SAVE Inquiry Information',
  'the_message_value_is_empty': 'The message value is empty.',
  'the_number_krw_1':
  'The number of times already registered for SUPER SAVE transaction is KRW.',
  'the_number_processed_38':
  'You are a user applying for a withdrawal, you cannot use the service during the withdrawal process.',
  'the_participation_day_12':
  'The participation limit is renewed every day, and the limit is restored by the amount of daily equal payment paid every day.',
  'the_payment_period_2':
  'The payment is paid in daily installments during the payment period.',
  'the_slips_20':
  '- The transaction confirmation certificate is provided for customer convenience and cannot be used as evidence such as cash receipts or sales slips.',
  'there_are_no_search_results': 'There are no results.',
  'there_is_complete_2':
  'There is an application for credit sale that can participate in SUPER SAVE. Please apply again after participation is complete.',
  'there_is_complete_20':
  'There is an application for credit sale that can participate in SUPER SAVE. Please apply again after participation is complete.',
  'to': 'To',
  'get_email_code': 'Get Email Code',
  'get_phone_code': 'Get Phone Code',
  'usdt_code_timout_title': 'Verification code timed out.',
  'usdt_code_wrong_title': 'The verification code does not match.',
  'usdt_code_timout_msg': 'Would you like to receive @thing again?',
  'text_msg': 'text message',
  'call': 'voice call',
  'usdt_code_wrong_msg': 'Please check your verification code again.',
  'usdt-resend-title': 'Please check before texting again',
  'usdt-recall-title': 'Please check before calling again',
  'usdt_sms_resend_txt':
  'Check your mobile phone number,Please make sure your mobile phone number is entered correctly.;'
      'Check spam messages,Please check if the message is classified as spam.;'
      'Check the carrier,Check that the carrier is able to receive text messages.\n(Service provider blocking service, bill payment status, etc.)',
  'usdt_voice_recall_txt':
  'Check your mobile phone number,Please make sure your mobile phone number is entered correctly.;'
      'Check spam messages,Please check if the message is classified as spam.;'
      'Check the carrier,Check that the carrier is able to receive voice calls.\n(Service provider blocking service, bill payment status, etc.)',
  'email_sms_resend_txt':
  'Check your phone number/email,Please make sure your phone number/email is entered correctly.;'
      'Check spam messages,Please check if the message is classified as spam.;'
      'Check the carrier,Check that the carrier is able to receive text messages.\n(Service provider blocking service, bill payment status, etc.)',
  'usdt_registration_txt':
  'When using SUPER SAVE USDT, mobile phone authentication is required to prevent others from stealing information.\n'
      'Transaction registration is required only for the first use of SUPER SAVE USDT, and will be omitted from the next participation.\n'
      'When transaction registration is completed, registration information is updated in member information, and SUPER SAVE can be used after confirmation by the person in charge.',
  'usdt_regist': 'SUPER SAVE USDT Registration',
  'usdt_regist_title': 'SUPER SAVE USDT Registration Information',
  'usdt_regist_btn': 'SUPER SAVE USDT Registration',
  'usdt_regist_cmplt': 'SUPER SAVE USDT\nregistration is complete.',
  'token_transfer': 'Token Transfer',
  'topup_credit': 'Topup/Credit',
  'total': 'Total: @length',
  'total_krw_usdt': 'Total: KRW+USDT',
  'total_amount': 'Total Amount',
  't_total_amount': 'The Total Amount',
  'total_credit_amount_1': 'Total Amount',
  'total_daily_equal_payout': 'Total Daily Payout',
  'show_completed_participations': 'Show Denied/Completed',
  'total_n_cases': '@n Total Cases',
  'total_paid_accounts_payable': 'Total Paid Payout',
  'total_participants': 'Total Participants',
  'total_participation_amount': 'Total Participation Amount',
  'total_participation_history': 'Total Participation History',
  'total_remaining_accounts_payable': 'Total Remaining Payout',
  'total_value': 'Total Value',
  'trade_registration': 'Trade Registration',
  'trading': 'Trading',
  'transaction_confirm_msg':
  'Your transaction is successfully accepted',
  'transaction_confirmation': 'Transaction Confirmation',
  'transaction_confirmed': 'Transaction Confirmed',
  'transaction_detail': 'Transaction Detail',
  'transaction_done':
  'Transaction already done. Kindly use another QR code.',
  'transaction_failed': 'Transaction Failed',
  'transaction_history': 'Transaction History',
  'transaction_information': 'Transaction Information',
  'transaction_name': 'Transaction Name',
  'transaction_number': 'Transaction No',
  'transaction_registration_participation_3':
  'Registration is required only for the first use of SUPER SAVE and will be omitted from the next participation.',
  'transaction_request': 'Transaction Request',
  'transaction_type': 'Transaction Type',
  'transaction_timeout': 'Transaction timeout, please try again.',
  'transaction_unsuccessful': 'Transaction Not Successful',
  'transfer': 'Transfer',
  'transfer_to_super_save_wallet': 'Transfer to SUPER SAVE Wallet',
  'transmission_quantity': 'Transfer Amount',
  'try_again_later': 'Please try again later',
  'try_again_msg_1': 'Try again after',
  'try_again_msg_2': 'minute(s)',
  'tx_id_cannot_be_blank': 'TXID cannot be blank.',
  'enter_valid_tx_id': 'You must enter a valid TXID.',
  'txid_input_again_1': 'TXID input timed out. Please try again.',
  'unlock_wallet': 'Confirm your identity',
  'update_billing_details': 'Update your billing details and address',
  'update_password': 'Update Password',
  'update_payment_method': 'Connect card',
  'usdt': 'USDT',
  'use_password': 'Use Password',
  'user': 'User',
  'user_': 'User:',
  'user_details': 'User Details',
  'user_guide': 'User Guide',
  'user_id': 'User ID',
  'user_name': 'Username',
  'username_copied': 'User Name has been copied to clipboard',
  'email_copied': 'Email has been copied to clipboard',
  'address_copied': 'Address has been copied to clipboard',
  'check_store_info': 'Check Store Information',
  'user_id_copied': 'User ID has been copied to clipboard',
  'view_all': 'View All',
  'waiting_for_approval': 'Waiting for Approval',
  'wallet': 'Wallet',
  'wallet_address': 'Wallet Address',
  'wallet_id_copied': 'Wallet Address has been copied to clipboard',
  'wallet_id_copied_to_clipboard': 'Wallet Address copied to clipboard',
  'wallet_request': 'Wallet Request',
  'wallet_connection_request': 'Wallet Connection Request',
  'wallet_successfully_terminated': 'Wallet Successfully Terminated',
  'wallet_termination': 'Wallet Termination',
  'wallet_cannot_termination':
  'You cannot terminate wallet because you have a SUPER SAVE registration.',
  'wallet_termination_failed': 'Wallet Termination Failed',
  'wallet_termination_screen': 'Wallet Termination',
  'want_to_logout': 'Do you want to logout',
  'sec_threat': 'Security Threat',
  'we_detected_sec_rel':
  'We have detected a security threat and we cannot allow you use app for now, try to resolve this and restart the app.',
  'case_code': 'Case Code: @c',
  'we_are_again_29':
  'We are unable to receive your response. Please try again.',
  'weekly_settlement_monday_3':
  'Weekly settlement is made and paid every monday.',
  'welcome': 'Welcome',
  'welcome_back': 'Welcome Back!',
  'what_is_super_save': 'What is SUPER SAVE?',
  'when_msq_voluntary_7':
  'When MSQ is transferred to SUPER SAVE wallet, the transaction is completed, ownership is transferred to MSQUARE headquarters, and ownership exercise is also '
      'voluntary.',
  'when_transaction_charge_4':
  'When account registration is completed, registration information is updated in KRW information, and SUPER SAVE can be used after confirmation by '
      'the person in charge.',
  'when_using_tax_2':
  'When using SUPER SAVE, identity verification and account registration are required to prevent others from stealing information, deposit payments, and settle '
      'capital gains tax.',
  'When_using_supersave':
  'When using SUPER SAVE, identity\nverification and account registration are\nrequired to prevent information theft by others,\n deposit payments, and settle capital gains tax.',
  'withdraw': 'Withdraw',
  'won': ' KRW',
  'won_suffix': ' KRW',
  'wrong_password': 'You have entered wrong password',
  'year': 'Year',
  'yes': 'Yes',
  'you_agree_etc_14':
  'You agree that the credit payment can be paid in cash or something of equivalent value (gold, rice, coins, etc.).',
  'you_can_apply_from_1_million_krw': 'You can apply from @from.',
  'you_can_have_a_look_at_your_ad’s_on_your_listings_page':
  'You can have a look at your ad’s on your listings page',
  'you_can_krw_6': 'You can apply in units of @of',
  'you_have_created_an_ad': 'You have created an ad',
  'you_have_no_cumulative_balance': 'You have no cumulative balance.',
  'you_sure': 'Are you sure?',
  'your_order_has_been_placed': 'Your order has been placed',
  'add_p2u_store_info': 'You can also click on the map to select it.',
  'dob': 'Date of Birth',
  'phone_company': 'Company',
  'input_number_error': 'Input cannot be empty',
  'otp_error': 'Verification Number must be 6-digits',
  'offshore_labor_projects': 'Offshore Labor Projects',
  'wait_for_release': 'Waiting for Launch',
  'recall': 'Recall',
  'call_me': 'Call me instead',
  'sms_me': 'SMS me instead',
  'sms_sent': 'You will receive a SMS shortly.',
  'call_sent': 'You will receive a voice call shortly.',
  'sensitive_information_prompt':
  'Sensitive information is encrypted and safely protected in accordance with the Personal Information Protection Act.',
  'select_phone_company': 'Select Phone Company',
  'enter_phone_number': 'Enter Phone Number',
  'enter_date_birth': 'Enter Date Birth',
  'enter_detail': 'Enter Your Information',
  'input_field_error': 'Input Field Can Not Be Empty',
  'name_error': 'Name cannot be empty',
  'dob_error': 'Date Of Birth cannot be empty',
  'number_error': 'Number cannot be empty',
  'check_phone_number': 'Check Your Phone Number',
  'check_phone_number_sub_text':
  'Please make sure your mobile phone number is entered',
  'check_spam': 'Check Spam Message',
  'check_spam_sub_text':
  'Please check if the message is classified as spam',
  'check_carrier': 'Check the carrier',
  'check_carrier_text':
  ' Check that the carrier is able to receive text message',
  'check_before_resend': 'Please check before texting again',
  'enter_verification_code': 'Enter Verification Code',
  'verification_failure': 'Verification Failed',
  'input_field_validation_error': 'Input Validation Failed',
  'verification_code_error':
  'The authentication number does not match.',
  'verification_code_error_description':
  'Please check the authentication number again.',
  'register_param_incorrect':
  'Some of your provided information is not correct please check again.',
  'referred_by': 'Referred by:',
  'add_referral': 'Who Introduced Super Save to You (Optional)',
  'add_referral_required':
  'Who Introduced Super Save to You (Required)',
  'add_referral_is_required': 'Referral Code is required.',
  'referral_code': 'Super Save',
  'referral_code_sub_title': 'Add Person Introduced to You',
  'type_your_referral_code':
  'Please enter the code of the person who introduced Super Save to you.',
  'referral_code_error': 'Invalid code, it must be 5 digits.',
  'referral_code_api_error': 'Invalid code, please check again.',
  'referral_phone_api_error':
  'Invalid phone number, please check again.',
  'add': 'Add',
  'please_confirm': 'Please Confirm',
  'grant': 'Grant',
  'approve_failure': 'Approve Failure',
  'referral_code_title': 'Referral Code',
  'added_successfully': 'added successfully.',
  'add_percentage': 'Add Percentage',
  'how_much_percentage': 'How much will you give?',
  'confirmation_text':
  '@name will get the credit sales right. Once the decision is made, it cannot be changed or reversed. Are you sure?',
  'dont_show_again': 'Don’t show again',
  'referrals_not_zero': 'Referrals could not have zero percentage.',
  'total_percentage_should_be_100':
  'Total percentage should be equal to 100%',
  'search_by_phone_number': 'Search by phone number.',
  'select_transfer_percentage':
  'Enter the amount of rights to transfer.',
  'remained_amount_after_transfer': 'Remained amount after transfer.',
  'phone_code': 'Phone',
  'invalid_phone_code': 'Invalid! Phone number is not correct.',
  'code_tab': 'Code',
  'deny': 'Deny',
  'code_already_exists': 'Referral code already exist.',
  'card_duplicate':
  'You already added @index card company, and no need to add, if you want to add other card company press button.',
  'invalid_registration_number': 'Invalid Resident Registration Number',
  'invalid_name': 'Invalid Name Provided',
  'invalid_number': 'Invalid Phone Number Entered',
  'credit_sale_right': 'You’ve unused Credit Sale right.(%credit_sale%)',
  'congratulations': 'Congratulations!',
  'go_to_credit_sale_right': 'Move to check',
  'go_to_check': 'Go to check',
  'move_to_check': 'Move to check',
  'super_saver_need_to_complete': ' needs to be\ncompleted.',
  'waiting_for_response': 'Waiting for Response',
  'active_inquiry': 'Active Inquiry',
  'solved': 'Completed',
  'hold_status': 'Hold',
  'search_for_inquiry': 'Search for inquiry',
  '1:1inquiry': '1:1 Inquiry',
  'Hold': 'Hold',
  'by_status': 'BY STATUS',
  'by_category': 'BY CATEGORY ',
  'status': 'Status:',
  'p2p_mining_inquiry': 'P2U Mining Inquiry',
  'select_category': 'Select Category',
  'attachment': 'Attachment',
  'browse_file': 'Browse file',
  'create_new_inquiry': 'Create New Inquiry',
  'message_here': 'Message here',
  'general': 'General',
  'bug': 'Bug',
  'p2u': 'P2U',
  'p2umining': 'P2U Mining',
  'inquiry_dialog_response':
  'Thank you for submitting your inquiry. We will review your case and provide you with a response within the next 24-48 hours.',
  'inquiry_track_detail':
  'You can keep track of your inquiry from the 1:1 inquiry screen.',
  'track_inquiry': 'Track Inquiry',
  '1:1inquiry_received': '1:1 Inquiry Received',
  'inquiry_anouncement':
  'You have received a response on your 1:1 inquiry.',
  'inquiry_empty': 'No Recent Inquiry Found',
  'title': 'Title',
  'subject_error': 'Title can not be empty',
  'category_error': 'Category can not be empty',
  'content_field_error': 'Message could not be empty',
  'inquiry_created_successfully': 'Inquiry Created Successfully',
  'something_went_wrong': 'Something went wrong',
  'Active': 'Active',
  'Solved': 'Solved',
  'Waiting': 'Waiting',
  'General': 'General',
  'Bug': 'Bug',
  'SUPER SAVE': 'SUPER SAVE',
  'P2U': 'P2U',
  'P2U Mining': 'P2U Mining',
  'super_save_is_confirmed': '%super_save_popup% is confirmed.',
  'super_save_popup': 'Super Save',
  'credit_sale_right_created': 'Credit Sale Right\nhas been issued.',
  'super_save_awaits_completion': 'Super Save need completion.',
  'commitment_document': 'Commitment Document',
  'please_add_commitment_document':
  'Please add your commitment document here.',
  'add_commitment_document': 'Add commitment document here',
  'your_card_will_be_deleted':
  'Solution: Your card registration will be deleted due to card company policy. Go to your card company and change your password. Be sure to make the password complex.',
  'your_added_card_deleted':
  'Your added card deleted and need to add again.',
  'confirmation_letter': 'Confirmation',
  'read_the_content': 'Read the following content.',
  'confirmation_terms':
  'When myself or my family sign up for a new Super Save account, if the introducer (creditor) is not a family member, I agree to allocate over 50% of the external introducing rights to the external introducer. In case of breach of agreement, I agree to the removal or modification of the introducer.',
  'confirmation_terms_1': '(However, if there are multiple referrers, the percentage of outright rights is the percentage specified by the user.)',
  'introducer': 'Introducer: ',
  'introduced_by': 'Participant: ',
  'enrollment_data': 'Join Date: ',
  'crop': 'Crop',
  'please_crop_image': 'Crop the Image',
  'failed_during_cropping_image': 'Failed during cropping image.',
  'the_image_too_small': 'The image is too small',
  'grant_location_permission':'Please grant location permission and reopen the screen.',
  'p2u_store_deleted_successfully':'Store deleted successfully.',
  'p2u_store_deleted_unsuccessfully':'Unable to delete store.',
  'delete':'Delete',
  'undo':'Undo',
  'hide_card_confirm': 'Are you sure want to hide this card?',
  'open_super_save': 'Go to Super Save',
  'complete_super_save': 'Complete Super Save',
  'request_credit_sale_right': 'Go to Credit Sale',
  'sut_credit_sale_right_issued': 'SUT Credit Sale right arrived.',
  'invalid_email_or_id': 'Email Address or id is not correct',
  'participation_transferred': 'Participation Transferred'
};
''';