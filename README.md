BVReorderTableView
==================

Easy Long Press Reordering for UITableView. Created for and used in my new app [PRAYERFUL](http://www.vogelzangsoftware.com/prayerful).

![Example](https://raw.github.com/bvogelzang/BVReorderTableView/master/Screenshot1.png)

## Example Usage

1. Copy BVReorderTableView.h and BVReorderTableView.m files to your project

2. In the identity inspector of your storyboard file, change the class of your UITableView to BVReorderTableView. Optionally, create the BVReorderTableView yourself.

3. Implement the delegate methods in your view controller and update your tableView:cellForRowAtIndexPath: method to handle the empty row

```objective-c
// This method is called when the long press gesture is triggered starting the re-ording process.
// You insert a blank row object into your data source and return the object you want to save for
// later. This method is only called once.
- (id)saveObjectAndInsertBlankRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [_objects objectAtIndex:indexPath.row];
    // Your dummy object can be something entirely different. It doesn't
    // have to be a string.
    [_objects replaceObjectAtIndex:indexPath.row withObject:@"DUMMY"];
    return object;
}

// This method is called when the selected row is dragged to a new position. You simply update your
// data source to reflect that the rows have switched places. This can be called multiple times
// during the reordering process.
- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    id object = [_objects objectAtIndex:fromIndexPath.row];
    [_objects removeObjectAtIndex:fromIndexPath.row];
    [_objects insertObject:object atIndex:toIndexPath.row];
}


// This method is called when the selected row is released to its new position. The object is the same
// object you returned in saveObjectAndInsertBlankRowAtIndexPath:. Simply update the data source so the
// object is in its new position. You should do any saving/cleanup here.
- (void)finishReorderingWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath; {
    [_objects replaceObjectAtIndex:indexPath.row withObject:object];
    // do any additional cleanup here
}
```

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    // You will have to manually configure what the 'empty' row looks like in this
    // method. Your dummy object can be something entirely different. It doesn't
    // have to be a string.
    if ([[_objects objectAtIndex:indexPath.row] isKindOfClass:[NSString class]] &&
        [[_objects objectAtIndex:indexPath.row] isEqualToString:@"DUMMY"]) {
        cell.textLabel.text = @"";
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else {
        NSDate *object = _objects[indexPath.row];
        cell.textLabel.text = [object description];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}
```

See the ReorderTest demo project included with these files for a working example.

## Requirements

BVReorderTableView requires iOS 5.0 and above.

#### ARC

BVReorderTableView uses ARC as of its 1.0 release.
