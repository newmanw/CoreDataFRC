//
//  ViewController.m
//  CoreDataTest
//

#import "ViewController.h"
#import "Report.h"

@interface ViewController ()<NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *reportFetchedResultsController;
@property (nonatomic, strong) NSFetchedResultsController *documentFetchedResultsController;
@property (weak, nonatomic) IBOutlet UITextView *label1;
@property (weak, nonatomic) IBOutlet UITextView *label2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.reportFetchedResultsController = [Report MR_fetchAllSortedBy:@"timestamp"
                                                      ascending:NO
                                                  withPredicate:[NSPredicate predicateWithFormat:@"dirty == YES"]
                                                        groupBy:nil
                                                       delegate:self
                                                      inContext:[NSManagedObjectContext MR_defaultContext]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id) anObject atIndexPath:(NSIndexPath *) indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *) newIndexPath {
    
        switch(type) {
            case NSFetchedResultsChangeInsert:
                self.label1.textColor = [UIColor greenColor];
                self.label1.text = @"Report has been inserted, this is expected";
                break;
            case NSFetchedResultsChangeUpdate:
                self.label2.textColor = [UIColor redColor];
                self.label2.text = @"Report has been updated, why????";
                break;
        }
}


- (IBAction) saveToCoreData:(UIButton *)sender {
    // Background context
    NSManagedObjectContext *context = [NSManagedObjectContext MR_context];
    
    Report *report = [Report MR_createInContext:context];
    report.dirty = [NSNumber numberWithBool:YES];
    report.timestamp = [NSDate date];
    
    NSLog(@"Saving.................................");
    [context MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        NSLog(@"Saved report to persistent store");
    }];
}

@end
