/****************************************************
 * Program:
 *   SimulatorView.mm
 * Author:
 *   Samuel Hibbard
 * Summary:
 *   This will define the subclass for NSOpenGLView.
 *
 * Created by Samuel Hibbard on 11/5/15.
 * Copyright © 2015 samIAm. All rights reserved.
 ****************************************************/

#import <Foundation/Foundation.h>
#import "SimulatorView.h"
#import "sim.h"

// Define the window size for Position
float Position::xMax = 500;
float Position::xMin = -500;
float Position::yMax = 343;
float Position::yMin = -343;

@implementation SimulatorView

/************************************************
 * perpareOpenGL
 *  This will synchronize buffer swaps with
 *      vertical refresh rate.
 ***********************************************/
- (void) perpareOpenGL
{
    GLint swapInt = 1;
    [[self openGLContext] setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];
}

/*************************************
 * runTimer
 *  This will start the timer and 
 *      redraw the view every 60 frames
 *      per second. This will be called
 *      when the simulator has been 
 *      started.
 *************************************/
- (void) runTimer
{
    renderTimer = [NSTimer timerWithTimeInterval:0.0167   // 60 frames per second
                                          target:self
                                        selector:@selector(timerFired:)
                                        userInfo:nil
                                         repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:renderTimer
                                 forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:renderTimer
                                 forMode:NSEventTrackingRunLoopMode]; //Ensure timer fires during resize
}

/*************************************
 * stopTimer
 *  What the name implies
 *************************************/
- (void) stopTimer
{
    [renderTimer invalidate];
    renderTimer = nil;
}

/*************************************
 * timerFired
 *  This will tell the view to redraw
 *      itself.
 *************************************/
- (void) timerFired: (id) sender
{
    [self setNeedsDisplay:YES];
}

/************************************************
 * drawRect
 *  This will draw the shapes to the NSOpenGLView
 ************************************************/
- (void) drawRect: (NSRect) bounds
{
    
}

@end