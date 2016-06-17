//
//  GridViewController.h
//  PicScramble
//
//  Created by Mohit Jethwa on 15/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout > {
    // Collection View which will show all Grid Images
	__weak IBOutlet UICollectionView *collectionGridView;
	// Target image view for Game 
    __weak IBOutlet UIImageView *targetImageView;
}

@end
