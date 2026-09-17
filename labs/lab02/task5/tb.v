module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;

  wire [3:0] t_result;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  // Waveform dump
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Test cases
  initial begin

    // ADD: 3 + 2 = 5
    t_a = 4'd3;
    t_b = 4'd2;
    t_op = 1'b0;
    #5;

    // ADD: change only b
    // This helps detect the sensitivity-list bug
    t_b = 4'd4;
    #5;

    // ADD: change only op
    // This also helps detect sensitivity-list problems
    t_op = 1'b1;
    #5;

    // SUB: 7 - 3 = 4
    t_a = 4'd7;
    t_b = 4'd3;
    t_op = 1'b1;
    #5;

    // SUB: 10 - 4 = 6
    t_a = 4'd10;
    t_b = 4'd4;
    #5;

    // ADD again
    t_op = 1'b0;
    #5;

    $finish;
  end

  initial
    $monitor($time, " a=%d b=%d op=%b | result=%d",
             t_a, t_b, t_op, t_result);

endmodule