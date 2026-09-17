module tb;

  reg [1:0] t_A;
  reg [1:0] t_B;

  wire t_GT;
  wire t_LT;
  wire t_EQ;

  comp2 DUT (
    .A(t_A),
    .B(t_B),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
  );

  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    for (integer a = 0; a < 4; a = a + 1) begin
      for (integer b = 0; b < 4; b = b + 1) begin

        t_A = a;
        t_B = b;

        #1;

        if (t_GT !== (a > b) ||
            t_LT !== (a < b) ||
            t_EQ !== (a == b)) begin

          $display("FAIL: A=%d B=%d | GT=%b LT=%b EQ=%b",
                   a, b, t_GT, t_LT, t_EQ);

        end
        else begin

          $display("PASS: A=%d B=%d | GT=%b LT=%b EQ=%b",
                   a, b, t_GT, t_LT, t_EQ);
        end
      end
    end

    $finish;
  end

endmodule