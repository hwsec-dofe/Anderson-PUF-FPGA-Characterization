`timescale 1ns / 1ps


module Anderson_PUF_128bit
(
  input clk,
  output [7:0] LED,
  output  uart_txd 
);

// ---------------- Constants ----------------
  localparam  FPGA_CLK_HZ   = 100_000_000;
  localparam  PERIOD_1S_TCK = (1_000_000); // 1s 0.1s 0.02
//  localparam SCLK_HZ = 50_000_000; // 2Hz
  localparam byte_max = 16;
  
  // ---------------- Wires / Regs ----------------
  wire        ready;
  wire [127:0]  Q;
  reg [7:0] transmit;
  reg         send = 1'b0;
  reg [3:0] byte_index = 0;
  wire sclk;

  // 2-second tick @ 100 MHz
  reg [27:0] cnt1 = 0;
  
  wire tick_1s = (cnt1 == PERIOD_1S_TCK - 1);
  
  UART_TX_CTRL_Final #(
      .FPGA_clk_val(FPGA_CLK_HZ),
      .UART_baud  (115200)
  ) tx_inst (
      .clk(clk),
      .send(send),       // one-cycle pulse
      .tx_data_in(transmit),
      .UART_TX(uart_txd),
      .tx_ready(ready)
  );
  
//  clock_divider_counter #(.DIVISOR(SCLK_HZ))
//  clk_inst (
//        .clk(clk),
//        .clk_div(sclk));
  
  // ---------------- PUF Array ----------------
// Enable PUF once every 2 seconds; Q updates on tick_2s edge.  
// Create 8 instances of Dist 5
generate genvar i;
  for (i = 0; i <= 127; i=i+1)
    begin : PUF_INST
      (* DONT_TOUCH = "true", KEEP = "true" *)
      
        // 1 SLICE
//      Anderson_PUF_1bit_0 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));
//      Anderson_PUF_1bit_1 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));  
//      Anderson_PUF_1bit_2 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));
        
        // 2 SLICE
//      Anderson_PUF_1bit_3 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i])); 
//      Anderson_PUF_1bit_4 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));
//      Anderson_PUF_1bit_5 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));
//      Anderson_PUF_1bit_6 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));

        // PUF_B
//      Anderson_PUF_B_1bit_3 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i])); 
//      Anderson_PUF_B_1bit_4 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));
//      Anderson_PUF_B_1bit_5 anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));

        // Paper
        Anderson_PUF_1bit_Paper anderson (.clk(clk), .sw_en(1'b1), .Q(Q[i]));
    end

endgenerate
  
  
    always @(posedge clk)
    begin
      cnt1 <= tick_1s ? 0 : cnt1 + 1;
    end
  
//   Add FSM for UART 1 Trigger then send all bytes
  localparam IDLE = 0, LOAD_DATA = 1, TRANSMIT_DATA = 2, WAIT = 3, DONE = 4;
  reg [2:0] state = IDLE;
  
  always @(posedge clk) 
  begin
    send <= 1'b0; // defaul
    case(state)
      IDLE:
        begin
          byte_index <= 0;
          send <= 0;
          if (tick_1s)
            state <= LOAD_DATA;
          else
            state <= IDLE;
        end
        
      LOAD_DATA:
        begin
          transmit <= Q[byte_index * 8 +: 8]; // stage byte
          send <= 1'b1;                       // Kick the UART START
          state <= TRANSMIT_DATA;
        end
      TRANSMIT_DATA: // Kick the UART START
        begin
          state <= WAIT;
        end
      
      WAIT:
        begin
          if (ready)
            begin
              if (byte_index < byte_max - 1)
                begin
                  byte_index <= byte_index + 1;
                  state <= LOAD_DATA;
                end
              else
                state <= DONE;
            end
          else
            state <= WAIT;
        end
        
      DONE:
        state <= IDLE;
        
    endcase
    
  end

// ---------------- LEDs ----------------
assign LED = transmit;  // show live PUF output, in here the LED will change really fast, because I send every byte at time

endmodule
