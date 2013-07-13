//
//  ListTableViewController.m
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "ListTableViewController.h"
#import "DetailsViewController.h"
#import "CustomCell.h"
#import "Mole.h"
#import "CameraViewController.h"

@interface ListTableViewController () <UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *searchResults;
@property (nonatomic, retain) NSMutableArray *moleArray;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ListTableViewController

@synthesize searchResults;
@synthesize moleButton;
@synthesize moleArray;
@synthesize dataArray;
@synthesize picker;
@synthesize image;

-(IBAction)ChooseExisting{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //[imageView setImage:image];
    [self addMole];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) addMole {
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    Mole *mole1 = [[Mole alloc] init];
    [mole1.imagesArray addObject:image];
    [moleArray addObject:mole1];
    
    //calculate time stamp and add 
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    [mole1.timeStamps addObject:destinationDate];
    
    //add mole name so table view can access
    [self.dataArray addObject:mole1.name];
    
    //not sure this is necessary
    for (int i = 0; i < [decodedArray count]; i++) {
        Mole *temp = [decodedArray objectAtIndex:i];
        [self.dataArray replaceObjectAtIndex:i withObject:temp.name];
        
        [moleArray replaceObjectAtIndex:i withObject:temp];
    }
    
    //save array
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:moleArray];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"moleArray"]];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc] init];
    moleArray = [[NSMutableArray alloc] init];
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:moleArray];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"moleArray"]];
}

- (void) viewDidAppear:(BOOL)animated{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    for (int i = 0; i < [decodedArray count]; i++) {
        Mole *temp = [decodedArray objectAtIndex:i];
        [self.dataArray replaceObjectAtIndex:i withObject:temp.name];
        
        [moleArray replaceObjectAtIndex:i withObject:temp];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) filterContentFprSearchText: (NSString *) searchText
{
    NSPredicate *resultsPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd] %@", searchText];
    self.searchResults = [self.dataArray filteredArrayUsingPredicate:resultsPredicate];
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //[self filterContentForSearchText:searchString];
    [self filterContentFprSearchText:searchString];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView){
        return [self.dataArray count];
    }else{
        return [self.searchResults count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (tableView == self.tableView){
        cell.moleLable.text = [self.dataArray objectAtIndex:indexPath.row];
        Mole *tempMole = [moleArray objectAtIndex:indexPath.row];
        if([tempMole.imagesArray count] != 0){//throws outofbounds error without
            cell.moleImageView.image = [tempMole.imagesArray objectAtIndex:0];
        }
    }else{
        cell.moleLable.text = [self.searchResults objectAtIndex:indexPath.row];
        cell.moleImageView.image = [UIImage imageNamed:@"photo(11).JPG"];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showDetails"]){
        DetailsViewController *dvc = segue.destinationViewController;
        
        NSIndexPath *indexPath = nil;
        
        if([self.searchDisplayController isActive]){
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            dvc.sendLabel = [self.searchResults objectAtIndex:indexPath.row];
            dvc.moleRow = indexPath.row;
            return;
        }else{
            indexPath = [self.tableView indexPathForSelectedRow];
            dvc.sendLabel = [self.dataArray objectAtIndex:indexPath.row];
            dvc.moleRow = indexPath.row;
            return;
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
