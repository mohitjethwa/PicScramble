//
//  GridImageCollectionViewCell.m
//  PicScramble
//
//  Created by Mohit Jethwa on 15/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import "GridImageCollectionViewCell.h"

@implementation GridImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setUpCollectionCell:(GridImage *)gridObject {
    switch (gridObject.flipState) {
            case FlipStateImageShowPlayed:{
                [self performSelector:@selector(flipAnimationForImageShow:) withObject:gridObject.imageObject afterDelay:0.1];
            }break;
            case FlipStateImageShowUnPlayed:{
                [self setImageForGrid:gridObject.imageObject];
            }break;
            case FlipStateImageHiddenPlayed:{
                [self flipAnimationForImageHidden];
            }break;
            case FlipStateImageHiddenUnPlayed:{
                [self flipAnimationForImageHidden];
            }break;
        default:
            break;
    }
}
-(void)flipAnimationForImageHidden {
    [UIView transitionWithView:gridImageView
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        //  Set the new image
                        //  Since its done in animation block, the change will be animated
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self resetImageForGrid];
                        });
                    } completion:^(BOOL finished) {

                        //  Do whatever when the animation is finished
                    }];
}
-(void)flipAnimationForImageShow:(UIImage *)url {
    [UIView transitionWithView:gridImageView
                       duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        //  Set the new image
                        //  Since its done in animation block, the change will be animated
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self setImageForGrid:url];
                        });

                    } completion:^(BOOL finished) {
                        //  Do whatever when the animation is finished
                        [_delegate imageFlipComplete];
                    }];
}

-(void)setImageForGrid:(UIImage *)url {
    gridImageView.image = url;
//    [gridImageView sd_setImageWithURL:[NSURL URLWithString:url]
//                       placeholderImage:kPlaceHolderImage
//                                options:SDWebImageHighPriority];

}
-(void)resetImageForGrid {
    //[gridImageView sd_setImageWithURL:[NSURL new] placeholderImage:nil];
    gridImageView.image = [UIImage imageNamed:@"flipOffState"];
}
@end
