`timescale 1ns / 1ps

module Anderson_PUF_1bit_0 #(parameter SRL16E_B_INIT = 16'hAAAA,
							 parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire srl_A, srl_B;
  wire N2, N1;

  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_B)
                      );       
					  
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );
					  
CARRY4 
        CARRY4_A_B(
                    .CO(CO_A),
                    .O(),
                    .CI(1'b0),
                    .CYINIT(1'b1),
                    .DI(4'b0000),
                    .S({srl_A, srl_B, 2'b11})
                    );
                      
assign N2 = CO_A[3];

  FDPE #(.INIT(1'b0))
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
   
endmodule



module Anderson_PUF_1bit_1 #(parameter SRL16E_B_INIT = 16'hAAAA,
							               parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire srl_A, srl_B;
  wire N2, N1;

  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_B)
                      );        
					  
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );
					  
CARRY4 
        CARRY4_A_B(
                    .CO(CO_A),
                    .O(),
                    .CI(1'b0),
                    .CYINIT(1'b1),
                    .DI(4'b0000),
                    .S({srl_A, 1'b1, srl_B, 1'b1})
                    );
                      
assign N2 = CO_A[3];

  FDPE #(.INIT(1'b0))
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
   
endmodule

module Anderson_PUF_1bit_2 #(parameter SRL16E_B_INIT = 16'hAAAA,
							 parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire srl_A, srl_B;
  wire N2, N1;

  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_B)
                      );     
					  
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );

CARRY4 
        CARRY4_A_B(
                    .CO(CO_A),
                    .O(),
                    .CI(1'b0),
                    .CYINIT(1'b1),
                    .DI(4'b0000),
                    .S({srl_A, 2'b11, srl_B})
                    );
                      
assign N2 = CO_A[3];

  FDPE #(.INIT(1'b0)) // Intial value of the register Q
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
   
endmodule

module Anderson_PUF_1bit_3 #(parameter SRL16E_B_INIT = 16'hAAAA,
							 parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire [3:0] CO_B;
  wire srl_A, srl_B;
  wire N2, N1;

// 16-Bit Shift Register Look-Up Table (LUT) with Clock Enable
// Instantiation
  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_B)
                      );                 
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );
// CARRY4: Fast Carry Logic Component
// Instantiation
 
  CARRY4 
        CARRY4_A(
                    .CO(CO_A),
                    .O(),
                    .CI(CO_B[3]),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S({srl_A, 3'b111})
                    );
  CARRY4 
          CARRY4_B(
                      .CO(CO_B),
                      .O(),
                      .CI(1'b0),
                      .CYINIT(1'b1),
                      .DI(4'b0000),
                      .S({srl_B, 3'b111})
                      );
                      
assign N2 = CO_A[3];

  // Instance of the FDPE primitive with initial value = 0
  FDPE #(.INIT(1'b0)) // Intial value of the register Q
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
endmodule

module Anderson_PUF_1bit_4 #(parameter SRL16E_B_INIT = 16'hAAAA,
							 parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire [3:0] CO_B;
  wire srl_A, srl_B;
  wire N2, N1;

// 16-Bit Shift Register Look-Up Table (LUT) with Clock Enable
// Instantiation
  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en), 
                      .CLK(clk),
                      .D(srl_B)
                      );                 
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );
// CARRY4: Fast Carry Logic Component
// Instantiation
 
  CARRY4 
        CARRY4_A(
                    .CO(CO_A),
                    .O(),
                    .CI(CO_B[3]),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S({srl_A, 3'b111})
                    );
  CARRY4 
          CARRY4_B(
                      .CO(CO_B),
                      .O(),
                      .CI(1'b0),
                      .CYINIT(1'b1),
                      .DI(4'b0000),
                      .S({1'b1, srl_B, 2'b11})
                      );
                      
assign N2 = CO_A[3];
//assign N1 = CO_B[2];

  // Instance of the FDPE primitive with initial value = 0
  FDPE #(.INIT(1'b0)) // Intial value of the register Q
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
endmodule

module Anderson_PUF_1bit_5 #(parameter SRL16E_B_INIT = 16'hAAAA,
							 parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire [3:0] CO_B;
  wire srl_A, srl_B;
  wire N2, N1;

// 16-Bit Shift Register Look-Up Table (LUT) with Clock Enable
// Instantiation
  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_B)
                      );                 
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );
// CARRY4: Fast Carry Logic Component
// Instantiation
 
  CARRY4 
        CARRY4_A(
                    .CO(CO_A),
                    .O(),
                    .CI(CO_B[3]),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S({srl_A, 3'b111})
                    );
  CARRY4 
          CARRY4_B(
                      .CO(CO_B),
                      .O(),
                      .CI(1'b0),
                      .CYINIT(1'b1),
                      .DI(4'b0000),
                      .S({2'b11, srl_B, 1'b1})
                      );
                      
assign N2 = CO_A[3];
//assign N1 = CO_B[1];

  // Instance of the FDPE primitive with initial value = 0
  FDPE #(.INIT(1'b0)) // Intial value of the register Q
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
endmodule

module Anderson_PUF_1bit_6 #(parameter SRL16E_B_INIT = 16'hAAAA,
							               parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire [3:0] CO_B;
  wire srl_A, srl_B;
  wire N2, N1;

// 16-Bit Shift Register Look-Up Table (LUT) with Clock Enable
// Instantiation
  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en), 
                      .CLK(clk),
                      .D(srl_B)
                      );                 
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en), 
                      .CLK(clk),
                      .D(srl_A)
                      );
// CARRY4: Fast Carry Logic Component
// Instantiation
 
  CARRY4 
        CARRY4_A(
                    .CO(CO_A),
                    .O(),
                    .CI(CO_B[3]),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S({srl_A, 3'b111})
                    );
  CARRY4 
          CARRY4_B(
                      .CO(CO_B),
                      .O(),
                      .CI(1'b0),
                      .CYINIT(1'b1),
                      .DI(4'b0000),
                      .S({3'b111, srl_B})
                      );
                      
assign N2 = CO_A[3];

  // Instance of the FDPE primitive with initial value = 0
  FDPE #(.INIT(1'b0)) // Intial value of the register Q
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
endmodule

module Anderson_PUF_B_1bit_3 #(parameter SRL16E_B_INIT = 16'hAAAA,
							                 parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire [3:0] CO_B;
  wire srl_A, srl_B;
  wire N2, N1;

// 16-Bit Shift Register Look-Up Table (LUT) with Clock Enable
// Instantiation
  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_B)
                      );                 
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );
// CARRY4: Fast Carry Logic Component
// Instantiation
 
  CARRY4 
        CARRY4_A(
                    .CO(CO_A),
                    .O(),
                    .CI(CO_B[3]),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S({3'b111, srl_A})
                    );
  CARRY4 
          CARRY4_B(
                      .CO(CO_B),
                      .O(),
                      .CI(1'b0),
                      .CYINIT(1'b1),
                      .DI(4'b0000),
                      .S({3'b111, srl_B})
                      );
                      
assign N2 = CO_A[3];
//assign N1 = CO_B[3];

  // Instance of the FDPE primitive with initial value = 0
  FDPE #(.INIT(1'b0)) // Intial value of the register Q
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
endmodule

module Anderson_PUF_B_1bit_4 #(parameter SRL16E_B_INIT = 16'hAAAA,
							   parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire [3:0] CO_B;
  wire srl_A, srl_B;
  wire N2, N1;

// 16-Bit Shift Register Look-Up Table (LUT) with Clock Enable
// Instantiation
  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en), 
                      .CLK(clk),
                      .D(srl_B)
                      );                 
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
//                      .CE(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );
// CARRY4: Fast Carry Logic Component
// Instantiation
 
  CARRY4 
        CARRY4_A(
                    .CO(CO_A),
                    .O(),
                    .CI(CO_B[3]),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S({2'b11, srl_A, 1'b1})
                    );
  CARRY4 
          CARRY4_B(
                      .CO(CO_B),
                      .O(),
                      .CI(1'b0),
                      .CYINIT(1'b1),
                      .DI(4'b0000),
                      .S({3'b111, srl_B})
                      );
                      
assign N2 = CO_A[3];
//assign N1 = CO_B[3];

  // Instance of the FDPE primitive with initial value = 0
  FDPE #(.INIT(1'b0)) // Intial value of the register Q
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
endmodule

module Anderson_PUF_B_1bit_5 #(parameter SRL16E_B_INIT = 16'hAAAA,
							                 parameter SRL16E_A_INIT = 16'h5555
)(
  input clk,
  input sw_en,
  output Q
);

  wire [3:0] CO_A;
  wire [3:0] CO_B;
  wire srl_A, srl_B;
  wire N2, N1;

// 16-Bit Shift Register Look-Up Table (LUT) with Clock Enable
// Instantiation
  SRL16E #(.INIT(SRL16E_B_INIT))
         SRL16E_B(
                      .Q(srl_B),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_B)
                      );             
   SRL16E #(.INIT(SRL16E_A_INIT))
         SRL16E_A(
                      .Q(srl_A),
                      .A0(1'b1),
                      .A1(1'b1),
                      .A2(1'b1),
                      .A3(1'b1),
                      .CE(sw_en),
                      .CLK(clk),
                      .D(srl_A)
                      );
// CARRY4: Fast Carry Logic Component
// Instantiation
  CARRY4 
        CARRY4_A(
                    .CO(CO_A),
                    .O(),
                    .CI(CO_B[3]),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S({1'b1, srl_A, 2'b11})
                    );
  CARRY4 
          CARRY4_B(
                      .CO(CO_B),
                      .O(),
                      .CI(1'b0),
                      .CYINIT(1'b1),
                      .DI(4'b0000),
                      .S({3'b111, srl_B})
                      );
                      
assign N2 = CO_A[3];
//assign N1 = CO_B[3];

  // Instance of the FDPE primitive with initial value = 0
  FDPE #(.INIT(1'b0)) // Intial value of the register Q
  FPDE_inst (
   .Q(Q),
   .C(clk),
   .CE(1'b1),
   .PRE(N2),
   .D(Q)
   ); 
endmodule