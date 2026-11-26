// structural verlog - comparator_8bit

`timescale 1ns/1ps

module comparator_8bit ( 

    input [7:0] count, 
    input [8:0] brightness,
    output pwm);
 
 wire not_q7;                                             
 not invert_count7(not_q7, count[7]);

wire bit7_smaller;                                          
and bit7_check(bit7_smaller, not_q7, brightness[7]);

wire bit7_equal;
xnor bit7_matching(bit7_equal, count[7], brightness[7]);   

//bit6-------------------------------------------------------------------------

wire not_q6;
not invert_count6(not_q6, count[6]);

wire bit6_smaller;
and bit6_check(bit6_smaller, not_q6, brightness[6]);

wire bit6_allowed;
and bit6_permission(bit6_allowed, bit6_smaller, bit7_equal); 

wire bits76_smaller;
or bits76_smaller_merged(bits76_smaller, bit6_allowed, bit7_smaller);

wire bit6_equal;
xnor bit6_matching(bit6_equal, brightness[6], count[6]);

wire bits76_equal;
and bits76_matching(bits76_equal, bit6_equal, bit7_equal);

//bit5-------------------------------------------------------------------------------

wire not_q5;
not invert_count5(not_q5, count[5]);

wire bit5_smaller;
and bit5_check(bit5_smaller, not_q5, brightness[5]);

wire bit5_allowed;
and bit5_permission(bit5_allowed, bit5_smaller, bits76_equal); 

wire bits765_smaller;
or bits765_smaller_merged(bits765_smaller, bit5_allowed, bits76_smaller);





// bit 4 ---------------------------------------------------------------------------

wire bit5_equal;
xnor bit5_matching(bit5_equal, count[5], brightness[5]);

wire bits765_equal;
and bits765_matching(bits765_equal, bits76_equal, bit5_equal);

wire not_q4;
not invert_count4(not_q4, count[4]);

wire bit4_smaller;
and bit4_check(bit4_smaller, not_q4, brightness[4]);

wire bit4_allowed;
and bit4_permision(bit4_allowed, bits765_equal, bit4_smaller);

wire bits7654_smaller;
or bits7654_smaller_merged(bits7654_smaller, bits765_smaller, bit4_allowed);


// bit 3 -----------------------------------------------------------------------------

wire bit4_equal;
xnor bit4_matching(bit4_equal, count[4], brightness[4]);

wire bits7654_equal;
and bits7654_matching(bits7654_equal, bits765_equal, bit4_equal);

wire not_q3;
not invert_count3(not_q3, count[3]);

wire bit3_smaller;
and bit3_check(bit3_smaller, not_q3, brightness[3]);

wire bit3_allowed;
and bit3_permision(bit3_allowed, bits7654_equal, bit3_smaller);

wire bits76543_smaller;
or bits76543_smaller_merged(bits76543_smaller, bits7654_smaller, bit3_allowed);



// bit 2 -----------------------------------------------------------------------------

wire bit3_equal;
xnor bit3_matching(bit3_equal, count[3], brightness[3]);

wire bits76543_equal;
and bits76543_matching(bits76543_equal, bits7654_equal, bit3_equal);

wire not_q2;
not invert_count2(not_q2, count[2]);

wire bit2_smaller;
and bit2_check(bit2_smaller, not_q2, brightness[2]);

wire bit2_allowed;
and bit2_permision(bit2_allowed, bits76543_equal, bit2_smaller);

wire bits765432_smaller;
or bits765432_smaller_merged(bits765432_smaller, bits76543_smaller, bit2_allowed);



// bit 1 -----------------------------------------------------------------------------

wire bit2_equal;
xnor bit2_matching(bit2_equal, count[2], brightness[2]);

wire bits765432_equal;
and bits765432_matching(bits765432_equal, bits76543_equal, bit2_equal);

wire not_q1;
not invert_count1(not_q1, count[1]);

wire bit1_smaller;
and bit1_check(bit1_smaller, not_q1, brightness[1]);

wire bit1_allowed;
and bit1_permision(bit1_allowed, bits765432_equal, bit1_smaller);

wire bits7654321_smaller;
or bits7654321_smaller_merged(bits7654321_smaller, bits765432_smaller, bit1_allowed);


// bit 0 -----------------------------------------------------------------------------

wire bit1_equal;
xnor bit1_matching(bit1_equal, count[1], brightness[1]);

wire bits7654321_equal;
and bits7654321_matching(bits7654321_equal, bits765432_equal, bit1_equal);

wire not_q0;
not invert_count0(not_q0, count[0]);

wire bit0_smaller;
and bit0_check(bit0_smaller, not_q0, brightness[0]);

wire bit0_allowed;
and bit0_permision(bit0_allowed, bits7654321_equal, bit0_smaller);

wire bits76543210_smaller;
or bits76543210_smaller_merged(bits76543210_smaller, bits7654321_smaller, bit0_allowed);





or final_or(pwm, bits76543210_smaller, brightness[8]);


endmodule


