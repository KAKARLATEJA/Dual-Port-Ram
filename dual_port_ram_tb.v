`timescale 1ns / 1ps

module dual_port_ram_tb;
  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b;
  reg clk;
  wire [7:0] q_a, q_b;
  dual_port_ram dpr1 (
    .data_a(data_a),
    .data_b(data_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .clk(clk),
    .q_a(q_a),
    .q_b(q_b)
  );
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, dual_port_ram_tb); 
  end
  initial begin
    $monitor("Time=%0t | we_a=%b addr_a=%2d data_a=%3d q_a=%3d | we_b=%b addr_b=%2d data_b=%3d q_b=%3d", 
             $time, we_a, addr_a, data_a, q_a, we_b, addr_b, data_b, q_b);
    we_a = 1'b0;    we_b = 1'b0;
    addr_a = 6'd0;  addr_b = 6'd0;
    data_a = 8'd0;  data_b = 8'd0;
    #10; // Wait for initial stable state
    data_a = 8'd33; addr_a = 6'd1; we_a = 1'b1;
    data_b = 8'd44; addr_b = 6'd2; we_b = 1'b1;
    #10;
    we_a = 1'b0; we_b = 1'b0;
    #10;           

    data_a = 8'd60; addr_a = 6'd4; we_a = 1'b1;
    #10;
      
    data_a = 8'd62; addr_a = 6'd5; we_a = 1'b1;
    #10;
       
    we_a = 1'b0;   // Turn off writing on Port A
    addr_b = 6'd4; we_b = 1'b0; // Read address 4 from Port B
    #10; 
    
    addr_b = 6'd5; we_b = 1'b0; // Read address 5 from Port B
    #10; 
    
    // --- TEST 3: Write on Port B, Read on Port A ---
    data_b = 8'd70; addr_b = 6'd8; we_b = 1'b1;
    #10;
      
    data_b = 8'd72; addr_b = 6'd9; we_b = 1'b1;
    #10;
      
    we_b = 1'b0;   // Turn off writing on Port B
    addr_a = 6'd8; we_a = 1'b0;  // Read address 8 from Port A
    #10;
     
    addr_a = 6'd9; we_a = 1'b0;  // Read address 9 from Port A
    #10; 
        
    data_b = 8'd45; addr_b = 6'd15; we_b = 1'b1;
    #10; 
     
    we_b = 1'b0;
    data_a = 8'd15; addr_a = 6'd15; we_a = 1'b1;
    #10; 
     
    we_a = 1'b0; we_b = 1'b0;
    addr_a = 6'd15;
    addr_b = 6'd15;
    #10; 
      
    $finish;    
  end 
  
endmodule