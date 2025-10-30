Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Qirui (Chiray) Fu
  * [personal website](https://qiruifu.github.io/)
* Tested on my own laptop: Windows 11, i5-13500HX @ 2.5GHz 16GB, GTX 4060 8GB

### README

### Description

In this project, I implement a tool to render and simulate behaviours of grasses in Vulkan. There are three parts in this project: rendering, simulating forces and culling. The grass blades are represented by Bezier curves and all forces are considered on three control points for blades. Furthermore, we can optimize the performance using some culling techniques.

### Technique Details

#### Forces

We have 3 kinds of forces to consider in this project: gravity, recovery and wind. They are not really physics based, we just apply the effects of them on the positions of control points. For example, the gravity has two parts: environmental gravity and front gravity. It's not physicallly precise but we can simulate the behaviours of curved blades.

#### Culling

We have 3 ways for culling so we don't need to render all grasses, which can improve the performance a lot. The first one is intuitive: our view is a frustum, all blades out of this view-frustum should not be rendered. The second is orientation culling, which means the blades who are parallal with view vector are not visible because they don't have width. The last one is if a blade is too far from the camera, we are not supposed to render it. We will discuss later how these methods can improve the performance.

### Performance Analysis
#### Number of Blades

This figure is generated with all culling methods on:
<img src="/img/p1.jpg">

The FPS decreases exponentially as the number of grass blades increases. I believe that the computational complexity is roughly `O(N)` or slightly higher. From $2^{13}$ to $2^{20}$, the number of blades increases by a factor of 128, while FPS drops from 6000 to 40 — about a 150 times decrease. This suggests that the main performance bottleneck scales linearly with the number of blades.

#### Culling Methods

The influence of 3 culling methods are shown here (# of blades: $2^{15}$):
<img src="/img/p2.jpg">

We can tell that distance culling has the most significant influence on the performance. However, it will also lead to some obvious artifacts: some grasses disapper when you move the camera. View-frustum culling doesn't improve FPS a lot, I believe the reason is most grasses are located in the frustum. If we build a bigger scene with more objects, this method is expected to have better performance.