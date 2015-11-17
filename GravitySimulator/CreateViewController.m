/****************************************************
 * Program:
 *  CreateViewController.m
 * Author:
 *   Samuel Hibbard
 * Summary:
 *   Define all the functions for the CreateViewController
 *      class.
 *
 * Created by Samuel Hibbard on 11/9/15.
 * Copyright © 2015 samIAm. All rights reserved.
 ****************************************************/

#import <Foundation/Foundation.h>
#import "SimulatorViewController.h"
#import "CreateViewController.h"

@implementation CreateViewController

/*************************************
 * viewDidLoad
 *  Set some values.
 ************************************/
- (void) viewDidLoad
{
    // Hide the label and button.
    // This is the last question. Only
    // used for the vector object.
    self.objectLabel.hidden = YES;
    self.objBtn.hidden = YES;
}

/*************************************
 * sendObjects
 *  This is where the objects are to 
 *      sent to this controller from
 *      the SimulatorViewController.
 ************************************/
- (void) sendObjects: (NSMutableArray *) sentIds names: (NSMutableArray *) sentNames
{
    // Grab the values
    ids = sentIds;
    names = sentNames;
    
    // Remove the old labels in the object label button
    [_objBtn removeAllItems];
    
    // Now update the object label
    for (int i = 0; i < [sentNames count]; i++)
    {
        [_objBtn addItemWithTitle: [names objectAtIndex:i]];
    }
}

/*************************************
 * clickedWhichObj
 *  This is the pop up button. This will
 *      change the other labels, depending
 *      on what was clicked.
 *************************************/
- (IBAction)clickedWhichObj:(id)sender
{
    // Grab which object was clicked
    NSString *obj = [[self.whichObjectBtn selectedItem] title];
    
    // Now see what was clicked on
    if ([obj isEqualToString:@"Planet"])
    {
        // Hide the label and button
        [self enableDisableForm:YES hide:YES];
        
        // Change the label
        self.label2.cell.title = @"Radius (m)";
        self.label3.cell.title = @"Mass (kg)";
    }
    else
    {
        // Disable the text fields and buttons if there are no planets
        // on the screen.
        if ([ids count] == 0)
        {
            [self enableDisableForm:NO hide:NO];
        }
        else
        {
            [self enableDisableForm:YES hide:NO];
        }
        
        // Change two of the labels
        self.label2.cell.title = @"Magnitude (m/s)";
        self.label3.cell.title = @"Angle (°)";
    }
}

/*************************************
 * enableDisableForm
 ************************************/
- (void) enableDisableForm: (BOOL) enable hide: (BOOL) hidden
{
    // Enable the forms
    self.nameInput.enabled = enable;
    self.diamOrMagInput.enabled = enable;
    self.massOrAngleInput.enabled = enable;
    self.objectLabel.enabled = enable;
    self.objBtn.enabled = enable;
    
    // Hide the last question
    self.objectLabel.hidden = hidden;
    self.objBtn.hidden = hidden;
}

/*************************************
 * validNumber
 *  This will check if the string is 
 *      a valid number.
 ************************************/
- (BOOL) validNumber: (NSString *) text
{
    // See if it is a valid number
    NSScanner *scan = [NSScanner scannerWithString:text];
    float val;
    
    return [scan scanFloat: &val] && [scan isAtEnd];
}

/*************************************
 * clickedCreate
 *  The create button was clicked. This
 *      will check the data and then
 *      save it to the newObj variable.
 *************************************/
- (IBAction)clickedCreate:(id)sender
{
    int valid = 0;
    
    // Grab the data
    NSString *obj         = [[self.whichObjectBtn selectedItem] title];
    NSString *name        = self.nameInput.stringValue;
    NSString *diamOrMag   = self.diamOrMagInput.stringValue;
    NSString *massOrAngle = self.massOrAngleInput.stringValue;
    NSString *objName = @"none";
    
    // See if vector was selected
    if ([obj isEqualToString:@"Vector"])
    {
        // If so then grab the objName
        objName = [[self.objBtn selectedItem] title];
    }
    
    // Check the data
    valid = (name.length > 0) ? 0 : 1;
    valid = ([self validNumber:diamOrMag] && valid == 0) ? 0: 2;
    valid = ([self validNumber:massOrAngle] && valid == 0) ? 0 : 3;
    
    
    // Now check the error code
    if (valid == 0)
    {
        // Create the keys
        NSString *diamOrMagKey = ([obj isEqualToString:@"Planet"]) ? @"radius" : @"mag";
        NSString *massOrAngleKey  = ([obj isEqualToString:@"Planet"]) ? @"mass" : @"angle";
        
        // Now save the values and keys into newObj
        NSDictionary *newObj = @{
                                 @"object"    : obj,
                                 @"name"      : name,
                                 diamOrMagKey : [NSNumber numberWithDouble:[diamOrMag doubleValue]],
                                 massOrAngleKey : [NSNumber numberWithDouble:[massOrAngle doubleValue]],
                                 @"objName"   : objName
                                 };
        
        // Send it on it's way
        [self.delegate grabData:newObj];
        
        // Now close the sheet.
        [self dismissViewController:self];
    }
    else
    {
        // Show error
        NSString *error = [NSString stringWithFormat:@"ERROR code number: %d", valid];
        NSLog(@"%@", error);
    }
}

/*************************************
 * clickedCancel
 *  Dimiss the view.
 *************************************/
- (IBAction)clickedCancel:(id)sender
{
    // Dismiss the sheet
    [self dismissViewController:self];
}

@end