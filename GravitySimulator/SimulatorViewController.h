/****************************************************
 * Program:
 *   SimulatorViewController.h
 * Author:
 *   Samuel Hibbard
 * Summary:
 *   This will be the main controller for the main 
 *      view of the application. It is the one that
 *      communicates the objects with the Simulator
 *      class.
 *
 * Created by Samuel Hibbard on 11/6/15.
 * Copyright © 2015 samIAm. All rights reserved.
 ****************************************************/

#ifndef SimulatorViewController_h
#define SimulatorViewController_h

#import <Cocoa/Cocoa.h>

/*************************************
 * SimulatorViewController
 *  This is what will control everything
 *      inside the view.
 *************************************/
@interface SimulatorViewController : NSViewController
{
    NSMutableArray *planetIDs;   // These are the ids of the objects
    NSMutableArray *planetNames; // Save the names for the list
    NSMutableArray *vectorIDs;   // Vector ids
    NSMutableArray *vectorNames; // Vector names
    int currentlySelected;       // Current selected item
}

// Here are all the actions that are needed to be controlled.
@property (weak) IBOutlet NSTextField *formLabel1;
@property (weak) IBOutlet NSTextField *formLabel2;
@property (weak) IBOutlet NSTextField *formLabel3;
@property (weak) IBOutlet NSTextField *formInputTextField1;
@property (weak) IBOutlet NSTextField *formInputTextField2;
@property (weak) IBOutlet NSPopUpButton *formSelectBtn;
@property (weak) IBOutlet NSButton *deleteBtn;
@property (weak) IBOutlet NSButton *clear;
@property (weak) IBOutlet NSButton *reset;
@property (weak) IBOutlet NSButton *run;
@property (weak) IBOutlet NSOpenGLView *simulator;
@property (weak) IBOutlet NSButton *stop;
@property (weak) IBOutlet NSPopUpButton *editItem;

// This will hold the delegate
@property(nonatomic,assign) id delegate;

// Member methods
- (void) addValuesToEditForm: (NSDictionary *) data selectedID: (int) id;
- (void) updateEditItem: (NSMutableArray *) ids vectorNames: (NSMutableArray *) names;
- (void) updateEverything: (NSMutableArray *) planetids planetNames: (NSMutableArray *) planetnames vectorIDs:(NSMutableArray *) ids vectorNames: (NSMutableArray *) names;

@end

@protocol sendObjectProtocol <NSObject>

- (NSNumber *) addToViewObject: (NSDictionary *) data;
- (void) editObject: (int) editId number:(NSNumber *) number edit: (NSString *) edit;
- (void) changeVector: (int) vectorId object: (int) newObject;
- (void) sendSelf: (SimulatorViewController *) c;
- (void) deleteObject: (int) objId type: (NSString *) type;
- (void) runSimulation: (BOOL) enable;
- (void) resetObjects;
- (NSDictionary *) selectObject: (int) selectedId;

@end

#endif /* SimulatorViewController_h */
