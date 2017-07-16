include <handyscad.scad>

use <heatsink.scad>
use <fan_30mm.scad>
use <prox_sensor.scad>
use <block_connector.scad>
use <heat_block.scad>
use <nozzle.scad>
use <blower.scad>
// the cooler attachement will be secured between the heatsink and the fan

module hot_end(){
  union(){
    color([.9,.9,.9,1])heatsink();
    translate([-19.15,0,15])rotate([90,0,90])color([.3,.3,.3,1])fan_30mm();
    translate([0,-15,-17])rotate([0,0,-90])color([0,1,0,1])prox_sensor();
    translate([3,0,-2.75])color("yellow")block_connector();
    translate([7,0,-7.8])color([.9,.9,.9,1])heat_block();
    translate([3,0,-19.8])color("yellow",1)nozzle();
  }
}

module support(){
  difference()
  {
    union()
    {
      translate([0,0,-10])linear_extrude(3.2)projection()fan_no_center_square();
      translate([7.5,-23, 3.2/2 - 10])
        cube([15,16,3.2], center = true);
    }
    union(){
      for (n = [-1 : 2 : 1])
      {
        for (m = [-1 : 2 : 1])
        {
          translate([3 * n + 6 ,-23 + 3 * m,-1 - 10])
            rotate([0,0,0])
              cylinder(r = 2., h = 5, $fn=30);
              //cube([4,4.5,5]);
        }
      }
    }
  }
}

module square(
      init_x, 
      init_y, 
      wall_thickness, 
      wall_shrinkage,
      iterations, 
      depth, 
      twist_x, 
      twist_y, 
      twist_z,
      twist_off_x,
      twist_off_y,
      twist_off_z,
      shift_x, 
      shift_y,
      shift_z,
      shrink_x,
      shrink_y,
      resolution,
      itr ){
        
        rotate(itr / resolution * [twist_off_x, twist_off_y, twist_off_z])
          translate(itr / resolution * [shift_x, shift_y, shift_z])
            rotate(itr / resolution *[ twist_x, twist_y, twist_z])
            cube
            ([
              init_x + wall_thickness - shrink_x * (itr / resolution), 
              depth, 
              init_y + wall_thickness - shrink_y * (itr / resolution),
            ], center=true);
}

module spiral(
      init_x, 
      init_y, 
      wall_thickness, 
      wall_shrinkage,
      iterations, 
      depth, 
      twist_x, 
      twist_y, 
      twist_z,
      twist_off_x,
      twist_off_y,
      twist_off_z,
      shift_x, 
      shift_y,
      shift_z,
      shrink_x,
      shrink_y,
      resolution){
        
  union(){
    translate([0,1.8,0])cube
    ([
      init_x + wall_thickness, 
      depth + 4, 
      init_y + wall_thickness,
      
    ], center=true);

      for (itr = [1 : iterations * resolution]){
          hull(){
          square(
          init_x = init_x, 
          init_y = init_y, 
          wall_thickness = wall_thickness, 
          wall_shrinkage = wall_shrinkage,
          iterations = iterations, 
          depth = depth, 
          twist_x = twist_x, 
          twist_y = twist_y, 
          twist_z = twist_z,
          twist_off_x = twist_off_x,
          twist_off_y = twist_off_y,
          twist_off_z = twist_off_z,
          shift_x = shift_x, 
          shift_y = shift_y,
          shift_z = shift_z,
          shrink_x = shrink_x,
          shrink_y = shrink_y,
          resolution = resolution,
          itr = itr - 1);
              
          square(
          init_x = init_x, 
          init_y = init_y, 
          wall_thickness = wall_thickness, 
          wall_shrinkage = wall_shrinkage,
          iterations = iterations, 
          depth = depth, 
          twist_x = twist_x, 
          twist_y = twist_y, 
          twist_z = twist_z,
          twist_off_x = twist_off_x,
          twist_off_y = twist_off_y,
          twist_off_z = twist_off_z,
          shift_x = shift_x, 
          shift_y = shift_y,
          shift_z = shift_z,
          shrink_x = shrink_x,
          shrink_y = shrink_y,
          resolution = resolution,
          itr = itr);
          
          square(
          init_x = init_x, 
          init_y = init_y, 
          wall_thickness = wall_thickness, 
          wall_shrinkage = wall_shrinkage,
          iterations = iterations, 
          depth = depth, 
          twist_x = twist_x, 
          twist_y = twist_y, 
          twist_z = twist_z,
          twist_off_x = twist_off_x,
          twist_off_y = twist_off_y,
          twist_off_z = twist_off_z,
          shift_x = shift_x, 
          shift_y = shift_y,
          shift_z = shift_z,
          shrink_x = shrink_x,
          shrink_y = shrink_y,
          resolution = resolution,
          itr = itr + 1);
          }
      } // for

  } // union
}

module one_blower()
{
  module fan_support()
  {
      translate([-35.2,20 + 15 ,20]){
          
        difference(){
          hull(){
            rotate([90 - 28 ,-50,0])
              translate([20.5,-15.8,9 ])
                cylinder(r=5, h = 2.4, $fn=30, center=true);
            translate(-1 * [-35.2 + 10,20 + 14.5,20 ])
              translate([-19.5 + 7,0,15])
                rotate([90,0,90])
                  translate([16,11.5, 2.4/2])
                    //cylinder(r=4, h = 3.2, $fn=30, center=true);
                    cube([3.2,7,2.4], center=true);
            translate(-1 * [-35.2 + 10,20 + 14.5,20 ])
              translate([-19.5 + 7,0,15])
                rotate([90,0,90])
                  translate([14,1, 0])
                    //cylinder(r=4, h = 3.2, $fn=30, center=true);
                    cube([0.1,0.1,0.1], center=true);
            
          }
          rotate([90 - 28 ,-50,0])
            translate([21,-16,0])
              cylinder(r=1.8, h= 40, $fn=30, center=true);
          rotate([90 - 28 ,-50,0])
            translate([20.5,-15.8,30])
              cylinder(r=2.4, h= 40, $fn=30, center=true);
        }
        //rotate([90 - 28 ,-50,0])color("blue")blower();
      }
  }

  init_x          = 21.5;   // 20
  init_y          = 16.5;   // 10
  wall_thickness  = 1.6;    // 2
  iterations      = 28;   // 50
  depth           = 0.1;    // 1
  twist_x         = 1;  // 0.4
  twist_y         = 1.5;//-3.3;//-1.8;  // 2.2
  twist_z         = -0.2; //-0.8; // -0.4
  twist_off_x     = -0.1;//- 0.3;
  twist_off_y     = 0.5;//1.5;
  twist_off_z     = -0.2;//- .15;
  shift_x         = 0.2; // 0.18
  shift_y         = -1; // -0.7
  shift_z         = 0.2; // 0.04
  shrink_x        = 0.6; // 0.35
  shrink_y        = 0.4; // 0.10
  resolution      = 1;    // 1
  
  union(){
    difference()
    {
      union()
      {
        fan_support();
          
        translate([-19.5 + 7,0,15])
		  rotate([90,0,90])support();
          
		  translate([-35.2,20 + 15 ,20])
		    rotate([90 - 28 ,-50,0])
			  translate([-16,-24,0])
			    spiral(
					init_x = init_x, 
					init_y = init_y, 
					wall_thickness = wall_thickness, 
					iterations = iterations, 
					depth = depth,
					twist_x = twist_x,
					twist_y = twist_y,
					twist_z = twist_z,
                    twist_off_x = twist_off_x,
                    twist_off_y = twist_off_y,
                    twist_off_z = twist_off_z,
					shift_x = shift_x,
					shift_y = shift_y,
					shift_z = shift_z,
					shrink_x = shrink_x,
					shrink_y = shrink_y,
					resolution = resolution);
      }
        translate([-35.2,20 + 15 ,20])
	      rotate([90 - 28 ,-50,0])
		    translate([-16,-24,0])
			  spiral(
					init_x = init_x,
					init_y = init_y,
					wall_thickness = 0,
					iterations = iterations,
					depth = depth + 0.1,
					twist_x = twist_x ,
					twist_y = twist_y,
					twist_z = twist_z,
                    twist_off_x = twist_off_x,
                    twist_off_y = twist_off_y,
                    twist_off_z = twist_off_z,
					shift_x = shift_x,
					shift_y = shift_y,
					shift_z = shift_z,
					shrink_x = shrink_x,
					shrink_y = shrink_y,
					resolution = resolution);
    } 
  }
}
/*
translate([3,0,-19.8])color("yellow",1)nozzle();
translate([7,0,-7.8])color([.9,.9,.9,1])heat_block();
translate([0,-15,-17])rotate([0,0,-90])color([0,1,0,1])prox_sensor();

hot_end();*/
difference(){
  union(){
    one_blower();
    mirror([0,1,0])one_blower();
  }
  hot_end();
}
