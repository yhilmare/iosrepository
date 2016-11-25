//
//  YHBottomTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHBottomTableViewCell.h"
#import "YHCompanyMsg.h"

@interface YHBottomTableViewCell ()

@property (nonatomic, strong) UILabel *required;

@property (nonatomic, strong) UILabel *requiredMsg;

@property (nonatomic, strong) UILabel *describtion;

@property (nonatomic, strong) UILabel *descMsg;

@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) UILabel *addressMsg;

@property (nonatomic, strong) UILabel *contactPer;

@property (nonatomic, strong) UILabel *contactPerMsg;

@property (nonatomic, strong) UILabel *contact;

@property (nonatomic, strong) UILabel *contactMsg;

@end

@implementation YHBottomTableViewCell

- (void) setMsg:(YHCompanyMsg *)msg{
    _msg = msg;
    
    
    self.required.frame = CGRectMake(17, 10, 200, 20);
    
    self.requiredMsg.text = _msg.companyRequired;
    self.requiredMsg.frame = _msg.requiredRect;
    self.requiredMsg.font = [UIFont systemFontOfSize:15];
    CGFloat y = CGRectGetMaxY(_msg.requiredRect);
    self.describtion.frame = CGRectMake(17, y + 20, 200, 20);
    
    self.descMsg.text = _msg.companyDescribtion;
    self.descMsg.frame = _msg.describtionRect;
    self.descMsg.font = [UIFont systemFontOfSize:15];
    
    y = CGRectGetMaxY(_msg.describtionRect);
    self.address.frame = CGRectMake(17, y + 20, 200, 20);
    
    self.addressMsg.text = _msg.companyAddress;
    self.addressMsg.frame = _msg.addressRect;
    self.addressMsg.font = [UIFont systemFontOfSize:15];
    
    y = CGRectGetMaxY(_msg.addressRect);
    self.contactPer.frame = CGRectMake(17, y + 20, 200, 20);
    
    self.contactPerMsg.text = msg.companyContactPerson;
    self.contactPerMsg.frame = msg.contactPersonRect;
    
    y = CGRectGetMaxY(_msg.contactPersonRect);
    self.contact.frame = CGRectMake(17, y + 20, 200, 20);
    
    self.contactMsg.text = msg.companyContact;
    self.contactMsg.frame = _msg.contactRect;
}

- (UILabel *) required{
    if(!_required){
        _required = [[UILabel alloc] init];
        _required.font = [UIFont systemFontOfSize:16];
        [_required setTextColor:[UIColor blackColor]];
        _required.text = @"职位要求 :";
    }
    return _required;
}

- (UILabel *) describtion{
    if(!_describtion){
        _describtion = [[UILabel alloc] init];
        _describtion.font = [UIFont systemFontOfSize:16];
        [_describtion setTextColor:[UIColor blackColor]];
        _describtion.text = @"职位描述 :";
    }
    return _describtion;
}

- (UILabel *)address{
    if(!_address){
        _address = [[UILabel alloc] init];
        _address.font = [UIFont systemFontOfSize:16];
        [_address setTintColor:[UIColor blackColor]];
        _address.text = @"公司地址 :";
    }
    return _address;
}

- (UILabel *)contactPer{
    if(!_contactPer){
        _contactPer = [[UILabel alloc] init];
        _contactPer.font = [UIFont systemFontOfSize:17];
        [_contactPer setTintColor:[UIColor blackColor]];
        _contactPer.text = @"联系人 :";
    }
    return _contactPer;
}

- (UILabel *)contact{
    if(!_contact){
        _contact = [[UILabel alloc] init];
        _contact.font = [UIFont systemFontOfSize:17];
        [_contact setTintColor:[UIColor blackColor]];
        _contact.text = @"联系电话 :";
    }
    return _contact;
}

- (UILabel *) requiredMsg{
    if(!_requiredMsg){
        _requiredMsg = [[UILabel alloc] init];
        _requiredMsg.font = [UIFont systemFontOfSize:16];
        _requiredMsg.numberOfLines = 0;
        [_requiredMsg setTextColor:[UIColor grayColor]];
    }
    return _requiredMsg;
}

- (UILabel *)descMsg{
    if(!_descMsg){
        _descMsg = [[UILabel alloc] init];
        _descMsg.font = [UIFont systemFontOfSize:16];
        _descMsg.numberOfLines = 0;
        [_descMsg setTextColor:[UIColor grayColor]];
    }
    return _descMsg;
}

- (UILabel *) addressMsg{
    if(!_addressMsg){
        _addressMsg = [[UILabel alloc] init];
        _addressMsg.font = [UIFont systemFontOfSize:16];
        _addressMsg.numberOfLines = 0;
        [_addressMsg setTextColor:[UIColor grayColor]];
    }
    return _addressMsg;
}

- (UILabel *) contactPerMsg{
    if(!_contactPerMsg){
        _contactPerMsg = [[UILabel alloc] init];
        _contactPerMsg.font = [UIFont systemFontOfSize:15];
        _contactPerMsg.numberOfLines = 0;
        [_contactPerMsg setTextColor:[UIColor grayColor]];
    }
    return _contactPerMsg;
}

- (UILabel *) contactMsg{
    if(!_contactMsg){
        _contactMsg = [[UILabel alloc] init];
        _contactMsg.font = [UIFont systemFontOfSize:15];
        _contactMsg.numberOfLines = 0;
        [_contactMsg setTextColor:[UIColor grayColor]];
    }
    return _contactMsg;
}

+ (instancetype) cellFromTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    YHBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.required];
        [self.contentView addSubview:self.requiredMsg];
        [self.contentView addSubview:self.describtion];
        [self.contentView addSubview:self.descMsg];
        [self.contentView addSubview:self.address];
        [self.contentView addSubview:self.addressMsg];
        [self.contentView addSubview:self.contactPer];
        [self.contentView addSubview:self.contactPerMsg];
        [self.contentView addSubview:self.contact];
        [self.contentView addSubview:self.contactMsg];
    }
    return self;
}



@end
