//
//  CUPreferences.m
//  Khronos
//
//  Created by Gautam Dey on 7/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CUPreferences.h"

// These are the General Preferences.
NSString *const CUPreferencesAskDeleteProject    = @"Delete Project";
NSString *const CUPreferencesAskDeleteSession    = @"Delete Session" ;
NSString *const CUPreferencesAutoSaveTime        = @"Auto Save Time";
NSString *const CUPreferencesAutoDeleteSettings  = @"Delete Settings";
NSString *const CUPreferencesMonetaryUnit        = @"Monetary Unit";
NSString *const CUPreferencesClockSetting        = @"24 Hour Clock";
NSString *const CUPreferencesUpdateTime          = @"Update time";

/*** Which columns in the Project table should be shown. ***/
// CUPreferencesProjectDisplay is a dictonary to hold the options for the Project Table.
NSString *const CUPreferencesProjectDisplay           = @"Project Display";
NSString *const CUPreferencesProjectDisplayNumber     = @"Number";
NSString *const CUPreferencesProjectDisplayName       = @"Name";
NSString *const CUPreferencesProjectDisplayClient     = @"Client";
NSString *const CUPreferencesProjectDisplayRate       = @"Rate";
NSString *const CUPreferencesProjectDisplayTime       = @"Time";
NSString *const CUPreferencesProjectDisplayCharges    = @"Charges";

/*** Which columns in the Session Table should be shown. ***/
// CUPreferencesSessionDisplay is a dictonary to hold the options for the Session Table.
NSString *const CUPreferencesSessionDisplay             = @"Sessions Display";
NSString *const CUPreferencesSessionDisplayStartDate    = @"Start Date";
NSString *const CUPreferencesSessionDisplayEndDate      = @"End Date";
NSString *const CUPreferencesSessionDisplayStartTime    = @"Start Time";
NSString *const CUPreferencesSessionDisplayEndTime      = @"End Time";
NSString *const CUPreferencesSessionDisplayPauseTime    = @"Pause Time";
NSString *const CUPreferencesSessionDisplayTotalTime    = @"Total Time";
NSString *const CUPreferencesSessionDisplayCharges      = @"Charges";
NSString *const CUPreferencesSessionDisplaySummary      = @"Summary";
NSString *const CUPreferencesSessionDisplayNumber       = @"Number";

@implementation CUPreferences


+ (void) resetPreferences 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Deleting Preferences.");
    [defaults removeObjectForKey:CUPreferencesAskDeleteProject];
    [defaults removeObjectForKey:CUPreferencesAskDeleteSession];
    [defaults removeObjectForKey:CUPreferencesAutoSaveTime];
    [defaults removeObjectForKey:CUPreferencesMonetaryUnit];
    [defaults removeObjectForKey:CUPreferencesClockSetting];
    [defaults removeObjectForKey:CUPreferencesUpdateTime];
    [defaults removeObjectForKey:CUPreferencesInvoice];
    [defaults removeObjectForKey:CUPreferencesProjectDisplay];
    [defaults removeObjectForKey:CUPreferencesSessionDisplay];
    [defaults removeObjectForKey:CUPreferencesMenuDisplay];     
}

+ (void) initilizeDefaults
{
#pragma mark Setting Default Values.
    // Create a Dictionary
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    
    // Register the default values for Clock, which is 24 hour clock.
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:CUPreferencesClockSetting];
    // Register the default value for Update time, which is 0 minutes
    [defaultValues setObject:[NSNumber numberWithInt:0] forKey:CUPreferencesUpdateTime];
    // Register the default value for Montery Unit.
    [defaultValues setObject:@"$" forKey:CUPreferencesMonetaryUnit];
    
    
    NSLog(@"Registering Project Table Defaults.");
    // Register the default value for the Poject Table.
    NSArray *keys = [NSArray arrayWithObjects: 
                     CUPreferencesProjectDisplayNumber,
                     CUPreferencesProjectDisplayName,
                     CUPreferencesProjectDisplayClient,
                     CUPreferencesProjectDisplayRate,
                     CUPreferencesProjectDisplayTime,
                     CUPreferencesProjectDisplayCharges,
                     nil];
    NSArray *values = [NSArray arrayWithObjects:
                       [NSNumber  numberWithBool: YES], // Number
                       [NSNumber  numberWithBool: YES], // Name
                       [NSNumber  numberWithBool: YES], // Client Name
                       [NSNumber  numberWithBool: NO] , // Rate
                       [NSNumber  numberWithBool: YES], // Time
                       [NSNumber  numberWithBool: YES], // Charges
                       nil];
    
    NSDictionary *projectTableValues = [NSDictionary dictionaryWithObjects:values 
                                                                   forKeys:keys];
    [defaultValues setObject:projectTableValues forKey:CUPreferencesProjectDisplay];
    
    NSLog(@"Registering Session Table Defaults.");
    // Register the default value for the Poject Table.
    keys = [NSArray arrayWithObjects: 
            CUPreferencesSessionDisplayStartDate,
            CUPreferencesSessionDisplayEndDate,
            CUPreferencesSessionDisplayStartTime,
            CUPreferencesSessionDisplayEndTime,
            CUPreferencesSessionDisplayPauseTime,
            CUPreferencesSessionDisplayTotalTime,
            CUPreferencesSessionDisplayCharges,
            CUPreferencesSessionDisplaySummary,
            CUPreferencesSessionDisplayNumber,
            nil];
    values = [NSArray arrayWithObjects:
              [NSNumber  numberWithBool: YES],  // Start Date
              [NSNumber  numberWithBool: YES],  // End Date
              [NSNumber  numberWithBool: YES],  // Start Time
              [NSNumber  numberWithBool: YES],  // End Time
              [NSNumber  numberWithBool: NO ],  // Pause Time
              [NSNumber  numberWithBool: YES],  // Total Time
              [NSNumber  numberWithBool: YES],  // Charges
              [NSNumber  numberWithBool: YES],  // Summary
              [NSNumber  numberWithBool: YES],  // Number
              nil];
    NSDictionary *sessionTableValues = [NSDictionary dictionaryWithObjects:values 
                                                                   forKeys:keys];
    [defaultValues setObject:sessionTableValues forKey:CUPreferencesSessionDisplay];
    
    
    NSLog(@"Registering Invoice Defaults");
    NSData *headingFontAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSFont fontWithName:@"Helvetica" size:18]];
    NSData *bodyFontAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSFont fontWithName:@"Helvetica" size:10]];
    keys = [NSArray arrayWithObjects:
            CUPreferencesInvoiceIndexTitle,
            CUPreferencesInvoiceIndexHeading,
            CUPreferencesInvoiceTitle,
            CUPreferencesInvoiceLinkHelp,
            CUPreferencesInvoiceHeading,
            CUPreferencesInvoiceHeadingFont,
            CUPreferencesInvoiceBodyFont,
            nil];
    values = [NSArray arrayWithObjects:
              @"Khronos Invoice List",                // Index Title
              @"Invoices",                            // Index Heading
              @"Khronos Invoice",                     // Title
              @"Click the job to view the invoice.",  // Link Help
              @"Invoice",                             // Heading
              headingFontAsData,                      // Heading Font
              bodyFontAsData,                         // Body Font
              nil];
    NSDictionary *invoiceValues = [NSDictionary dictionaryWithObjects:values
                                                              forKeys:keys];
    [defaultValues setObject:invoiceValues forKey:CUPreferencesInvoice];
    
    NSLog(@"Registering Menu Table Defaults.");
    // Register the default value for the Poject Table.
    keys = [NSArray arrayWithObjects: 
            CUPreferencesMenuDisplayPauseButton,
            CUPreferencesMenuDisplayRecrodingButton,
            CUPreferencesMenuDisplayProjectList,
            CUPreferencesMenuDisplayTotalTime,
            CUPreferencesMenuDisplayCharges,
            nil];
    values = [NSArray arrayWithObjects:
              [NSNumber  numberWithBool: YES],  // Pause Button
              [NSNumber  numberWithBool: YES],  // Recording Button
              [NSNumber  numberWithBool: YES],  // Project List
              [NSNumber  numberWithBool: YES],  // Total Time
              [NSNumber  numberWithBool: YES],  // Charges
              nil];
    NSDictionary *menuTableValues = [NSDictionary dictionaryWithObjects:values 
                                                                forKeys:keys];
    [defaultValues setObject:menuTableValues forKey:CUPreferencesMenuDisplay];
    // Register the dictionary of defaults.
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    
    NSLog(@"Registered defaults: %@", defaultValues ); 
}

#pragma mark Table Options
// These are the setting for Project Table, Session Table and Menu.
- (NSDictionary *)columnsForTable:(NSString *)tableName
{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:tableName];
}
- (void) setTable:(NSString *)tableName column:(NSString *)column display:(BOOL)yn
{
    NSMutableDictionary *newTable = [[self columnsForTable:tableName] mutableCopy];
    [newTable setObject:[NSNumber numberWithBool:yn] forKey:column];
}
- (BOOL) displayForTable:(NSString *)tableName column:(NSString *)column
{
    return [[[self columnsForTable:tableName] objectForKey:column] boolValue];
}

#pragma mark General Options

- (BOOL) askDeleteProject
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:CUPreferencesAskDeleteProject];
}

- (void) setAskDeleteProject:(BOOL)yn
{
    [[NSUserDefaults standardUserDefaults] setBool:yn forKey:CUPreferencesAskDeleteProject];
}

- (BOOL) askDeleteSession
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:CUPreferencesAskDeleteSession];
}

- (void) setAskDeleteSession:(BOOL)yn
{
    [[NSUserDefaults standardUserDefaults] setBool:yn ForKey:CUPreferencesAskDeleteSession];
}

- (BOOL) autoSaveTime
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:CUPreferencesAutoSaveTime];
}

- (void) setAutoSaveTime:(BOOL)yn
{
    [[NSUserDefaults standardUserDefaults] setBool:yn forKey:CUPreferencesAutoSaveTime];
}

- (BOOL) autoDeleteSettings
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:CUPreferencesAutoDeleteSettings];    
}
- (void) setAutoDeleteSettings:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:yn forKey:CUPreferencesAutoDeleteSettings];
}
- (BOOL) is24HourClock
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:CUPreferencesClockSetting];
}
- (void) setIs24HourClock:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:yn forKey:CUPreferencesClockSetting];
}
- (int) updateTimeEvery
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:CUPreferencesUpdateTime] intValue];
}
- (void) setUpdateTimeEvery:(int)minutes
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:minutes] forKey:CUPreferencesUpdateTime];    
}
- (NSString *)monetaryUnit
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CUPreferencesMonetaryUnit];
}
- (void) setMonetaryUnit:(NSString *)unit
{
    [[NSUserDefaults standardUserDefaults] setObject:unit  forKey:CUPreferencesMonetaryUnit];    
}

@end