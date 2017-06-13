module p()
{
    union()
    {
        translate([14/2,0,7 + 36-14])cube([14,18,14], center=true);
        translate([18/2,0,17/2])cube([18,18,17],center=true);
        color("red", 0.5)hull(){
        translate([0.5,0,16.5])cube([1,18,1],center=true);
        translate([0.5,0,16.5 + 5])cube([1,18,1],center=true);
        translate([0.5 + 17,0,16.5 ])cube([1,18,1],center=true);
        translate([0.5+13,0,16.5 + 5])cube([1,18,1],center=true);}
    }
}

module prox_sensor(){
    color([0,1,0],0.8)p();
    }

prox_sensor();