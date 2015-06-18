#import <UIKit/UIKit.h>

/**
 *  搜索结果view controller
 */
@interface EMSearchDisplayController : UISearchDisplayController<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>

// 搜索结果源
@property (strong, nonatomic) NSMutableArray *resultsSource;

//编辑cell时显示的风格，默认为UITableViewCellEditingStyleDelete；会将值付给[tableView:editingStyleForRowAtIndexPath:]
@property (nonatomic) UITableViewCellEditingStyle editingStyle;

/**
 *  回调，需要返回tableview的cell
 */
@property (copy) UITableViewCell * (^cellForRowAtIndexPathCompletion)(UITableView *tableView, NSIndexPath *indexPath);
/**
 *  回调，返回某行是否可以编辑
 */
@property (copy) BOOL (^canEditRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

/**
 *  回调，返回某行的高度
 */
@property (copy) CGFloat (^heightForRowAtIndexPathCompletion)(UITableView *tableView, NSIndexPath *indexPath);

/**
 *  回调，某行被选中
 */
@property (copy) void (^didSelectRowAtIndexPathCompletion)(UITableView *tableView, NSIndexPath *indexPath);

/**
 *  回调，某行取消选中
 */
@property (copy) void (^didDeselectRowAtIndexPathCompletion)(UITableView *tableView, NSIndexPath *indexPath);

@end
