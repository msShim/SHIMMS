//
//  redblack.swift
//  CQ
//
//  Created by 남조선명지대학 on 2016. 9. 28..
//  Copyright © 2016년 SMS. All rights reserved.
//
private enum RBTColor {
    case red
    case black
    case doubleBlack
}
public struct Coffee {
    var id: Int?
    var name: String?
    var img: String?
    var category: Int?
    var price: Int?
}
open class RBTNode<T: Comparable>: CustomStringConvertible {
    fileprivate var color: RBTColor = .red
    open var value: Coffee? = nil
    open var right:  RBTNode<T>!
    open var left:  RBTNode<T>!
    open var parent:  RBTNode<T>!
    open var flag: Int?
    
    open var description: String {
        if self.value == nil {
            return "null"
        } else {
            var nodeValue: String
            
            // If the value is encapsulated by parentheses it is red
            // If the value is encapsulated by pipes it is black
            // If the value is encapsulated by double pipes it is double black (This should not occur in a verified RBTree)
            if self.isRed {
                nodeValue = "(\(self.value!))"
            } else if self.isBlack{
                nodeValue = "|\(self.value!)|"
            } else {
                nodeValue = "||\(self.value!)||"
            }
            
            return "(\(self.left.description)<-\(nodeValue)->\(self.right.description))"
        }
    }
    
    init(tree: RBTree<T>) {
        right = tree.nullLeaf
        left = tree.nullLeaf
        parent = tree.nullLeaf
        flag = 0
    }
    
    init() {
        //This method is here to support the creation of a nullLeaf
    }
    
    open var isLeftChild: Bool {
        return self.parent.left === self
    }
    
    open var isRightChild: Bool {
        return self.parent.right === self
    }
    
    open var grandparent: RBTNode<T> {
        return parent.parent
    }
    
    open var sibling: RBTNode<T> {
        if isLeftChild {
            return self.parent.right
        } else {
            return self.parent.left
        }
    }
    
    open var uncle: RBTNode<T> {
        return parent.sibling
    }
    
    fileprivate var isRed: Bool {
        return color == .red
    }
    
    fileprivate var isBlack: Bool {
        return color == .black
    }
    
    fileprivate var isDoubleBlack: Bool {
        return color == .doubleBlack
    }
}

open class RBTree<T: Comparable>: CustomStringConvertible {
    open var root: RBTNode<T>
    fileprivate let nullLeaf: RBTNode<T>
    
    open var description: String {
        return root.description
    }
    
    public init() {
        nullLeaf = RBTNode<T>()
        nullLeaf.color = .black
        root = nullLeaf
    }
    
    public convenience init(withValue value: Coffee) {
        self.init()
        insert(value)
    }
    
    public convenience init(withArray array: [Coffee]) {
        self.init()
        insert(array)
    }
    
    open func insert(_ value: Coffee) {
        let newNode = RBTNode<T>(tree: self)
        newNode.value = value
        insertNode(newNode)
        print(newNode.value)
    }
    
    open func insert(_ values: [Coffee]) {
        for value in values {
            print(value)
            insert(value)
        }
    }
    
    open func delete(_ value: Coffee) {
        let nodeToDelete = find(value)
        if nodeToDelete !== nullLeaf {
            deleteNode(nodeToDelete)
        }
    }
    
    open func find(_ value: Coffee) -> RBTNode<T> {
        let foundNode = findNode(root, value: value)
        return foundNode
    }
    open func findId(_ value: Int) -> RBTNode<T> {
        let foundNode = findNodeId(root, value: value)
        return foundNode
    }
    open func categoryMenu(_ n: RBTNode<T>) -> RBTNode<T>{
        if n.flag == 0{
            n.flag = n.flag! + 1
            if n.left !== nullLeaf{
                return categoryMenu(n.left)
            }
        }
        
        if (n.flag == 1){
            n.flag = n.flag! + 1
            var item = Coffee()
            item.id = n.value?.id
            item.name = n.value?.name
            item.price = n.value?.price
            item.category = n.value?.category
            item.img = n.value?.img
            print(n.value?.id)
            if((n.value?.id)! >= 110001 && (n.value?.id)! <= 210000){
                mCoffeeAll.append(item)
            }
            if((n.value?.id)! >= 110001 && (n.value?.id)! <= 120000){
                mCoffee1.append(item)
            }
            if((n.value?.id)! >= 120001 && (n.value?.id)! <= 130000){
                mCoffee2.append(item)
            }
            if((n.value?.id)! >= 130001 && (n.value?.id)! <= 140000){
                mCoffee3.append(item)
            }
            if((n.value?.id)! >= 210001 && (n.value?.id)! <= 310000){
                gCoffeeAll.append(item)
            }
            if((n.value?.id)! >= 210001 && (n.value?.id)! <= 220000){
                gCoffee1.append(item)
            }
            if((n.value?.id)! >= 220001 && (n.value?.id)! <= 230000){
                gCoffee2.append(item)
            }
            if((n.value?.id)! >= 230001 && (n.value?.id)! <= 240000){
                gCoffee3.append(item)
            }
            if n.right !== nullLeaf{
                return categoryMenu(n.right)
            }
        }
        
        if (n.flag == 2){
            n.flag = 0
            return categoryMenu(n.parent)
        }
        return root
    }
    open func printAll(_ n: RBTNode<T>) -> RBTNode<T> {
        if n.flag == 0{
            //값을 입력 트리의 순서대로 출력하고 싶을 때
            //            print(n.value?.id, "--->")
            n.flag = n.flag! + 1
            if n.left !== nullLeaf{
                return printAll(n.left)
            }
        }
        
        if (n.flag == 1){
            n.flag = n.flag! + 1
            //값의 순서대로 출력하고 싶을 때
            print(n.value?.id,  "--->")
            
            if n.right !== nullLeaf{
                return printAll(n.right)
            }
        }
        
        if (n.flag == 2){
            n.flag = 1
            return printAll(n.parent)
        }
    
        if n.left === nullLeaf && n.right === nullLeaf{
            n.flag = 0
            return printAll(n.parent)
        }
        return root
    }
    
    open func minimum(_ n: RBTNode<T>) -> RBTNode<T> {
        var min = n
        if n.left !== nullLeaf {
            min = minimum(n.left)
        }
        
        return min
    }
    
    open func maximum(_ n: RBTNode<T>) -> RBTNode<T> {
        var max = n
        if n.right !== nullLeaf {
            max = maximum(n.right)
        }
        
        return max
    }
    
    open func verify() {
        if self.root === nullLeaf {
            print("The tree is empty")
            return
        }
        property1()
        property2(self.root)
        property3()
    }
    
    fileprivate func findNode(_ rootNode: RBTNode<T>, value: Coffee) -> RBTNode<T> {
        var nextNode = rootNode
        if rootNode !== nullLeaf && value.id != rootNode.value?.id {
            if value.id! < (rootNode.value?.id!)! {
                nextNode = findNode(rootNode.left, value: value)
            } else {
                nextNode = findNode(rootNode.right, value: value)
            }
        }
        return nextNode
    }
    open func findNodeId(_ rootNode: RBTNode<T>, value: Int) -> RBTNode<T>{
        var nextNode = rootNode
        if rootNode !== nullLeaf && value != rootNode.value?.id {
            if value < (rootNode.value?.id!)! {
                nextNode = findNodeId(rootNode.left, value: value)
            } else {
                nextNode = findNodeId(rootNode.right, value: value)
            }
        }
        return nextNode
    }
    fileprivate func insertNode(_ n: RBTNode<T>) {
        BSTInsertNode(n, parent: root)
        insertCase1(n)
    }
    
    fileprivate func BSTInsertNode(_ n: RBTNode<T>, parent: RBTNode<T>) {
        if parent === nullLeaf {
            self.root = n
        } else if (n.value?.id!)! < (parent.value?.id!)! {
            if parent.left !== nullLeaf {
                BSTInsertNode(n, parent: parent.left)
            } else {
                parent.left = n
                parent.left.parent = parent
            }
        } else {
            if parent.right !== nullLeaf {
                BSTInsertNode(n, parent: parent.right)
            } else {
                parent.right = n
                parent.right.parent = parent
            }
        }
    }
    
    // if node is root change color to black, else move on
    fileprivate func insertCase1(_ n: RBTNode<T>) {
        if n === root {
            n.color = .black
        } else {
            insertCase2(n)
        }
    }
    
    // if parent of node is not black, and node is not root move on
    fileprivate func insertCase2(_ n: RBTNode<T>) {
        if !n.parent.isBlack {
            insertCase3(n)
        }
    }
    
    // if uncle is red do stuff otherwise move to 4
    fileprivate func insertCase3(_ n: RBTNode<T>) {
        if n.uncle.isRed { // node must have grandparent as children of root have a black parent
            // both parent and uncle are red, so grandparent must be black.
            n.parent.color = .black
            n.uncle.color = .black
            n.grandparent.color = .red
            // now both parent and uncle are black and grandparent is red.
            // we repeat for the grandparent
            insertCase1(n.grandparent)
        } else {
            insertCase4(n)
        }
    }
    
    // parent is red, grandparent is black, uncle is black
    // There are 4 cases left:
    // - left left
    // - left right
    // - right right
    // - right left
    
    // the cases "left right" and "right left" can be rotated into the other two
    // so if either of the two is detected we apply a rotation and then move on to
    // deal with the final two cases, if neither is detected we move on to those cases anyway
    fileprivate func insertCase4(_ n: RBTNode<T>) {
        if n.parent.isLeftChild && n.isRightChild { // left right case
            leftRotate(n.parent)
            insertCase5(n.left)
        } else if n.parent.isRightChild && n.isLeftChild { // right left case
            rightRotate(n.parent)
            insertCase5(n.right)
        } else {
            insertCase5(n)
        }
    }
    
    fileprivate func insertCase5(_ n: RBTNode<T>) {
        // swap color of parent and grandparent
        // parent is red grandparent is black
        n.parent.color = .black
        n.grandparent.color = .red
        
        if n.isLeftChild { // left left case
            rightRotate(n.grandparent)
        } else { // right right case
            leftRotate(n.grandparent)
        }
    }
    
    fileprivate func deleteNode(_ n: RBTNode<T>) {
        var toDel = n
        
        if toDel.left === nullLeaf && toDel.right === nullLeaf && toDel.parent === nullLeaf {
            self.root = nullLeaf
            return
        }
        
        if toDel.left === nullLeaf && toDel.right === nullLeaf && toDel.isRed {
            if toDel.isLeftChild {
                toDel.parent.left = nullLeaf
            } else {
                toDel.parent.right = nullLeaf
            }
            return
        }
        
        if toDel.left !== nullLeaf && toDel.right !== nullLeaf {
            let pred = maximum(toDel.left)
            toDel.value = pred.value
            toDel = pred
        }
        
        // from here toDel has at most 1 non nullLeaf child
        
        var child: RBTNode<T>
        if toDel.left !== nullLeaf {
            child = toDel.left
        } else {
            child = toDel.right
        }
        
        if toDel.isRed || child.isRed {
            child.color = .black
            
            if toDel.isLeftChild {
                toDel.parent.left = child
            } else {
                toDel.parent.right = child
            }
            
            if child !== nullLeaf {
                child.parent = toDel.parent
            }
        } else { // both toDel and child are black
            
            var sibling = toDel.sibling
            
            if toDel.isLeftChild {
                toDel.parent.left = child
            } else {
                toDel.parent.right = child
            }
            if child !== nullLeaf {
                child.parent = toDel.parent
            }
            child.color = .doubleBlack
            
            while child.isDoubleBlack || (child.parent !== nullLeaf && child.parent != nil) {
                if sibling.isBlack {
                    
                    var leftRedChild: RBTNode<T>! = nil
                    if sibling.left.isRed {
                        leftRedChild = sibling.left
                    }
                    var rightRedChild: RBTNode<T>! = nil
                    if sibling.right.isRed {
                        rightRedChild = sibling.right
                    }
                    
                    if leftRedChild != nil || rightRedChild != nil { // at least one of sibling's children are red
                        child.color = .black
                        if sibling.isLeftChild {
                            if leftRedChild != nil { // left left case
                                sibling.left.color = .black
                                let tempColor = sibling.parent.color
                                sibling.parent.color = sibling.color
                                sibling.color = tempColor
                                rightRotate(sibling.parent)
                            } else { // left right case
                                if sibling.parent.isRed {
                                    sibling.parent.color = .black
                                } else {
                                    sibling.right.color = .black
                                }
                                leftRotate(sibling)
                                rightRotate(sibling.grandparent)
                            }
                        } else {
                            if rightRedChild != nil { // right right case
                                sibling.right.color = .black
                                let tempColor = sibling.parent.color
                                sibling.parent.color = sibling.color
                                sibling.color = tempColor
                                leftRotate(sibling.parent)
                            } else { // right left case
                                if sibling.parent.isRed {
                                    sibling.parent.color = .black
                                } else {
                                    sibling.left.color = .black
                                }
                                rightRotate(sibling)
                                leftRotate(sibling.grandparent)
                            }
                        }
                        break
                    } else { // both sibling's children are black
                        child.color = .black
                        sibling.color = .red
                        if sibling.parent.isRed {
                            sibling.parent.color = .black
                            break
                        }
                        /*
                         sibling.parent.color = .doubleBlack
                         child = sibling.parent
                         sibling = child.sibling
                         */
                        if sibling.parent.parent === nullLeaf { // parent of child is root
                            break
                        } else {
                            sibling.parent.color = .doubleBlack
                            child = sibling.parent
                            sibling = child.sibling // can become nill if child is root as parent is nullLeaf
                        }
                        //---------------
                    }
                } else { // sibling is red
                    sibling.color = .black
                    
                    if sibling.isLeftChild { // left case
                        rightRotate(sibling.parent)
                        sibling = sibling.right.left
                        sibling.parent.color = .red
                    } else { // right case
                        leftRotate(sibling.parent)
                        sibling = sibling.left.right
                        sibling.parent.color = .red
                    }
                }
                
                // sibling check is here for when child is a nullLeaf and thus does not have a parent.
                // child is here as sibling can become nil when child is the root
                if (sibling.parent === nullLeaf) || (child !== nullLeaf && child.parent === nullLeaf) {
                    child.color = .black
                }
            }
        }
    }
    
    fileprivate func property1() {
        
        if self.root.isRed {
            print("Root is not black")
        }
    }
    
    fileprivate func property2(_ n: RBTNode<T>) {
        if n === nullLeaf {
            return
        }
        if n.isRed {
            if n.left !== nullLeaf && n.left.isRed {
                print("Red node: \(n.value), has red left child")
            } else if n.right !== nullLeaf && n.right.isRed {
                print("Red node: \(n.value), has red right child")
            }
        }
        property2(n.left)
        property2(n.right)
    }
    
    fileprivate func property3() {
        let bDepth = blackDepth(self.root)
        
        let leaves:[RBTNode<T>] = getLeaves(self.root)
        
        for leaflet in leaves {
            var leaf = leaflet
            var i = 0
            
            while leaf !== nullLeaf {
                if leaf.isBlack {
                    i = i + 1
                }
                leaf = leaf.parent
            }
            
            if i != bDepth {
                print("black depth: \(bDepth), is not equal (depth: \(i)) for leaf with value: \(leaflet.value)")
            }
        }
        
    }
    
    fileprivate func getLeaves(_ n: RBTNode<T>) -> [RBTNode<T>] {
        var leaves = [RBTNode<T>]()
        
        if n !== nullLeaf {
            if n.left === nullLeaf && n.right === nullLeaf {
                leaves.append(n)
            } else {
                let leftLeaves = getLeaves(n.left)
                let rightLeaves = getLeaves(n.right)
                
                leaves.append(contentsOf: leftLeaves)
                leaves.append(contentsOf: rightLeaves)
            }
        }
        
        return leaves
    }
    
    fileprivate func blackDepth(_ root: RBTNode<T>) -> Int {
        if root === nullLeaf {
            return 0
        } else {
            let returnValue = root.isBlack ? 1 : 0
            return returnValue + (max(blackDepth(root.left), blackDepth(root.right)))
        }
    }
    
    fileprivate func leftRotate(_ n: RBTNode<T>) {
        let newRoot = n.right!
        n.right = newRoot.left!
        if newRoot.left !== nullLeaf {
            newRoot.left.parent = n
        }
        newRoot.parent = n.parent
        if n.parent === nullLeaf {
            self.root = newRoot
        } else if n.isLeftChild {
            n.parent.left = newRoot
        } else {
            n.parent.right = newRoot
        }
        newRoot.left = n
        n.parent = newRoot
    }
    
    fileprivate func rightRotate(_ n: RBTNode<T>) {
        let newRoot = n.left!
        n.left = newRoot.right!
        if newRoot.right !== nullLeaf {
            newRoot.right.parent = n
        }
        newRoot.parent = n.parent
        if n.parent === nullLeaf {
            self.root = newRoot
        } else if n.isRightChild {
            n.parent.right = newRoot
        } else {
            n.parent.left = newRoot
        }
        newRoot.right = n
        n.parent = newRoot
    }
}
