//
//  OS_DFS_BFS.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/26/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OS_DFS_BFS.h"
#import "OSDisjointSet.h"
#import "OSTreeNode.h"
#import "OSUndirectedGraphNode.h"
#import "OSListNode.h"

#define matrixColsAllNeighbors [[NSArray alloc] initWithObjects:@1, @1, @1, @0, @0, @-1, @-1, nil]
#define matrixRowsAllNeighbors [[NSArray alloc] initWithObjects:@-1, @0, @1, @-1, @1, @-1, @1, nil]
#define matrixRows [[NSArray alloc] initWithObjects:@1, @-1, @0, @0, nil]
#define matrixCols [[NSArray alloc] initWithObjects:@0, @0, @1, @-1, nil]

@implementation OS_DFS_BFS

-(int)LC296:(NSArray *)M{
    
    int result = 0;
    
    if([M count] == 0){
        return result;
    }
    
    // Vertical and Horizontal arrays will help us to find out
    // the mid point between all positions of the attendees
    NSMutableArray *vertical = [NSMutableArray array];
    NSMutableArray *horizontal = [NSMutableArray array];
    
    // Traverse the matrix inorder to find the points where we have an attendant
    for(int row = 0; row < [M count]; row++){
        for(int col = 0; col < [M[0] count]; col++){
            if([M[row][col] intValue] == 1){
                // Add current row into vertical array
                [vertical addObject:[NSNumber numberWithInt:row]];
                // Add current column into horizontal array
                [horizontal addObject:[NSNumber numberWithInt:col]];
            }
        }
    }
    
    // Sort both vertical and horizontal arrays and we will find out
    // maximum and minimum ditance for all attendees
    vertical = [[vertical sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    horizontal = [[horizontal sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    // Calculate mid point of all vertical and horizontal points
    int midPointVertical = [[vertical objectAtIndex:[vertical count] / 2] intValue];
    int midPointHorizontal = [[horizontal objectAtIndex:[horizontal count] / 2] intValue];
    
    // Traverse again the matrix to calculate the result
    for(int row = 0; row < [M count]; row++){
        for(int col = 0; col < [M[0] count]; col++){
            if([M[row][col] intValue] == 1){
                // Add the distance from each point to the mid point for both vertical and horizontal
                result += abs(midPointVertical - row) + abs(midPointHorizontal - col);
            }
        }
    }
    
    NSLog(@"\n\nLC296: %d\n.", result);
    
    return result;
}

-(void)LC130:(NSMutableArray *)M{
    
    int rows = (int)[M count];
    int columns = (int)[M[0] count];
    NSMutableArray *result = [NSMutableArray array];
    
    // Find 'O's in first and last column and updated to 'N'
    // since this elements and their cluster cannot be surrounded
    for(int row = 0; row < rows; row++){
        if([M[row][0] isEqualToString:@"O"]){
            [self helperLC130:M with:row with:0];
        }
        if([M[row][columns - 1] isEqualToString:@"O"]){
            [self helperLC130:M with:row with:columns - 1];
        }
    }
    
    // Find 'O's in first and last row and updated to 'N'
    // since this elements and their cluster cannot be surrounded
    for(int col = 1; col < columns - 1; col++){
        if([M[0][col] isEqualToString:@"O"]){
            [self helperLC130:M with:0 with:col];
        }
        if([M[rows - 1][col] isEqualToString:@"O"]){
            [self helperLC130:M with:rows - 1 with:col];
        }
    }
    
    // Now we can update all 'O' with 'X' since they will be surrounded by 'X'
    // At the same time we update the 'N' to 'O'
    // also we create an array to print the result
    for(int row = 0; row < [M count]; row++){
        NSMutableArray *temp = [NSMutableArray array];
        for(int col = 0; col < [M[0] count]; col++){
            if([M[row][col] isEqualToString:@"O"]){
                [M[row] replaceObjectAtIndex:col withObject:@"X"];
            }
            
            if(col > 0 && [M[row][col - 1] isEqualToString:@"N"]){
                [M[row] replaceObjectAtIndex:col - 1 withObject:@"O"];
                [temp replaceObjectAtIndex:col - 1 withObject:@"O"];
            }
            
            [temp addObject:M[row][col]];
        }
        
        if([M[row][columns - 1] isEqualToString:@"N"]){
            [M[row] replaceObjectAtIndex:columns - 1 withObject:@"O"];
            [temp replaceObjectAtIndex:columns - 1 withObject:@"O"];
        }
        
        [result addObject:[temp componentsJoinedByString:@" "]];
    }
    
    NSLog(@"\n\nLC130: %@\n.", [result componentsJoinedByString:@"\n"]);
}
-(void)helperLC130:(NSMutableArray *)M with:(int)row with:(int)col{
    
    if(row < 0 || row >= [M count] || col < 0 || col >= [M[0] count]){
        return;
    }
    
    if([M[row][col] isEqualToString:@"O"]){
        
        [M[row] replaceObjectAtIndex:col withObject:@"N"];
        
        [self helperLC130:M with:row - 1 with:col];
        [self helperLC130:M with:row + 1 with:col];
        [self helperLC130:M with:row with:col + 1];
        [self helperLC130:M with:row with:col - 1];
    }
}

-(NSArray *)LC721:(NSArray *)M{
    
    NSMutableArray *result = [NSMutableArray array];
    
    if([M count] == 0){
        return [result copy];
    }
    
    NSMutableDictionary *dicNames = [NSMutableDictionary dictionary];
    NSMutableDictionary *dicResult = [NSMutableDictionary dictionary];
    OSDisjointSet *disjointSet = [[OSDisjointSet alloc] init];
    NSString *name = @"";
    NSString *mainEmail = @"";
    
    for(NSArray *account in M){
        name = [account firstObject];
        mainEmail = [account objectAtIndex:1];
        // Make a set if first email account does not exists in the dictionary of emails
        if([dicNames objectForKey:mainEmail] == nil){
            [dicNames setObject:name forKey:mainEmail];
            [disjointSet makeSet:mainEmail];
        }
        // Traverse the elements for each account
        for(NSString *item in account){
            // First element is the name so we skip this item
            if([name isEqualToString:item]){
                continue;
            }
            // If current item does not exists in the dictionary of emails we make a set
            if([dicNames objectForKey:item] == nil){
                [dicNames setObject:name forKey:item];
                [disjointSet makeSet:item];
            }
            // We do union set of current email and main email in the account
            [disjointSet unionSet:item with:mainEmail];
        }
    }
    // We traverse again the dictionary of emails and we do find set
    // in order to get the representative email and start building a dictionary
    // with the representative email as a key and the emails of the same group as a value
    for(NSString *key in [dicNames allKeys]){
        NSString *setObj = [disjointSet findSet:key];
        NSMutableArray *temp = [dicResult objectForKey:setObj];
        if(temp == nil){
            temp = [NSMutableArray array];
            [dicResult setObject:temp forKey:setObj];
        }
        [temp addObject:key];
    }
    // Finally we iterate through the dictionary with the emails
    // merged to create the result
    for(NSString *key in [dicResult allKeys]){
        NSMutableArray *temp = [NSMutableArray array];
        [temp addObject:[dicNames objectForKey:key]];
        [temp addObjectsFromArray:[dicResult objectForKey:key]];
        [result addObject:temp];
    }
    
    return [result copy];
}

-(NSArray *)LC529:(NSArray *)M with:(int)row with:(int)col{
    
    NSMutableArray *result = [NSMutableArray array];
    if([M count] == 0){
        return result;
    }
    
    // Create a mutable copy of the current 2D matrix since we are going to update the cells
    NSMutableArray *board = [NSMutableArray array];
    for(int i = 0; i < [M count]; i++){
        [board addObject:[M[i] mutableCopy]];
    }
    NSMutableSet *visited = [NSMutableSet set];
    if([M[row][col] isEqualToString:@"M"]){
        [M[row] replaceObjectAtIndex:col withObject:@"X"];
    }
    
    [self helperLC529:board with:row with:col with:visited];
    
    // Print the result
    NSString *temp = @"";
    for(int i = 0; i < [board count]; i++){
        temp = [NSString stringWithFormat:@"%@%@\n", temp, [board[i] componentsJoinedByString:@" "]];
    }
    NSLog(@"\n\nLC529: \n\n%@\n\n\n.", temp);
    
    return [result copy];
}
-(void)helperLC529:(NSMutableArray *)M with:(int)row with:(int)col with:(NSMutableSet *)visited{
    
    
    // Validate bounds of current row and col and cell value should be 'E'
    if(row < 0 || row >= [M count] || col < 0 || col >= [M[0] count] ||
       ![M[row][col] isEqualToString:@"E"]){
        return;
    }
    // Validate if we already visited current cell
    NSString *currentCell = [NSString stringWithFormat:@"%d-%d", row, col];
    if([visited containsObject:currentCell]){
        return;
    }
    // Add current cell to visited set
    [visited addObject:currentCell];
    // Check neighbors of current cell and count total number of mines around it
    int minesAround = 0;
    for(int i = 0; i < 8; i++){
        int posX = col + [matrixColsAllNeighbors[i] intValue];
        int posY = row + [matrixRowsAllNeighbors[i] intValue];
        if((posX >= 0 && posX < [M[0] count] && posY >= 0 && posY < [M count])){
            if([M[posY][posX] isEqualToString:@"M"] || [M[posY][posX] isEqualToString:@"X"]){
                minesAround++;
            }
        }
    }
    
    // Update current cell with either total mines of blank
    NSString *currentValue = minesAround == 0 ? @"B" : [NSString stringWithFormat:@"%d", minesAround];
    [M[row] replaceObjectAtIndex:col withObject:currentValue];
    
    // Explore all neighbors
    for(int i = 0; i < 8; i++){
        int posX = row + [matrixColsAllNeighbors[i] intValue];
        int posY = col + [matrixRowsAllNeighbors[i] intValue];
        if((posX >= 0 && posX < [M[0] count] && posY >= 0 && posY < [M count])){
            
            [self helperLC529:M with:posY with:posX with:visited];
        }
    }
}

-(NSArray *)LC515:(OSTreeNode *)root{
    
    if(root == nil){
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    // Get the heigh of the tree, this will help to get all elements at
    // each level
    int heigh = [root getTreeHeight:root];
    for(int i = 1; i <= heigh; i++){
        
        // For each level add an element to the array
        // in the end we will get total elements equal to the heigh of the tree,
        // which is one element for each level
        [result addObject:[NSNumber numberWithInt:INT_MIN]];
        // We call recursion method going deep until we match the ith level
        [self helperLC515:root with:i with:i with:result];
    }
    
    NSLog(@"\n\nLC515: [%@]\n.", [result componentsJoinedByString:@", "]);
    
    return [result copy];
}
-(void)helperLC515:(OSTreeNode *)root with:(int)level with:(int)currentLevel with:(NSMutableArray *)result{
    
    if(root == nil){
        return;
    }
    // If level is equal to 1 we reach the current deep level
    if(level == 1){
        // Update the maximum value for each level
        int currentMax = fmax([[result objectAtIndex:currentLevel - 1] intValue], root.value);
        [result replaceObjectAtIndex:currentLevel - 1 withObject:[NSNumber numberWithInt:currentMax]];
    }
    else if(level > 1){
        // Call recursion until level is equal to 1
        [self helperLC515:root.left with:level - 1 with:currentLevel with:result];
        [self helperLC515:root.right with:level - 1 with:currentLevel with:result];
    }
}

-(NSArray *)LC491:(NSArray *)M{
    
    if([M count] < 2){
        return nil;
    }
    
    NSMutableArray *tempResult = [NSMutableArray array];
    
    for(int i = 0; i < [M count]; i++){
        [tempResult addObject:[NSMutableArray array]];
    }
    
    for(int i = 0; i < [M count]; i++){
        NSMutableArray *temp = [NSMutableArray array];
        [temp addObject:[M objectAtIndex:i]];
        [[tempResult objectAtIndex:i] addObject:temp];
    }
    
    for(int i = 1; i < [M count]; i++){
        for(int j = 0; j < i; j++){
            if([M[i] intValue] >= [M[j] intValue]){
                for(NSMutableArray *subArray in [tempResult objectAtIndex:j]){
                    NSMutableArray *temp = [subArray mutableCopy];
                    [temp addObject:[M objectAtIndex:i]];
                    [[tempResult objectAtIndex:i] addObject:temp];
                }
            }
        }
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.@count>=2"];
    NSMutableSet *resultSet = [NSMutableSet set];
    for(int i = 0; i < [M count]; i++){
        
        NSArray *filter = [tempResult[i] filteredArrayUsingPredicate:predicate];
        if([filter count] > 0){
            [resultSet addObject:filter];
        }
    }
    
    return [resultSet allObjects];
}
-(void)helperLC491:(NSArray *)M with:(NSMutableArray *)tempArray with:(int)currentIndex with:(NSMutableArray *)result{
    
    // Once the temp array has more than two elements we added to the final result
    if([tempArray count] >= 2){
        [result addObject:[tempArray copy]];
    }
    // Using backtracking to create all subsets of the array
    for(int i = currentIndex; i < [M count]; i++){
        // If array is empty or last element is less than element at current index
        // we add the element to the array and we call recursion
        if([tempArray count] == 0 || [[tempArray lastObject] intValue] <= [[M objectAtIndex:i] intValue]){
            [tempArray addObject:[M objectAtIndex:i]];
            [self helperLC491:M with:tempArray with:i + 1 with:result];
            [tempArray removeLastObject];
        }
    }
}

-(NSArray *)LC199:(OSTreeNode *)root{
    
    NSMutableArray *result = [NSMutableArray array];
    if (root == nil) {
        return [result copy];
    }
    
    [self helperLC199:root with:0 with:result];
    
    return [result copy];
}

-(void)helperLC199:(OSTreeNode *)root with:(int)level with:(NSMutableArray *)result{
    
    if(root == nil){
        return;
    }
    
    if([result count] == level){
        [result addObject:[NSNumber numberWithInt:root.value]];
    }
    
    [self helperLC199:root.right with:level + 1 with:result];
    [self helperLC199:root.left with:level + 1 with:result];
}

-(OSUndirectedGraphNode *)LC133:(OSUndirectedGraphNode *)node{
    
    if(node == nil){
        return nil;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableSet *visited = [NSMutableSet set];
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:node];
    OSUndirectedGraphNode *currentNode;
    OSUndirectedGraphNode *clonedNode;
    
    // Do BFS to traverse the graph
    while([queue count] > 0){
        currentNode = [queue firstObject];
        [queue removeObjectAtIndex:0];
        [visited addObject:currentNode];
        // Create a clone of each node without neighbors
        [dic setObject:[[OSUndirectedGraphNode alloc] initWithValue:currentNode.label] forKey:[NSNumber numberWithInt:currentNode.label]];
        for(OSUndirectedGraphNode *neighbor in currentNode.neighbors){
            if(![visited containsObject:neighbor]){
                [queue addObject:neighbor];
            }
        }
    }
    
    [visited removeAllObjects];
    [queue addObject:node];
    // Do BFS again and this time we are going to create the neighbors for each node
    while([queue count] > 0){
        currentNode = [queue firstObject];
        [queue removeObjectAtIndex:0];
        [visited addObject:currentNode];
        // Get the current node from dictionary
        clonedNode = [dic objectForKey:[NSNumber numberWithInt:currentNode.label]];
        for(OSUndirectedGraphNode *neighbor in currentNode.neighbors){
            // Assign the neighbors from the same dictionary
            [clonedNode.neighbors addObject:[dic objectForKey:[NSNumber numberWithInt:neighbor.label]]];
            if(![visited containsObject:neighbor]){
                [queue addObject:neighbor];
            }
        }
    }
    
    return [dic objectForKey:[NSNumber numberWithInt:node.label]];
}

-(NSArray *)LC417:(NSArray *)M{
    
    if([M count] == 0){
        return [NSArray array];
    }
    NSMutableSet *emptyMatrixPacific = [NSMutableSet set];
    NSMutableSet *emptyMatrixAtlantic = [NSMutableSet set];
    
    // Traverse first row for Pacific and last row for Atlantic
    for(int row = 0; row < [M count]; row++){
        [self helperLC417:M with:row with:0 with:emptyMatrixPacific ];
        [self helperLC417:M with:row with:(int)[M[0] count] - 1 with:emptyMatrixAtlantic];
    }
    // Traverse first column for Pacific and last column for Atlantic
    for(int col = 0; col < [M[0] count]; col++){
        [self helperLC417:M with:0 with:col with:emptyMatrixPacific];
        [self helperLC417:M with:(int)[M count] - 1 with:col with:emptyMatrixAtlantic];
    }
    
    // Get intersection of two sets
    [emptyMatrixPacific intersectSet:emptyMatrixAtlantic];
    NSArray *arrayIntersection = [emptyMatrixPacific allObjects];
    NSArray *result = [arrayIntersection sortedArrayUsingSelector:@selector(compare:)];
    
    return [result copy];
}
-(void)helperLC417:(NSArray *)M with:(int)row with:(int)col with:(NSMutableSet *)result{
    
    int rows = (int)[M count];
    int cols = (int)[M[0] count];
    // Add current cell to the set
    NSString *currentCell = [NSString stringWithFormat:@"%d-%d", row, col];
    [result addObject:currentCell];
    for(int i = 0; i < 4; i++){
        int y = row + [matrixRows[i] intValue];
        int x = col + [matrixCols[i] intValue];
        currentCell = [NSString stringWithFormat:@"%d-%d", y, x];
        // Validate bounds of the matrix and value at cell position is greater or equal to currentValue
        if(y >= 0 && y < rows && x >= 0 && x < cols && [M[y][x] intValue] >= [M[row][col] intValue] && ![result containsObject:currentCell]){
            [self helperLC417:M with:y with:x with:result];
        }
    }
}

-(NSString *)LC394:(NSString *)s{
    
    if([s length] == 0){
        return @"";
    }
    NSString *result = @"";
    
    NSMutableArray *stack = [NSMutableArray array];
    NSMutableArray *stackNums = [NSMutableArray array];
    NSCharacterSet *validNums = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int index = 0;
    int currentNum = 0;
    NSString *temp;
    
    while(index < [s length]){
        
        char currentChar = [s characterAtIndex:index];
        if([validNums characterIsMember:currentChar]){
            currentNum = 0;
            while([validNums characterIsMember:currentChar]){
                currentNum = ((currentChar - '0') + (10 * currentNum));
                index++;
                currentChar = [s characterAtIndex:index];
            }
            
            [stackNums addObject:[NSNumber numberWithInt:currentNum]];
            [stack addObject:[NSString stringWithFormat:@"%c", currentChar]];
        }
        else if(currentChar == ']'){
            temp = [stack lastObject];
            [stack removeLastObject];
            while(![[stack lastObject] isEqualToString:@"["]){
                temp = [NSString stringWithFormat:@"%@%@", [stack lastObject], temp];
                [stack removeLastObject];
            }
            [stack removeLastObject];
            
            NSString *currentCluster = @"";
            currentNum = [[stackNums lastObject] intValue];
            for(int i = 0; i < currentNum; i++){
                currentCluster = [NSString stringWithFormat:@"%@%@", currentCluster, temp];
            }
            
            [stack addObject:currentCluster];
            [stackNums removeLastObject];
        }
        else{
            [stack addObject:[NSString stringWithFormat:@"%c", currentChar]];
        }
        
        index++;
    }
    
    result = [stack componentsJoinedByString:@""];
    return result;
}

-(OSTreeNode *)LC105:(NSArray *)preorder with:(NSArray *)inorder{
    
    if([preorder count] == 0 || [inorder count] == 0){
        return nil;
    }
    
    // First element in preorder array is always the root
    OSTreeNode *result = [[OSTreeNode alloc] initWithValue:[[preorder objectAtIndex:0] intValue]];
    OSTreeNode *tempTree = result;
    NSMutableArray *stack = [NSMutableArray array];
    int preorderIndex = 1;
    int inorderIndex = 0;
    BOOL flagLeftRight = false;
    // Add root to the stack
    [stack addObject:result];
    while(preorderIndex < [preorder count]){
        // If last element in the stack is equal to element at current index of inorder array that means we skip
        // current element and the next new node will be the right node, basically inorder array will help us
        // to know when should we add the right node
        if([stack count] != 0 && ((OSTreeNode *)[stack lastObject]).value == [[inorder objectAtIndex:inorderIndex] intValue]){
            // Update current tempTree since it is right node will be the new one
            tempTree = [stack lastObject];
            [stack removeLastObject];
            flagLeftRight = true;
            inorderIndex++;
        }
        else{
            OSTreeNode *newNode = [[OSTreeNode alloc] initWithValue:[[preorder objectAtIndex:preorderIndex] intValue]];
            //If flag is true that means next object will be the right node of current tempTree
            if(flagLeftRight){
                tempTree.right = newNode;
                // Update flag since next new node will the left node
                flagLeftRight = false;
            }
            else{
                tempTree.left = newNode;
            }
            // tempTree it is always the las element created
            tempTree = newNode;
            [stack addObject:newNode];
            preorderIndex++;
        }
    }
    
    return result;
}

-(OSTreeNode *)LC106:(NSArray *)postorder with:(NSArray *)inorder{
    
    if([postorder count] == 0 || [inorder count] == 0){
        return nil;
    }
    
    // Last element in postorder array is always the root
    OSTreeNode *result = [[OSTreeNode alloc] initWithValue:[[postorder lastObject] intValue]];
    OSTreeNode *currentTree = result;
    OSTreeNode *lastTree = nil;
    NSMutableArray *stack = [NSMutableArray array];
    int postorderIndex = (int)[postorder count] - 2;
    int inorderIndex = (int)[inorder count] - 1;
    
    [stack addObject:result];
    while (postorderIndex > - 1){
        
        currentTree = [stack lastObject];
        if(currentTree.value == [[inorder objectAtIndex:inorderIndex] intValue]){
            inorderIndex--;
            [stack removeLastObject];
            lastTree = [stack lastObject];
            if(lastTree.value == [[inorder objectAtIndex:inorderIndex] intValue]){
                continue;
            }
            currentTree.left = [[OSTreeNode alloc] initWithValue:[[postorder objectAtIndex:postorderIndex] intValue]];
            [stack addObject:currentTree.left];
        }
        else{
            currentTree = [[OSTreeNode alloc] initWithValue:[[postorder objectAtIndex:postorderIndex] intValue]];
            lastTree = [stack lastObject];
            lastTree.right = currentTree;
            [stack addObject:currentTree];
        }
        
        postorderIndex--;
    }
    
    return result;
}

-(void)LC114:(OSTreeNode *)root{
    
    if(root == nil){
        return;
    }
    OSTreeNode *currentTree = root;
    while(currentTree){
        // We can swap nodes, basically going to the left and from there going to the deepest right node
        // then set least right node with the current right node and then update the current right node
        // with the left node and set left node to nil, repeat this process until we traverse all the right nodes
        // and there is no more left nodes
        if(currentTree.left){
            OSTreeNode *tempNode = currentTree.left;
            while(tempNode.right){
                tempNode = tempNode.right;
            }
            tempNode.right = currentTree.right;
            currentTree.right = currentTree.left;
            currentTree.left = nil;
        }
        currentTree = currentTree.right;
    }
}

-(int)LC124:(OSTreeNode *)root{
    
    if(root == nil){
        return 0;
    }
    // Get the maximum value for left and right trees
    int left = fmax([self LC124:root.left], 0);
    int right = fmax([self LC124:root.right], 0);
    // Update current max, either the sum of left, right and node or current max
    _resultLC124 = fmax(_resultLC124, left + right + root.value);
    // Return maximum path for an especific node
    return fmax(left, right) + root.value;
}

-(BOOL)LC207:(int)numCourses with:(NSArray *)prerequisites{
    
    NSMutableSet *visited = [NSMutableSet set];
    NSMutableSet *completed = [NSMutableSet set];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for(NSArray *item in prerequisites){
        NSNumber *first = [NSNumber numberWithInt:[[item objectAtIndex:0] intValue]];
        NSNumber *second = [NSNumber numberWithInt:[[item objectAtIndex:1] intValue]];
        NSMutableArray *temp = [dic objectForKey:first];
        if(temp == nil){
            temp = [NSMutableArray array];
            [dic setObject:temp forKey:first];
        }
        [temp addObject:second];
    }
    
    for(int i = 0; i < numCourses; i++){
        [self helperLC207:dic with:visited with:completed with:[NSNumber numberWithInt:i]];
        if([completed count] >= numCourses){
            return true;
        }
    }
    
    return false;
}

-(BOOL)helperLC207:(NSMutableDictionary *)courses with:(NSMutableSet *)visited with:(NSMutableSet *)completed with:(NSNumber *)course{
    
    if([completed containsObject:course]){
        return true;
    }
    if([visited containsObject:course]){
        return false;
    }
    NSMutableArray *items = [courses objectForKey:course];
    for(NSNumber *item in items){
        [visited addObject:course];
        if(![self helperLC207:courses with:visited with:completed with:item]){
            return false;
        }
    }
    [completed addObject:course];
    return true;
}

-(BOOL)LC098:(OSTreeNode *)root{
    
    return [self helperLC098:root with:INT_MIN with:INT_MAX];
}

-(BOOL)helperLC098:(OSTreeNode *)root with:(int)minVal with:(int)maxVal{
    
    if(root == nil){
        return true;
    }
    
    if(root.value >= maxVal || root.value <= minVal){
        return false;
    }
    else{
        return [self helperLC098:root.left with:minVal with:root.value] && [self helperLC098:root.right with:root.value with:maxVal];
    }
}

-(OSTreeNode *)LC109:(OSListNode *)head{
    
    if(head == nil){
        return nil;
    }
    
    OSTreeNode *result = [self helperLC109:head with:nil];
    
    return result;
}

-(OSTreeNode *)helperLC109:(OSListNode *)start with:(OSListNode *)end{
    
    if(start == end){
        return nil;
    }
    
    OSListNode *mid = start;
    OSListNode *runner = start;
    while(runner != end && runner.next != nil && runner.next != end){
        mid = mid.next;
        runner = runner.next.next;
    }
    
    OSTreeNode *result = [[OSTreeNode alloc] initWithValue:mid.value];
    result.left = [self helperLC109:start with:mid];
    result.right = [self helperLC109:mid.next with:end];
    
    return result;
}

-(int)LC127:(NSString *)beginWord with:(NSString *)endWord with:(NSArray *)wordList{
    
    if(![wordList containsObject:endWord]){
        return 0;
    }
    
    int result = 0;
    NSMutableArray *queue = [NSMutableArray array];
    NSMutableSet *visited = [NSMutableSet set];
    NSString *currentWord = @"";
    NSString *tempWord = @"";
    [queue addObject:beginWord];
    [visited addObject:beginWord];
    
    while([queue count] > 0){
        
        currentWord = [queue firstObject];
        [queue removeObjectAtIndex:0];
        result++;
        
        if([currentWord isEqualToString:endWord]){
            return result;
        }
        else{
            for(int i = 0; i < [currentWord length]; i++){
                for(char currentChar = 'a'; currentChar <='z'; currentChar++){
                    
                    tempWord = [NSString stringWithFormat:@"%@%c%@", [currentWord substringToIndex:i], currentChar, [currentWord substringFromIndex:i + 1]];
                    
                    if([wordList containsObject:tempWord] && ![visited containsObject:tempWord]){
                        
                        if([tempWord isEqualToString:endWord]){
                            return result;
                        }
                        
                        [queue addObject:tempWord];
                        [visited addObject:tempWord];
                    }
                }
            }
        }
    }
    
    return 0;
}

-(NSString *)LC332:(NSArray *)tickets{
    
    if([tickets count] == 0){
        return @"";
    }
    
    //  Create a dictionary for each element and the value will be an array
    //  with all destinations
    NSString *result = @"";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *ticketFrom = @"";
    NSString *ticketTo = @"";
    for(NSArray *array in tickets){
        ticketFrom = array[0];
        ticketTo = array[1];
        NSMutableArray *temp = [dic objectForKey:ticketFrom];
        if(temp == nil){
            temp = [NSMutableArray array];
            [dic setObject:temp forKey:ticketFrom];
        }
        [temp addObject:ticketTo];
    }
    //  Sort the elements to get lexical order
    for(NSString *key in [dic allKeys]){
        NSMutableArray *temp = [dic objectForKey:key];
        temp = [[[[temp sortedArrayUsingSelector:@selector(compare:)] reverseObjectEnumerator] allObjects] mutableCopy];
        [dic setObject:temp forKey:key];
    }
    
    //  We can use Hierholzer’s Algorithm in order to solve this problem
    //  The idea is use a stack to push every key element from the dictionary
    //  if the array of elements for each key is empty we are going to push the key in the
    //  itinerary and updating the current key from the stack
    NSMutableArray *stack = [NSMutableArray array];
    NSMutableArray *itinerary = [NSMutableArray array];
    NSString *current = @"JFK";
    
    while([stack count] > 0 || [[dic objectForKey:current] count] > 0){
        NSMutableArray *temp = [dic objectForKey:current];
        if([temp count] == 0){
            [itinerary addObject:current];
            current = [stack lastObject];
            [stack removeLastObject];
        }
        else{
            [stack addObject:current];
            current = [temp lastObject];
            [temp removeLastObject];
        }
    }
    
    [itinerary addObject:current];
    result = [[[itinerary reverseObjectEnumerator] allObjects] componentsJoinedByString:@","];
    
    return result;
}


@end
