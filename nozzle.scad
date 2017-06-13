include <handyscad.scad>
module nozzle(){
    intersection(){
        color("red", 0.4)linear_extrude(7)circle_outer(6, 6);
        union(){
            color("purple", 0.4)translate([0,0,10/2 + 2])cube([10,10,10],center=true);
            color("blue", 0.4)cylinder(r1=1.75/2, r2=3.5, h=2, $fn=45);
        }
    }
}

color([.71,.65,.26,1])
nozzle();