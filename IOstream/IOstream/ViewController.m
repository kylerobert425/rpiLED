//
//  ViewController.m
//  IOstream
//
//  Created by Kyle Woods on 2/12/17.
//  Copyright © 2017 Kyle Woods. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize port, hostIP, connect, disconnect, status;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [status setText:@"Not connected"];
    
    [self initNetworkCommunication];
    _lightToggle.selectedSegmentIndex = 1;
    
    //LOAD DEFAULTS? (from moving raspi app)
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"com.aboudou.movingraspiremote.host"] != nil) {
//        [hostIP setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"com.aboudou.movingraspiremote.host"]];
//    }
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"com.aboudou.movingraspiremote.port"] != nil) {
//        [port setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"com.aboudou.movingraspiremote.port"]];
//    }

}
- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)CFBridgingRetain([self.hostIP text]), [[self.port text] intValue], &readStream, &writeStream);
    _inputStream = (NSInputStream *)CFBridgingRelease(readStream);
    _outputStream = (NSOutputStream *)CFBridgingRelease(writeStream);
    
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
    
    
}

- (IBAction)ToggleLight:(id)sender {
    
    UISegmentedControl *button = ((UISegmentedControl*)sender);
    long tag = button.tag;
    
    //send string based on the P7 high low protocol
    NSString *response  = [NSString stringWithFormat:@"P%ld%@", tag , button.selectedSegmentIndex?@"L" : @"H"];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [_outputStream write:[data bytes] maxLength:[data length]];
    
}

- (IBAction)doDisconnect:(id)sender {
    [[self hostIP] resignFirstResponder];
    [[self port] resignFirstResponder];
    
    [_outputStream close];
    
    [status setText:@"Not connected"];

}
 //connect button action,

- (IBAction)doConnect:(id)sender{
//    // Save user defaults (from moving raspi app)
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[hostIP text] forKey:@"com.aboudou.movingraspiremote.host"];
//    [defaults setObject:[port text] forKey:@"com.aboudou.movingraspiremote.port"];
//    [defaults synchronize];
    
    [[self hostIP] resignFirstResponder];
    [[self port] resignFirstResponder];
    
    [self doDisconnect:nil];
    [self initNetworkCommunication];
    
    [status setText:@"Connected!"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
