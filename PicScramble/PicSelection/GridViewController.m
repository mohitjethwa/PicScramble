//
//  GridViewController.m
//  PicScramble
//
//  Created by Mohit Jethwa on 15/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import "GridViewController.h"
#import "GridImage.h"
#import "GridImageCollectionViewCell.h"

@interface GridViewController () < GridCellDelegate >{
    NSMutableArray *gridCollectionImageData;
    NSMutableArray *gridPendingStateImageData;
    GridImage *currentSelectedGrid;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    __weak IBOutlet UIButton *startGameBtn;
    NSTimer *timeToStartGame;
}

@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableview];
    [self getGridImageDataFromFlickerServer];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Collection View Cell Setup Methods
-(void)configureTableview{
    // Register nib to show grid image components
    // which is resuseable for memory issues
    [collectionGridView registerNib:[UINib nibWithNibName:NSStringFromClass([GridImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kGridCollectionCellIdentifier];
    ((UICollectionViewFlowLayout *)collectionGridView.collectionViewLayout).sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
}
#pragma mark - Collection View Delegate and DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return gridCollectionImageData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionview cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GridImageCollectionViewCell *cell = [collectionview dequeueReusableCellWithReuseIdentifier:kGridCollectionCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [cell setUpCollectionCell:[gridCollectionImageData objectAtIndex:indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    GridImage *selectedImage = [gridCollectionImageData objectAtIndex:indexPath.item];
    if (selectedImage.flipState == FlipStateImageShowPlayed || selectedImage.flipState == FlipStateImageShowUnPlayed) {
        return; 
    } else {
        if ( selectedImage == currentSelectedGrid) {
            selectedImage.flipState = FlipStateImageShowPlayed;
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        } else {
            return;
        }
    }

}
#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionview layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat widthOfGrid = (collectionview.frame.size.width-20)/3;
    CGFloat heigthOfGrid = widthOfGrid;
    return CGSizeMake(widthOfGrid,heigthOfGrid);
}

#pragma mark - Request Related Methods
// Request Method For Flicker Public API
-(void)getGridImageDataFromFlickerServer {
    activityIndicator.hidden = false;
    SDWebImageManager.sharedManager.imageDownloader.maxConcurrentDownloads = kGameImageCount;
    gridCollectionImageData = [[NSMutableArray alloc] init];

    [GridImageDownloader getGameImageDataFromFlicker:^(NSArray *responseObject, NSError *error, bool status) {
        activityIndicator.hidden = true;
        if (status) {
         [gridCollectionImageData addObjectsFromArray:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                startGameBtn.hidden = false;
            });
        }
    }];
}
#pragma mark - Ramdom Selection
-(void)createRandomSelectionOfUnplayedGrids {
    NSMutableArray *unplayedArray = [gridCollectionImageData mutableCopy];
    [unplayedArray filterUsingPredicate:[NSPredicate predicateWithFormat:@"flipState == %i", FlipStateImageHiddenUnPlayed]];
    if (unplayedArray.count == 0){
        [self flipAllImagesEndGame];
    } else {
        NSInteger randomLocation = [CommonMethods randomNumberGeneratorWithMax:(u_int32_t)unplayedArray.count-1];
        if (randomLocation < unplayedArray.count){
        currentSelectedGrid = [unplayedArray objectAtIndex:randomLocation];
            NSLog(@"Random value %li",(unsigned long)[gridCollectionImageData indexOfObject:currentSelectedGrid]);
        }
        [targetImageView setImage:currentSelectedGrid.imageObject];
    }
}
#pragma mark - Game Start Point
-(void)flipAllImagesStartGame {
    [gridCollectionImageData enumerateObjectsUsingBlock:^(GridImage*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.flipState = FlipStateImageHiddenUnPlayed;
    }];
    [collectionGridView reloadData];
    [self createRandomSelectionOfUnplayedGrids];
}
-(void)flipAllImagesEndGame {
    [gridCollectionImageData enumerateObjectsUsingBlock:^(GridImage*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.flipState = FlipStateImageHiddenPlayed;
    }];
    [targetImageView setImage:[UIImage imageNamed:@"flipOffState"]];
    [collectionGridView reloadData];
    [self cleanCacheAfterGame];
}
- (void)cleanCacheAfterGame {
    [SDWebImageManager.sharedManager.imageCache clearMemory];
    [SDWebImageManager.sharedManager.imageCache clearDisk];
}
#pragma mark - Grid Cell Delegate
-(void)imageFlipComplete {
    [self createRandomSelectionOfUnplayedGrids];
}

#pragma mark - Timer and Start Button Action
- (IBAction)startBtnTapped:(id)sender {
    if (!timeToStartGame) {
    [collectionGridView reloadData];
    timeToStartGame = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:true];
    }
}
-(void)updateTimer {
    static NSInteger time = 0;
    time = time+1;
    [startGameBtn setTitle:[NSString stringWithFormat:@"Timer: %li", (long)time] forState:UIControlStateNormal];
    if (time == 16){
        [timeToStartGame invalidate];
        [self flipAllImagesStartGame];
        startGameBtn.hidden = true;
    }
}
@end
