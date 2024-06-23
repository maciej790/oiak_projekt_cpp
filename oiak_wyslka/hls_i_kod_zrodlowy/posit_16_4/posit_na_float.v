// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 0.9.7-dev - Revision 151822f6eb6b28b68ef7cde4c7c3c0add185ed9d-panda-0.9.7-dev - Date 2024-06-01T20:39:46
// bambu executed with: bambu --std=c99 --top-fname=posit_na_float posit_16_4.c 
// 
// Send any bug to: panda-info@polimi.it
// ************************************************************************
// The following text holds for all the components tagged with PANDA_LGPLv3.
// They are all part of the BAMBU/PANDA IP LIBRARY.
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3 of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public
// License along with the PandA framework; see the files COPYING.LIB
// If not, see <http://www.gnu.org/licenses/>.
// ************************************************************************

`ifdef __ICARUS__
  `define _SIM_HAVE_CLOG2
`endif
`ifdef VERILATOR
  `define _SIM_HAVE_CLOG2
`endif
`ifdef MODEL_TECH
  `define _SIM_HAVE_CLOG2
`endif
`ifdef VCS
  `define _SIM_HAVE_CLOG2
`endif
`ifdef NCVERILOG
  `define _SIM_HAVE_CLOG2
`endif
`ifdef XILINX_SIMULATOR
  `define _SIM_HAVE_CLOG2
`endif
`ifdef XILINX_ISIM
  `define _SIM_HAVE_CLOG2
`endif

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>, Christian Pilato <christian.pilato@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module constant_value(out1);
  parameter BITSIZE_out1=1, value=1'b0;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = value;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module register_STD(clock, reset, in1, wenable, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input clock;
  input reset;
  input [BITSIZE_in1-1:0] in1;
  input wenable;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  reg [BITSIZE_out1-1:0] reg_out1 =0;
  assign out1 = reg_out1;
  always @(posedge clock)
    reg_out1 <= in1;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module register_SE(clock, reset, in1, wenable, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input clock;
  input reset;
  input [BITSIZE_in1-1:0] in1;
  input wenable;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  
  reg [BITSIZE_out1-1:0] reg_out1 =0;
  assign out1 = reg_out1;
  always @(posedge clock)
    if (wenable)
      reg_out1 <= in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module UIdata_converter_FU(in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){1'b0}},in1};
  end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module IUdata_converter_FU(in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){in1[BITSIZE_in1-1]}},in1};
  end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module read_cond_FU(in1, out1);
  parameter BITSIZE_in1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output out1;
  assign out1 = in1 != {BITSIZE_in1{1'b0}};
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module multi_read_cond_FU(in1, out1);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2, BITSIZE_out1=1;
  // IN
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module view_convert_expr_FU(in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module bit_and_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 & in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module bit_ior_concat_expr_FU(in1, in2, in3, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_in3=1, BITSIZE_out1=1, OFFSET_PARAMETER=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  input signed [BITSIZE_in3-1:0] in3;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  
  parameter nbit_out = BITSIZE_out1 > OFFSET_PARAMETER ? BITSIZE_out1 : 1+OFFSET_PARAMETER;
  wire signed [nbit_out-1:0] tmp_in1;
  wire signed [OFFSET_PARAMETER-1:0] tmp_in2;
  generate
    if(BITSIZE_in1 >= nbit_out)
      assign tmp_in1=in1[nbit_out-1:0];
    else
      assign tmp_in1={{(nbit_out-BITSIZE_in1){in1[BITSIZE_in1-1]}},in1};
  endgenerate
  generate
    if(BITSIZE_in2 >= OFFSET_PARAMETER)
      assign tmp_in2=in2[OFFSET_PARAMETER-1:0];
    else
      assign tmp_in2={{(OFFSET_PARAMETER-BITSIZE_in2){in2[BITSIZE_in2-1]}},in2};
  endgenerate
  assign out1 = {tmp_in1[nbit_out-1:OFFSET_PARAMETER] , tmp_in2};
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module bit_ior_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 | in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module cond_expr_FU(in1, in2, in3, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_in3=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  input signed [BITSIZE_in3-1:0] in3;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 != 0 ? in2 : in3;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module eq_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 == in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module fp_cond_expr_FU(in1, in2, in3, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_in3=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 != 0 ? in2 : in3;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module lshift_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1, PRECISION=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  `ifndef _SIM_HAVE_CLOG2
    function integer log2;
       input integer value;
       integer temp_value;
      begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
      end
    endfunction
  `endif
  `ifdef _SIM_HAVE_CLOG2
    parameter arg2_bitsize = $clog2(PRECISION);
  `else
    parameter arg2_bitsize = log2(PRECISION);
  `endif
  generate
    if(BITSIZE_in2 > arg2_bitsize)
      assign out1 = in1 <<< in2[arg2_bitsize-1:0];
    else
      assign out1 = in1 <<< in2;
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module minus_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 - in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ne_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 != in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module plus_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 + in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module rshift_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1, PRECISION=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  `ifndef _SIM_HAVE_CLOG2
    function integer log2;
       input integer value;
       integer temp_value;
      begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
      end
    endfunction
  `endif
  `ifdef _SIM_HAVE_CLOG2
    parameter arg2_bitsize = $clog2(PRECISION);
  `else
    parameter arg2_bitsize = log2(PRECISION);
  `endif
  generate
    if(BITSIZE_in2 > arg2_bitsize)
      assign out1 = in1 >>> (in2[arg2_bitsize-1:0]);
    else
      assign out1 = in1 >>> in2;
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module truth_and_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 && in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module truth_not_expr_FU(in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = !in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_cond_expr_FU(in1, in2, in3, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_in3=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 != 0 ? in2 : in3;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_minus_expr_FU(in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 - in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_negate_expr_FU(in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = -in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ASSIGN_SIGNED_FU(in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>, Christian Pilato <christian.pilato@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module MUX_GATE(sel, in1, in2, out1);
  parameter BITSIZE_in1=1, BITSIZE_in2=1, BITSIZE_out1=1;
  // IN
  input sel;
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = sel ? in1 : in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module UUdata_converter_FU(in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){1'b0}},in1};
  end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module IIdata_converter_FU(in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){in1[BITSIZE_in1-1]}},in1};
  end
  endgenerate
endmodule

// Datapath RTL description for posit_na_float
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_posit_na_float(clock, reset, in_port_x, return_port, selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0, selector_MUX_48_gimple_return_FU_6_i0_0_0_0, selector_MUX_95_reg_5_0_0_0, selector_MUX_96_reg_6_0_0_0, selector_MUX_97_reg_7_0_0_0, selector_MUX_98_reg_8_0_0_0, selector_MUX_99_reg_9_0_0_0, wrenable_reg_0, wrenable_reg_1, wrenable_reg_2, wrenable_reg_3, wrenable_reg_4, wrenable_reg_5, wrenable_reg_6, wrenable_reg_7, wrenable_reg_8, wrenable_reg_9, OUT_CONDITION_posit_na_float_28435_28460, OUT_MULTIIF_posit_na_float_28435_28730);
  // IN
  input clock;
  input reset;
  input [15:0] in_port_x;
  input selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0;
  input selector_MUX_48_gimple_return_FU_6_i0_0_0_0;
  input selector_MUX_95_reg_5_0_0_0;
  input selector_MUX_96_reg_6_0_0_0;
  input selector_MUX_97_reg_7_0_0_0;
  input selector_MUX_98_reg_8_0_0_0;
  input selector_MUX_99_reg_9_0_0_0;
  input wrenable_reg_0;
  input wrenable_reg_1;
  input wrenable_reg_2;
  input wrenable_reg_3;
  input wrenable_reg_4;
  input wrenable_reg_5;
  input wrenable_reg_6;
  input wrenable_reg_7;
  input wrenable_reg_8;
  input wrenable_reg_9;
  // OUT
  output [31:0] return_port;
  output OUT_CONDITION_posit_na_float_28435_28460;
  output [1:0] OUT_MULTIIF_posit_na_float_28435_28730;
  // Component and signal declarations
  wire [3:0] out_IUdata_converter_FU_11_i0_fu_posit_na_float_28435_28535;
  wire [14:0] out_IUdata_converter_FU_4_i0_fu_posit_na_float_28435_28483;
  wire [14:0] out_IUdata_converter_FU_8_i0_fu_posit_na_float_28435_28495;
  wire [4:0] out_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0;
  wire [31:0] out_MUX_48_gimple_return_FU_6_i0_0_0_0;
  wire [4:0] out_MUX_95_reg_5_0_0_0;
  wire [9:0] out_MUX_96_reg_6_0_0_0;
  wire [4:0] out_MUX_97_reg_7_0_0_0;
  wire [31:0] out_MUX_98_reg_8_0_0_0;
  wire [5:0] out_MUX_99_reg_9_0_0_0;
  wire signed [4:0] out_UIdata_converter_FU_12_i0_fu_posit_na_float_28435_28537;
  wire signed [16:0] out_UIdata_converter_FU_2_i0_fu_posit_na_float_28435_28456;
  wire signed [14:0] out_UIdata_converter_FU_3_i0_fu_posit_na_float_28435_28458;
  wire signed [14:0] out_UIdata_converter_FU_7_i0_fu_posit_na_float_28435_28493;
  wire signed [15:0] out_UIdata_converter_FU_9_i0_fu_posit_na_float_28435_28512;
  wire signed [15:0] out_bit_and_expr_FU_16_0_16_19_i0_fu_posit_na_float_28435_28459;
  wire signed [15:0] out_bit_and_expr_FU_16_0_16_19_i1_fu_posit_na_float_28435_28494;
  wire signed [8:0] out_bit_and_expr_FU_16_0_16_20_i0_fu_posit_na_float_28435_28612;
  wire signed [15:0] out_bit_and_expr_FU_16_16_16_21_i0_fu_posit_na_float_28435_28608;
  wire signed [23:0] out_bit_and_expr_FU_32_0_32_22_i0_fu_posit_na_float_28435_28614;
  wire signed [1:0] out_bit_and_expr_FU_8_0_8_23_i0_fu_posit_na_float_28435_28539;
  wire signed [4:0] out_bit_and_expr_FU_8_0_8_24_i0_fu_posit_na_float_28435_28607;
  wire signed [9:0] out_bit_ior_concat_expr_FU_25_i0_fu_posit_na_float_28435_28562;
  wire signed [31:0] out_bit_ior_expr_FU_0_32_32_26_i0_fu_posit_na_float_28435_28615;
  wire signed [31:0] out_bit_ior_expr_FU_0_32_32_27_i0_fu_posit_na_float_28435_28616;
  wire signed [9:0] out_cond_expr_FU_16_16_16_16_28_i0_fu_posit_na_float_28435_28739;
  wire signed [31:0] out_cond_expr_FU_32_32_32_32_29_i0_fu_posit_na_float_28435_28745;
  wire signed [4:0] out_cond_expr_FU_8_8_8_8_30_i0_fu_posit_na_float_28435_28742;
  wire signed [5:0] out_cond_expr_FU_8_8_8_8_30_i1_fu_posit_na_float_28435_28748;
  wire out_const_0;
  wire [31:0] out_const_1;
  wire [4:0] out_const_10;
  wire [5:0] out_const_11;
  wire [7:0] out_const_12;
  wire [8:0] out_const_13;
  wire [10:0] out_const_14;
  wire [15:0] out_const_15;
  wire [23:0] out_const_16;
  wire [31:0] out_const_17;
  wire [3:0] out_const_18;
  wire [1:0] out_const_19;
  wire [1:0] out_const_2;
  wire [3:0] out_const_20;
  wire [3:0] out_const_3;
  wire [4:0] out_const_4;
  wire [9:0] out_const_5;
  wire [5:0] out_const_6;
  wire [4:0] out_const_7;
  wire [3:0] out_const_8;
  wire [5:0] out_const_9;
  wire [14:0] out_conv_out_MUX_98_reg_8_0_0_0_32_15;
  wire [4:0] out_conv_out_i_assign_conn_obj_0_ASSIGN_SIGNED_FU_i_assign_0_I_1_5;
  wire [4:0] out_conv_out_i_assign_conn_obj_1_ASSIGN_SIGNED_FU_i_assign_1_I_4_5;
  wire [31:0] out_conv_out_i_assign_conn_obj_2_ASSIGN_SIGNED_FU_i_assign_2_I_2_32;
  wire signed [0:0] out_conv_out_rshift_expr_FU_16_16_16_49_i0_rshift_expr_FU_16_16_16_49_i0_I_4_I_1;
  wire out_eq_expr_FU_16_0_16_31_i0_fu_posit_na_float_28435_28675;
  wire [31:0] out_fp_cond_expr_FU_32_32_32_32_32_i0_fu_posit_na_float_28435_28727;
  wire signed [0:0] out_i_assign_conn_obj_0_ASSIGN_SIGNED_FU_i_assign_0;
  wire signed [3:0] out_i_assign_conn_obj_1_ASSIGN_SIGNED_FU_i_assign_1;
  wire signed [1:0] out_i_assign_conn_obj_2_ASSIGN_SIGNED_FU_i_assign_2;
  wire signed [31:0] out_i_assign_conn_obj_3_ASSIGN_SIGNED_FU_i_assign_3;
  wire signed [31:0] out_lshift_expr_FU_0_32_32_33_i0_fu_posit_na_float_28435_28564;
  wire signed [8:0] out_lshift_expr_FU_16_0_16_34_i0_fu_posit_na_float_28435_28561;
  wire signed [9:0] out_lshift_expr_FU_16_0_16_35_i0_fu_posit_na_float_28435_28723;
  wire signed [31:0] out_lshift_expr_FU_32_0_32_36_i0_fu_posit_na_float_28435_28611;
  wire signed [31:0] out_lshift_expr_FU_32_0_32_37_i0_fu_posit_na_float_28435_28613;
  wire signed [22:0] out_lshift_expr_FU_32_32_32_38_i0_fu_posit_na_float_28435_28609;
  wire signed [4:0] out_minus_expr_FU_0_8_8_39_i0_fu_posit_na_float_28435_28563;
  wire [1:0] out_multi_read_cond_FU_13_i0_fu_posit_na_float_28435_28730;
  wire out_ne_expr_FU_8_0_8_40_i0_fu_posit_na_float_28435_28679;
  wire out_ne_expr_FU_8_0_8_40_i1_fu_posit_na_float_28435_28683;
  wire out_ne_expr_FU_8_0_8_40_i2_fu_posit_na_float_28435_28685;
  wire out_ne_expr_FU_8_0_8_41_i0_fu_posit_na_float_28435_28681;
  wire signed [31:0] out_plus_expr_FU_32_0_32_42_i0_fu_posit_na_float_28435_28565;
  wire signed [4:0] out_plus_expr_FU_8_0_8_43_i0_fu_posit_na_float_28435_28517;
  wire signed [4:0] out_plus_expr_FU_8_0_8_44_i0_fu_posit_na_float_28435_28560;
  wire signed [5:0] out_plus_expr_FU_8_0_8_45_i0_fu_posit_na_float_28435_28566;
  wire signed [5:0] out_plus_expr_FU_8_0_8_46_i0_fu_posit_na_float_28435_28719;
  wire signed [7:0] out_plus_expr_FU_8_8_8_47_i0_fu_posit_na_float_28435_28610;
  wire out_read_cond_FU_5_i0_fu_posit_na_float_28435_28460;
  wire [31:0] out_reg_0_reg_0;
  wire [14:0] out_reg_1_reg_1;
  wire [31:0] out_reg_2_reg_2;
  wire out_reg_3_reg_3;
  wire [15:0] out_reg_4_reg_4;
  wire [4:0] out_reg_5_reg_5;
  wire [9:0] out_reg_6_reg_6;
  wire [4:0] out_reg_7_reg_7;
  wire [14:0] out_reg_8_reg_8;
  wire [5:0] out_reg_9_reg_9;
  wire signed [4:0] out_rshift_expr_FU_16_0_16_48_i0_fu_posit_na_float_28435_28715;
  wire signed [3:0] out_rshift_expr_FU_16_16_16_49_i0_rshift_expr_FU_16_16_16_49_i0;
  wire signed [1:0] out_rshift_expr_FU_32_0_32_50_i0_fu_posit_na_float_28435_28457;
  wire out_truth_and_expr_FU_1_1_1_51_i0_fu_posit_na_float_28435_28736;
  wire out_truth_not_expr_FU_1_1_52_i0_fu_posit_na_float_28435_28733;
  wire [14:0] out_ui_cond_expr_FU_16_16_16_16_53_i0_fu_posit_na_float_28435_28737;
  wire [31:0] out_ui_minus_expr_FU_0_8_8_54_i0_fu_posit_na_float_28435_28536;
  wire [14:0] out_ui_negate_expr_FU_16_16_55_i0_fu_posit_na_float_28435_28492;
  wire [31:0] out_view_convert_expr_FU_18_i0_fu_posit_na_float_28435_28617;
  
  ASSIGN_SIGNED_FU #(.BITSIZE_in1(1), .BITSIZE_out1(1)) ASSIGN_SIGNED_FU_i_assign_0 (.out1(out_i_assign_conn_obj_0_ASSIGN_SIGNED_FU_i_assign_0), .in1(out_const_0));
  ASSIGN_SIGNED_FU #(.BITSIZE_in1(4), .BITSIZE_out1(4)) ASSIGN_SIGNED_FU_i_assign_1 (.out1(out_i_assign_conn_obj_1_ASSIGN_SIGNED_FU_i_assign_1), .in1(out_const_18));
  ASSIGN_SIGNED_FU #(.BITSIZE_in1(2), .BITSIZE_out1(2)) ASSIGN_SIGNED_FU_i_assign_2 (.out1(out_i_assign_conn_obj_2_ASSIGN_SIGNED_FU_i_assign_2), .in1(out_const_19));
  ASSIGN_SIGNED_FU #(.BITSIZE_in1(32), .BITSIZE_out1(32)) ASSIGN_SIGNED_FU_i_assign_3 (.out1(out_i_assign_conn_obj_3_ASSIGN_SIGNED_FU_i_assign_3), .in1(out_cond_expr_FU_32_32_32_32_29_i0_fu_posit_na_float_28435_28745));
  MUX_GATE #(.BITSIZE_in1(5), .BITSIZE_in2(5), .BITSIZE_out1(5)) MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0 (.out1(out_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0), .sel(selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0), .in1(out_reg_7_reg_7), .in2(out_UIdata_converter_FU_12_i0_fu_posit_na_float_28435_28537));
  MUX_GATE #(.BITSIZE_in1(32), .BITSIZE_in2(32), .BITSIZE_out1(32)) MUX_48_gimple_return_FU_6_i0_0_0_0 (.out1(out_MUX_48_gimple_return_FU_6_i0_0_0_0), .sel(selector_MUX_48_gimple_return_FU_6_i0_0_0_0), .in1(out_reg_0_reg_0), .in2(out_view_convert_expr_FU_18_i0_fu_posit_na_float_28435_28617));
  MUX_GATE #(.BITSIZE_in1(5), .BITSIZE_in2(5), .BITSIZE_out1(5)) MUX_95_reg_5_0_0_0 (.out1(out_MUX_95_reg_5_0_0_0), .sel(selector_MUX_95_reg_5_0_0_0), .in1(out_conv_out_i_assign_conn_obj_0_ASSIGN_SIGNED_FU_i_assign_0_I_1_5), .in2(out_plus_expr_FU_8_0_8_43_i0_fu_posit_na_float_28435_28517));
  MUX_GATE #(.BITSIZE_in1(10), .BITSIZE_in2(10), .BITSIZE_out1(10)) MUX_96_reg_6_0_0_0 (.out1(out_MUX_96_reg_6_0_0_0), .sel(selector_MUX_96_reg_6_0_0_0), .in1(out_const_5), .in2(out_cond_expr_FU_16_16_16_16_28_i0_fu_posit_na_float_28435_28739));
  MUX_GATE #(.BITSIZE_in1(5), .BITSIZE_in2(5), .BITSIZE_out1(5)) MUX_97_reg_7_0_0_0 (.out1(out_MUX_97_reg_7_0_0_0), .sel(selector_MUX_97_reg_7_0_0_0), .in1(out_cond_expr_FU_8_8_8_8_30_i0_fu_posit_na_float_28435_28742), .in2(out_conv_out_i_assign_conn_obj_1_ASSIGN_SIGNED_FU_i_assign_1_I_4_5));
  MUX_GATE #(.BITSIZE_in1(32), .BITSIZE_in2(32), .BITSIZE_out1(32)) MUX_98_reg_8_0_0_0 (.out1(out_MUX_98_reg_8_0_0_0), .sel(selector_MUX_98_reg_8_0_0_0), .in1(out_conv_out_i_assign_conn_obj_2_ASSIGN_SIGNED_FU_i_assign_2_I_2_32), .in2(out_i_assign_conn_obj_3_ASSIGN_SIGNED_FU_i_assign_3));
  MUX_GATE #(.BITSIZE_in1(6), .BITSIZE_in2(6), .BITSIZE_out1(6)) MUX_99_reg_9_0_0_0 (.out1(out_MUX_99_reg_9_0_0_0), .sel(selector_MUX_99_reg_9_0_0_0), .in1(out_const_9), .in2(out_cond_expr_FU_8_8_8_8_30_i1_fu_posit_na_float_28435_28748));
  constant_value #(.BITSIZE_out1(1), .value(1'b0)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(32), .value(32'b00000000000000000000000000000000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(5), .value(5'b01111)) const_10 (.out1(out_const_10));
  constant_value #(.BITSIZE_out1(6), .value(6'b011111)) const_11 (.out1(out_const_11));
  constant_value #(.BITSIZE_out1(8), .value(8'b01111111)) const_12 (.out1(out_const_12));
  constant_value #(.BITSIZE_out1(9), .value(9'b011111111)) const_13 (.out1(out_const_13));
  constant_value #(.BITSIZE_out1(11), .value(11'b01111111111)) const_14 (.out1(out_const_14));
  constant_value #(.BITSIZE_out1(16), .value(16'b0111111111111111)) const_15 (.out1(out_const_15));
  constant_value #(.BITSIZE_out1(24), .value(24'b011111111111111111111111)) const_16 (.out1(out_const_16));
  constant_value #(.BITSIZE_out1(32), .value(32'b10000000000000000000000000000000)) const_17 (.out1(out_const_17));
  constant_value #(.BITSIZE_out1(4), .value(4'b1011)) const_18 (.out1(out_const_18));
  constant_value #(.BITSIZE_out1(2), .value(2'b11)) const_19 (.out1(out_const_19));
  constant_value #(.BITSIZE_out1(2), .value(2'b01)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(4), .value(4'b1110)) const_20 (.out1(out_const_20));
  constant_value #(.BITSIZE_out1(4), .value(4'b0100)) const_3 (.out1(out_const_3));
  constant_value #(.BITSIZE_out1(5), .value(5'b01010)) const_4 (.out1(out_const_4));
  constant_value #(.BITSIZE_out1(10), .value(10'b0101011111)) const_5 (.out1(out_const_5));
  constant_value #(.BITSIZE_out1(6), .value(6'b010111)) const_6 (.out1(out_const_6));
  constant_value #(.BITSIZE_out1(5), .value(5'b01101)) const_7 (.out1(out_const_7));
  constant_value #(.BITSIZE_out1(4), .value(4'b0111)) const_8 (.out1(out_const_8));
  constant_value #(.BITSIZE_out1(6), .value(6'b011100)) const_9 (.out1(out_const_9));
  UUdata_converter_FU #(.BITSIZE_in1(32), .BITSIZE_out1(15)) conv_out_MUX_98_reg_8_0_0_0_32_15 (.out1(out_conv_out_MUX_98_reg_8_0_0_0_32_15), .in1(out_MUX_98_reg_8_0_0_0));
  IUdata_converter_FU #(.BITSIZE_in1(1), .BITSIZE_out1(5)) conv_out_i_assign_conn_obj_0_ASSIGN_SIGNED_FU_i_assign_0_I_1_5 (.out1(out_conv_out_i_assign_conn_obj_0_ASSIGN_SIGNED_FU_i_assign_0_I_1_5), .in1(out_i_assign_conn_obj_0_ASSIGN_SIGNED_FU_i_assign_0));
  IUdata_converter_FU #(.BITSIZE_in1(4), .BITSIZE_out1(5)) conv_out_i_assign_conn_obj_1_ASSIGN_SIGNED_FU_i_assign_1_I_4_5 (.out1(out_conv_out_i_assign_conn_obj_1_ASSIGN_SIGNED_FU_i_assign_1_I_4_5), .in1(out_i_assign_conn_obj_1_ASSIGN_SIGNED_FU_i_assign_1));
  IUdata_converter_FU #(.BITSIZE_in1(2), .BITSIZE_out1(32)) conv_out_i_assign_conn_obj_2_ASSIGN_SIGNED_FU_i_assign_2_I_2_32 (.out1(out_conv_out_i_assign_conn_obj_2_ASSIGN_SIGNED_FU_i_assign_2_I_2_32), .in1(out_i_assign_conn_obj_2_ASSIGN_SIGNED_FU_i_assign_2));
  IIdata_converter_FU #(.BITSIZE_in1(4), .BITSIZE_out1(1)) conv_out_rshift_expr_FU_16_16_16_49_i0_rshift_expr_FU_16_16_16_49_i0_I_4_I_1 (.out1(out_conv_out_rshift_expr_FU_16_16_16_49_i0_rshift_expr_FU_16_16_16_49_i0_I_4_I_1), .in1(out_rshift_expr_FU_16_16_16_49_i0_rshift_expr_FU_16_16_16_49_i0));
  UIdata_converter_FU #(.BITSIZE_in1(16), .BITSIZE_out1(17)) fu_posit_na_float_28435_28456 (.out1(out_UIdata_converter_FU_2_i0_fu_posit_na_float_28435_28456), .in1(in_port_x));
  rshift_expr_FU #(.BITSIZE_in1(17), .BITSIZE_in2(5), .BITSIZE_out1(2), .PRECISION(32)) fu_posit_na_float_28435_28457 (.out1(out_rshift_expr_FU_32_0_32_50_i0_fu_posit_na_float_28435_28457), .in1(out_UIdata_converter_FU_2_i0_fu_posit_na_float_28435_28456), .in2(out_const_10));
  UIdata_converter_FU #(.BITSIZE_in1(16), .BITSIZE_out1(15)) fu_posit_na_float_28435_28458 (.out1(out_UIdata_converter_FU_3_i0_fu_posit_na_float_28435_28458), .in1(in_port_x));
  bit_and_expr_FU #(.BITSIZE_in1(15), .BITSIZE_in2(16), .BITSIZE_out1(16)) fu_posit_na_float_28435_28459 (.out1(out_bit_and_expr_FU_16_0_16_19_i0_fu_posit_na_float_28435_28459), .in1(out_UIdata_converter_FU_3_i0_fu_posit_na_float_28435_28458), .in2(out_const_15));
  read_cond_FU #(.BITSIZE_in1(1)) fu_posit_na_float_28435_28460 (.out1(out_read_cond_FU_5_i0_fu_posit_na_float_28435_28460), .in1(out_eq_expr_FU_16_0_16_31_i0_fu_posit_na_float_28435_28675));
  IUdata_converter_FU #(.BITSIZE_in1(16), .BITSIZE_out1(15)) fu_posit_na_float_28435_28483 (.out1(out_IUdata_converter_FU_4_i0_fu_posit_na_float_28435_28483), .in1(out_bit_and_expr_FU_16_0_16_19_i0_fu_posit_na_float_28435_28459));
  ui_negate_expr_FU #(.BITSIZE_in1(15), .BITSIZE_out1(15)) fu_posit_na_float_28435_28492 (.out1(out_ui_negate_expr_FU_16_16_55_i0_fu_posit_na_float_28435_28492), .in1(out_reg_1_reg_1));
  UIdata_converter_FU #(.BITSIZE_in1(15), .BITSIZE_out1(15)) fu_posit_na_float_28435_28493 (.out1(out_UIdata_converter_FU_7_i0_fu_posit_na_float_28435_28493), .in1(out_ui_negate_expr_FU_16_16_55_i0_fu_posit_na_float_28435_28492));
  bit_and_expr_FU #(.BITSIZE_in1(15), .BITSIZE_in2(16), .BITSIZE_out1(16)) fu_posit_na_float_28435_28494 (.out1(out_bit_and_expr_FU_16_0_16_19_i1_fu_posit_na_float_28435_28494), .in1(out_UIdata_converter_FU_7_i0_fu_posit_na_float_28435_28493), .in2(out_const_15));
  IUdata_converter_FU #(.BITSIZE_in1(16), .BITSIZE_out1(15)) fu_posit_na_float_28435_28495 (.out1(out_IUdata_converter_FU_8_i0_fu_posit_na_float_28435_28495), .in1(out_bit_and_expr_FU_16_0_16_19_i1_fu_posit_na_float_28435_28494));
  UIdata_converter_FU #(.BITSIZE_in1(15), .BITSIZE_out1(16)) fu_posit_na_float_28435_28512 (.out1(out_UIdata_converter_FU_9_i0_fu_posit_na_float_28435_28512), .in1(out_ui_cond_expr_FU_16_16_16_16_53_i0_fu_posit_na_float_28435_28737));
  plus_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(2), .BITSIZE_out1(5)) fu_posit_na_float_28435_28517 (.out1(out_plus_expr_FU_8_0_8_43_i0_fu_posit_na_float_28435_28517), .in1(out_reg_5_reg_5), .in2(out_const_2));
  IUdata_converter_FU #(.BITSIZE_in1(5), .BITSIZE_out1(4)) fu_posit_na_float_28435_28535 (.out1(out_IUdata_converter_FU_11_i0_fu_posit_na_float_28435_28535), .in1(out_reg_5_reg_5));
  ui_minus_expr_FU #(.BITSIZE_in1(4), .BITSIZE_in2(4), .BITSIZE_out1(32)) fu_posit_na_float_28435_28536 (.out1(out_ui_minus_expr_FU_0_8_8_54_i0_fu_posit_na_float_28435_28536), .in1(out_const_20), .in2(out_IUdata_converter_FU_11_i0_fu_posit_na_float_28435_28535));
  UIdata_converter_FU #(.BITSIZE_in1(32), .BITSIZE_out1(5)) fu_posit_na_float_28435_28537 (.out1(out_UIdata_converter_FU_12_i0_fu_posit_na_float_28435_28537), .in1(out_ui_minus_expr_FU_0_8_8_54_i0_fu_posit_na_float_28435_28536));
  bit_and_expr_FU #(.BITSIZE_in1(1), .BITSIZE_in2(2), .BITSIZE_out1(2)) fu_posit_na_float_28435_28539 (.out1(out_bit_and_expr_FU_8_0_8_23_i0_fu_posit_na_float_28435_28539), .in1(out_conv_out_rshift_expr_FU_16_16_16_49_i0_rshift_expr_FU_16_16_16_49_i0_I_4_I_1), .in2(out_const_2));
  plus_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(2), .BITSIZE_out1(5)) fu_posit_na_float_28435_28560 (.out1(out_plus_expr_FU_8_0_8_44_i0_fu_posit_na_float_28435_28560), .in1(out_reg_5_reg_5), .in2(out_const_19));
  lshift_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(4), .BITSIZE_out1(9), .PRECISION(32)) fu_posit_na_float_28435_28561 (.out1(out_lshift_expr_FU_16_0_16_34_i0_fu_posit_na_float_28435_28561), .in1(out_plus_expr_FU_8_0_8_44_i0_fu_posit_na_float_28435_28560), .in2(out_const_3));
  bit_ior_concat_expr_FU #(.BITSIZE_in1(10), .BITSIZE_in2(5), .BITSIZE_in3(4), .BITSIZE_out1(10), .OFFSET_PARAMETER(4)) fu_posit_na_float_28435_28562 (.out1(out_bit_ior_concat_expr_FU_25_i0_fu_posit_na_float_28435_28562), .in1(out_lshift_expr_FU_16_0_16_35_i0_fu_posit_na_float_28435_28723), .in2(out_const_10), .in3(out_const_3));
  minus_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(5), .BITSIZE_out1(5)) fu_posit_na_float_28435_28563 (.out1(out_minus_expr_FU_0_8_8_39_i0_fu_posit_na_float_28435_28563), .in1(out_const_4), .in2(out_reg_5_reg_5));
  lshift_expr_FU #(.BITSIZE_in1(2), .BITSIZE_in2(5), .BITSIZE_out1(32), .PRECISION(32)) fu_posit_na_float_28435_28564 (.out1(out_lshift_expr_FU_0_32_32_33_i0_fu_posit_na_float_28435_28564), .in1(out_const_2), .in2(out_minus_expr_FU_0_8_8_39_i0_fu_posit_na_float_28435_28563));
  plus_expr_FU #(.BITSIZE_in1(32), .BITSIZE_in2(2), .BITSIZE_out1(32)) fu_posit_na_float_28435_28565 (.out1(out_plus_expr_FU_32_0_32_42_i0_fu_posit_na_float_28435_28565), .in1(out_lshift_expr_FU_0_32_32_33_i0_fu_posit_na_float_28435_28564), .in2(out_const_19));
  plus_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(5), .BITSIZE_out1(6)) fu_posit_na_float_28435_28566 (.out1(out_plus_expr_FU_8_0_8_45_i0_fu_posit_na_float_28435_28566), .in1(out_reg_5_reg_5), .in2(out_const_7));
  bit_and_expr_FU #(.BITSIZE_in1(4), .BITSIZE_in2(5), .BITSIZE_out1(5)) fu_posit_na_float_28435_28607 (.out1(out_bit_and_expr_FU_8_0_8_24_i0_fu_posit_na_float_28435_28607), .in1(out_rshift_expr_FU_16_16_16_49_i0_rshift_expr_FU_16_16_16_49_i0), .in2(out_const_10));
  bit_and_expr_FU #(.BITSIZE_in1(16), .BITSIZE_in2(15), .BITSIZE_out1(16)) fu_posit_na_float_28435_28608 (.out1(out_bit_and_expr_FU_16_16_16_21_i0_fu_posit_na_float_28435_28608), .in1(out_reg_4_reg_4), .in2(out_reg_8_reg_8));
  lshift_expr_FU #(.BITSIZE_in1(16), .BITSIZE_in2(6), .BITSIZE_out1(23), .PRECISION(32)) fu_posit_na_float_28435_28609 (.out1(out_lshift_expr_FU_32_32_32_38_i0_fu_posit_na_float_28435_28609), .in1(out_bit_and_expr_FU_16_16_16_21_i0_fu_posit_na_float_28435_28608), .in2(out_reg_9_reg_9));
  plus_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(10), .BITSIZE_out1(8)) fu_posit_na_float_28435_28610 (.out1(out_plus_expr_FU_8_8_8_47_i0_fu_posit_na_float_28435_28610), .in1(out_bit_and_expr_FU_8_0_8_24_i0_fu_posit_na_float_28435_28607), .in2(out_reg_6_reg_6));
  lshift_expr_FU #(.BITSIZE_in1(2), .BITSIZE_in2(6), .BITSIZE_out1(32), .PRECISION(32)) fu_posit_na_float_28435_28611 (.out1(out_lshift_expr_FU_32_0_32_36_i0_fu_posit_na_float_28435_28611), .in1(out_rshift_expr_FU_32_0_32_50_i0_fu_posit_na_float_28435_28457), .in2(out_const_11));
  bit_and_expr_FU #(.BITSIZE_in1(8), .BITSIZE_in2(9), .BITSIZE_out1(9)) fu_posit_na_float_28435_28612 (.out1(out_bit_and_expr_FU_16_0_16_20_i0_fu_posit_na_float_28435_28612), .in1(out_plus_expr_FU_8_8_8_47_i0_fu_posit_na_float_28435_28610), .in2(out_const_13));
  lshift_expr_FU #(.BITSIZE_in1(9), .BITSIZE_in2(6), .BITSIZE_out1(32), .PRECISION(32)) fu_posit_na_float_28435_28613 (.out1(out_lshift_expr_FU_32_0_32_37_i0_fu_posit_na_float_28435_28613), .in1(out_bit_and_expr_FU_16_0_16_20_i0_fu_posit_na_float_28435_28612), .in2(out_const_6));
  bit_and_expr_FU #(.BITSIZE_in1(23), .BITSIZE_in2(24), .BITSIZE_out1(24)) fu_posit_na_float_28435_28614 (.out1(out_bit_and_expr_FU_32_0_32_22_i0_fu_posit_na_float_28435_28614), .in1(out_lshift_expr_FU_32_32_32_38_i0_fu_posit_na_float_28435_28609), .in2(out_const_16));
  bit_ior_expr_FU #(.BITSIZE_in1(24), .BITSIZE_in2(32), .BITSIZE_out1(32)) fu_posit_na_float_28435_28615 (.out1(out_bit_ior_expr_FU_0_32_32_26_i0_fu_posit_na_float_28435_28615), .in1(out_bit_and_expr_FU_32_0_32_22_i0_fu_posit_na_float_28435_28614), .in2(out_reg_2_reg_2));
  bit_ior_expr_FU #(.BITSIZE_in1(32), .BITSIZE_in2(32), .BITSIZE_out1(32)) fu_posit_na_float_28435_28616 (.out1(out_bit_ior_expr_FU_0_32_32_27_i0_fu_posit_na_float_28435_28616), .in1(out_bit_ior_expr_FU_0_32_32_26_i0_fu_posit_na_float_28435_28615), .in2(out_lshift_expr_FU_32_0_32_37_i0_fu_posit_na_float_28435_28613));
  view_convert_expr_FU #(.BITSIZE_in1(32), .BITSIZE_out1(32)) fu_posit_na_float_28435_28617 (.out1(out_view_convert_expr_FU_18_i0_fu_posit_na_float_28435_28617), .in1(out_bit_ior_expr_FU_0_32_32_27_i0_fu_posit_na_float_28435_28616));
  eq_expr_FU #(.BITSIZE_in1(16), .BITSIZE_in2(1), .BITSIZE_out1(1)) fu_posit_na_float_28435_28675 (.out1(out_eq_expr_FU_16_0_16_31_i0_fu_posit_na_float_28435_28675), .in1(out_bit_and_expr_FU_16_0_16_19_i0_fu_posit_na_float_28435_28459), .in2(out_const_0));
  ne_expr_FU #(.BITSIZE_in1(2), .BITSIZE_in2(1), .BITSIZE_out1(1)) fu_posit_na_float_28435_28679 (.out1(out_ne_expr_FU_8_0_8_40_i0_fu_posit_na_float_28435_28679), .in1(out_rshift_expr_FU_32_0_32_50_i0_fu_posit_na_float_28435_28457), .in2(out_const_0));
  ne_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(5), .BITSIZE_out1(1)) fu_posit_na_float_28435_28681 (.out1(out_ne_expr_FU_8_0_8_41_i0_fu_posit_na_float_28435_28681), .in1(out_plus_expr_FU_8_0_8_43_i0_fu_posit_na_float_28435_28517), .in2(out_const_10));
  ne_expr_FU #(.BITSIZE_in1(2), .BITSIZE_in2(1), .BITSIZE_out1(1)) fu_posit_na_float_28435_28683 (.out1(out_ne_expr_FU_8_0_8_40_i1_fu_posit_na_float_28435_28683), .in1(out_bit_and_expr_FU_8_0_8_23_i0_fu_posit_na_float_28435_28539), .in2(out_const_0));
  ne_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(1), .BITSIZE_out1(1)) fu_posit_na_float_28435_28685 (.out1(out_ne_expr_FU_8_0_8_40_i2_fu_posit_na_float_28435_28685), .in1(out_reg_5_reg_5), .in2(out_const_0));
  rshift_expr_FU #(.BITSIZE_in1(9), .BITSIZE_in2(4), .BITSIZE_out1(5), .PRECISION(32)) fu_posit_na_float_28435_28715 (.out1(out_rshift_expr_FU_16_0_16_48_i0_fu_posit_na_float_28435_28715), .in1(out_lshift_expr_FU_16_0_16_34_i0_fu_posit_na_float_28435_28561), .in2(out_const_3));
  plus_expr_FU #(.BITSIZE_in1(5), .BITSIZE_in2(4), .BITSIZE_out1(6)) fu_posit_na_float_28435_28719 (.out1(out_plus_expr_FU_8_0_8_46_i0_fu_posit_na_float_28435_28719), .in1(out_rshift_expr_FU_16_0_16_48_i0_fu_posit_na_float_28435_28715), .in2(out_const_8));
  lshift_expr_FU #(.BITSIZE_in1(6), .BITSIZE_in2(4), .BITSIZE_out1(10), .PRECISION(32)) fu_posit_na_float_28435_28723 (.out1(out_lshift_expr_FU_16_0_16_35_i0_fu_posit_na_float_28435_28723), .in1(out_plus_expr_FU_8_0_8_46_i0_fu_posit_na_float_28435_28719), .in2(out_const_3));
  fp_cond_expr_FU #(.BITSIZE_in1(1), .BITSIZE_in2(32), .BITSIZE_in3(32), .BITSIZE_out1(32)) fu_posit_na_float_28435_28727 (.out1(out_fp_cond_expr_FU_32_32_32_32_32_i0_fu_posit_na_float_28435_28727), .in1(out_ne_expr_FU_8_0_8_40_i0_fu_posit_na_float_28435_28679), .in2(out_const_17), .in3(out_const_1));
  multi_read_cond_FU #(.BITSIZE_in1(1), .PORTSIZE_in1(2), .BITSIZE_out1(2)) fu_posit_na_float_28435_28730 (.out1(out_multi_read_cond_FU_13_i0_fu_posit_na_float_28435_28730), .in1({out_truth_and_expr_FU_1_1_1_51_i0_fu_posit_na_float_28435_28736, out_truth_not_expr_FU_1_1_52_i0_fu_posit_na_float_28435_28733}));
  truth_not_expr_FU #(.BITSIZE_in1(1), .BITSIZE_out1(1)) fu_posit_na_float_28435_28733 (.out1(out_truth_not_expr_FU_1_1_52_i0_fu_posit_na_float_28435_28733), .in1(out_ne_expr_FU_8_0_8_40_i1_fu_posit_na_float_28435_28683));
  truth_and_expr_FU #(.BITSIZE_in1(1), .BITSIZE_in2(1), .BITSIZE_out1(1)) fu_posit_na_float_28435_28736 (.out1(out_truth_and_expr_FU_1_1_1_51_i0_fu_posit_na_float_28435_28736), .in1(out_ne_expr_FU_8_0_8_40_i1_fu_posit_na_float_28435_28683), .in2(out_ne_expr_FU_8_0_8_41_i0_fu_posit_na_float_28435_28681));
  ui_cond_expr_FU #(.BITSIZE_in1(1), .BITSIZE_in2(15), .BITSIZE_in3(15), .BITSIZE_out1(15)) fu_posit_na_float_28435_28737 (.out1(out_ui_cond_expr_FU_16_16_16_16_53_i0_fu_posit_na_float_28435_28737), .in1(out_reg_3_reg_3), .in2(out_IUdata_converter_FU_8_i0_fu_posit_na_float_28435_28495), .in3(out_reg_1_reg_1));
  cond_expr_FU #(.BITSIZE_in1(1), .BITSIZE_in2(10), .BITSIZE_in3(8), .BITSIZE_out1(10)) fu_posit_na_float_28435_28739 (.out1(out_cond_expr_FU_16_16_16_16_28_i0_fu_posit_na_float_28435_28739), .in1(out_ne_expr_FU_8_0_8_40_i2_fu_posit_na_float_28435_28685), .in2(out_bit_ior_concat_expr_FU_25_i0_fu_posit_na_float_28435_28562), .in3(out_const_12));
  cond_expr_FU #(.BITSIZE_in1(1), .BITSIZE_in2(5), .BITSIZE_in3(5), .BITSIZE_out1(5)) fu_posit_na_float_28435_28742 (.out1(out_cond_expr_FU_8_8_8_8_30_i0_fu_posit_na_float_28435_28742), .in1(out_ne_expr_FU_8_0_8_40_i2_fu_posit_na_float_28435_28685), .in2(out_minus_expr_FU_0_8_8_39_i0_fu_posit_na_float_28435_28563), .in3(out_const_4));
  cond_expr_FU #(.BITSIZE_in1(1), .BITSIZE_in2(32), .BITSIZE_in3(11), .BITSIZE_out1(32)) fu_posit_na_float_28435_28745 (.out1(out_cond_expr_FU_32_32_32_32_29_i0_fu_posit_na_float_28435_28745), .in1(out_ne_expr_FU_8_0_8_40_i2_fu_posit_na_float_28435_28685), .in2(out_plus_expr_FU_32_0_32_42_i0_fu_posit_na_float_28435_28565), .in3(out_const_14));
  cond_expr_FU #(.BITSIZE_in1(1), .BITSIZE_in2(6), .BITSIZE_in3(5), .BITSIZE_out1(6)) fu_posit_na_float_28435_28748 (.out1(out_cond_expr_FU_8_8_8_8_30_i1_fu_posit_na_float_28435_28748), .in1(out_ne_expr_FU_8_0_8_40_i2_fu_posit_na_float_28435_28685), .in2(out_plus_expr_FU_8_0_8_45_i0_fu_posit_na_float_28435_28566), .in3(out_const_7));
  register_STD #(.BITSIZE_in1(32), .BITSIZE_out1(32)) reg_0 (.out1(out_reg_0_reg_0), .clock(clock), .reset(reset), .in1(out_fp_cond_expr_FU_32_32_32_32_32_i0_fu_posit_na_float_28435_28727), .wenable(wrenable_reg_0));
  register_STD #(.BITSIZE_in1(15), .BITSIZE_out1(15)) reg_1 (.out1(out_reg_1_reg_1), .clock(clock), .reset(reset), .in1(out_IUdata_converter_FU_4_i0_fu_posit_na_float_28435_28483), .wenable(wrenable_reg_1));
  register_SE #(.BITSIZE_in1(32), .BITSIZE_out1(32)) reg_2 (.out1(out_reg_2_reg_2), .clock(clock), .reset(reset), .in1(out_lshift_expr_FU_32_0_32_36_i0_fu_posit_na_float_28435_28611), .wenable(wrenable_reg_2));
  register_STD #(.BITSIZE_in1(1), .BITSIZE_out1(1)) reg_3 (.out1(out_reg_3_reg_3), .clock(clock), .reset(reset), .in1(out_ne_expr_FU_8_0_8_40_i0_fu_posit_na_float_28435_28679), .wenable(wrenable_reg_3));
  register_SE #(.BITSIZE_in1(16), .BITSIZE_out1(16)) reg_4 (.out1(out_reg_4_reg_4), .clock(clock), .reset(reset), .in1(out_UIdata_converter_FU_9_i0_fu_posit_na_float_28435_28512), .wenable(wrenable_reg_4));
  register_SE #(.BITSIZE_in1(5), .BITSIZE_out1(5)) reg_5 (.out1(out_reg_5_reg_5), .clock(clock), .reset(reset), .in1(out_MUX_95_reg_5_0_0_0), .wenable(wrenable_reg_5));
  register_SE #(.BITSIZE_in1(10), .BITSIZE_out1(10)) reg_6 (.out1(out_reg_6_reg_6), .clock(clock), .reset(reset), .in1(out_MUX_96_reg_6_0_0_0), .wenable(wrenable_reg_6));
  register_SE #(.BITSIZE_in1(5), .BITSIZE_out1(5)) reg_7 (.out1(out_reg_7_reg_7), .clock(clock), .reset(reset), .in1(out_MUX_97_reg_7_0_0_0), .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(15), .BITSIZE_out1(15)) reg_8 (.out1(out_reg_8_reg_8), .clock(clock), .reset(reset), .in1(out_conv_out_MUX_98_reg_8_0_0_0_32_15), .wenable(wrenable_reg_8));
  register_SE #(.BITSIZE_in1(6), .BITSIZE_out1(6)) reg_9 (.out1(out_reg_9_reg_9), .clock(clock), .reset(reset), .in1(out_MUX_99_reg_9_0_0_0), .wenable(wrenable_reg_9));
  rshift_expr_FU #(.BITSIZE_in1(16), .BITSIZE_in2(5), .BITSIZE_out1(4), .PRECISION(32)) rshift_expr_FU_16_16_16_49_i0 (.out1(out_rshift_expr_FU_16_16_16_49_i0_rshift_expr_FU_16_16_16_49_i0), .in1(out_reg_4_reg_4), .in2(out_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0));
  // io-signal post fix
  assign return_port = out_MUX_48_gimple_return_FU_6_i0_0_0_0;
  assign OUT_CONDITION_posit_na_float_28435_28460 = out_read_cond_FU_5_i0_fu_posit_na_float_28435_28460;
  assign OUT_MULTIIF_posit_na_float_28435_28730 = out_multi_read_cond_FU_13_i0_fu_posit_na_float_28435_28730;

endmodule

// FSM based controller description for posit_na_float
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_posit_na_float(done_port, selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0, selector_MUX_48_gimple_return_FU_6_i0_0_0_0, selector_MUX_95_reg_5_0_0_0, selector_MUX_96_reg_6_0_0_0, selector_MUX_97_reg_7_0_0_0, selector_MUX_98_reg_8_0_0_0, selector_MUX_99_reg_9_0_0_0, wrenable_reg_0, wrenable_reg_1, wrenable_reg_2, wrenable_reg_3, wrenable_reg_4, wrenable_reg_5, wrenable_reg_6, wrenable_reg_7, wrenable_reg_8, wrenable_reg_9, OUT_CONDITION_posit_na_float_28435_28460, OUT_MULTIIF_posit_na_float_28435_28730, clock, reset, start_port);
  // IN
  input OUT_CONDITION_posit_na_float_28435_28460;
  input [1:0] OUT_MULTIIF_posit_na_float_28435_28730;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0;
  output selector_MUX_48_gimple_return_FU_6_i0_0_0_0;
  output selector_MUX_95_reg_5_0_0_0;
  output selector_MUX_96_reg_6_0_0_0;
  output selector_MUX_97_reg_7_0_0_0;
  output selector_MUX_98_reg_8_0_0_0;
  output selector_MUX_99_reg_9_0_0_0;
  output wrenable_reg_0;
  output wrenable_reg_1;
  output wrenable_reg_2;
  output wrenable_reg_3;
  output wrenable_reg_4;
  output wrenable_reg_5;
  output wrenable_reg_6;
  output wrenable_reg_7;
  output wrenable_reg_8;
  output wrenable_reg_9;
  parameter [5:0] S_0 = 6'b000001,
    S_5 = 6'b100000,
    S_1 = 6'b000010,
    S_2 = 6'b000100,
    S_3 = 6'b001000,
    S_4 = 6'b010000;
  reg [5:0] _present_state, _next_state;
  reg done_port;
  reg selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0;
  reg selector_MUX_48_gimple_return_FU_6_i0_0_0_0;
  reg selector_MUX_95_reg_5_0_0_0;
  reg selector_MUX_96_reg_6_0_0_0;
  reg selector_MUX_97_reg_7_0_0_0;
  reg selector_MUX_98_reg_8_0_0_0;
  reg selector_MUX_99_reg_9_0_0_0;
  reg wrenable_reg_0;
  reg wrenable_reg_1;
  reg wrenable_reg_2;
  reg wrenable_reg_3;
  reg wrenable_reg_4;
  reg wrenable_reg_5;
  reg wrenable_reg_6;
  reg wrenable_reg_7;
  reg wrenable_reg_8;
  reg wrenable_reg_9;
  
  always @(posedge clock)
    if (reset == 1'b0) _present_state <= S_0;
    else _present_state <= _next_state;
  
  always @(*)
  begin
    done_port = 1'b0;
    selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0 = 1'b0;
    selector_MUX_48_gimple_return_FU_6_i0_0_0_0 = 1'b0;
    selector_MUX_95_reg_5_0_0_0 = 1'b0;
    selector_MUX_96_reg_6_0_0_0 = 1'b0;
    selector_MUX_97_reg_7_0_0_0 = 1'b0;
    selector_MUX_98_reg_8_0_0_0 = 1'b0;
    selector_MUX_99_reg_9_0_0_0 = 1'b0;
    wrenable_reg_0 = 1'b0;
    wrenable_reg_1 = 1'b0;
    wrenable_reg_2 = 1'b0;
    wrenable_reg_3 = 1'b0;
    wrenable_reg_4 = 1'b0;
    wrenable_reg_5 = 1'b0;
    wrenable_reg_6 = 1'b0;
    wrenable_reg_7 = 1'b0;
    wrenable_reg_8 = 1'b0;
    wrenable_reg_9 = 1'b0;
    case (_present_state)
      S_0 :
        if(start_port == 1'b1)
        begin
          wrenable_reg_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          if (OUT_CONDITION_posit_na_float_28435_28460 == 1'b0)
            begin
              _next_state = S_1;
              wrenable_reg_0 = 1'b0;
            end
          else
            begin
              _next_state = S_5;
              done_port = 1'b1;
              wrenable_reg_1 = 1'b0;
              wrenable_reg_2 = 1'b0;
              wrenable_reg_3 = 1'b0;
            end
        end
        else
        begin
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          _next_state = S_0;
        end
      S_5 :
        begin
          selector_MUX_48_gimple_return_FU_6_i0_0_0_0 = 1'b1;
          _next_state = S_0;
        end
      S_1 :
        begin
          selector_MUX_95_reg_5_0_0_0 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          _next_state = S_2;
        end
      S_2 :
        begin
          selector_MUX_96_reg_6_0_0_0 = 1'b1;
          selector_MUX_98_reg_8_0_0_0 = 1'b1;
          selector_MUX_99_reg_9_0_0_0 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          casez (OUT_MULTIIF_posit_na_float_28435_28730)
            2'b?1 :
              begin
                _next_state = S_3;
                selector_MUX_96_reg_6_0_0_0 = 1'b0;
                selector_MUX_98_reg_8_0_0_0 = 1'b0;
                selector_MUX_99_reg_9_0_0_0 = 1'b0;
                wrenable_reg_5 = 1'b0;
                wrenable_reg_6 = 1'b0;
                wrenable_reg_7 = 1'b0;
                wrenable_reg_8 = 1'b0;
                wrenable_reg_9 = 1'b0;
              end
            2'b10 :
              begin
                _next_state = S_2;
                selector_MUX_96_reg_6_0_0_0 = 1'b0;
                selector_MUX_98_reg_8_0_0_0 = 1'b0;
                selector_MUX_99_reg_9_0_0_0 = 1'b0;
                wrenable_reg_6 = 1'b0;
                wrenable_reg_7 = 1'b0;
                wrenable_reg_8 = 1'b0;
                wrenable_reg_9 = 1'b0;
              end
            default
              begin
                _next_state = S_4;
                done_port = 1'b1;
                wrenable_reg_5 = 1'b0;
              end
          endcase
        end
      S_3 :
        begin
          selector_MUX_97_reg_7_0_0_0 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          _next_state = S_4;
          done_port = 1'b1;
        end
      S_4 :
        begin
          selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0 = 1'b1;
          _next_state = S_0;
        end
      default :
        begin
          _next_state = S_0;
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
        end
    endcase
  end
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2020 Politecnico di Milano
// Author(s): Marco Lattuada <marco.lattuada@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module flipflop_AR(clock, reset, in1, out1);
  parameter BITSIZE_in1=1, BITSIZE_out1=1;
  // IN
  input clock;
  input reset;
  input in1;
  // OUT
  output out1;
  
  reg reg_out1 =0;
  assign out1 = reg_out1;
  always @(posedge clock )
    if (reset == 1'b0)
      reg_out1 <= {BITSIZE_out1{1'b0}};
    else
      reg_out1 <= in1;
endmodule

// Top component for posit_na_float
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module _posit_na_float(clock, reset, start_port, done_port, x, return_port);
  // IN
  input clock;
  input reset;
  input start_port;
  input [15:0] x;
  // OUT
  output done_port;
  output [31:0] return_port;
  // Component and signal declarations
  wire OUT_CONDITION_posit_na_float_28435_28460;
  wire [1:0] OUT_MULTIIF_posit_na_float_28435_28730;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0;
  wire selector_MUX_48_gimple_return_FU_6_i0_0_0_0;
  wire selector_MUX_95_reg_5_0_0_0;
  wire selector_MUX_96_reg_6_0_0_0;
  wire selector_MUX_97_reg_7_0_0_0;
  wire selector_MUX_98_reg_8_0_0_0;
  wire selector_MUX_99_reg_9_0_0_0;
  wire wrenable_reg_0;
  wire wrenable_reg_1;
  wire wrenable_reg_2;
  wire wrenable_reg_3;
  wire wrenable_reg_4;
  wire wrenable_reg_5;
  wire wrenable_reg_6;
  wire wrenable_reg_7;
  wire wrenable_reg_8;
  wire wrenable_reg_9;
  
  controller_posit_na_float Controller_i (.done_port(done_delayed_REG_signal_in), .selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0(selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0), .selector_MUX_48_gimple_return_FU_6_i0_0_0_0(selector_MUX_48_gimple_return_FU_6_i0_0_0_0), .selector_MUX_95_reg_5_0_0_0(selector_MUX_95_reg_5_0_0_0), .selector_MUX_96_reg_6_0_0_0(selector_MUX_96_reg_6_0_0_0), .selector_MUX_97_reg_7_0_0_0(selector_MUX_97_reg_7_0_0_0), .selector_MUX_98_reg_8_0_0_0(selector_MUX_98_reg_8_0_0_0), .selector_MUX_99_reg_9_0_0_0(selector_MUX_99_reg_9_0_0_0), .wrenable_reg_0(wrenable_reg_0), .wrenable_reg_1(wrenable_reg_1), .wrenable_reg_2(wrenable_reg_2), .wrenable_reg_3(wrenable_reg_3), .wrenable_reg_4(wrenable_reg_4), .wrenable_reg_5(wrenable_reg_5), .wrenable_reg_6(wrenable_reg_6), .wrenable_reg_7(wrenable_reg_7), .wrenable_reg_8(wrenable_reg_8), .wrenable_reg_9(wrenable_reg_9), .OUT_CONDITION_posit_na_float_28435_28460(OUT_CONDITION_posit_na_float_28435_28460), .OUT_MULTIIF_posit_na_float_28435_28730(OUT_MULTIIF_posit_na_float_28435_28730), .clock(clock), .reset(reset), .start_port(start_port));
  datapath_posit_na_float Datapath_i (.return_port(return_port), .OUT_CONDITION_posit_na_float_28435_28460(OUT_CONDITION_posit_na_float_28435_28460), .OUT_MULTIIF_posit_na_float_28435_28730(OUT_MULTIIF_posit_na_float_28435_28730), .clock(clock), .reset(reset), .in_port_x(x), .selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0(selector_MUX_103_rshift_expr_FU_16_16_16_49_i0_1_0_0), .selector_MUX_48_gimple_return_FU_6_i0_0_0_0(selector_MUX_48_gimple_return_FU_6_i0_0_0_0), .selector_MUX_95_reg_5_0_0_0(selector_MUX_95_reg_5_0_0_0), .selector_MUX_96_reg_6_0_0_0(selector_MUX_96_reg_6_0_0_0), .selector_MUX_97_reg_7_0_0_0(selector_MUX_97_reg_7_0_0_0), .selector_MUX_98_reg_8_0_0_0(selector_MUX_98_reg_8_0_0_0), .selector_MUX_99_reg_9_0_0_0(selector_MUX_99_reg_9_0_0_0), .wrenable_reg_0(wrenable_reg_0), .wrenable_reg_1(wrenable_reg_1), .wrenable_reg_2(wrenable_reg_2), .wrenable_reg_3(wrenable_reg_3), .wrenable_reg_4(wrenable_reg_4), .wrenable_reg_5(wrenable_reg_5), .wrenable_reg_6(wrenable_reg_6), .wrenable_reg_7(wrenable_reg_7), .wrenable_reg_8(wrenable_reg_8), .wrenable_reg_9(wrenable_reg_9));
  flipflop_AR #(.BITSIZE_in1(1), .BITSIZE_out1(1)) done_delayed_REG (.out1(done_delayed_REG_signal_out), .clock(clock), .reset(reset), .in1(done_delayed_REG_signal_in));
  // io-signal post fix
  assign done_port = done_delayed_REG_signal_out;

endmodule

// Minimal interface for function: posit_na_float
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module posit_na_float(clock, reset, start_port, x, done_port, return_port);
  // IN
  input clock;
  input reset;
  input start_port;
  input [15:0] x;
  // OUT
  output done_port;
  output [31:0] return_port;
  // Component and signal declarations
  
  _posit_na_float _posit_na_float_i0 (.done_port(done_port), .return_port(return_port), .clock(clock), .reset(reset), .start_port(start_port), .x(x));

endmodule


