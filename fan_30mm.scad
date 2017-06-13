module fan_30mm_quarter(){
    difference(){
        translate([7.5, 7.5, 5]){
            cube([15, 15, 10], center=true);
        }
        cylinder(r = 14.2, h = 100, $fn=180, center=true);
        translate([12,12]){
            difference(){
                translate([1.5, 1.5, 0]){
                    cube([3.05, 3.05, 50], center = true);
                }
                cylinder(r = 3, h = 50, $fn=180, center=true);
            }
        }
        translate([12, 12]){
            cylinder(r = 1.75, h = 50, center = true, $fn = 90);
        }
    }
}

module fan_no_center(){
                for(n = [0:3]){
                rotate([0, 0, 90 * n]){
                   fan_30mm_quarter();  
                }
            }
    
    }

module f(){
    intersection(){
        cube([30,30,100], center=true);
        union(){
            color("blue", 0.5)cylinder(r=17 / 2, h=10, $fn=90);
            for(n = [0:2]){
                color("red")rotate([0,0,10 + 120 * n])translate([0,5,0])cube([20, 2, 1]);
            }
            fan_no_center();
        }
    }
}


module fan_30mm(){f();}

module fan_30mm_2d(){
    difference(){
        fan_30mm();
        translate([0,0,5 + 2]){
            cube([100,100,10], center=true);
        }
    }
}
    
fan_30mm();