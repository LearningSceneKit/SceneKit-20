//
//  ViewController.m
//  SceneKit-19ELSL
//
//  Created by ShiWen on 2017/7/31.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()
@property (nonatomic,strong) SCNView *mScnView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mScnView];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    cameraNode.camera.automaticallyAdjustsZRange = YES;
    cameraNode.position = SCNVector3Make(0, 100, 500);
    [self.mScnView.scene.rootNode addChildNode:cameraNode];
    
    
    SCNBox *box = [SCNBox boxWithWidth:100 height:100 length:100 chamferRadius:0];
    box.firstMaterial.diffuse.contents = [UIColor blueColor];
    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    [self.mScnView.scene.rootNode addChildNode:boxNode];
//    加载3D模型
    SCNScene *scene = [SCNScene sceneNamed:@"foldingMap.dae"];
    SCNNode *scnNode = [[scene rootNode] childNodeWithName:@"Map" recursively:YES];
    [self.mScnView.scene.rootNode addChildNode:scnNode];
    
//    读取文件 ELSL文件内容
//    可动态获取加载
    NSString *fragment = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Fragment" ofType:@"shader"] encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",mapFragment);
    NSString *geometry = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Geometry" ofType:@"shader"] encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",mapGeometry);
    
    NSString *lighting = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Lighting" ofType:@"shader"] encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",mapLighting);
    
    
    scnNode.geometry.shaderModifiers = @{SCNShaderModifierEntryPointGeometry:geometry,SCNShaderModifierEntryPointFragment:fragment,SCNShaderModifierEntryPointLightingModel:lighting};
    
}

-(SCNView *)mScnView{
    if (!_mScnView) {
        _mScnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _mScnView.allowsCameraControl = YES;
        _mScnView.backgroundColor = [UIColor blackColor];
        _mScnView.scene = [SCNScene scene];
        
    }
    return _mScnView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
