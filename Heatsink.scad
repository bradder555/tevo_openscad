number_of_fins = 8;
number_of_gaps = 7;
block_height =  30;
fin_depth = 6; 
block_and_fin_depth = 18; 
block_depth = block_and_fin_depth - fin_depth;
block_width = 30;

fin_and_space_pair_height = 2 * block_height / (number_of_fins + number_of_gaps);
distance_between_fins = fin_and_space_pair_height / 2;
fin_height = distance_between_fins;

module heatsink(){

    
    union(){
        color([1,1,1]){
            translate([0, 0, fin_height / 2]){
                for (fin_no = [0:number_of_fins - 1]){
                    translate([0,0,fin_and_space_pair_height * fin_no]){
                        cube([block_and_fin_depth, block_width, fin_height], center=true);
                    }  
                }
            }
            translate([(block_depth / 2) - (fin_depth / 2), 0, block_height / 2]){
                cube([block_depth, block_width, block_height], center = true);
            }
        }
    }
}

module heatsink_side_2d(){
    linear_extrude(1)
    projection(){
        translate([0, 0, 1]){
            rotate([90, 0, 0]){
                translate([0 , (30 - 2) / 2 , 0])
                {
                    heatsink();
                }
            }
        }
    }
}

module heatsink_bottom_2d(){
    // really this should come from the completed thing, but this is so simple and just a sanity check i'll type it in here
    cube([block_and_fin_depth, block_width, 2]);
}


heatsink();

/*
heatsink_side_2d();
translate([30 / 2 , -30, 0]){
    heatsink_bottom_2d();
}*/