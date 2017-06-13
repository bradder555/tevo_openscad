include <handyscad.scad>

use <heatsink.scad>
use <fan_30mm.scad>
use <prox_sensor.scad>
use <block_connector.scad>
use <heat_block.scad>
use <nozzle.scad>

color([.9,.9,.9,.3])heatsink();
translate([-19.5,0,15])rotate([90,0,90])color([.3,.3,.3,.3])fan_30mm();
translate([0,-15,-17])rotate([0,0,-90])color([0,1,0,.3])prox_sensor();
translate([3,0,-2.75])color("yellow",.3)block_connector();
translate([7,0,-7.8])color([.9,.9,.9,.3])heat_block();
translate([3,0,-19.8])color("yellow",.3)nozzle();
