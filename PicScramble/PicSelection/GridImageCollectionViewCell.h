//
//  GridImageCollectionViewCell.h
//  PicScramble
//
//  Created by Mohit Jethwa on 15/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridImage.h"
// This protocol method will call when using select correct image. After image will flip this method will help to move to next image for game.
@protocol GridCellDelegate <NSObject>
-(void)imageFlipComplete;
@end

@interface GridImageCollectionViewCell : UICollectionViewCell {
    __weak IBOutlet UIImageView *gridImageView;

}
@property (weak, nonatomic) id<GridCellDelegate> delegate;

/**
  Grid Image display and animation according to current flip state.
*/
-(void)setUpCollectionCell:(GridImage *)gridObject;
@end
