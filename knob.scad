// Raw measurements
STEM_OD = 10;
STEM_ID = 6 + 0.4;
STEM_CLIP = 8.25 + 0.4;
STEM_DEPTH = 12;

RIM_HEIGHT = 7.25;
KNOB_OD = 38;
HANDLE_WIDTH = 10;
HANDLE_DEPTH = 12;

STEM_WALL = 2; // (STEM_OD - STEM_ID) / 2;

module stem(stem_depth, stem_od, stem_clip, stem_wall) {
    rotate([0, 0, 90])
    translate([0, 0, stem_depth])
    mirror([0, 0, 1])
    difference() {
        difference() {
            cylinder(h=stem_depth,r=stem_od / 2, center=false);
            translate([-stem_depth / 2, stem_clip - stem_od / 2, 0])
            cube([stem_depth, stem_depth, stem_depth], center=false);
        }

        difference() {
            cylinder(h=stem_depth,r=stem_id / 2, center=false);
            translate([-stem_depth / 2, stem_clip - stem_od / 2 - stem_wall, 0])
            cube([stem_depth, stem_depth, stem_depth], center=false);
        };

        translate([0,0, -stem_od + stem_wall])
        sphere(r=stem_od);
    }
};

module head(handle_depth, rim_height, knob_od, stem_wall) {
    render()
    difference() {
        translate([0, 0, -handle_depth])
        cylinder(h=rim_height + handle_depth,r=knob_od / 2);

        translate([0, 0, stem_wall])
        cylinder(h=rim_height - stem_wall,r=knob_od / 2 - stem_wall);

        // translate([-knob_od / 2 + stem_wall,-HANDLE_WIDTH / 2,-handle_depth])
        // translate([0, HANDLE_WIDTH / 2 - stem_wall / 2, 0])
        // cube([knob_od / 2 - stem_wall, stem_wall, stem_wall/2]);

        translate([0, 0, -handle_depth])
        hull() {
            cylinder(h=stem_wall / 2, r=stem_wall);
            translate([-knob_od / 2 + stem_wall, 0, 0])
            cylinder(h=stem_wall / 2, r=stem_wall / 4);
        }

        n = 32;
        for (i = [0:n]) {
            rotate([0, 0, 360 / n * i])
            translate([0, knob_od / 2, -handle_depth])
            cylinder(h=rim_height + handle_depth, r=stem_wall * 0.3, $fn=12);
        }
    }



    // hull() {
    //    cylinder(h=STEM_WALL,r=KNOB_OD/2);
    //    translate([-KNOB_OD/2,-HANDLE_WIDTH/2,-KNOB_OD/4])
    //    cube([KNOB_OD, HANDLE_WIDTH, 1]);
    // }
    // translate([-KNOB_OD/2,-HANDLE_WIDTH/2,-KNOB_OD/4-HANDLE_DEPTH])
    // translate([-KNOB_OD / 2 + STEM_WALL,-HANDLE_WIDTH / 2,-HANDLE_DEPTH])
    // difference() {
    //     cube([KNOB_OD - STEM_WALL * 2, HANDLE_WIDTH, HANDLE_DEPTH]);
    // }
}

module knob() {
    head(STEM_DEPTH, STEM_OD, STEM_CLIP, STEM_WALL);
    stem(HANDLE_DEPTH, RIM_HEIGHT, KNOB_OD, STEM_WALL);
};

!knob($fn=100);
