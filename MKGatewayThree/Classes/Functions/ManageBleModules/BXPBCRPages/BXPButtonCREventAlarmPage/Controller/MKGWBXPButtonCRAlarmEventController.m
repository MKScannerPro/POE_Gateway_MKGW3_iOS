//
//  MKGWBXPButtonCRAlarmEventController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonCRAlarmEventController.h"

#import <MessageUI/MessageUI.h>
#import <sys/utsname.h>

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKButtonMsgCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKAlertView.h"
#import "MKSettingTextCell.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWDeviceModeManager.h"
#import "MKGWDeviceModel.h"

#import "MKGWBXPButtonCRAlarmEventHeader.h"

#import "MKGWBXPButtonCRAlarmEventModel.h"

@interface MKGWBXPButtonCRAlarmEventController ()<MFMailComposeViewControllerDelegate,
MKGWBXPButtonCRAlarmEventHeaderDelegate>

@property (nonatomic, strong)MKGWBXPButtonCRAlarmEventHeader *headerView;

@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, strong)NSDateFormatter *dateFormatter;

@property (nonatomic, strong)MKGWBXPButtonCRAlarmEventModel *dataModel;

@end

@implementation MKGWBXPButtonCRAlarmEventController

- (void)dealloc {
    NSLog(@"MKGWBXPButtonCRAlarmEventController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:  //取消
            break;
        case MFMailComposeResultSaved:      //用户保存
            break;
        case MFMailComposeResultSent:       //用户点击发送
            [self.view showCentralToast:@"send success"];
            break;
        case MFMailComposeResultFailed: //用户尝试保存或发送邮件失败
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MKGWBXPButtonCRAlarmEventHeaderDelegate
- (void)gw_bxpButtonCRAlarmEventHeaderView_syncButtonPressed:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [self.dataModel notifyDataWithBleMac:self.bleMac notify:isOn sucBlock:^{
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
        [self.headerView updateSyncStatus:isOn];
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveAlarmDatas:)
                                                         name:MKGWReceiveBXPBtnCRAlarmEventDataNotification
                                                       object:nil];
        }else {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)gw_bxpButtonCRAlarmEventHeaderView_exportButtonPressed {
    if (![MFMailComposeViewController canSendMail]) {
        //如果是未绑定有效的邮箱，则跳转到系统自带的邮箱去处理
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"MESSAGE://"]
                                           options:@{}
                                 completionHandler:nil];
        return;
    }
    NSData *emailData = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
    if (!ValidData(emailData) || emailData.length == 0) {
        [self.view showCentralToast:@"Log file does not exist"];
        return;
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *bodyMsg = [NSString stringWithFormat:@"APP Version: %@ + + OS: %@",
                         version,
                         kSystemVersionString];
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    
    //收件人
    [mailComposer setToRecipients:@[@"Development@mokotechnology.com"]];
    //邮件主题
    [mailComposer setSubject:@"Feedback of mail"];
    [mailComposer addAttachmentData:emailData
                           mimeType:@"application/txt"
                           fileName:@"BXP-B-CR AlarmEventData.txt"];
    [mailComposer setMessageBody:bodyMsg isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

#pragma mark - Notes
- (void)receiveAlarmDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKGWDeviceModeManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:self.bleMac]) {
        return;
    }
    long long timestamp = [dataDic[@"timestamp"] longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(timestamp / 1000.0)];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    NSInteger type = [dataDic[@"type"] integerValue];
    NSString *typeString = @"Single press mode";
    if (type == 1) {
        typeString = @"Double press mode";
    }else if (type == 2) {
        typeString = @"Long press mode";
    }
    NSString *text = [NSString stringWithFormat:@"\n%@\t\t\t%@",dateString,typeString];
    self.textView.text = [self.textView.text stringByAppendingString:text];
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Alarm event data";
    [self.view addSubview:self.headerView];
    [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0);
        make.right.mas_equalTo(-10.0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(10.f);
        make.height.mas_equalTo(115.f);
    }];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0);
        make.right.mas_equalTo(-10.0);
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(5.f);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKGWBXPButtonCRAlarmEventHeader *)headerView {
    if (!_headerView) {
        _headerView = [[MKGWBXPButtonCRAlarmEventHeader alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = MKFont(13.f);
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        _textView.editable = NO;
        _textView.textColor = DEFAULT_TEXT_COLOR;
    }
    return _textView;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    }
    return _dateFormatter;
}

- (MKGWBXPButtonCRAlarmEventModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKGWBXPButtonCRAlarmEventModel alloc] init];
    }
    return _dataModel;
}

@end
