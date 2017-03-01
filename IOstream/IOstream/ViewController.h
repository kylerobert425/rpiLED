//
//  ViewController.h
//  IOstream
//
//  Created by Kyle Woods on 2/12/17.
//  Copyright © 2017 Kyle Woods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSStreamDelegate>
{
    NSOutputStream *_outputStream;
}
    //do all the stuff for streaming here
    @property (nonatomic, retain) NSInputStream *inputStream;
    @property (nonatomic, retain) NSOutputStream *outputStream;
    //IP, port text fields, connect, disconnect buttons and status label
    @property (nonatomic, strong) IBOutlet UIButton *connect;
    @property (nonatomic, strong) IBOutlet UIButton *disconnect;
    @property (nonatomic, strong) IBOutlet UITextField *hostIP;
    @property (nonatomic, strong) IBOutlet UITextField *port;
    @property (nonatomic, strong) IBOutlet UILabel *status;


    //light switch
    @property (weak, nonatomic) IBOutlet UISegmentedControl *lightToggle;
    - (IBAction)ToggleLight:(id)sender;

    //actions that will be performed, connect depending on buttons
    -(IBAction)doConnect:(id)sender;
    -(IBAction)doDisconnect:(id)sender;

@end

