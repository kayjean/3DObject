use <LEGO.scad>;


rotate([0, 0, 180]) union() {
    
    place(-4, -12) uncenter(22, 6) rotate([0, 0, 90]) block(
        type="tile",
        width=6,
        length=4
    );
    
/*    
    place(-4, -12) uncenter(22, 6) rotate([0, 0, 90]) block(
        type="baseplate",
        width=6,
        length=22,
        roadway_width=6,
        roadway_length=6,
        roadway_x=12
    );
    
    
    //place(0, 0, 13/96) {
        color( "yellow" ) place(-5, -5, 0) uncenter(1/3, 15, 4) rotate([90, 0, 0]) block(
            dual_sided=true,
            width=4,
            length=15,
            height=1/3
        );
    
        color( "orange" ) place(-6.5, -3, 0) uncenter(1/3, 11, 3) rotate([90, 0, 0]) block(
            dual_bottom=true,
            width=3,
            length=15,
            height=1/3
        );
    
        color( "red" ) place(1, 0, 0) uncenter(2, 9) block(
            width=2,
            length=9,
            height=2,
            reinforcement=true
        );
        
        color( "blue" ) place(4, 0, 0) uncenter(2, 2) block(
            width=2,
            length=2,
            stud_type="hollow"
        );
        
        color( "white" ) place(4, 3, 0) uncenter(2, 2) block(
            width=2,
            length=2,
            height=1/3,
            vertical_axle_holes=true
        );
        
        color( "green" ) place(4, 6, 0) uncenter(2, 3) block(
            width=2,
            length=3,
            height=1/3,
            type="tile"
        );
        
        color( "white" ) place(7, 0, 0) uncenter(4, 9) block(
            width=4,
            length=9,
            height=1/3,
            type="wing",
            stud_notches=false
        );
    
        color( "yellow" ) place(12, 0, 0) uncenter(1, 8) block(
            width=1,
            length=8,
            horizontal_holes=true
        );
        
        color( "black" ) place(16, -5, 0) uncenter(2, 4) block(
            width=2,
            length=4,
            type="slope"
        );
        
        color( "green" ) place(-4, 0, 0) uncenter(4, 6) block(
            width=2,
            length=3,
            brand="duplo",
            reinforcement=true,
            stud_type="hollow"
        );
        
        color( "blue" ) place(-4, 7, 0) uncenter(4, 4) rotate([0, 0, 180]) block(
            width=2,
            length=2,
            brand="duplo",
            reinforcement=true,
            stud_type="hollow",
            type="curve"
        );
        
        color( "gray" ) place(-4, -5, 0) uncenter(12, 4) rotate([0, 0, 270]) block(
            width=2,
            length=6,
            height=2,
            curve_end_height=1,
            curve_stud_rows=5,
            brand="duplo",
            type="curve",
            curve_type="convex"
        );
    
        color( "blue" ) place(9, -5, 0) uncenter(6, 4) rotate([0, 0, 270]) block(
            width=4,
            length=6,
            height=2,
            brand="lego",
            reinforcement=true,
            stud_type="hollow",
            type="slope",
            slope_stud_rows=4,
            slope_end_height=1
        );
    
        color( "red" ) place(14, 0, 0) uncenter(3, 7) block(
            width=3,
            length=7,
            height=1,
            type="wing",
            wing_type="left",
            wing_end_width=1
        );
    
        color( "yellow" ) place(1, 10, 0) uncenter(6, 2) rotate([0, 0, 90]) block(
            width=2,
            length=6,
            height=1/3,
            type="wing",
            wing_type="right",
            wing_end_width=1,
            wing_base_length=1
        );
*/        
   // }
}

module angle_plate( angle=90, base_stud_length=2, base_stud_width=2, overhang_stud_length=2, overhang_stud_width=2 ) {
    // Values from Lego.scad.
    lego_brick_height = 9.6; // Height of the non-stud portion of a regular brick.
    stud_spacing=8; // Distance between centers of studs.
    stud_diameter=4.85; // Diameters of studs.
    wall_play=0.1; // Amount of space removed from the outer edge of bricks so that they will fit next to each other.

    base_height = lego_brick_height/3;
    base_width = (base_stud_width * stud_spacing) - (wall_play * 2);
    base_length = (base_stud_length * stud_spacing) - (wall_play * 2);

    overhang_height = lego_brick_height/3;
    overhang_width = (overhang_stud_width * stud_spacing) - (wall_play * 2);
    overhang_length = (overhang_stud_length * stud_spacing) - (wall_play * 2);

    if (base_stud_length > base_stud_width) {
        // Lego.scad always makes the longest number the length. Rotate it manually if we want it wider than long.
        rotate([0, 0, 90])
            block(
                height=.33333333333,
                type="brick",
                length=base_stud_length,
                width=base_stud_width
            );
    }
    else {
        block(
            height=.33333333333,
            type="brick",
            length=base_stud_length,
            width=base_stud_width
        );
    }
    
    if (angle <= 90 ) {
        // Add a solid section protruding out one end of the base to join it to the angled portion.
       translate([((base_width+overhang_height*sin(angle))/2)+wall_play/2, 0, base_height/2])
            cube([(overhang_height*sin(angle))+wall_play, base_length,base_height], true);
    }
    
    difference() {
        translate( [base_width/2 + (overhang_height*sin(angle))+wall_play, 0, base_height] )
            rotate([0, angle, 0])
            translate([overhang_width/2, 0, -overhang_height])
            union() {
                if (overhang_stud_length > overhang_stud_width) {
                    // Lego.scad always makes the longest number the length. Rotate it manually if we want it wider than long.
                    rotate([0, 0, 90])
                        block(
                            height=.33333333333,
                            type="brick",
                            length=overhang_stud_length,
                            width=overhang_stud_width,
                            stud_type="hollow"
                        );
                }
                else {
                    block(
                        height=.33333333333,
                        type="brick",
                        length=overhang_stud_length,
                        width=overhang_stud_width,
                        stud_type="hollow"
                    );
                }
                
                // Fill in the underside of the angled portion. type=baseplate would do this, but it would also make it thinner and give it rounded edges.
                translate( [0, 0, overhang_height/2] ) cube( [overhang_width, overhang_length, overhang_height], true );
        }

        // Remove from the angled brick everything above the top of the base brick.
        translate([ 0, 0, base_height + overhang_width/2]) {
            cube( [ base_width + (overhang_height * 2 * sin(angle)) + 0.01, max(base_length, overhang_length)+0.01, overhang_width ], true);
        }

        // Remove from the angle brick everything past the edge of the base.
        translate( [0, 0, base_height/2] ) {
            cube( [ base_width, max(base_length, overhang_length)+0.01, base_height * 10 ], true);
        }
    }
}

//angle_plate();