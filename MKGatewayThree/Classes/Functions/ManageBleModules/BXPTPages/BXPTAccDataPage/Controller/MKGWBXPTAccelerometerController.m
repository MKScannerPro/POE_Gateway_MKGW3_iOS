//
//  MKGWBXPTAccelerometerController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPTAccelerometerController.h"

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

#import "MKGWBXPButtonAccHeaderView.h"

@interface MKGWBXPTAccelerometerController ()<MFMailComposeViewControllerDelegate,
MKGWBXPButtonAccHeaderViewDelegate>

@property (nonatomic, strong)MKGWBXPButtonAccHeaderView *headerView;

@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, strong)NSDateFormatter *dateFormatter;

@end

@implementation MKGWBXPTAccelerometerController

- (void)dealloc {
    NSLog(@"MKGWBXPTAccelerometerController销毁");
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

#pragma mark - MKGWBXPButtonAccHeaderViewDelegate
- (void)gw_bxpButtonAccHeaderView_syncButtonPressed:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_bxpBXPTNotifyAccDataWithBleMac:self.bleMac notify:isOn macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
        [self.headerView updateSyncStatus:isOn];
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveAccDatas:)
                                                         name:MKGWReceiveBXPTAccDataNotification
                                                       object:nil];
        }else {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)gw_bxpButtonAccHeaderView_exportButtonPressed {
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
                           fileName:@"BXP-D AccData.txt"];
    [mailComposer setMessageBody:bodyMsg isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

#pragma mark - Notes
- (void)receiveAccDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKGWDeviceModeManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:self.bleMac]) {
        return;
    }
    NSString *dateString = [self.dateFormatter stringFromDate:[NSDate date]];
    NSString *x = [@" X-axis:" stringByAppendingString:[NSString stringWithFormat:@"%@",dataDic[@"x_axis_data"]]];
    NSString *y = [@" Y-axis:" stringByAppendingString:[NSString stringWithFormat:@"%@",dataDic[@"y_axis_data"]]];
    NSString *z = [@" Z-axis:" stringByAppendingString:[NSString stringWithFormat:@"%@",dataDic[@"z_axis_data"]]];
    NSString *text = [NSString stringWithFormat:@"\n%@ %@ %@ %@",dateString,x,y,z];
    self.textView.text = [self.textView.text stringByAppendingString:text];
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Accelerometer data";
    [self.view addSubview:self.headerView];
    [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0);
        make.right.mas_equalTo(-10.0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(10.f);
        make.height.mas_equalTo(100.f);
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
- (MKGWBXPButtonAccHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MKGWBXPButtonAccHeaderView alloc] init];
        _headerView.showTimeLabel = NO;
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

@end
