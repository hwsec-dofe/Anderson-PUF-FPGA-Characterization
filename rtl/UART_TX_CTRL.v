`timescale 1ns / 1ps

module UART_TX_CTRL_Final #(
                      // UART CONFIGURATION PARAMETER
                       parameter FPGA_clk_val = 100_000_000, // Testing the FSM 100_000: Should be 100_000_000
                       parameter UART_baud = 9_600
                      )
                      (
                        input clk,
                        input send, // enable signal
                        input [7:0] tx_data_in,
                        output tx_ready,
                        output UART_TX
                      );

  // UART BIT CLOCK
  //  Bit Timer Max: How many FGPA Clock Cycles Equal 1 UART Bit
localparam baud_count_max  = (FPGA_clk_val / UART_baud)-1; 
localparam bit_index_max = 10;
  //Counter that keeps track of the number of clock cycles the current bit has been held stable over the
  //UART TX line. It is used to signal when the next bit should be transferred on the UART TX line
reg [31:0] baud_count = 0;
  //combinatorial logic that goes high when bitTmr has counted to the proper value to ensure
  //a 9600 baud rate
wire baud_pulse; // Trigger whenever 1 bit send is done --> The BitDONE 
  //Contains the index of the next bit in txData that needs to be transferred 
reg [3:0] bit_index = 3'b000;
  //a register that holds the current data being sent over the UART TX line
reg tx_bit = 1;
  // A register that contains the whole data packet to be sent, including start and stop bits. 
reg [9:0] tx_data = 0;
reg [9:0] tx_debug = 0; // For debugging
// FSM State of UART TX 
parameter idle = 0, load_bit = 1, send_bit = 2;
reg [1:0] tx_state = idle;

// Bit Timing - Generate Trigger for Baud Rate (end of cycle) + oversampling pulse
always@(posedge clk)
begin 
  if(tx_state == idle)
      baud_count <= 0;
  else
    begin
      if (baud_pulse == 1'b1)
          baud_count <= 0;
      else
        baud_count <= baud_count + 1;
    end
end
assign baud_pulse = (baud_count == baud_count_max) ? 1'b1 : 1'b0;

always@(posedge clk)
begin
  case(tx_state)
    idle:
      begin
        tx_bit <= 1;
        bit_index <= 0;
        tx_debug <= 0;

        if (send && tx_ready)
          begin
            tx_data <= {1'b1, tx_data_in, 1'b0};
            tx_state <= load_bit;
          end
        else
            tx_state <= idle;
      end
      
    load_bit:
      begin
        
        tx_bit <= tx_data[bit_index];
        tx_debug <= {tx_data[bit_index], tx_debug[9:1]};
        bit_index <= bit_index + 1;
        tx_state <= send_bit;
      end
      
    send_bit:
      begin 
        if (baud_pulse == 1'b1)
          begin
            if (bit_index == bit_index_max)
              tx_state <= idle;
            else
              tx_state <= load_bit;
          end
      end
    default:
      tx_state <= idle;
  endcase
end

assign UART_TX = tx_bit;
assign tx_ready = (tx_state == idle) ? 1'b1 : 1'b0;


endmodule
