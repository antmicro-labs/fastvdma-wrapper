module WishboneCSR( // @[:@3.2]
  input  [31:0] io_ctl_dat_i, // @[:@6.4]
  output [31:0] io_ctl_dat_o, // @[:@6.4]
  input         io_ctl_stb_i, // @[:@6.4]
  input         io_ctl_we_i, // @[:@6.4]
  input  [31:0] io_ctl_adr_i, // @[:@6.4]
  output        io_ctl_ack_o, // @[:@6.4]
  output [3:0]  io_bus_addr, // @[:@6.4]
  output [31:0] io_bus_dataOut, // @[:@6.4]
  input  [31:0] io_bus_dataIn, // @[:@6.4]
  output        io_bus_write, // @[:@6.4]
  output        io_bus_read // @[:@6.4]
);
  wire  _T_39; // @[WishboneCSR.scala 45:34:@15.4]
  assign _T_39 = io_ctl_we_i == 1'h0; // @[WishboneCSR.scala 45:34:@15.4]
  assign io_ctl_dat_o = io_bus_dataIn; // @[WishboneCSR.scala 42:16:@12.4]
  assign io_ctl_ack_o = io_ctl_stb_i; // @[WishboneCSR.scala 39:16:@10.4]
  assign io_bus_addr = io_ctl_adr_i[5:2]; // @[WishboneCSR.scala 47:15:@19.4]
  assign io_bus_dataOut = io_ctl_dat_i; // @[WishboneCSR.scala 41:18:@11.4]
  assign io_bus_write = io_ctl_stb_i & io_ctl_we_i; // @[WishboneCSR.scala 44:16:@14.4]
  assign io_bus_read = io_ctl_stb_i & _T_39; // @[WishboneCSR.scala 45:15:@17.4]
endmodule
module WishboneClassicReader( // @[:@21.2]
  input         clock, // @[:@22.4]
  input         reset, // @[:@23.4]
  input  [31:0] io_bus_dat_i, // @[:@24.4]
  output        io_bus_cyc_o, // @[:@24.4]
  output        io_bus_stb_o, // @[:@24.4]
  output [31:0] io_bus_adr_o, // @[:@24.4]
  input         io_bus_ack_i, // @[:@24.4]
  input         io_dataOut_ready, // @[:@24.4]
  output        io_dataOut_valid, // @[:@24.4]
  output [31:0] io_dataOut_bits, // @[:@24.4]
  output        io_xfer_done, // @[:@24.4]
  input  [31:0] io_xfer_address, // @[:@24.4]
  input  [31:0] io_xfer_length, // @[:@24.4]
  input         io_xfer_valid // @[:@24.4]
);
  reg  state; // @[WishboneClassicReader.scala 40:22:@26.4]
  reg [31:0] _RAND_0;
  reg [31:0] stbCnt; // @[WishboneClassicReader.scala 42:23:@27.4]
  reg [31:0] _RAND_1;
  reg [31:0] adr; // @[WishboneClassicReader.scala 43:20:@28.4]
  reg [31:0] _RAND_2;
  wire  cyc; // @[WishboneClassicReader.scala 44:29:@29.4]
  wire  stb; // @[WishboneClassicReader.scala 45:37:@33.4]
  wire  _T_62; // @[WishboneClassicReader.scala 48:28:@38.4]
  wire  ready; // @[WishboneClassicReader.scala 48:35:@39.4]
  reg  done; // @[WishboneClassicReader.scala 50:21:@42.4]
  reg [31:0] _RAND_3;
  wire  _T_71; // @[Conditional.scala 37:30:@53.4]
  wire  _GEN_0; // @[WishboneClassicReader.scala 67:27:@56.6]
  wire [31:0] _GEN_1; // @[WishboneClassicReader.scala 67:27:@56.6]
  wire [31:0] _GEN_2; // @[WishboneClassicReader.scala 67:27:@56.6]
  wire  _T_75; // @[WishboneClassicReader.scala 74:19:@65.8]
  wire  _GEN_3; // @[WishboneClassicReader.scala 74:27:@66.8]
  wire  _GEN_4; // @[WishboneClassicReader.scala 74:27:@66.8]
  wire  _GEN_5; // @[Conditional.scala 39:67:@64.6]
  wire  _GEN_6; // @[Conditional.scala 39:67:@64.6]
  wire  _GEN_7; // @[Conditional.scala 40:58:@54.4]
  wire  _GEN_8; // @[Conditional.scala 40:58:@54.4]
  wire [31:0] _GEN_9; // @[Conditional.scala 40:58:@54.4]
  wire [31:0] _GEN_10; // @[Conditional.scala 40:58:@54.4]
  wire  _T_79; // @[WishboneClassicReader.scala 81:23:@72.4]
  wire [32:0] _T_81; // @[WishboneClassicReader.scala 82:16:@74.6]
  wire [31:0] _T_82; // @[WishboneClassicReader.scala 82:16:@75.6]
  wire [32:0] _T_84; // @[WishboneClassicReader.scala 83:22:@77.6]
  wire [32:0] _T_85; // @[WishboneClassicReader.scala 83:22:@78.6]
  wire [31:0] _T_86; // @[WishboneClassicReader.scala 83:22:@79.6]
  wire [31:0] _GEN_11; // @[WishboneClassicReader.scala 81:32:@73.4]
  wire [31:0] _GEN_12; // @[WishboneClassicReader.scala 81:32:@73.4]
  assign cyc = stbCnt != 32'h0; // @[WishboneClassicReader.scala 44:29:@29.4]
  assign stb = cyc & io_dataOut_ready; // @[WishboneClassicReader.scala 45:37:@33.4]
  assign _T_62 = cyc & stb; // @[WishboneClassicReader.scala 48:28:@38.4]
  assign ready = _T_62 & io_bus_ack_i; // @[WishboneClassicReader.scala 48:35:@39.4]
  assign _T_71 = 1'h0 == state; // @[Conditional.scala 37:30:@53.4]
  assign _GEN_0 = io_xfer_valid ? 1'h1 : state; // @[WishboneClassicReader.scala 67:27:@56.6]
  assign _GEN_1 = io_xfer_valid ? io_xfer_length : stbCnt; // @[WishboneClassicReader.scala 67:27:@56.6]
  assign _GEN_2 = io_xfer_valid ? io_xfer_address : adr; // @[WishboneClassicReader.scala 67:27:@56.6]
  assign _T_75 = stbCnt == 32'h0; // @[WishboneClassicReader.scala 74:19:@65.8]
  assign _GEN_3 = _T_75 ? 1'h0 : state; // @[WishboneClassicReader.scala 74:27:@66.8]
  assign _GEN_4 = _T_75 ? 1'h1 : done; // @[WishboneClassicReader.scala 74:27:@66.8]
  assign _GEN_5 = state ? _GEN_3 : state; // @[Conditional.scala 39:67:@64.6]
  assign _GEN_6 = state ? _GEN_4 : done; // @[Conditional.scala 39:67:@64.6]
  assign _GEN_7 = _T_71 ? 1'h0 : _GEN_6; // @[Conditional.scala 40:58:@54.4]
  assign _GEN_8 = _T_71 ? _GEN_0 : _GEN_5; // @[Conditional.scala 40:58:@54.4]
  assign _GEN_9 = _T_71 ? _GEN_1 : stbCnt; // @[Conditional.scala 40:58:@54.4]
  assign _GEN_10 = _T_71 ? _GEN_2 : adr; // @[Conditional.scala 40:58:@54.4]
  assign _T_79 = cyc & ready; // @[WishboneClassicReader.scala 81:23:@72.4]
  assign _T_81 = adr + 32'h4; // @[WishboneClassicReader.scala 82:16:@74.6]
  assign _T_82 = adr + 32'h4; // @[WishboneClassicReader.scala 82:16:@75.6]
  assign _T_84 = stbCnt - 32'h1; // @[WishboneClassicReader.scala 83:22:@77.6]
  assign _T_85 = $unsigned(_T_84); // @[WishboneClassicReader.scala 83:22:@78.6]
  assign _T_86 = _T_85[31:0]; // @[WishboneClassicReader.scala 83:22:@79.6]
  assign _GEN_11 = _T_79 ? _T_82 : _GEN_10; // @[WishboneClassicReader.scala 81:32:@73.4]
  assign _GEN_12 = _T_79 ? _T_86 : _GEN_9; // @[WishboneClassicReader.scala 81:32:@73.4]
  assign io_bus_cyc_o = stbCnt != 32'h0; // @[WishboneClassicReader.scala 59:16:@50.4]
  assign io_bus_stb_o = cyc & io_dataOut_ready; // @[WishboneClassicReader.scala 60:16:@51.4]
  assign io_bus_adr_o = adr; // @[WishboneClassicReader.scala 58:16:@49.4]
  assign io_dataOut_valid = _T_62 & io_bus_ack_i; // @[WishboneClassicReader.scala 53:20:@44.4]
  assign io_dataOut_bits = io_bus_dat_i; // @[WishboneClassicReader.scala 52:19:@43.4]
  assign io_xfer_done = done; // @[WishboneClassicReader.scala 62:16:@52.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  stbCnt = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  adr = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  done = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      state <= 1'h0;
    end else begin
      if (_T_71) begin
        if (io_xfer_valid) begin
          state <= 1'h1;
        end
      end else begin
        if (state) begin
          if (_T_75) begin
            state <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      stbCnt <= 32'h0;
    end else begin
      if (_T_79) begin
        stbCnt <= _T_86;
      end else begin
        if (_T_71) begin
          if (io_xfer_valid) begin
            stbCnt <= io_xfer_length;
          end
        end
      end
    end
    if (reset) begin
      adr <= 32'h0;
    end else begin
      if (_T_79) begin
        adr <= _T_82;
      end else begin
        if (_T_71) begin
          if (io_xfer_valid) begin
            adr <= io_xfer_address;
          end
        end
      end
    end
    if (reset) begin
      done <= 1'h0;
    end else begin
      if (_T_71) begin
        done <= 1'h0;
      end else begin
        if (state) begin
          if (_T_75) begin
            done <= 1'h1;
          end
        end
      end
    end
  end
endmodule
module WishboneClassicWriter( // @[:@83.2]
  input         clock, // @[:@84.4]
  input         reset, // @[:@85.4]
  output [31:0] io_bus_dat_o, // @[:@86.4]
  output        io_bus_cyc_o, // @[:@86.4]
  output        io_bus_stb_o, // @[:@86.4]
  output [31:0] io_bus_adr_o, // @[:@86.4]
  input         io_bus_ack_i, // @[:@86.4]
  output        io_dataIn_ready, // @[:@86.4]
  input         io_dataIn_valid, // @[:@86.4]
  input  [31:0] io_dataIn_bits, // @[:@86.4]
  output        io_xfer_done, // @[:@86.4]
  input  [31:0] io_xfer_address, // @[:@86.4]
  input  [31:0] io_xfer_length, // @[:@86.4]
  input         io_xfer_valid // @[:@86.4]
);
  reg  state; // @[WishboneClassicWriter.scala 40:22:@88.4]
  reg [31:0] _RAND_0;
  reg [31:0] stbCnt; // @[WishboneClassicWriter.scala 44:23:@91.4]
  reg [31:0] _RAND_1;
  reg [31:0] adr; // @[WishboneClassicWriter.scala 45:20:@92.4]
  reg [31:0] _RAND_2;
  wire  cyc; // @[WishboneClassicWriter.scala 46:29:@93.4]
  wire  stb; // @[WishboneClassicWriter.scala 47:37:@97.4]
  wire  _T_69; // @[WishboneClassicWriter.scala 50:28:@102.4]
  wire  ready; // @[WishboneClassicWriter.scala 50:35:@103.4]
  reg  done; // @[WishboneClassicWriter.scala 52:21:@106.4]
  reg [31:0] _RAND_3;
  wire  _T_77; // @[Conditional.scala 37:30:@116.4]
  wire  _GEN_0; // @[WishboneClassicWriter.scala 69:27:@119.6]
  wire [31:0] _GEN_1; // @[WishboneClassicWriter.scala 69:27:@119.6]
  wire [31:0] _GEN_2; // @[WishboneClassicWriter.scala 69:27:@119.6]
  wire  _T_81; // @[WishboneClassicWriter.scala 76:19:@128.8]
  wire  _GEN_3; // @[WishboneClassicWriter.scala 76:27:@129.8]
  wire  _GEN_4; // @[WishboneClassicWriter.scala 76:27:@129.8]
  wire  _GEN_5; // @[Conditional.scala 39:67:@127.6]
  wire  _GEN_6; // @[Conditional.scala 39:67:@127.6]
  wire  _GEN_7; // @[Conditional.scala 40:58:@117.4]
  wire  _GEN_8; // @[Conditional.scala 40:58:@117.4]
  wire [31:0] _GEN_9; // @[Conditional.scala 40:58:@117.4]
  wire [31:0] _GEN_10; // @[Conditional.scala 40:58:@117.4]
  wire  _T_85; // @[WishboneClassicWriter.scala 83:23:@135.4]
  wire [32:0] _T_87; // @[WishboneClassicWriter.scala 84:16:@137.6]
  wire [31:0] _T_88; // @[WishboneClassicWriter.scala 84:16:@138.6]
  wire [32:0] _T_90; // @[WishboneClassicWriter.scala 85:22:@140.6]
  wire [32:0] _T_91; // @[WishboneClassicWriter.scala 85:22:@141.6]
  wire [31:0] _T_92; // @[WishboneClassicWriter.scala 85:22:@142.6]
  wire [31:0] _GEN_11; // @[WishboneClassicWriter.scala 83:32:@136.4]
  wire [31:0] _GEN_12; // @[WishboneClassicWriter.scala 83:32:@136.4]
  assign cyc = stbCnt != 32'h0; // @[WishboneClassicWriter.scala 46:29:@93.4]
  assign stb = cyc & io_dataIn_valid; // @[WishboneClassicWriter.scala 47:37:@97.4]
  assign _T_69 = cyc & stb; // @[WishboneClassicWriter.scala 50:28:@102.4]
  assign ready = _T_69 & io_bus_ack_i; // @[WishboneClassicWriter.scala 50:35:@103.4]
  assign _T_77 = 1'h0 == state; // @[Conditional.scala 37:30:@116.4]
  assign _GEN_0 = io_xfer_valid ? 1'h1 : state; // @[WishboneClassicWriter.scala 69:27:@119.6]
  assign _GEN_1 = io_xfer_valid ? io_xfer_length : stbCnt; // @[WishboneClassicWriter.scala 69:27:@119.6]
  assign _GEN_2 = io_xfer_valid ? io_xfer_address : adr; // @[WishboneClassicWriter.scala 69:27:@119.6]
  assign _T_81 = stbCnt == 32'h0; // @[WishboneClassicWriter.scala 76:19:@128.8]
  assign _GEN_3 = _T_81 ? 1'h0 : state; // @[WishboneClassicWriter.scala 76:27:@129.8]
  assign _GEN_4 = _T_81 ? 1'h1 : done; // @[WishboneClassicWriter.scala 76:27:@129.8]
  assign _GEN_5 = state ? _GEN_3 : state; // @[Conditional.scala 39:67:@127.6]
  assign _GEN_6 = state ? _GEN_4 : done; // @[Conditional.scala 39:67:@127.6]
  assign _GEN_7 = _T_77 ? 1'h0 : _GEN_6; // @[Conditional.scala 40:58:@117.4]
  assign _GEN_8 = _T_77 ? _GEN_0 : _GEN_5; // @[Conditional.scala 40:58:@117.4]
  assign _GEN_9 = _T_77 ? _GEN_1 : stbCnt; // @[Conditional.scala 40:58:@117.4]
  assign _GEN_10 = _T_77 ? _GEN_2 : adr; // @[Conditional.scala 40:58:@117.4]
  assign _T_85 = cyc & ready; // @[WishboneClassicWriter.scala 83:23:@135.4]
  assign _T_87 = adr + 32'h4; // @[WishboneClassicWriter.scala 84:16:@137.6]
  assign _T_88 = adr + 32'h4; // @[WishboneClassicWriter.scala 84:16:@138.6]
  assign _T_90 = stbCnt - 32'h1; // @[WishboneClassicWriter.scala 85:22:@140.6]
  assign _T_91 = $unsigned(_T_90); // @[WishboneClassicWriter.scala 85:22:@141.6]
  assign _T_92 = _T_91[31:0]; // @[WishboneClassicWriter.scala 85:22:@142.6]
  assign _GEN_11 = _T_85 ? _T_88 : _GEN_10; // @[WishboneClassicWriter.scala 83:32:@136.4]
  assign _GEN_12 = _T_85 ? _T_92 : _GEN_9; // @[WishboneClassicWriter.scala 83:32:@136.4]
  assign io_bus_dat_o = io_dataIn_bits; // @[WishboneClassicWriter.scala 54:16:@107.4]
  assign io_bus_cyc_o = stbCnt != 32'h0; // @[WishboneClassicWriter.scala 61:16:@113.4]
  assign io_bus_stb_o = cyc & io_dataIn_valid; // @[WishboneClassicWriter.scala 62:16:@114.4]
  assign io_bus_adr_o = adr; // @[WishboneClassicWriter.scala 60:16:@112.4]
  assign io_dataIn_ready = _T_69 & io_bus_ack_i; // @[WishboneClassicWriter.scala 55:19:@108.4]
  assign io_xfer_done = done; // @[WishboneClassicWriter.scala 64:16:@115.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  stbCnt = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  adr = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  done = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      state <= 1'h0;
    end else begin
      if (_T_77) begin
        if (io_xfer_valid) begin
          state <= 1'h1;
        end
      end else begin
        if (state) begin
          if (_T_81) begin
            state <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      stbCnt <= 32'h0;
    end else begin
      if (_T_85) begin
        stbCnt <= _T_92;
      end else begin
        if (_T_77) begin
          if (io_xfer_valid) begin
            stbCnt <= io_xfer_length;
          end
        end
      end
    end
    if (reset) begin
      adr <= 32'h0;
    end else begin
      if (_T_85) begin
        adr <= _T_88;
      end else begin
        if (_T_77) begin
          if (io_xfer_valid) begin
            adr <= io_xfer_address;
          end
        end
      end
    end
    if (reset) begin
      done <= 1'h0;
    end else begin
      if (_T_77) begin
        done <= 1'h0;
      end else begin
        if (state) begin
          if (_T_81) begin
            done <= 1'h1;
          end
        end
      end
    end
  end
endmodule
module CSR( // @[:@146.2]
  output [31:0] io_csr_0_dataOut, // @[:@149.4]
  output        io_csr_0_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_0_dataIn, // @[:@149.4]
  input  [31:0] io_csr_1_dataIn, // @[:@149.4]
  output [31:0] io_csr_2_dataOut, // @[:@149.4]
  output        io_csr_2_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_2_dataIn, // @[:@149.4]
  output [31:0] io_csr_3_dataOut, // @[:@149.4]
  output        io_csr_3_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_3_dataIn, // @[:@149.4]
  output [31:0] io_csr_4_dataOut, // @[:@149.4]
  output        io_csr_4_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_4_dataIn, // @[:@149.4]
  output [31:0] io_csr_5_dataOut, // @[:@149.4]
  output        io_csr_5_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_5_dataIn, // @[:@149.4]
  output [31:0] io_csr_6_dataOut, // @[:@149.4]
  output        io_csr_6_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_6_dataIn, // @[:@149.4]
  output [31:0] io_csr_7_dataOut, // @[:@149.4]
  output        io_csr_7_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_7_dataIn, // @[:@149.4]
  output [31:0] io_csr_8_dataOut, // @[:@149.4]
  output        io_csr_8_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_8_dataIn, // @[:@149.4]
  output [31:0] io_csr_9_dataOut, // @[:@149.4]
  output        io_csr_9_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_9_dataIn, // @[:@149.4]
  output [31:0] io_csr_10_dataOut, // @[:@149.4]
  output        io_csr_10_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_10_dataIn, // @[:@149.4]
  output [31:0] io_csr_11_dataOut, // @[:@149.4]
  output        io_csr_11_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_11_dataIn, // @[:@149.4]
  output [31:0] io_csr_12_dataOut, // @[:@149.4]
  output        io_csr_12_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_12_dataIn, // @[:@149.4]
  output [31:0] io_csr_13_dataOut, // @[:@149.4]
  output        io_csr_13_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_13_dataIn, // @[:@149.4]
  output [31:0] io_csr_14_dataOut, // @[:@149.4]
  output        io_csr_14_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_14_dataIn, // @[:@149.4]
  output [31:0] io_csr_15_dataOut, // @[:@149.4]
  output        io_csr_15_dataWrite, // @[:@149.4]
  input  [31:0] io_csr_15_dataIn, // @[:@149.4]
  input  [3:0]  io_bus_addr, // @[:@149.4]
  input  [31:0] io_bus_dataOut, // @[:@149.4]
  output [31:0] io_bus_dataIn, // @[:@149.4]
  input         io_bus_write, // @[:@149.4]
  input         io_bus_read // @[:@149.4]
);
  wire  _T_178; // @[CSR.scala 40:22:@154.4]
  wire  _T_179; // @[CSR.scala 40:30:@155.4]
  wire [31:0] _GEN_0; // @[CSR.scala 40:45:@156.4]
  wire  _T_184; // @[CSR.scala 47:30:@164.4]
  wire  _T_189; // @[CSR.scala 40:22:@173.4]
  wire  _T_190; // @[CSR.scala 40:30:@174.4]
  wire [31:0] _GEN_4; // @[CSR.scala 40:45:@175.4]
  wire  _T_200; // @[CSR.scala 40:22:@192.4]
  wire  _T_201; // @[CSR.scala 40:30:@193.4]
  wire [31:0] _GEN_8; // @[CSR.scala 40:45:@194.4]
  wire  _T_206; // @[CSR.scala 47:30:@202.4]
  wire  _T_211; // @[CSR.scala 40:22:@211.4]
  wire  _T_212; // @[CSR.scala 40:30:@212.4]
  wire [31:0] _GEN_12; // @[CSR.scala 40:45:@213.4]
  wire  _T_217; // @[CSR.scala 47:30:@221.4]
  wire  _T_222; // @[CSR.scala 40:22:@230.4]
  wire  _T_223; // @[CSR.scala 40:30:@231.4]
  wire [31:0] _GEN_16; // @[CSR.scala 40:45:@232.4]
  wire  _T_228; // @[CSR.scala 47:30:@240.4]
  wire  _T_233; // @[CSR.scala 40:22:@249.4]
  wire  _T_234; // @[CSR.scala 40:30:@250.4]
  wire [31:0] _GEN_20; // @[CSR.scala 40:45:@251.4]
  wire  _T_239; // @[CSR.scala 47:30:@259.4]
  wire  _T_244; // @[CSR.scala 40:22:@268.4]
  wire  _T_245; // @[CSR.scala 40:30:@269.4]
  wire [31:0] _GEN_24; // @[CSR.scala 40:45:@270.4]
  wire  _T_250; // @[CSR.scala 47:30:@278.4]
  wire  _T_255; // @[CSR.scala 40:22:@287.4]
  wire  _T_256; // @[CSR.scala 40:30:@288.4]
  wire [31:0] _GEN_28; // @[CSR.scala 40:45:@289.4]
  wire  _T_261; // @[CSR.scala 47:30:@297.4]
  wire  _T_266; // @[CSR.scala 40:22:@306.4]
  wire  _T_267; // @[CSR.scala 40:30:@307.4]
  wire [31:0] _GEN_32; // @[CSR.scala 40:45:@308.4]
  wire  _T_272; // @[CSR.scala 47:30:@316.4]
  wire  _T_277; // @[CSR.scala 40:22:@325.4]
  wire  _T_278; // @[CSR.scala 40:30:@326.4]
  wire [31:0] _GEN_36; // @[CSR.scala 40:45:@327.4]
  wire  _T_283; // @[CSR.scala 47:30:@335.4]
  wire  _T_288; // @[CSR.scala 40:22:@344.4]
  wire  _T_289; // @[CSR.scala 40:30:@345.4]
  wire [31:0] _GEN_40; // @[CSR.scala 40:45:@346.4]
  wire  _T_294; // @[CSR.scala 47:30:@354.4]
  wire  _T_299; // @[CSR.scala 40:22:@363.4]
  wire  _T_300; // @[CSR.scala 40:30:@364.4]
  wire [31:0] _GEN_44; // @[CSR.scala 40:45:@365.4]
  wire  _T_305; // @[CSR.scala 47:30:@373.4]
  wire  _T_310; // @[CSR.scala 40:22:@382.4]
  wire  _T_311; // @[CSR.scala 40:30:@383.4]
  wire [31:0] _GEN_48; // @[CSR.scala 40:45:@384.4]
  wire  _T_316; // @[CSR.scala 47:30:@392.4]
  wire  _T_321; // @[CSR.scala 40:22:@401.4]
  wire  _T_322; // @[CSR.scala 40:30:@402.4]
  wire [31:0] _GEN_52; // @[CSR.scala 40:45:@403.4]
  wire  _T_327; // @[CSR.scala 47:30:@411.4]
  wire  _T_332; // @[CSR.scala 40:22:@420.4]
  wire  _T_333; // @[CSR.scala 40:30:@421.4]
  wire [31:0] _GEN_56; // @[CSR.scala 40:45:@422.4]
  wire  _T_338; // @[CSR.scala 47:30:@430.4]
  wire  _T_343; // @[CSR.scala 40:22:@439.4]
  wire  _T_344; // @[CSR.scala 40:30:@440.4]
  wire  _T_349; // @[CSR.scala 47:30:@449.4]
  assign _T_178 = io_bus_addr == 4'h0; // @[CSR.scala 40:22:@154.4]
  assign _T_179 = _T_178 & io_bus_read; // @[CSR.scala 40:30:@155.4]
  assign _GEN_0 = _T_179 ? io_csr_0_dataIn : 32'h0; // @[CSR.scala 40:45:@156.4]
  assign _T_184 = _T_178 & io_bus_write; // @[CSR.scala 47:30:@164.4]
  assign _T_189 = io_bus_addr == 4'h1; // @[CSR.scala 40:22:@173.4]
  assign _T_190 = _T_189 & io_bus_read; // @[CSR.scala 40:30:@174.4]
  assign _GEN_4 = _T_190 ? io_csr_1_dataIn : _GEN_0; // @[CSR.scala 40:45:@175.4]
  assign _T_200 = io_bus_addr == 4'h2; // @[CSR.scala 40:22:@192.4]
  assign _T_201 = _T_200 & io_bus_read; // @[CSR.scala 40:30:@193.4]
  assign _GEN_8 = _T_201 ? io_csr_2_dataIn : _GEN_4; // @[CSR.scala 40:45:@194.4]
  assign _T_206 = _T_200 & io_bus_write; // @[CSR.scala 47:30:@202.4]
  assign _T_211 = io_bus_addr == 4'h3; // @[CSR.scala 40:22:@211.4]
  assign _T_212 = _T_211 & io_bus_read; // @[CSR.scala 40:30:@212.4]
  assign _GEN_12 = _T_212 ? io_csr_3_dataIn : _GEN_8; // @[CSR.scala 40:45:@213.4]
  assign _T_217 = _T_211 & io_bus_write; // @[CSR.scala 47:30:@221.4]
  assign _T_222 = io_bus_addr == 4'h4; // @[CSR.scala 40:22:@230.4]
  assign _T_223 = _T_222 & io_bus_read; // @[CSR.scala 40:30:@231.4]
  assign _GEN_16 = _T_223 ? io_csr_4_dataIn : _GEN_12; // @[CSR.scala 40:45:@232.4]
  assign _T_228 = _T_222 & io_bus_write; // @[CSR.scala 47:30:@240.4]
  assign _T_233 = io_bus_addr == 4'h5; // @[CSR.scala 40:22:@249.4]
  assign _T_234 = _T_233 & io_bus_read; // @[CSR.scala 40:30:@250.4]
  assign _GEN_20 = _T_234 ? io_csr_5_dataIn : _GEN_16; // @[CSR.scala 40:45:@251.4]
  assign _T_239 = _T_233 & io_bus_write; // @[CSR.scala 47:30:@259.4]
  assign _T_244 = io_bus_addr == 4'h6; // @[CSR.scala 40:22:@268.4]
  assign _T_245 = _T_244 & io_bus_read; // @[CSR.scala 40:30:@269.4]
  assign _GEN_24 = _T_245 ? io_csr_6_dataIn : _GEN_20; // @[CSR.scala 40:45:@270.4]
  assign _T_250 = _T_244 & io_bus_write; // @[CSR.scala 47:30:@278.4]
  assign _T_255 = io_bus_addr == 4'h7; // @[CSR.scala 40:22:@287.4]
  assign _T_256 = _T_255 & io_bus_read; // @[CSR.scala 40:30:@288.4]
  assign _GEN_28 = _T_256 ? io_csr_7_dataIn : _GEN_24; // @[CSR.scala 40:45:@289.4]
  assign _T_261 = _T_255 & io_bus_write; // @[CSR.scala 47:30:@297.4]
  assign _T_266 = io_bus_addr == 4'h8; // @[CSR.scala 40:22:@306.4]
  assign _T_267 = _T_266 & io_bus_read; // @[CSR.scala 40:30:@307.4]
  assign _GEN_32 = _T_267 ? io_csr_8_dataIn : _GEN_28; // @[CSR.scala 40:45:@308.4]
  assign _T_272 = _T_266 & io_bus_write; // @[CSR.scala 47:30:@316.4]
  assign _T_277 = io_bus_addr == 4'h9; // @[CSR.scala 40:22:@325.4]
  assign _T_278 = _T_277 & io_bus_read; // @[CSR.scala 40:30:@326.4]
  assign _GEN_36 = _T_278 ? io_csr_9_dataIn : _GEN_32; // @[CSR.scala 40:45:@327.4]
  assign _T_283 = _T_277 & io_bus_write; // @[CSR.scala 47:30:@335.4]
  assign _T_288 = io_bus_addr == 4'ha; // @[CSR.scala 40:22:@344.4]
  assign _T_289 = _T_288 & io_bus_read; // @[CSR.scala 40:30:@345.4]
  assign _GEN_40 = _T_289 ? io_csr_10_dataIn : _GEN_36; // @[CSR.scala 40:45:@346.4]
  assign _T_294 = _T_288 & io_bus_write; // @[CSR.scala 47:30:@354.4]
  assign _T_299 = io_bus_addr == 4'hb; // @[CSR.scala 40:22:@363.4]
  assign _T_300 = _T_299 & io_bus_read; // @[CSR.scala 40:30:@364.4]
  assign _GEN_44 = _T_300 ? io_csr_11_dataIn : _GEN_40; // @[CSR.scala 40:45:@365.4]
  assign _T_305 = _T_299 & io_bus_write; // @[CSR.scala 47:30:@373.4]
  assign _T_310 = io_bus_addr == 4'hc; // @[CSR.scala 40:22:@382.4]
  assign _T_311 = _T_310 & io_bus_read; // @[CSR.scala 40:30:@383.4]
  assign _GEN_48 = _T_311 ? io_csr_12_dataIn : _GEN_44; // @[CSR.scala 40:45:@384.4]
  assign _T_316 = _T_310 & io_bus_write; // @[CSR.scala 47:30:@392.4]
  assign _T_321 = io_bus_addr == 4'hd; // @[CSR.scala 40:22:@401.4]
  assign _T_322 = _T_321 & io_bus_read; // @[CSR.scala 40:30:@402.4]
  assign _GEN_52 = _T_322 ? io_csr_13_dataIn : _GEN_48; // @[CSR.scala 40:45:@403.4]
  assign _T_327 = _T_321 & io_bus_write; // @[CSR.scala 47:30:@411.4]
  assign _T_332 = io_bus_addr == 4'he; // @[CSR.scala 40:22:@420.4]
  assign _T_333 = _T_332 & io_bus_read; // @[CSR.scala 40:30:@421.4]
  assign _GEN_56 = _T_333 ? io_csr_14_dataIn : _GEN_52; // @[CSR.scala 40:45:@422.4]
  assign _T_338 = _T_332 & io_bus_write; // @[CSR.scala 47:30:@430.4]
  assign _T_343 = io_bus_addr == 4'hf; // @[CSR.scala 40:22:@439.4]
  assign _T_344 = _T_343 & io_bus_read; // @[CSR.scala 40:30:@440.4]
  assign _T_349 = _T_343 & io_bus_write; // @[CSR.scala 47:30:@449.4]
  assign io_csr_0_dataOut = _T_184 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@166.6 CSR.scala 52:25:@171.6]
  assign io_csr_0_dataWrite = _T_178 & io_bus_write; // @[CSR.scala 49:27:@167.6 CSR.scala 51:27:@170.6]
  assign io_csr_2_dataOut = _T_206 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@204.6 CSR.scala 52:25:@209.6]
  assign io_csr_2_dataWrite = _T_200 & io_bus_write; // @[CSR.scala 49:27:@205.6 CSR.scala 51:27:@208.6]
  assign io_csr_3_dataOut = _T_217 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@223.6 CSR.scala 52:25:@228.6]
  assign io_csr_3_dataWrite = _T_211 & io_bus_write; // @[CSR.scala 49:27:@224.6 CSR.scala 51:27:@227.6]
  assign io_csr_4_dataOut = _T_228 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@242.6 CSR.scala 52:25:@247.6]
  assign io_csr_4_dataWrite = _T_222 & io_bus_write; // @[CSR.scala 49:27:@243.6 CSR.scala 51:27:@246.6]
  assign io_csr_5_dataOut = _T_239 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@261.6 CSR.scala 52:25:@266.6]
  assign io_csr_5_dataWrite = _T_233 & io_bus_write; // @[CSR.scala 49:27:@262.6 CSR.scala 51:27:@265.6]
  assign io_csr_6_dataOut = _T_250 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@280.6 CSR.scala 52:25:@285.6]
  assign io_csr_6_dataWrite = _T_244 & io_bus_write; // @[CSR.scala 49:27:@281.6 CSR.scala 51:27:@284.6]
  assign io_csr_7_dataOut = _T_261 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@299.6 CSR.scala 52:25:@304.6]
  assign io_csr_7_dataWrite = _T_255 & io_bus_write; // @[CSR.scala 49:27:@300.6 CSR.scala 51:27:@303.6]
  assign io_csr_8_dataOut = _T_272 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@318.6 CSR.scala 52:25:@323.6]
  assign io_csr_8_dataWrite = _T_266 & io_bus_write; // @[CSR.scala 49:27:@319.6 CSR.scala 51:27:@322.6]
  assign io_csr_9_dataOut = _T_283 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@337.6 CSR.scala 52:25:@342.6]
  assign io_csr_9_dataWrite = _T_277 & io_bus_write; // @[CSR.scala 49:27:@338.6 CSR.scala 51:27:@341.6]
  assign io_csr_10_dataOut = _T_294 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@356.6 CSR.scala 52:25:@361.6]
  assign io_csr_10_dataWrite = _T_288 & io_bus_write; // @[CSR.scala 49:27:@357.6 CSR.scala 51:27:@360.6]
  assign io_csr_11_dataOut = _T_305 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@375.6 CSR.scala 52:25:@380.6]
  assign io_csr_11_dataWrite = _T_299 & io_bus_write; // @[CSR.scala 49:27:@376.6 CSR.scala 51:27:@379.6]
  assign io_csr_12_dataOut = _T_316 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@394.6 CSR.scala 52:25:@399.6]
  assign io_csr_12_dataWrite = _T_310 & io_bus_write; // @[CSR.scala 49:27:@395.6 CSR.scala 51:27:@398.6]
  assign io_csr_13_dataOut = _T_327 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@413.6 CSR.scala 52:25:@418.6]
  assign io_csr_13_dataWrite = _T_321 & io_bus_write; // @[CSR.scala 49:27:@414.6 CSR.scala 51:27:@417.6]
  assign io_csr_14_dataOut = _T_338 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@432.6 CSR.scala 52:25:@437.6]
  assign io_csr_14_dataWrite = _T_332 & io_bus_write; // @[CSR.scala 49:27:@433.6 CSR.scala 51:27:@436.6]
  assign io_csr_15_dataOut = _T_349 ? io_bus_dataOut : 32'h0; // @[CSR.scala 48:25:@451.6 CSR.scala 52:25:@456.6]
  assign io_csr_15_dataWrite = _T_343 & io_bus_write; // @[CSR.scala 49:27:@452.6 CSR.scala 51:27:@455.6]
  assign io_bus_dataIn = _T_344 ? io_csr_15_dataIn : _GEN_56; // @[CSR.scala 37:17:@153.4]
endmodule
module AddressGenerator( // @[:@459.2]
  input         clock, // @[:@460.4]
  input         reset, // @[:@461.4]
  input         io_ctl_start, // @[:@462.4]
  output        io_ctl_busy, // @[:@462.4]
  input  [31:0] io_ctl_startAddress, // @[:@462.4]
  input  [31:0] io_ctl_lineLength, // @[:@462.4]
  input  [31:0] io_ctl_lineCount, // @[:@462.4]
  input  [31:0] io_ctl_lineGap, // @[:@462.4]
  input         io_xfer_done, // @[:@462.4]
  output [31:0] io_xfer_address, // @[:@462.4]
  output [31:0] io_xfer_length, // @[:@462.4]
  output        io_xfer_valid // @[:@462.4]
);
  reg [1:0] state; // @[AddressGenerator.scala 37:22:@464.4]
  reg [31:0] _RAND_0;
  reg [31:0] lineCount; // @[AddressGenerator.scala 39:26:@465.4]
  reg [31:0] _RAND_1;
  reg [31:0] lineGap; // @[AddressGenerator.scala 40:24:@466.4]
  reg [31:0] _RAND_2;
  reg [31:0] address_o; // @[AddressGenerator.scala 42:26:@467.4]
  reg [31:0] _RAND_3;
  reg [31:0] address_i; // @[AddressGenerator.scala 43:26:@468.4]
  reg [31:0] _RAND_4;
  reg [31:0] length_o; // @[AddressGenerator.scala 44:25:@469.4]
  reg [31:0] _RAND_5;
  reg [31:0] length_i; // @[AddressGenerator.scala 45:25:@470.4]
  reg [31:0] _RAND_6;
  reg  valid; // @[AddressGenerator.scala 46:22:@471.4]
  reg [31:0] _RAND_7;
  reg  busy; // @[AddressGenerator.scala 47:21:@472.4]
  reg [31:0] _RAND_8;
  wire  _T_42; // @[AddressGenerator.scala 54:14:@477.4]
  wire  _GEN_0; // @[AddressGenerator.scala 54:24:@478.4]
  wire  _T_45; // @[Conditional.scala 37:30:@484.4]
  wire [1:0] _GEN_1; // @[AddressGenerator.scala 62:25:@486.6]
  wire [31:0] _GEN_2; // @[AddressGenerator.scala 62:25:@486.6]
  wire [31:0] _GEN_3; // @[AddressGenerator.scala 62:25:@486.6]
  wire [31:0] _GEN_4; // @[AddressGenerator.scala 62:25:@486.6]
  wire [31:0] _GEN_5; // @[AddressGenerator.scala 62:25:@486.6]
  wire  _T_46; // @[Conditional.scala 37:30:@495.6]
  wire [34:0] _T_49; // @[AddressGenerator.scala 75:42:@500.8]
  wire [34:0] _GEN_24; // @[AddressGenerator.scala 75:30:@501.8]
  wire [35:0] _T_50; // @[AddressGenerator.scala 75:30:@501.8]
  wire [34:0] _T_51; // @[AddressGenerator.scala 75:30:@502.8]
  wire [34:0] _T_53; // @[AddressGenerator.scala 75:74:@503.8]
  wire [35:0] _T_54; // @[AddressGenerator.scala 75:63:@504.8]
  wire [34:0] _T_55; // @[AddressGenerator.scala 75:63:@505.8]
  wire [32:0] _T_57; // @[AddressGenerator.scala 77:30:@507.8]
  wire [32:0] _T_58; // @[AddressGenerator.scala 77:30:@508.8]
  wire [31:0] _T_59; // @[AddressGenerator.scala 77:30:@509.8]
  wire  _T_60; // @[Conditional.scala 37:30:@514.8]
  wire  _T_63; // @[AddressGenerator.scala 83:24:@518.12]
  wire [1:0] _GEN_6; // @[AddressGenerator.scala 83:30:@519.12]
  wire [1:0] _GEN_7; // @[AddressGenerator.scala 82:25:@517.10]
  wire  _GEN_8; // @[Conditional.scala 39:67:@515.8]
  wire [1:0] _GEN_9; // @[Conditional.scala 39:67:@515.8]
  wire  _GEN_10; // @[Conditional.scala 39:67:@496.6]
  wire [31:0] _GEN_11; // @[Conditional.scala 39:67:@496.6]
  wire [31:0] _GEN_12; // @[Conditional.scala 39:67:@496.6]
  wire [34:0] _GEN_13; // @[Conditional.scala 39:67:@496.6]
  wire [31:0] _GEN_14; // @[Conditional.scala 39:67:@496.6]
  wire [1:0] _GEN_15; // @[Conditional.scala 39:67:@496.6]
  wire [1:0] _GEN_16; // @[Conditional.scala 40:58:@485.4]
  wire [34:0] _GEN_17; // @[Conditional.scala 40:58:@485.4]
  wire [31:0] _GEN_18; // @[Conditional.scala 40:58:@485.4]
  wire [31:0] _GEN_19; // @[Conditional.scala 40:58:@485.4]
  wire [31:0] _GEN_20; // @[Conditional.scala 40:58:@485.4]
  wire  _GEN_21; // @[Conditional.scala 40:58:@485.4]
  wire [31:0] _GEN_22; // @[Conditional.scala 40:58:@485.4]
  wire [31:0] _GEN_23; // @[Conditional.scala 40:58:@485.4]
  assign _T_42 = state == 2'h0; // @[AddressGenerator.scala 54:14:@477.4]
  assign _GEN_0 = _T_42 ? 1'h0 : 1'h1; // @[AddressGenerator.scala 54:24:@478.4]
  assign _T_45 = 2'h0 == state; // @[Conditional.scala 37:30:@484.4]
  assign _GEN_1 = io_ctl_start ? 2'h1 : state; // @[AddressGenerator.scala 62:25:@486.6]
  assign _GEN_2 = io_ctl_start ? io_ctl_startAddress : address_i; // @[AddressGenerator.scala 62:25:@486.6]
  assign _GEN_3 = io_ctl_start ? io_ctl_lineLength : length_i; // @[AddressGenerator.scala 62:25:@486.6]
  assign _GEN_4 = io_ctl_start ? io_ctl_lineCount : lineCount; // @[AddressGenerator.scala 62:25:@486.6]
  assign _GEN_5 = io_ctl_start ? io_ctl_lineGap : lineGap; // @[AddressGenerator.scala 62:25:@486.6]
  assign _T_46 = 2'h1 == state; // @[Conditional.scala 37:30:@495.6]
  assign _T_49 = length_i * 32'h4; // @[AddressGenerator.scala 75:42:@500.8]
  assign _GEN_24 = {{3'd0}, address_i}; // @[AddressGenerator.scala 75:30:@501.8]
  assign _T_50 = _GEN_24 + _T_49; // @[AddressGenerator.scala 75:30:@501.8]
  assign _T_51 = _GEN_24 + _T_49; // @[AddressGenerator.scala 75:30:@502.8]
  assign _T_53 = lineGap * 32'h4; // @[AddressGenerator.scala 75:74:@503.8]
  assign _T_54 = _T_51 + _T_53; // @[AddressGenerator.scala 75:63:@504.8]
  assign _T_55 = _T_51 + _T_53; // @[AddressGenerator.scala 75:63:@505.8]
  assign _T_57 = lineCount - 32'h1; // @[AddressGenerator.scala 77:30:@507.8]
  assign _T_58 = $unsigned(_T_57); // @[AddressGenerator.scala 77:30:@508.8]
  assign _T_59 = _T_58[31:0]; // @[AddressGenerator.scala 77:30:@509.8]
  assign _T_60 = 2'h2 == state; // @[Conditional.scala 37:30:@514.8]
  assign _T_63 = lineCount > 32'h0; // @[AddressGenerator.scala 83:24:@518.12]
  assign _GEN_6 = _T_63 ? 2'h1 : 2'h0; // @[AddressGenerator.scala 83:30:@519.12]
  assign _GEN_7 = io_xfer_done ? _GEN_6 : state; // @[AddressGenerator.scala 82:25:@517.10]
  assign _GEN_8 = _T_60 ? 1'h0 : valid; // @[Conditional.scala 39:67:@515.8]
  assign _GEN_9 = _T_60 ? _GEN_7 : state; // @[Conditional.scala 39:67:@515.8]
  assign _GEN_10 = _T_46 ? 1'h1 : _GEN_8; // @[Conditional.scala 39:67:@496.6]
  assign _GEN_11 = _T_46 ? address_i : address_o; // @[Conditional.scala 39:67:@496.6]
  assign _GEN_12 = _T_46 ? length_i : length_o; // @[Conditional.scala 39:67:@496.6]
  assign _GEN_13 = _T_46 ? _T_55 : {{3'd0}, address_i}; // @[Conditional.scala 39:67:@496.6]
  assign _GEN_14 = _T_46 ? _T_59 : lineCount; // @[Conditional.scala 39:67:@496.6]
  assign _GEN_15 = _T_46 ? 2'h2 : _GEN_9; // @[Conditional.scala 39:67:@496.6]
  assign _GEN_16 = _T_45 ? _GEN_1 : _GEN_15; // @[Conditional.scala 40:58:@485.4]
  assign _GEN_17 = _T_45 ? {{3'd0}, _GEN_2} : _GEN_13; // @[Conditional.scala 40:58:@485.4]
  assign _GEN_18 = _T_45 ? _GEN_3 : length_i; // @[Conditional.scala 40:58:@485.4]
  assign _GEN_19 = _T_45 ? _GEN_4 : _GEN_14; // @[Conditional.scala 40:58:@485.4]
  assign _GEN_20 = _T_45 ? _GEN_5 : lineGap; // @[Conditional.scala 40:58:@485.4]
  assign _GEN_21 = _T_45 ? valid : _GEN_10; // @[Conditional.scala 40:58:@485.4]
  assign _GEN_22 = _T_45 ? address_o : _GEN_11; // @[Conditional.scala 40:58:@485.4]
  assign _GEN_23 = _T_45 ? length_o : _GEN_12; // @[Conditional.scala 40:58:@485.4]
  assign io_ctl_busy = busy; // @[AddressGenerator.scala 52:15:@476.4]
  assign io_xfer_address = address_o; // @[AddressGenerator.scala 49:19:@473.4]
  assign io_xfer_length = length_o; // @[AddressGenerator.scala 50:18:@474.4]
  assign io_xfer_valid = valid; // @[AddressGenerator.scala 51:17:@475.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  lineCount = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  lineGap = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  address_o = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  address_i = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  length_o = _RAND_5[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  length_i = _RAND_6[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  valid = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  busy = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
    end else begin
      if (_T_45) begin
        if (io_ctl_start) begin
          state <= 2'h1;
        end
      end else begin
        if (_T_46) begin
          state <= 2'h2;
        end else begin
          if (_T_60) begin
            if (io_xfer_done) begin
              if (_T_63) begin
                state <= 2'h1;
              end else begin
                state <= 2'h0;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      lineCount <= 32'h0;
    end else begin
      if (_T_45) begin
        if (io_ctl_start) begin
          lineCount <= io_ctl_lineCount;
        end
      end else begin
        if (_T_46) begin
          lineCount <= _T_59;
        end
      end
    end
    if (reset) begin
      lineGap <= 32'h0;
    end else begin
      if (_T_45) begin
        if (io_ctl_start) begin
          lineGap <= io_ctl_lineGap;
        end
      end
    end
    if (reset) begin
      address_o <= 32'h0;
    end else begin
      if (!(_T_45)) begin
        if (_T_46) begin
          address_o <= address_i;
        end
      end
    end
    if (reset) begin
      address_i <= 32'h0;
    end else begin
      address_i <= _GEN_17[31:0];
    end
    if (reset) begin
      length_o <= 32'h0;
    end else begin
      if (!(_T_45)) begin
        if (_T_46) begin
          length_o <= length_i;
        end
      end
    end
    if (reset) begin
      length_i <= 32'h0;
    end else begin
      if (_T_45) begin
        if (io_ctl_start) begin
          length_i <= io_ctl_lineLength;
        end
      end
    end
    if (reset) begin
      valid <= 1'h0;
    end else begin
      if (!(_T_45)) begin
        if (_T_46) begin
          valid <= 1'h1;
        end else begin
          if (_T_60) begin
            valid <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      busy <= 1'h0;
    end else begin
      if (_T_42) begin
        busy <= 1'h0;
      end else begin
        busy <= 1'h1;
      end
    end
  end
endmodule
module TransferSplitter( // @[:@528.2]
  output        io_xferIn_done, // @[:@531.4]
  input  [31:0] io_xferIn_address, // @[:@531.4]
  input  [31:0] io_xferIn_length, // @[:@531.4]
  input         io_xferIn_valid, // @[:@531.4]
  input         io_xferOut_done, // @[:@531.4]
  output [31:0] io_xferOut_address, // @[:@531.4]
  output [31:0] io_xferOut_length, // @[:@531.4]
  output        io_xferOut_valid // @[:@531.4]
);
  assign io_xferIn_done = io_xferOut_done; // @[TransferSplitter.scala 125:16:@536.4]
  assign io_xferOut_address = io_xferIn_address; // @[TransferSplitter.scala 125:16:@535.4]
  assign io_xferOut_length = io_xferIn_length; // @[TransferSplitter.scala 125:16:@534.4]
  assign io_xferOut_valid = io_xferIn_valid; // @[TransferSplitter.scala 125:16:@533.4]
endmodule
module ClearCSR( // @[:@617.2]
  input         clock, // @[:@618.4]
  input         reset, // @[:@619.4]
  input  [31:0] io_csr_dataOut, // @[:@620.4]
  input         io_csr_dataWrite, // @[:@620.4]
  output [31:0] io_csr_dataIn, // @[:@620.4]
  output [31:0] io_value, // @[:@620.4]
  input  [31:0] io_clear // @[:@620.4]
);
  reg [31:0] reg$; // @[ClearCSR.scala 36:20:@622.4]
  reg [31:0] _RAND_0;
  wire [31:0] _T_29; // @[ClearCSR.scala 44:19:@629.6]
  wire [31:0] _T_30; // @[ClearCSR.scala 44:16:@630.6]
  wire [31:0] _GEN_0; // @[ClearCSR.scala 41:25:@625.4]
  assign _T_29 = ~ io_clear; // @[ClearCSR.scala 44:19:@629.6]
  assign _T_30 = reg$ & _T_29; // @[ClearCSR.scala 44:16:@630.6]
  assign _GEN_0 = io_csr_dataWrite ? io_csr_dataOut : _T_30; // @[ClearCSR.scala 41:25:@625.4]
  assign io_csr_dataIn = reg$; // @[ClearCSR.scala 38:17:@623.4]
  assign io_value = reg$; // @[ClearCSR.scala 39:12:@624.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reg$ <= 32'h0;
    end else begin
      if (io_csr_dataWrite) begin
        reg$ <= io_csr_dataOut;
      end else begin
        reg$ <= _T_30;
      end
    end
  end
endmodule
module StatusCSR( // @[:@634.2]
  input         clock, // @[:@635.4]
  output [31:0] io_csr_dataIn, // @[:@637.4]
  input  [31:0] io_value // @[:@637.4]
);
  reg [31:0] reg$; // @[StatusCSR.scala 35:20:@639.4]
  reg [31:0] _RAND_0;
  assign io_csr_dataIn = reg$; // @[StatusCSR.scala 37:17:@641.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    reg$ <= io_value;
  end
endmodule
module SimpleCSR( // @[:@643.2]
  input         clock, // @[:@644.4]
  input         reset, // @[:@645.4]
  input  [31:0] io_csr_dataOut, // @[:@646.4]
  input         io_csr_dataWrite, // @[:@646.4]
  output [31:0] io_csr_dataIn, // @[:@646.4]
  output [31:0] io_value // @[:@646.4]
);
  reg [31:0] reg$; // @[SimpleCSR.scala 35:20:@648.4]
  reg [31:0] _RAND_0;
  wire [31:0] _GEN_0; // @[SimpleCSR.scala 40:25:@651.4]
  assign _GEN_0 = io_csr_dataWrite ? io_csr_dataOut : reg$; // @[SimpleCSR.scala 40:25:@651.4]
  assign io_csr_dataIn = reg$; // @[SimpleCSR.scala 37:17:@649.4]
  assign io_value = reg$; // @[SimpleCSR.scala 38:12:@650.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reg$ <= 32'h0;
    end else begin
      if (io_csr_dataWrite) begin
        reg$ <= io_csr_dataOut;
      end
    end
  end
endmodule
module SetCSR( // @[:@655.2]
  input         clock, // @[:@656.4]
  input         reset, // @[:@657.4]
  input  [31:0] io_csr_dataOut, // @[:@658.4]
  input         io_csr_dataWrite, // @[:@658.4]
  output [31:0] io_csr_dataIn, // @[:@658.4]
  output [31:0] io_value, // @[:@658.4]
  input  [31:0] io_set // @[:@658.4]
);
  reg [31:0] reg$; // @[SetCSR.scala 36:20:@660.4]
  reg [31:0] _RAND_0;
  wire [31:0] _T_29; // @[SetCSR.scala 42:20:@664.6]
  wire [31:0] _T_30; // @[SetCSR.scala 42:17:@665.6]
  wire [31:0] _T_31; // @[SetCSR.scala 42:45:@666.6]
  wire [31:0] _T_32; // @[SetCSR.scala 44:16:@670.6]
  wire [31:0] _GEN_0; // @[SetCSR.scala 41:25:@663.4]
  assign _T_29 = ~ io_csr_dataOut; // @[SetCSR.scala 42:20:@664.6]
  assign _T_30 = reg$ & _T_29; // @[SetCSR.scala 42:17:@665.6]
  assign _T_31 = _T_30 | io_set; // @[SetCSR.scala 42:45:@666.6]
  assign _T_32 = reg$ | io_set; // @[SetCSR.scala 44:16:@670.6]
  assign _GEN_0 = io_csr_dataWrite ? _T_31 : _T_32; // @[SetCSR.scala 41:25:@663.4]
  assign io_csr_dataIn = reg$; // @[SetCSR.scala 38:17:@661.4]
  assign io_value = reg$; // @[SetCSR.scala 39:12:@662.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reg$ <= 32'h0;
    end else begin
      if (io_csr_dataWrite) begin
        reg$ <= _T_31;
      end else begin
        reg$ <= _T_32;
      end
    end
  end
endmodule
module InterruptController( // @[:@674.2]
  input         clock, // @[:@675.4]
  input         reset, // @[:@676.4]
  output        io_irq_readerDone, // @[:@677.4]
  output        io_irq_writerDone, // @[:@677.4]
  input         io_readBusy, // @[:@677.4]
  input         io_writeBusy, // @[:@677.4]
  input  [31:0] io_imr_dataOut, // @[:@677.4]
  input         io_imr_dataWrite, // @[:@677.4]
  output [31:0] io_imr_dataIn, // @[:@677.4]
  input  [31:0] io_isr_dataOut, // @[:@677.4]
  input         io_isr_dataWrite, // @[:@677.4]
  output [31:0] io_isr_dataIn // @[:@677.4]
);
  wire  SimpleCSR_clock; // @[SimpleCSR.scala 48:21:@679.4]
  wire  SimpleCSR_reset; // @[SimpleCSR.scala 48:21:@679.4]
  wire [31:0] SimpleCSR_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@679.4]
  wire  SimpleCSR_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@679.4]
  wire [31:0] SimpleCSR_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@679.4]
  wire [31:0] SimpleCSR_io_value; // @[SimpleCSR.scala 48:21:@679.4]
  wire  SetCSR_clock; // @[SetCSR.scala 51:21:@711.4]
  wire  SetCSR_reset; // @[SetCSR.scala 51:21:@711.4]
  wire [31:0] SetCSR_io_csr_dataOut; // @[SetCSR.scala 51:21:@711.4]
  wire  SetCSR_io_csr_dataWrite; // @[SetCSR.scala 51:21:@711.4]
  wire [31:0] SetCSR_io_csr_dataIn; // @[SetCSR.scala 51:21:@711.4]
  wire [31:0] SetCSR_io_value; // @[SetCSR.scala 51:21:@711.4]
  wire [31:0] SetCSR_io_set; // @[SetCSR.scala 51:21:@711.4]
  reg  readBusy; // @[InterruptController.scala 41:25:@688.4]
  reg [31:0] _RAND_0;
  reg  readBusyOld; // @[InterruptController.scala 42:28:@690.4]
  reg [31:0] _RAND_1;
  reg  writeBusy; // @[InterruptController.scala 44:26:@692.4]
  reg [31:0] _RAND_2;
  reg  writeBusyOld; // @[InterruptController.scala 45:29:@694.4]
  reg [31:0] _RAND_3;
  reg  writeBusyIrq; // @[InterruptController.scala 47:29:@696.4]
  reg [31:0] _RAND_4;
  reg  readBusyIrq; // @[InterruptController.scala 48:28:@697.4]
  reg [31:0] _RAND_5;
  wire  _T_59; // @[InterruptController.scala 50:35:@698.4]
  wire  _T_60; // @[InterruptController.scala 50:32:@699.4]
  wire [31:0] mask; // @[:@686.4 :@687.4]
  wire  _T_61; // @[InterruptController.scala 50:53:@700.4]
  wire  _T_62; // @[InterruptController.scala 50:46:@701.4]
  wire  _T_64; // @[InterruptController.scala 51:33:@703.4]
  wire  _T_65; // @[InterruptController.scala 51:30:@704.4]
  wire  _T_66; // @[InterruptController.scala 51:50:@705.4]
  wire  _T_67; // @[InterruptController.scala 51:43:@706.4]
  wire [1:0] irq; // @[Cat.scala 30:58:@708.4]
  wire [31:0] isr; // @[:@719.4 :@720.4]
  SimpleCSR SimpleCSR ( // @[SimpleCSR.scala 48:21:@679.4]
    .clock(SimpleCSR_clock),
    .reset(SimpleCSR_reset),
    .io_csr_dataOut(SimpleCSR_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_io_csr_dataIn),
    .io_value(SimpleCSR_io_value)
  );
  SetCSR SetCSR ( // @[SetCSR.scala 51:21:@711.4]
    .clock(SetCSR_clock),
    .reset(SetCSR_reset),
    .io_csr_dataOut(SetCSR_io_csr_dataOut),
    .io_csr_dataWrite(SetCSR_io_csr_dataWrite),
    .io_csr_dataIn(SetCSR_io_csr_dataIn),
    .io_value(SetCSR_io_value),
    .io_set(SetCSR_io_set)
  );
  assign _T_59 = writeBusy == 1'h0; // @[InterruptController.scala 50:35:@698.4]
  assign _T_60 = writeBusyOld & _T_59; // @[InterruptController.scala 50:32:@699.4]
  assign mask = SimpleCSR_io_value; // @[:@686.4 :@687.4]
  assign _T_61 = mask[0]; // @[InterruptController.scala 50:53:@700.4]
  assign _T_62 = _T_60 & _T_61; // @[InterruptController.scala 50:46:@701.4]
  assign _T_64 = readBusy == 1'h0; // @[InterruptController.scala 51:33:@703.4]
  assign _T_65 = readBusyOld & _T_64; // @[InterruptController.scala 51:30:@704.4]
  assign _T_66 = mask[1]; // @[InterruptController.scala 51:50:@705.4]
  assign _T_67 = _T_65 & _T_66; // @[InterruptController.scala 51:43:@706.4]
  assign irq = {readBusyIrq,writeBusyIrq}; // @[Cat.scala 30:58:@708.4]
  assign isr = SetCSR_io_value; // @[:@719.4 :@720.4]
  assign io_irq_readerDone = isr[1]; // @[InterruptController.scala 58:21:@724.4]
  assign io_irq_writerDone = isr[0]; // @[InterruptController.scala 57:21:@722.4]
  assign io_imr_dataIn = SimpleCSR_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@682.4]
  assign io_isr_dataIn = SetCSR_io_csr_dataIn; // @[SetCSR.scala 55:16:@715.4]
  assign SimpleCSR_clock = clock; // @[:@680.4]
  assign SimpleCSR_reset = reset; // @[:@681.4]
  assign SimpleCSR_io_csr_dataOut = io_imr_dataOut; // @[SimpleCSR.scala 50:16:@684.4]
  assign SimpleCSR_io_csr_dataWrite = io_imr_dataWrite; // @[SimpleCSR.scala 50:16:@683.4]
  assign SetCSR_clock = clock; // @[:@712.4]
  assign SetCSR_reset = reset; // @[:@713.4]
  assign SetCSR_io_csr_dataOut = io_isr_dataOut; // @[SetCSR.scala 55:16:@717.4]
  assign SetCSR_io_csr_dataWrite = io_isr_dataWrite; // @[SetCSR.scala 55:16:@716.4]
  assign SetCSR_io_set = {{30'd0}, irq}; // @[SetCSR.scala 53:16:@714.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  readBusy = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  readBusyOld = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  writeBusy = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  writeBusyOld = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  writeBusyIrq = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  readBusyIrq = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    readBusy <= io_readBusy;
    readBusyOld <= readBusy;
    writeBusy <= io_writeBusy;
    writeBusyOld <= writeBusy;
    if (reset) begin
      writeBusyIrq <= 1'h0;
    end else begin
      writeBusyIrq <= _T_62;
    end
    if (reset) begin
      readBusyIrq <= 1'h0;
    end else begin
      readBusyIrq <= _T_67;
    end
  end
endmodule
module WorkerCSRWrapper( // @[:@870.2]
  input         clock, // @[:@871.4]
  input         reset, // @[:@872.4]
  input  [31:0] io_csr_0_dataOut, // @[:@873.4]
  input         io_csr_0_dataWrite, // @[:@873.4]
  output [31:0] io_csr_0_dataIn, // @[:@873.4]
  output [31:0] io_csr_1_dataIn, // @[:@873.4]
  input  [31:0] io_csr_2_dataOut, // @[:@873.4]
  input         io_csr_2_dataWrite, // @[:@873.4]
  output [31:0] io_csr_2_dataIn, // @[:@873.4]
  input  [31:0] io_csr_3_dataOut, // @[:@873.4]
  input         io_csr_3_dataWrite, // @[:@873.4]
  output [31:0] io_csr_3_dataIn, // @[:@873.4]
  input  [31:0] io_csr_4_dataOut, // @[:@873.4]
  input         io_csr_4_dataWrite, // @[:@873.4]
  output [31:0] io_csr_4_dataIn, // @[:@873.4]
  input  [31:0] io_csr_5_dataOut, // @[:@873.4]
  input         io_csr_5_dataWrite, // @[:@873.4]
  output [31:0] io_csr_5_dataIn, // @[:@873.4]
  input  [31:0] io_csr_6_dataOut, // @[:@873.4]
  input         io_csr_6_dataWrite, // @[:@873.4]
  output [31:0] io_csr_6_dataIn, // @[:@873.4]
  input  [31:0] io_csr_7_dataOut, // @[:@873.4]
  input         io_csr_7_dataWrite, // @[:@873.4]
  output [31:0] io_csr_7_dataIn, // @[:@873.4]
  input  [31:0] io_csr_8_dataOut, // @[:@873.4]
  input         io_csr_8_dataWrite, // @[:@873.4]
  output [31:0] io_csr_8_dataIn, // @[:@873.4]
  input  [31:0] io_csr_9_dataOut, // @[:@873.4]
  input         io_csr_9_dataWrite, // @[:@873.4]
  output [31:0] io_csr_9_dataIn, // @[:@873.4]
  input  [31:0] io_csr_10_dataOut, // @[:@873.4]
  input         io_csr_10_dataWrite, // @[:@873.4]
  output [31:0] io_csr_10_dataIn, // @[:@873.4]
  input  [31:0] io_csr_11_dataOut, // @[:@873.4]
  input         io_csr_11_dataWrite, // @[:@873.4]
  output [31:0] io_csr_11_dataIn, // @[:@873.4]
  input  [31:0] io_csr_12_dataOut, // @[:@873.4]
  input         io_csr_12_dataWrite, // @[:@873.4]
  output [31:0] io_csr_12_dataIn, // @[:@873.4]
  input  [31:0] io_csr_13_dataOut, // @[:@873.4]
  input         io_csr_13_dataWrite, // @[:@873.4]
  output [31:0] io_csr_13_dataIn, // @[:@873.4]
  input  [31:0] io_csr_14_dataOut, // @[:@873.4]
  input         io_csr_14_dataWrite, // @[:@873.4]
  output [31:0] io_csr_14_dataIn, // @[:@873.4]
  input  [31:0] io_csr_15_dataOut, // @[:@873.4]
  input         io_csr_15_dataWrite, // @[:@873.4]
  output [31:0] io_csr_15_dataIn, // @[:@873.4]
  output        io_irq_readerDone, // @[:@873.4]
  output        io_irq_writerDone, // @[:@873.4]
  input         io_sync_readerSync, // @[:@873.4]
  input         io_sync_writerSync, // @[:@873.4]
  input         io_xferRead_done, // @[:@873.4]
  output [31:0] io_xferRead_address, // @[:@873.4]
  output [31:0] io_xferRead_length, // @[:@873.4]
  output        io_xferRead_valid, // @[:@873.4]
  input         io_xferWrite_done, // @[:@873.4]
  output [31:0] io_xferWrite_address, // @[:@873.4]
  output [31:0] io_xferWrite_length, // @[:@873.4]
  output        io_xferWrite_valid // @[:@873.4]
);
  wire  addressGeneratorRead_clock; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire  addressGeneratorRead_reset; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire  addressGeneratorRead_io_ctl_start; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire  addressGeneratorRead_io_ctl_busy; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire [31:0] addressGeneratorRead_io_ctl_startAddress; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire [31:0] addressGeneratorRead_io_ctl_lineLength; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire [31:0] addressGeneratorRead_io_ctl_lineCount; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire [31:0] addressGeneratorRead_io_ctl_lineGap; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire  addressGeneratorRead_io_xfer_done; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire [31:0] addressGeneratorRead_io_xfer_address; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire [31:0] addressGeneratorRead_io_xfer_length; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire  addressGeneratorRead_io_xfer_valid; // @[WorkerCSRWrapper.scala 41:36:@875.4]
  wire  transferSplitterRead_io_xferIn_done; // @[WorkerCSRWrapper.scala 42:36:@878.4]
  wire [31:0] transferSplitterRead_io_xferIn_address; // @[WorkerCSRWrapper.scala 42:36:@878.4]
  wire [31:0] transferSplitterRead_io_xferIn_length; // @[WorkerCSRWrapper.scala 42:36:@878.4]
  wire  transferSplitterRead_io_xferIn_valid; // @[WorkerCSRWrapper.scala 42:36:@878.4]
  wire  transferSplitterRead_io_xferOut_done; // @[WorkerCSRWrapper.scala 42:36:@878.4]
  wire [31:0] transferSplitterRead_io_xferOut_address; // @[WorkerCSRWrapper.scala 42:36:@878.4]
  wire [31:0] transferSplitterRead_io_xferOut_length; // @[WorkerCSRWrapper.scala 42:36:@878.4]
  wire  transferSplitterRead_io_xferOut_valid; // @[WorkerCSRWrapper.scala 42:36:@878.4]
  wire  addressGeneratorWrite_clock; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire  addressGeneratorWrite_reset; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire  addressGeneratorWrite_io_ctl_start; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire  addressGeneratorWrite_io_ctl_busy; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire [31:0] addressGeneratorWrite_io_ctl_startAddress; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire [31:0] addressGeneratorWrite_io_ctl_lineLength; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire [31:0] addressGeneratorWrite_io_ctl_lineCount; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire [31:0] addressGeneratorWrite_io_ctl_lineGap; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire  addressGeneratorWrite_io_xfer_done; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire [31:0] addressGeneratorWrite_io_xfer_address; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire [31:0] addressGeneratorWrite_io_xfer_length; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire  addressGeneratorWrite_io_xfer_valid; // @[WorkerCSRWrapper.scala 44:37:@881.4]
  wire  transferSplitterWrite_io_xferIn_done; // @[WorkerCSRWrapper.scala 45:37:@884.4]
  wire [31:0] transferSplitterWrite_io_xferIn_address; // @[WorkerCSRWrapper.scala 45:37:@884.4]
  wire [31:0] transferSplitterWrite_io_xferIn_length; // @[WorkerCSRWrapper.scala 45:37:@884.4]
  wire  transferSplitterWrite_io_xferIn_valid; // @[WorkerCSRWrapper.scala 45:37:@884.4]
  wire  transferSplitterWrite_io_xferOut_done; // @[WorkerCSRWrapper.scala 45:37:@884.4]
  wire [31:0] transferSplitterWrite_io_xferOut_address; // @[WorkerCSRWrapper.scala 45:37:@884.4]
  wire [31:0] transferSplitterWrite_io_xferOut_length; // @[WorkerCSRWrapper.scala 45:37:@884.4]
  wire  transferSplitterWrite_io_xferOut_valid; // @[WorkerCSRWrapper.scala 45:37:@884.4]
  wire  ClearCSR_clock; // @[ClearCSR.scala 50:21:@904.4]
  wire  ClearCSR_reset; // @[ClearCSR.scala 50:21:@904.4]
  wire [31:0] ClearCSR_io_csr_dataOut; // @[ClearCSR.scala 50:21:@904.4]
  wire  ClearCSR_io_csr_dataWrite; // @[ClearCSR.scala 50:21:@904.4]
  wire [31:0] ClearCSR_io_csr_dataIn; // @[ClearCSR.scala 50:21:@904.4]
  wire [31:0] ClearCSR_io_value; // @[ClearCSR.scala 50:21:@904.4]
  wire [31:0] ClearCSR_io_clear; // @[ClearCSR.scala 50:21:@904.4]
  wire  StatusCSR_clock; // @[StatusCSR.scala 42:21:@913.4]
  wire [31:0] StatusCSR_io_csr_dataIn; // @[StatusCSR.scala 42:21:@913.4]
  wire [31:0] StatusCSR_io_value; // @[StatusCSR.scala 42:21:@913.4]
  wire  InterruptController_clock; // @[InterruptController.scala 63:22:@921.4]
  wire  InterruptController_reset; // @[InterruptController.scala 63:22:@921.4]
  wire  InterruptController_io_irq_readerDone; // @[InterruptController.scala 63:22:@921.4]
  wire  InterruptController_io_irq_writerDone; // @[InterruptController.scala 63:22:@921.4]
  wire  InterruptController_io_readBusy; // @[InterruptController.scala 63:22:@921.4]
  wire  InterruptController_io_writeBusy; // @[InterruptController.scala 63:22:@921.4]
  wire [31:0] InterruptController_io_imr_dataOut; // @[InterruptController.scala 63:22:@921.4]
  wire  InterruptController_io_imr_dataWrite; // @[InterruptController.scala 63:22:@921.4]
  wire [31:0] InterruptController_io_imr_dataIn; // @[InterruptController.scala 63:22:@921.4]
  wire [31:0] InterruptController_io_isr_dataOut; // @[InterruptController.scala 63:22:@921.4]
  wire  InterruptController_io_isr_dataWrite; // @[InterruptController.scala 63:22:@921.4]
  wire [31:0] InterruptController_io_isr_dataIn; // @[InterruptController.scala 63:22:@921.4]
  wire  SimpleCSR_clock; // @[SimpleCSR.scala 48:21:@951.4]
  wire  SimpleCSR_reset; // @[SimpleCSR.scala 48:21:@951.4]
  wire [31:0] SimpleCSR_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@951.4]
  wire  SimpleCSR_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@951.4]
  wire [31:0] SimpleCSR_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@951.4]
  wire [31:0] SimpleCSR_io_value; // @[SimpleCSR.scala 48:21:@951.4]
  wire  SimpleCSR_1_clock; // @[SimpleCSR.scala 48:21:@959.4]
  wire  SimpleCSR_1_reset; // @[SimpleCSR.scala 48:21:@959.4]
  wire [31:0] SimpleCSR_1_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@959.4]
  wire  SimpleCSR_1_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@959.4]
  wire [31:0] SimpleCSR_1_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@959.4]
  wire [31:0] SimpleCSR_1_io_value; // @[SimpleCSR.scala 48:21:@959.4]
  wire  SimpleCSR_2_clock; // @[SimpleCSR.scala 48:21:@967.4]
  wire  SimpleCSR_2_reset; // @[SimpleCSR.scala 48:21:@967.4]
  wire [31:0] SimpleCSR_2_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@967.4]
  wire  SimpleCSR_2_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@967.4]
  wire [31:0] SimpleCSR_2_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@967.4]
  wire [31:0] SimpleCSR_2_io_value; // @[SimpleCSR.scala 48:21:@967.4]
  wire  SimpleCSR_3_clock; // @[SimpleCSR.scala 48:21:@975.4]
  wire  SimpleCSR_3_reset; // @[SimpleCSR.scala 48:21:@975.4]
  wire [31:0] SimpleCSR_3_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@975.4]
  wire  SimpleCSR_3_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@975.4]
  wire [31:0] SimpleCSR_3_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@975.4]
  wire [31:0] SimpleCSR_3_io_value; // @[SimpleCSR.scala 48:21:@975.4]
  wire  SimpleCSR_4_clock; // @[SimpleCSR.scala 48:21:@984.4]
  wire  SimpleCSR_4_reset; // @[SimpleCSR.scala 48:21:@984.4]
  wire [31:0] SimpleCSR_4_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@984.4]
  wire  SimpleCSR_4_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@984.4]
  wire [31:0] SimpleCSR_4_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@984.4]
  wire [31:0] SimpleCSR_4_io_value; // @[SimpleCSR.scala 48:21:@984.4]
  wire  SimpleCSR_5_clock; // @[SimpleCSR.scala 48:21:@992.4]
  wire  SimpleCSR_5_reset; // @[SimpleCSR.scala 48:21:@992.4]
  wire [31:0] SimpleCSR_5_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@992.4]
  wire  SimpleCSR_5_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@992.4]
  wire [31:0] SimpleCSR_5_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@992.4]
  wire [31:0] SimpleCSR_5_io_value; // @[SimpleCSR.scala 48:21:@992.4]
  wire  SimpleCSR_6_clock; // @[SimpleCSR.scala 48:21:@1000.4]
  wire  SimpleCSR_6_reset; // @[SimpleCSR.scala 48:21:@1000.4]
  wire [31:0] SimpleCSR_6_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@1000.4]
  wire  SimpleCSR_6_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@1000.4]
  wire [31:0] SimpleCSR_6_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@1000.4]
  wire [31:0] SimpleCSR_6_io_value; // @[SimpleCSR.scala 48:21:@1000.4]
  wire  SimpleCSR_7_clock; // @[SimpleCSR.scala 48:21:@1008.4]
  wire  SimpleCSR_7_reset; // @[SimpleCSR.scala 48:21:@1008.4]
  wire [31:0] SimpleCSR_7_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@1008.4]
  wire  SimpleCSR_7_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@1008.4]
  wire [31:0] SimpleCSR_7_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@1008.4]
  wire [31:0] SimpleCSR_7_io_value; // @[SimpleCSR.scala 48:21:@1008.4]
  wire  SimpleCSR_8_clock; // @[SimpleCSR.scala 48:21:@1016.4]
  wire  SimpleCSR_8_reset; // @[SimpleCSR.scala 48:21:@1016.4]
  wire [31:0] SimpleCSR_8_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@1016.4]
  wire  SimpleCSR_8_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@1016.4]
  wire [31:0] SimpleCSR_8_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@1016.4]
  wire [31:0] SimpleCSR_8_io_value; // @[SimpleCSR.scala 48:21:@1016.4]
  wire  SimpleCSR_9_clock; // @[SimpleCSR.scala 48:21:@1023.4]
  wire  SimpleCSR_9_reset; // @[SimpleCSR.scala 48:21:@1023.4]
  wire [31:0] SimpleCSR_9_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@1023.4]
  wire  SimpleCSR_9_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@1023.4]
  wire [31:0] SimpleCSR_9_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@1023.4]
  wire [31:0] SimpleCSR_9_io_value; // @[SimpleCSR.scala 48:21:@1023.4]
  wire  SimpleCSR_10_clock; // @[SimpleCSR.scala 48:21:@1030.4]
  wire  SimpleCSR_10_reset; // @[SimpleCSR.scala 48:21:@1030.4]
  wire [31:0] SimpleCSR_10_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@1030.4]
  wire  SimpleCSR_10_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@1030.4]
  wire [31:0] SimpleCSR_10_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@1030.4]
  wire [31:0] SimpleCSR_10_io_value; // @[SimpleCSR.scala 48:21:@1030.4]
  wire  SimpleCSR_11_clock; // @[SimpleCSR.scala 48:21:@1037.4]
  wire  SimpleCSR_11_reset; // @[SimpleCSR.scala 48:21:@1037.4]
  wire [31:0] SimpleCSR_11_io_csr_dataOut; // @[SimpleCSR.scala 48:21:@1037.4]
  wire  SimpleCSR_11_io_csr_dataWrite; // @[SimpleCSR.scala 48:21:@1037.4]
  wire [31:0] SimpleCSR_11_io_csr_dataIn; // @[SimpleCSR.scala 48:21:@1037.4]
  wire [31:0] SimpleCSR_11_io_value; // @[SimpleCSR.scala 48:21:@1037.4]
  reg [1:0] status; // @[WorkerCSRWrapper.scala 47:23:@888.4]
  reg [31:0] _RAND_0;
  reg  readerSync; // @[WorkerCSRWrapper.scala 49:27:@890.4]
  reg [31:0] _RAND_1;
  reg  readerSyncOld; // @[WorkerCSRWrapper.scala 50:30:@892.4]
  reg [31:0] _RAND_2;
  reg  writerSync; // @[WorkerCSRWrapper.scala 52:27:@894.4]
  reg [31:0] _RAND_3;
  reg  writerSyncOld; // @[WorkerCSRWrapper.scala 53:30:@896.4]
  reg [31:0] _RAND_4;
  reg  readerStart; // @[WorkerCSRWrapper.scala 55:28:@898.4]
  reg [31:0] _RAND_5;
  reg  writerStart; // @[WorkerCSRWrapper.scala 56:28:@899.4]
  reg [31:0] _RAND_6;
  wire [1:0] clear; // @[Cat.scala 30:58:@901.4]
  wire  _T_201; // @[WorkerCSRWrapper.scala 68:20:@936.4]
  wire  _T_202; // @[WorkerCSRWrapper.scala 68:35:@937.4]
  wire [31:0] control; // @[WorkerCSRWrapper.scala 58:21:@900.4 WorkerCSRWrapper.scala 61:11:@912.4]
  wire  _T_203; // @[WorkerCSRWrapper.scala 68:60:@938.4]
  wire  _T_204; // @[WorkerCSRWrapper.scala 68:50:@939.4]
  wire  _T_205; // @[WorkerCSRWrapper.scala 68:75:@940.4]
  wire  _T_206; // @[WorkerCSRWrapper.scala 68:65:@941.4]
  wire  _T_208; // @[WorkerCSRWrapper.scala 69:20:@943.4]
  wire  _T_209; // @[WorkerCSRWrapper.scala 69:35:@944.4]
  wire  _T_210; // @[WorkerCSRWrapper.scala 69:60:@945.4]
  wire  _T_211; // @[WorkerCSRWrapper.scala 69:50:@946.4]
  wire  _T_212; // @[WorkerCSRWrapper.scala 69:75:@947.4]
  wire  _T_213; // @[WorkerCSRWrapper.scala 69:65:@948.4]
  AddressGenerator addressGeneratorRead ( // @[WorkerCSRWrapper.scala 41:36:@875.4]
    .clock(addressGeneratorRead_clock),
    .reset(addressGeneratorRead_reset),
    .io_ctl_start(addressGeneratorRead_io_ctl_start),
    .io_ctl_busy(addressGeneratorRead_io_ctl_busy),
    .io_ctl_startAddress(addressGeneratorRead_io_ctl_startAddress),
    .io_ctl_lineLength(addressGeneratorRead_io_ctl_lineLength),
    .io_ctl_lineCount(addressGeneratorRead_io_ctl_lineCount),
    .io_ctl_lineGap(addressGeneratorRead_io_ctl_lineGap),
    .io_xfer_done(addressGeneratorRead_io_xfer_done),
    .io_xfer_address(addressGeneratorRead_io_xfer_address),
    .io_xfer_length(addressGeneratorRead_io_xfer_length),
    .io_xfer_valid(addressGeneratorRead_io_xfer_valid)
  );
  TransferSplitter transferSplitterRead ( // @[WorkerCSRWrapper.scala 42:36:@878.4]
    .io_xferIn_done(transferSplitterRead_io_xferIn_done),
    .io_xferIn_address(transferSplitterRead_io_xferIn_address),
    .io_xferIn_length(transferSplitterRead_io_xferIn_length),
    .io_xferIn_valid(transferSplitterRead_io_xferIn_valid),
    .io_xferOut_done(transferSplitterRead_io_xferOut_done),
    .io_xferOut_address(transferSplitterRead_io_xferOut_address),
    .io_xferOut_length(transferSplitterRead_io_xferOut_length),
    .io_xferOut_valid(transferSplitterRead_io_xferOut_valid)
  );
  AddressGenerator addressGeneratorWrite ( // @[WorkerCSRWrapper.scala 44:37:@881.4]
    .clock(addressGeneratorWrite_clock),
    .reset(addressGeneratorWrite_reset),
    .io_ctl_start(addressGeneratorWrite_io_ctl_start),
    .io_ctl_busy(addressGeneratorWrite_io_ctl_busy),
    .io_ctl_startAddress(addressGeneratorWrite_io_ctl_startAddress),
    .io_ctl_lineLength(addressGeneratorWrite_io_ctl_lineLength),
    .io_ctl_lineCount(addressGeneratorWrite_io_ctl_lineCount),
    .io_ctl_lineGap(addressGeneratorWrite_io_ctl_lineGap),
    .io_xfer_done(addressGeneratorWrite_io_xfer_done),
    .io_xfer_address(addressGeneratorWrite_io_xfer_address),
    .io_xfer_length(addressGeneratorWrite_io_xfer_length),
    .io_xfer_valid(addressGeneratorWrite_io_xfer_valid)
  );
  TransferSplitter transferSplitterWrite ( // @[WorkerCSRWrapper.scala 45:37:@884.4]
    .io_xferIn_done(transferSplitterWrite_io_xferIn_done),
    .io_xferIn_address(transferSplitterWrite_io_xferIn_address),
    .io_xferIn_length(transferSplitterWrite_io_xferIn_length),
    .io_xferIn_valid(transferSplitterWrite_io_xferIn_valid),
    .io_xferOut_done(transferSplitterWrite_io_xferOut_done),
    .io_xferOut_address(transferSplitterWrite_io_xferOut_address),
    .io_xferOut_length(transferSplitterWrite_io_xferOut_length),
    .io_xferOut_valid(transferSplitterWrite_io_xferOut_valid)
  );
  ClearCSR ClearCSR ( // @[ClearCSR.scala 50:21:@904.4]
    .clock(ClearCSR_clock),
    .reset(ClearCSR_reset),
    .io_csr_dataOut(ClearCSR_io_csr_dataOut),
    .io_csr_dataWrite(ClearCSR_io_csr_dataWrite),
    .io_csr_dataIn(ClearCSR_io_csr_dataIn),
    .io_value(ClearCSR_io_value),
    .io_clear(ClearCSR_io_clear)
  );
  StatusCSR StatusCSR ( // @[StatusCSR.scala 42:21:@913.4]
    .clock(StatusCSR_clock),
    .io_csr_dataIn(StatusCSR_io_csr_dataIn),
    .io_value(StatusCSR_io_value)
  );
  InterruptController InterruptController ( // @[InterruptController.scala 63:22:@921.4]
    .clock(InterruptController_clock),
    .reset(InterruptController_reset),
    .io_irq_readerDone(InterruptController_io_irq_readerDone),
    .io_irq_writerDone(InterruptController_io_irq_writerDone),
    .io_readBusy(InterruptController_io_readBusy),
    .io_writeBusy(InterruptController_io_writeBusy),
    .io_imr_dataOut(InterruptController_io_imr_dataOut),
    .io_imr_dataWrite(InterruptController_io_imr_dataWrite),
    .io_imr_dataIn(InterruptController_io_imr_dataIn),
    .io_isr_dataOut(InterruptController_io_isr_dataOut),
    .io_isr_dataWrite(InterruptController_io_isr_dataWrite),
    .io_isr_dataIn(InterruptController_io_isr_dataIn)
  );
  SimpleCSR SimpleCSR ( // @[SimpleCSR.scala 48:21:@951.4]
    .clock(SimpleCSR_clock),
    .reset(SimpleCSR_reset),
    .io_csr_dataOut(SimpleCSR_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_io_csr_dataIn),
    .io_value(SimpleCSR_io_value)
  );
  SimpleCSR SimpleCSR_1 ( // @[SimpleCSR.scala 48:21:@959.4]
    .clock(SimpleCSR_1_clock),
    .reset(SimpleCSR_1_reset),
    .io_csr_dataOut(SimpleCSR_1_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_1_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_1_io_csr_dataIn),
    .io_value(SimpleCSR_1_io_value)
  );
  SimpleCSR SimpleCSR_2 ( // @[SimpleCSR.scala 48:21:@967.4]
    .clock(SimpleCSR_2_clock),
    .reset(SimpleCSR_2_reset),
    .io_csr_dataOut(SimpleCSR_2_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_2_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_2_io_csr_dataIn),
    .io_value(SimpleCSR_2_io_value)
  );
  SimpleCSR SimpleCSR_3 ( // @[SimpleCSR.scala 48:21:@975.4]
    .clock(SimpleCSR_3_clock),
    .reset(SimpleCSR_3_reset),
    .io_csr_dataOut(SimpleCSR_3_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_3_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_3_io_csr_dataIn),
    .io_value(SimpleCSR_3_io_value)
  );
  SimpleCSR SimpleCSR_4 ( // @[SimpleCSR.scala 48:21:@984.4]
    .clock(SimpleCSR_4_clock),
    .reset(SimpleCSR_4_reset),
    .io_csr_dataOut(SimpleCSR_4_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_4_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_4_io_csr_dataIn),
    .io_value(SimpleCSR_4_io_value)
  );
  SimpleCSR SimpleCSR_5 ( // @[SimpleCSR.scala 48:21:@992.4]
    .clock(SimpleCSR_5_clock),
    .reset(SimpleCSR_5_reset),
    .io_csr_dataOut(SimpleCSR_5_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_5_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_5_io_csr_dataIn),
    .io_value(SimpleCSR_5_io_value)
  );
  SimpleCSR SimpleCSR_6 ( // @[SimpleCSR.scala 48:21:@1000.4]
    .clock(SimpleCSR_6_clock),
    .reset(SimpleCSR_6_reset),
    .io_csr_dataOut(SimpleCSR_6_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_6_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_6_io_csr_dataIn),
    .io_value(SimpleCSR_6_io_value)
  );
  SimpleCSR SimpleCSR_7 ( // @[SimpleCSR.scala 48:21:@1008.4]
    .clock(SimpleCSR_7_clock),
    .reset(SimpleCSR_7_reset),
    .io_csr_dataOut(SimpleCSR_7_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_7_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_7_io_csr_dataIn),
    .io_value(SimpleCSR_7_io_value)
  );
  SimpleCSR SimpleCSR_8 ( // @[SimpleCSR.scala 48:21:@1016.4]
    .clock(SimpleCSR_8_clock),
    .reset(SimpleCSR_8_reset),
    .io_csr_dataOut(SimpleCSR_8_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_8_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_8_io_csr_dataIn),
    .io_value(SimpleCSR_8_io_value)
  );
  SimpleCSR SimpleCSR_9 ( // @[SimpleCSR.scala 48:21:@1023.4]
    .clock(SimpleCSR_9_clock),
    .reset(SimpleCSR_9_reset),
    .io_csr_dataOut(SimpleCSR_9_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_9_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_9_io_csr_dataIn),
    .io_value(SimpleCSR_9_io_value)
  );
  SimpleCSR SimpleCSR_10 ( // @[SimpleCSR.scala 48:21:@1030.4]
    .clock(SimpleCSR_10_clock),
    .reset(SimpleCSR_10_reset),
    .io_csr_dataOut(SimpleCSR_10_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_10_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_10_io_csr_dataIn),
    .io_value(SimpleCSR_10_io_value)
  );
  SimpleCSR SimpleCSR_11 ( // @[SimpleCSR.scala 48:21:@1037.4]
    .clock(SimpleCSR_11_clock),
    .reset(SimpleCSR_11_reset),
    .io_csr_dataOut(SimpleCSR_11_io_csr_dataOut),
    .io_csr_dataWrite(SimpleCSR_11_io_csr_dataWrite),
    .io_csr_dataIn(SimpleCSR_11_io_csr_dataIn),
    .io_value(SimpleCSR_11_io_value)
  );
  assign clear = {readerStart,writerStart}; // @[Cat.scala 30:58:@901.4]
  assign _T_201 = readerSyncOld == 1'h0; // @[WorkerCSRWrapper.scala 68:20:@936.4]
  assign _T_202 = _T_201 & readerSync; // @[WorkerCSRWrapper.scala 68:35:@937.4]
  assign control = ClearCSR_io_value; // @[WorkerCSRWrapper.scala 58:21:@900.4 WorkerCSRWrapper.scala 61:11:@912.4]
  assign _T_203 = control[3]; // @[WorkerCSRWrapper.scala 68:60:@938.4]
  assign _T_204 = _T_202 | _T_203; // @[WorkerCSRWrapper.scala 68:50:@939.4]
  assign _T_205 = control[1]; // @[WorkerCSRWrapper.scala 68:75:@940.4]
  assign _T_206 = _T_204 & _T_205; // @[WorkerCSRWrapper.scala 68:65:@941.4]
  assign _T_208 = writerSyncOld == 1'h0; // @[WorkerCSRWrapper.scala 69:20:@943.4]
  assign _T_209 = _T_208 & writerSync; // @[WorkerCSRWrapper.scala 69:35:@944.4]
  assign _T_210 = control[2]; // @[WorkerCSRWrapper.scala 69:60:@945.4]
  assign _T_211 = _T_209 | _T_210; // @[WorkerCSRWrapper.scala 69:50:@946.4]
  assign _T_212 = control[0]; // @[WorkerCSRWrapper.scala 69:75:@947.4]
  assign _T_213 = _T_211 & _T_212; // @[WorkerCSRWrapper.scala 69:65:@948.4]
  assign io_csr_0_dataIn = ClearCSR_io_csr_dataIn; // @[ClearCSR.scala 54:16:@908.4]
  assign io_csr_1_dataIn = StatusCSR_io_csr_dataIn; // @[StatusCSR.scala 44:16:@916.4]
  assign io_csr_2_dataIn = InterruptController_io_imr_dataIn; // @[InterruptController.scala 68:17:@926.4]
  assign io_csr_3_dataIn = InterruptController_io_isr_dataIn; // @[InterruptController.scala 69:17:@930.4]
  assign io_csr_4_dataIn = SimpleCSR_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@954.4]
  assign io_csr_5_dataIn = SimpleCSR_1_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@962.4]
  assign io_csr_6_dataIn = SimpleCSR_2_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@970.4]
  assign io_csr_7_dataIn = SimpleCSR_3_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@978.4]
  assign io_csr_8_dataIn = SimpleCSR_4_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@987.4]
  assign io_csr_9_dataIn = SimpleCSR_5_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@995.4]
  assign io_csr_10_dataIn = SimpleCSR_6_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@1003.4]
  assign io_csr_11_dataIn = SimpleCSR_7_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@1011.4]
  assign io_csr_12_dataIn = SimpleCSR_8_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@1019.4]
  assign io_csr_13_dataIn = SimpleCSR_9_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@1026.4]
  assign io_csr_14_dataIn = SimpleCSR_10_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@1033.4]
  assign io_csr_15_dataIn = SimpleCSR_11_io_csr_dataIn; // @[SimpleCSR.scala 50:16:@1040.4]
  assign io_irq_readerDone = InterruptController_io_irq_readerDone; // @[WorkerCSRWrapper.scala 65:10:@935.4]
  assign io_irq_writerDone = InterruptController_io_irq_writerDone; // @[WorkerCSRWrapper.scala 65:10:@934.4]
  assign io_xferRead_address = transferSplitterRead_io_xferOut_address; // @[WorkerCSRWrapper.scala 88:15:@1050.4]
  assign io_xferRead_length = transferSplitterRead_io_xferOut_length; // @[WorkerCSRWrapper.scala 88:15:@1049.4]
  assign io_xferRead_valid = transferSplitterRead_io_xferOut_valid; // @[WorkerCSRWrapper.scala 88:15:@1048.4]
  assign io_xferWrite_address = transferSplitterWrite_io_xferOut_address; // @[WorkerCSRWrapper.scala 91:16:@1058.4]
  assign io_xferWrite_length = transferSplitterWrite_io_xferOut_length; // @[WorkerCSRWrapper.scala 91:16:@1057.4]
  assign io_xferWrite_valid = transferSplitterWrite_io_xferOut_valid; // @[WorkerCSRWrapper.scala 91:16:@1056.4]
  assign addressGeneratorRead_clock = clock; // @[:@876.4]
  assign addressGeneratorRead_reset = reset; // @[:@877.4]
  assign addressGeneratorRead_io_ctl_start = readerStart; // @[WorkerCSRWrapper.scala 71:37:@950.4]
  assign addressGeneratorRead_io_ctl_startAddress = SimpleCSR_io_value; // @[WorkerCSRWrapper.scala 72:44:@958.4]
  assign addressGeneratorRead_io_ctl_lineLength = SimpleCSR_1_io_value; // @[WorkerCSRWrapper.scala 73:42:@966.4]
  assign addressGeneratorRead_io_ctl_lineCount = SimpleCSR_2_io_value; // @[WorkerCSRWrapper.scala 74:41:@974.4]
  assign addressGeneratorRead_io_ctl_lineGap = SimpleCSR_3_io_value; // @[WorkerCSRWrapper.scala 75:39:@982.4]
  assign addressGeneratorRead_io_xfer_done = transferSplitterRead_io_xferIn_done; // @[WorkerCSRWrapper.scala 87:34:@1047.4]
  assign transferSplitterRead_io_xferIn_address = addressGeneratorRead_io_xfer_address; // @[WorkerCSRWrapper.scala 87:34:@1046.4]
  assign transferSplitterRead_io_xferIn_length = addressGeneratorRead_io_xfer_length; // @[WorkerCSRWrapper.scala 87:34:@1045.4]
  assign transferSplitterRead_io_xferIn_valid = addressGeneratorRead_io_xfer_valid; // @[WorkerCSRWrapper.scala 87:34:@1044.4]
  assign transferSplitterRead_io_xferOut_done = io_xferRead_done; // @[WorkerCSRWrapper.scala 88:15:@1051.4]
  assign addressGeneratorWrite_clock = clock; // @[:@882.4]
  assign addressGeneratorWrite_reset = reset; // @[:@883.4]
  assign addressGeneratorWrite_io_ctl_start = writerStart; // @[WorkerCSRWrapper.scala 77:38:@983.4]
  assign addressGeneratorWrite_io_ctl_startAddress = SimpleCSR_4_io_value; // @[WorkerCSRWrapper.scala 78:45:@991.4]
  assign addressGeneratorWrite_io_ctl_lineLength = SimpleCSR_5_io_value; // @[WorkerCSRWrapper.scala 79:43:@999.4]
  assign addressGeneratorWrite_io_ctl_lineCount = SimpleCSR_6_io_value; // @[WorkerCSRWrapper.scala 80:42:@1007.4]
  assign addressGeneratorWrite_io_ctl_lineGap = SimpleCSR_7_io_value; // @[WorkerCSRWrapper.scala 81:40:@1015.4]
  assign addressGeneratorWrite_io_xfer_done = transferSplitterWrite_io_xferIn_done; // @[WorkerCSRWrapper.scala 90:35:@1055.4]
  assign transferSplitterWrite_io_xferIn_address = addressGeneratorWrite_io_xfer_address; // @[WorkerCSRWrapper.scala 90:35:@1054.4]
  assign transferSplitterWrite_io_xferIn_length = addressGeneratorWrite_io_xfer_length; // @[WorkerCSRWrapper.scala 90:35:@1053.4]
  assign transferSplitterWrite_io_xferIn_valid = addressGeneratorWrite_io_xfer_valid; // @[WorkerCSRWrapper.scala 90:35:@1052.4]
  assign transferSplitterWrite_io_xferOut_done = io_xferWrite_done; // @[WorkerCSRWrapper.scala 91:16:@1059.4]
  assign ClearCSR_clock = clock; // @[:@905.4]
  assign ClearCSR_reset = reset; // @[:@906.4]
  assign ClearCSR_io_csr_dataOut = io_csr_0_dataOut; // @[ClearCSR.scala 54:16:@910.4]
  assign ClearCSR_io_csr_dataWrite = io_csr_0_dataWrite; // @[ClearCSR.scala 54:16:@909.4]
  assign ClearCSR_io_clear = {{30'd0}, clear}; // @[ClearCSR.scala 52:18:@907.4]
  assign StatusCSR_clock = clock; // @[:@914.4]
  assign StatusCSR_io_value = {{30'd0}, status}; // @[StatusCSR.scala 46:18:@920.4]
  assign InterruptController_clock = clock; // @[:@922.4]
  assign InterruptController_reset = reset; // @[:@923.4]
  assign InterruptController_io_readBusy = addressGeneratorRead_io_ctl_busy; // @[InterruptController.scala 65:22:@924.4]
  assign InterruptController_io_writeBusy = addressGeneratorWrite_io_ctl_busy; // @[InterruptController.scala 66:23:@925.4]
  assign InterruptController_io_imr_dataOut = io_csr_2_dataOut; // @[InterruptController.scala 68:17:@928.4]
  assign InterruptController_io_imr_dataWrite = io_csr_2_dataWrite; // @[InterruptController.scala 68:17:@927.4]
  assign InterruptController_io_isr_dataOut = io_csr_3_dataOut; // @[InterruptController.scala 69:17:@932.4]
  assign InterruptController_io_isr_dataWrite = io_csr_3_dataWrite; // @[InterruptController.scala 69:17:@931.4]
  assign SimpleCSR_clock = clock; // @[:@952.4]
  assign SimpleCSR_reset = reset; // @[:@953.4]
  assign SimpleCSR_io_csr_dataOut = io_csr_4_dataOut; // @[SimpleCSR.scala 50:16:@956.4]
  assign SimpleCSR_io_csr_dataWrite = io_csr_4_dataWrite; // @[SimpleCSR.scala 50:16:@955.4]
  assign SimpleCSR_1_clock = clock; // @[:@960.4]
  assign SimpleCSR_1_reset = reset; // @[:@961.4]
  assign SimpleCSR_1_io_csr_dataOut = io_csr_5_dataOut; // @[SimpleCSR.scala 50:16:@964.4]
  assign SimpleCSR_1_io_csr_dataWrite = io_csr_5_dataWrite; // @[SimpleCSR.scala 50:16:@963.4]
  assign SimpleCSR_2_clock = clock; // @[:@968.4]
  assign SimpleCSR_2_reset = reset; // @[:@969.4]
  assign SimpleCSR_2_io_csr_dataOut = io_csr_6_dataOut; // @[SimpleCSR.scala 50:16:@972.4]
  assign SimpleCSR_2_io_csr_dataWrite = io_csr_6_dataWrite; // @[SimpleCSR.scala 50:16:@971.4]
  assign SimpleCSR_3_clock = clock; // @[:@976.4]
  assign SimpleCSR_3_reset = reset; // @[:@977.4]
  assign SimpleCSR_3_io_csr_dataOut = io_csr_7_dataOut; // @[SimpleCSR.scala 50:16:@980.4]
  assign SimpleCSR_3_io_csr_dataWrite = io_csr_7_dataWrite; // @[SimpleCSR.scala 50:16:@979.4]
  assign SimpleCSR_4_clock = clock; // @[:@985.4]
  assign SimpleCSR_4_reset = reset; // @[:@986.4]
  assign SimpleCSR_4_io_csr_dataOut = io_csr_8_dataOut; // @[SimpleCSR.scala 50:16:@989.4]
  assign SimpleCSR_4_io_csr_dataWrite = io_csr_8_dataWrite; // @[SimpleCSR.scala 50:16:@988.4]
  assign SimpleCSR_5_clock = clock; // @[:@993.4]
  assign SimpleCSR_5_reset = reset; // @[:@994.4]
  assign SimpleCSR_5_io_csr_dataOut = io_csr_9_dataOut; // @[SimpleCSR.scala 50:16:@997.4]
  assign SimpleCSR_5_io_csr_dataWrite = io_csr_9_dataWrite; // @[SimpleCSR.scala 50:16:@996.4]
  assign SimpleCSR_6_clock = clock; // @[:@1001.4]
  assign SimpleCSR_6_reset = reset; // @[:@1002.4]
  assign SimpleCSR_6_io_csr_dataOut = io_csr_10_dataOut; // @[SimpleCSR.scala 50:16:@1005.4]
  assign SimpleCSR_6_io_csr_dataWrite = io_csr_10_dataWrite; // @[SimpleCSR.scala 50:16:@1004.4]
  assign SimpleCSR_7_clock = clock; // @[:@1009.4]
  assign SimpleCSR_7_reset = reset; // @[:@1010.4]
  assign SimpleCSR_7_io_csr_dataOut = io_csr_11_dataOut; // @[SimpleCSR.scala 50:16:@1013.4]
  assign SimpleCSR_7_io_csr_dataWrite = io_csr_11_dataWrite; // @[SimpleCSR.scala 50:16:@1012.4]
  assign SimpleCSR_8_clock = clock; // @[:@1017.4]
  assign SimpleCSR_8_reset = reset; // @[:@1018.4]
  assign SimpleCSR_8_io_csr_dataOut = io_csr_12_dataOut; // @[SimpleCSR.scala 50:16:@1021.4]
  assign SimpleCSR_8_io_csr_dataWrite = io_csr_12_dataWrite; // @[SimpleCSR.scala 50:16:@1020.4]
  assign SimpleCSR_9_clock = clock; // @[:@1024.4]
  assign SimpleCSR_9_reset = reset; // @[:@1025.4]
  assign SimpleCSR_9_io_csr_dataOut = io_csr_13_dataOut; // @[SimpleCSR.scala 50:16:@1028.4]
  assign SimpleCSR_9_io_csr_dataWrite = io_csr_13_dataWrite; // @[SimpleCSR.scala 50:16:@1027.4]
  assign SimpleCSR_10_clock = clock; // @[:@1031.4]
  assign SimpleCSR_10_reset = reset; // @[:@1032.4]
  assign SimpleCSR_10_io_csr_dataOut = io_csr_14_dataOut; // @[SimpleCSR.scala 50:16:@1035.4]
  assign SimpleCSR_10_io_csr_dataWrite = io_csr_14_dataWrite; // @[SimpleCSR.scala 50:16:@1034.4]
  assign SimpleCSR_11_clock = clock; // @[:@1038.4]
  assign SimpleCSR_11_reset = reset; // @[:@1039.4]
  assign SimpleCSR_11_io_csr_dataOut = io_csr_15_dataOut; // @[SimpleCSR.scala 50:16:@1042.4]
  assign SimpleCSR_11_io_csr_dataWrite = io_csr_15_dataWrite; // @[SimpleCSR.scala 50:16:@1041.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  status = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  readerSync = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  readerSyncOld = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  writerSync = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  writerSyncOld = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  readerStart = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  writerStart = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    status <= {addressGeneratorRead_io_ctl_busy,addressGeneratorWrite_io_ctl_busy};
    readerSync <= io_sync_readerSync;
    readerSyncOld <= readerSync;
    writerSync <= io_sync_writerSync;
    writerSyncOld <= writerSync;
    if (reset) begin
      readerStart <= 1'h0;
    end else begin
      readerStart <= _T_206;
    end
    if (reset) begin
      writerStart <= 1'h0;
    end else begin
      writerStart <= _T_213;
    end
  end
endmodule
module Queue( // @[:@1061.2]
  input         clock, // @[:@1062.4]
  input         reset, // @[:@1063.4]
  output        io_enq_ready, // @[:@1064.4]
  input         io_enq_valid, // @[:@1064.4]
  input  [31:0] io_enq_bits, // @[:@1064.4]
  input         io_deq_ready, // @[:@1064.4]
  output        io_deq_valid, // @[:@1064.4]
  output [31:0] io_deq_bits // @[:@1064.4]
);
  reg [31:0] ram [0:511]; // @[Decoupled.scala 215:24:@1066.4]
  reg [31:0] _RAND_0;
  wire [31:0] ram__T_63_data; // @[Decoupled.scala 215:24:@1066.4]
  wire [8:0] ram__T_63_addr; // @[Decoupled.scala 215:24:@1066.4]
  wire [31:0] ram__T_49_data; // @[Decoupled.scala 215:24:@1066.4]
  wire [8:0] ram__T_49_addr; // @[Decoupled.scala 215:24:@1066.4]
  wire  ram__T_49_mask; // @[Decoupled.scala 215:24:@1066.4]
  wire  ram__T_49_en; // @[Decoupled.scala 215:24:@1066.4]
  reg [8:0] value; // @[Counter.scala 26:33:@1067.4]
  reg [31:0] _RAND_1;
  reg [8:0] value_1; // @[Counter.scala 26:33:@1068.4]
  reg [31:0] _RAND_2;
  reg  maybe_full; // @[Decoupled.scala 218:35:@1069.4]
  reg [31:0] _RAND_3;
  wire  _T_41; // @[Decoupled.scala 220:41:@1070.4]
  wire  _T_43; // @[Decoupled.scala 221:36:@1071.4]
  wire  empty; // @[Decoupled.scala 221:33:@1072.4]
  wire  _T_44; // @[Decoupled.scala 222:32:@1073.4]
  wire  do_enq; // @[Decoupled.scala 37:37:@1074.4]
  wire  do_deq; // @[Decoupled.scala 37:37:@1077.4]
  wire [9:0] _T_52; // @[Counter.scala 35:22:@1084.6]
  wire [8:0] _T_53; // @[Counter.scala 35:22:@1085.6]
  wire [8:0] _GEN_5; // @[Decoupled.scala 226:17:@1080.4]
  wire [9:0] _T_56; // @[Counter.scala 35:22:@1090.6]
  wire [8:0] _T_57; // @[Counter.scala 35:22:@1091.6]
  wire [8:0] _GEN_6; // @[Decoupled.scala 230:17:@1088.4]
  wire  _T_58; // @[Decoupled.scala 233:16:@1094.4]
  wire  _GEN_7; // @[Decoupled.scala 233:28:@1095.4]
  assign ram__T_63_addr = value_1;
  assign ram__T_63_data = ram[ram__T_63_addr]; // @[Decoupled.scala 215:24:@1066.4]
  assign ram__T_49_data = io_enq_bits;
  assign ram__T_49_addr = value;
  assign ram__T_49_mask = 1'h1;
  assign ram__T_49_en = io_enq_ready & io_enq_valid;
  assign _T_41 = value == value_1; // @[Decoupled.scala 220:41:@1070.4]
  assign _T_43 = maybe_full == 1'h0; // @[Decoupled.scala 221:36:@1071.4]
  assign empty = _T_41 & _T_43; // @[Decoupled.scala 221:33:@1072.4]
  assign _T_44 = _T_41 & maybe_full; // @[Decoupled.scala 222:32:@1073.4]
  assign do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 37:37:@1074.4]
  assign do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 37:37:@1077.4]
  assign _T_52 = value + 9'h1; // @[Counter.scala 35:22:@1084.6]
  assign _T_53 = value + 9'h1; // @[Counter.scala 35:22:@1085.6]
  assign _GEN_5 = do_enq ? _T_53 : value; // @[Decoupled.scala 226:17:@1080.4]
  assign _T_56 = value_1 + 9'h1; // @[Counter.scala 35:22:@1090.6]
  assign _T_57 = value_1 + 9'h1; // @[Counter.scala 35:22:@1091.6]
  assign _GEN_6 = do_deq ? _T_57 : value_1; // @[Decoupled.scala 230:17:@1088.4]
  assign _T_58 = do_enq != do_deq; // @[Decoupled.scala 233:16:@1094.4]
  assign _GEN_7 = _T_58 ? do_enq : maybe_full; // @[Decoupled.scala 233:28:@1095.4]
  assign io_enq_ready = _T_44 == 1'h0; // @[Decoupled.scala 238:16:@1101.4]
  assign io_deq_valid = empty == 1'h0; // @[Decoupled.scala 237:16:@1099.4]
  assign io_deq_bits = ram__T_63_data; // @[Decoupled.scala 239:15:@1103.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 512; initvar = initvar+1)
    ram[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[8:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  value_1 = _RAND_2[8:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_49_en & ram__T_49_mask) begin
      ram[ram__T_49_addr] <= ram__T_49_data; // @[Decoupled.scala 215:24:@1066.4]
    end
    if (reset) begin
      value <= 9'h0;
    end else begin
      if (do_enq) begin
        value <= _T_53;
      end
    end
    if (reset) begin
      value_1 <= 9'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_57;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_58) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module DMATop( // @[:@1112.2]
  input         clock, // @[:@1113.4]
  input         reset, // @[:@1114.4]
  input  [31:0] io_control_dat_i, // @[:@1115.4]
  output [31:0] io_control_dat_o, // @[:@1115.4]
  input         io_control_cyc_i, // @[:@1115.4]
  input         io_control_stb_i, // @[:@1115.4]
  input         io_control_we_i, // @[:@1115.4]
  input  [31:0] io_control_adr_i, // @[:@1115.4]
  input  [3:0]  io_control_sel_i, // @[:@1115.4]
  output        io_control_ack_o, // @[:@1115.4]
  output        io_control_stall_o, // @[:@1115.4]
  output        io_control_err_o, // @[:@1115.4]
  input  [31:0] io_read_dat_i, // @[:@1115.4]
  output [31:0] io_read_dat_o, // @[:@1115.4]
  output        io_read_cyc_o, // @[:@1115.4]
  output        io_read_stb_o, // @[:@1115.4]
  output        io_read_we_o, // @[:@1115.4]
  output [31:0] io_read_adr_o, // @[:@1115.4]
  output [3:0]  io_read_sel_o, // @[:@1115.4]
  input         io_read_ack_i, // @[:@1115.4]
  input         io_read_stall_i, // @[:@1115.4]
  input         io_read_err_i, // @[:@1115.4]
  input  [31:0] io_write_dat_i, // @[:@1115.4]
  output [31:0] io_write_dat_o, // @[:@1115.4]
  output        io_write_cyc_o, // @[:@1115.4]
  output        io_write_stb_o, // @[:@1115.4]
  output        io_write_we_o, // @[:@1115.4]
  output [31:0] io_write_adr_o, // @[:@1115.4]
  output [3:0]  io_write_sel_o, // @[:@1115.4]
  input         io_write_ack_i, // @[:@1115.4]
  input         io_write_stall_i, // @[:@1115.4]
  input         io_write_err_i, // @[:@1115.4]
  output        io_irq_readerDone, // @[:@1115.4]
  output        io_irq_writerDone, // @[:@1115.4]
  input         io_sync_readerSync, // @[:@1115.4]
  input         io_sync_writerSync // @[:@1115.4]
);
  wire [31:0] csrFrontend_io_ctl_dat_i; // @[DMATop.scala 42:27:@1117.4]
  wire [31:0] csrFrontend_io_ctl_dat_o; // @[DMATop.scala 42:27:@1117.4]
  wire  csrFrontend_io_ctl_stb_i; // @[DMATop.scala 42:27:@1117.4]
  wire  csrFrontend_io_ctl_we_i; // @[DMATop.scala 42:27:@1117.4]
  wire [31:0] csrFrontend_io_ctl_adr_i; // @[DMATop.scala 42:27:@1117.4]
  wire  csrFrontend_io_ctl_ack_o; // @[DMATop.scala 42:27:@1117.4]
  wire [3:0] csrFrontend_io_bus_addr; // @[DMATop.scala 42:27:@1117.4]
  wire [31:0] csrFrontend_io_bus_dataOut; // @[DMATop.scala 42:27:@1117.4]
  wire [31:0] csrFrontend_io_bus_dataIn; // @[DMATop.scala 42:27:@1117.4]
  wire  csrFrontend_io_bus_write; // @[DMATop.scala 42:27:@1117.4]
  wire  csrFrontend_io_bus_read; // @[DMATop.scala 42:27:@1117.4]
  wire  readerFrontend_clock; // @[DMATop.scala 44:30:@1120.4]
  wire  readerFrontend_reset; // @[DMATop.scala 44:30:@1120.4]
  wire [31:0] readerFrontend_io_bus_dat_i; // @[DMATop.scala 44:30:@1120.4]
  wire  readerFrontend_io_bus_cyc_o; // @[DMATop.scala 44:30:@1120.4]
  wire  readerFrontend_io_bus_stb_o; // @[DMATop.scala 44:30:@1120.4]
  wire [31:0] readerFrontend_io_bus_adr_o; // @[DMATop.scala 44:30:@1120.4]
  wire  readerFrontend_io_bus_ack_i; // @[DMATop.scala 44:30:@1120.4]
  wire  readerFrontend_io_dataOut_ready; // @[DMATop.scala 44:30:@1120.4]
  wire  readerFrontend_io_dataOut_valid; // @[DMATop.scala 44:30:@1120.4]
  wire [31:0] readerFrontend_io_dataOut_bits; // @[DMATop.scala 44:30:@1120.4]
  wire  readerFrontend_io_xfer_done; // @[DMATop.scala 44:30:@1120.4]
  wire [31:0] readerFrontend_io_xfer_address; // @[DMATop.scala 44:30:@1120.4]
  wire [31:0] readerFrontend_io_xfer_length; // @[DMATop.scala 44:30:@1120.4]
  wire  readerFrontend_io_xfer_valid; // @[DMATop.scala 44:30:@1120.4]
  wire  writerFrontend_clock; // @[DMATop.scala 46:30:@1123.4]
  wire  writerFrontend_reset; // @[DMATop.scala 46:30:@1123.4]
  wire [31:0] writerFrontend_io_bus_dat_o; // @[DMATop.scala 46:30:@1123.4]
  wire  writerFrontend_io_bus_cyc_o; // @[DMATop.scala 46:30:@1123.4]
  wire  writerFrontend_io_bus_stb_o; // @[DMATop.scala 46:30:@1123.4]
  wire [31:0] writerFrontend_io_bus_adr_o; // @[DMATop.scala 46:30:@1123.4]
  wire  writerFrontend_io_bus_ack_i; // @[DMATop.scala 46:30:@1123.4]
  wire  writerFrontend_io_dataIn_ready; // @[DMATop.scala 46:30:@1123.4]
  wire  writerFrontend_io_dataIn_valid; // @[DMATop.scala 46:30:@1123.4]
  wire [31:0] writerFrontend_io_dataIn_bits; // @[DMATop.scala 46:30:@1123.4]
  wire  writerFrontend_io_xfer_done; // @[DMATop.scala 46:30:@1123.4]
  wire [31:0] writerFrontend_io_xfer_address; // @[DMATop.scala 46:30:@1123.4]
  wire [31:0] writerFrontend_io_xfer_length; // @[DMATop.scala 46:30:@1123.4]
  wire  writerFrontend_io_xfer_valid; // @[DMATop.scala 46:30:@1123.4]
  wire [31:0] csr_io_csr_0_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_0_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_0_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_1_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_2_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_2_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_2_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_3_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_3_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_3_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_4_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_4_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_4_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_5_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_5_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_5_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_6_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_6_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_6_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_7_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_7_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_7_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_8_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_8_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_8_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_9_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_9_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_9_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_10_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_10_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_10_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_11_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_11_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_11_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_12_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_12_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_12_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_13_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_13_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_13_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_14_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_14_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_14_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_15_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_csr_15_dataWrite; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_csr_15_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire [3:0] csr_io_bus_addr; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_bus_dataOut; // @[DMATop.scala 48:19:@1126.4]
  wire [31:0] csr_io_bus_dataIn; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_bus_write; // @[DMATop.scala 48:19:@1126.4]
  wire  csr_io_bus_read; // @[DMATop.scala 48:19:@1126.4]
  wire  ctl_clock; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_reset; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_0_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_0_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_0_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_1_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_2_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_2_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_2_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_3_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_3_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_3_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_4_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_4_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_4_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_5_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_5_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_5_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_6_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_6_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_6_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_7_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_7_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_7_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_8_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_8_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_8_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_9_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_9_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_9_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_10_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_10_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_10_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_11_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_11_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_11_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_12_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_12_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_12_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_13_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_13_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_13_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_14_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_14_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_14_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_15_dataOut; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_csr_15_dataWrite; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_csr_15_dataIn; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_irq_readerDone; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_irq_writerDone; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_sync_readerSync; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_sync_writerSync; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_xferRead_done; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_xferRead_address; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_xferRead_length; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_xferRead_valid; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_xferWrite_done; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_xferWrite_address; // @[DMATop.scala 50:19:@1129.4]
  wire [31:0] ctl_io_xferWrite_length; // @[DMATop.scala 50:19:@1129.4]
  wire  ctl_io_xferWrite_valid; // @[DMATop.scala 50:19:@1129.4]
  wire  queue_clock; // @[Decoupled.scala 294:21:@1132.4]
  wire  queue_reset; // @[Decoupled.scala 294:21:@1132.4]
  wire  queue_io_enq_ready; // @[Decoupled.scala 294:21:@1132.4]
  wire  queue_io_enq_valid; // @[Decoupled.scala 294:21:@1132.4]
  wire [31:0] queue_io_enq_bits; // @[Decoupled.scala 294:21:@1132.4]
  wire  queue_io_deq_ready; // @[Decoupled.scala 294:21:@1132.4]
  wire  queue_io_deq_valid; // @[Decoupled.scala 294:21:@1132.4]
  wire [31:0] queue_io_deq_bits; // @[Decoupled.scala 294:21:@1132.4]
  WishboneCSR csrFrontend ( // @[DMATop.scala 42:27:@1117.4]
    .io_ctl_dat_i(csrFrontend_io_ctl_dat_i),
    .io_ctl_dat_o(csrFrontend_io_ctl_dat_o),
    .io_ctl_stb_i(csrFrontend_io_ctl_stb_i),
    .io_ctl_we_i(csrFrontend_io_ctl_we_i),
    .io_ctl_adr_i(csrFrontend_io_ctl_adr_i),
    .io_ctl_ack_o(csrFrontend_io_ctl_ack_o),
    .io_bus_addr(csrFrontend_io_bus_addr),
    .io_bus_dataOut(csrFrontend_io_bus_dataOut),
    .io_bus_dataIn(csrFrontend_io_bus_dataIn),
    .io_bus_write(csrFrontend_io_bus_write),
    .io_bus_read(csrFrontend_io_bus_read)
  );
  WishboneClassicReader readerFrontend ( // @[DMATop.scala 44:30:@1120.4]
    .clock(readerFrontend_clock),
    .reset(readerFrontend_reset),
    .io_bus_dat_i(readerFrontend_io_bus_dat_i),
    .io_bus_cyc_o(readerFrontend_io_bus_cyc_o),
    .io_bus_stb_o(readerFrontend_io_bus_stb_o),
    .io_bus_adr_o(readerFrontend_io_bus_adr_o),
    .io_bus_ack_i(readerFrontend_io_bus_ack_i),
    .io_dataOut_ready(readerFrontend_io_dataOut_ready),
    .io_dataOut_valid(readerFrontend_io_dataOut_valid),
    .io_dataOut_bits(readerFrontend_io_dataOut_bits),
    .io_xfer_done(readerFrontend_io_xfer_done),
    .io_xfer_address(readerFrontend_io_xfer_address),
    .io_xfer_length(readerFrontend_io_xfer_length),
    .io_xfer_valid(readerFrontend_io_xfer_valid)
  );
  WishboneClassicWriter writerFrontend ( // @[DMATop.scala 46:30:@1123.4]
    .clock(writerFrontend_clock),
    .reset(writerFrontend_reset),
    .io_bus_dat_o(writerFrontend_io_bus_dat_o),
    .io_bus_cyc_o(writerFrontend_io_bus_cyc_o),
    .io_bus_stb_o(writerFrontend_io_bus_stb_o),
    .io_bus_adr_o(writerFrontend_io_bus_adr_o),
    .io_bus_ack_i(writerFrontend_io_bus_ack_i),
    .io_dataIn_ready(writerFrontend_io_dataIn_ready),
    .io_dataIn_valid(writerFrontend_io_dataIn_valid),
    .io_dataIn_bits(writerFrontend_io_dataIn_bits),
    .io_xfer_done(writerFrontend_io_xfer_done),
    .io_xfer_address(writerFrontend_io_xfer_address),
    .io_xfer_length(writerFrontend_io_xfer_length),
    .io_xfer_valid(writerFrontend_io_xfer_valid)
  );
  CSR csr ( // @[DMATop.scala 48:19:@1126.4]
    .io_csr_0_dataOut(csr_io_csr_0_dataOut),
    .io_csr_0_dataWrite(csr_io_csr_0_dataWrite),
    .io_csr_0_dataIn(csr_io_csr_0_dataIn),
    .io_csr_1_dataIn(csr_io_csr_1_dataIn),
    .io_csr_2_dataOut(csr_io_csr_2_dataOut),
    .io_csr_2_dataWrite(csr_io_csr_2_dataWrite),
    .io_csr_2_dataIn(csr_io_csr_2_dataIn),
    .io_csr_3_dataOut(csr_io_csr_3_dataOut),
    .io_csr_3_dataWrite(csr_io_csr_3_dataWrite),
    .io_csr_3_dataIn(csr_io_csr_3_dataIn),
    .io_csr_4_dataOut(csr_io_csr_4_dataOut),
    .io_csr_4_dataWrite(csr_io_csr_4_dataWrite),
    .io_csr_4_dataIn(csr_io_csr_4_dataIn),
    .io_csr_5_dataOut(csr_io_csr_5_dataOut),
    .io_csr_5_dataWrite(csr_io_csr_5_dataWrite),
    .io_csr_5_dataIn(csr_io_csr_5_dataIn),
    .io_csr_6_dataOut(csr_io_csr_6_dataOut),
    .io_csr_6_dataWrite(csr_io_csr_6_dataWrite),
    .io_csr_6_dataIn(csr_io_csr_6_dataIn),
    .io_csr_7_dataOut(csr_io_csr_7_dataOut),
    .io_csr_7_dataWrite(csr_io_csr_7_dataWrite),
    .io_csr_7_dataIn(csr_io_csr_7_dataIn),
    .io_csr_8_dataOut(csr_io_csr_8_dataOut),
    .io_csr_8_dataWrite(csr_io_csr_8_dataWrite),
    .io_csr_8_dataIn(csr_io_csr_8_dataIn),
    .io_csr_9_dataOut(csr_io_csr_9_dataOut),
    .io_csr_9_dataWrite(csr_io_csr_9_dataWrite),
    .io_csr_9_dataIn(csr_io_csr_9_dataIn),
    .io_csr_10_dataOut(csr_io_csr_10_dataOut),
    .io_csr_10_dataWrite(csr_io_csr_10_dataWrite),
    .io_csr_10_dataIn(csr_io_csr_10_dataIn),
    .io_csr_11_dataOut(csr_io_csr_11_dataOut),
    .io_csr_11_dataWrite(csr_io_csr_11_dataWrite),
    .io_csr_11_dataIn(csr_io_csr_11_dataIn),
    .io_csr_12_dataOut(csr_io_csr_12_dataOut),
    .io_csr_12_dataWrite(csr_io_csr_12_dataWrite),
    .io_csr_12_dataIn(csr_io_csr_12_dataIn),
    .io_csr_13_dataOut(csr_io_csr_13_dataOut),
    .io_csr_13_dataWrite(csr_io_csr_13_dataWrite),
    .io_csr_13_dataIn(csr_io_csr_13_dataIn),
    .io_csr_14_dataOut(csr_io_csr_14_dataOut),
    .io_csr_14_dataWrite(csr_io_csr_14_dataWrite),
    .io_csr_14_dataIn(csr_io_csr_14_dataIn),
    .io_csr_15_dataOut(csr_io_csr_15_dataOut),
    .io_csr_15_dataWrite(csr_io_csr_15_dataWrite),
    .io_csr_15_dataIn(csr_io_csr_15_dataIn),
    .io_bus_addr(csr_io_bus_addr),
    .io_bus_dataOut(csr_io_bus_dataOut),
    .io_bus_dataIn(csr_io_bus_dataIn),
    .io_bus_write(csr_io_bus_write),
    .io_bus_read(csr_io_bus_read)
  );
  WorkerCSRWrapper ctl ( // @[DMATop.scala 50:19:@1129.4]
    .clock(ctl_clock),
    .reset(ctl_reset),
    .io_csr_0_dataOut(ctl_io_csr_0_dataOut),
    .io_csr_0_dataWrite(ctl_io_csr_0_dataWrite),
    .io_csr_0_dataIn(ctl_io_csr_0_dataIn),
    .io_csr_1_dataIn(ctl_io_csr_1_dataIn),
    .io_csr_2_dataOut(ctl_io_csr_2_dataOut),
    .io_csr_2_dataWrite(ctl_io_csr_2_dataWrite),
    .io_csr_2_dataIn(ctl_io_csr_2_dataIn),
    .io_csr_3_dataOut(ctl_io_csr_3_dataOut),
    .io_csr_3_dataWrite(ctl_io_csr_3_dataWrite),
    .io_csr_3_dataIn(ctl_io_csr_3_dataIn),
    .io_csr_4_dataOut(ctl_io_csr_4_dataOut),
    .io_csr_4_dataWrite(ctl_io_csr_4_dataWrite),
    .io_csr_4_dataIn(ctl_io_csr_4_dataIn),
    .io_csr_5_dataOut(ctl_io_csr_5_dataOut),
    .io_csr_5_dataWrite(ctl_io_csr_5_dataWrite),
    .io_csr_5_dataIn(ctl_io_csr_5_dataIn),
    .io_csr_6_dataOut(ctl_io_csr_6_dataOut),
    .io_csr_6_dataWrite(ctl_io_csr_6_dataWrite),
    .io_csr_6_dataIn(ctl_io_csr_6_dataIn),
    .io_csr_7_dataOut(ctl_io_csr_7_dataOut),
    .io_csr_7_dataWrite(ctl_io_csr_7_dataWrite),
    .io_csr_7_dataIn(ctl_io_csr_7_dataIn),
    .io_csr_8_dataOut(ctl_io_csr_8_dataOut),
    .io_csr_8_dataWrite(ctl_io_csr_8_dataWrite),
    .io_csr_8_dataIn(ctl_io_csr_8_dataIn),
    .io_csr_9_dataOut(ctl_io_csr_9_dataOut),
    .io_csr_9_dataWrite(ctl_io_csr_9_dataWrite),
    .io_csr_9_dataIn(ctl_io_csr_9_dataIn),
    .io_csr_10_dataOut(ctl_io_csr_10_dataOut),
    .io_csr_10_dataWrite(ctl_io_csr_10_dataWrite),
    .io_csr_10_dataIn(ctl_io_csr_10_dataIn),
    .io_csr_11_dataOut(ctl_io_csr_11_dataOut),
    .io_csr_11_dataWrite(ctl_io_csr_11_dataWrite),
    .io_csr_11_dataIn(ctl_io_csr_11_dataIn),
    .io_csr_12_dataOut(ctl_io_csr_12_dataOut),
    .io_csr_12_dataWrite(ctl_io_csr_12_dataWrite),
    .io_csr_12_dataIn(ctl_io_csr_12_dataIn),
    .io_csr_13_dataOut(ctl_io_csr_13_dataOut),
    .io_csr_13_dataWrite(ctl_io_csr_13_dataWrite),
    .io_csr_13_dataIn(ctl_io_csr_13_dataIn),
    .io_csr_14_dataOut(ctl_io_csr_14_dataOut),
    .io_csr_14_dataWrite(ctl_io_csr_14_dataWrite),
    .io_csr_14_dataIn(ctl_io_csr_14_dataIn),
    .io_csr_15_dataOut(ctl_io_csr_15_dataOut),
    .io_csr_15_dataWrite(ctl_io_csr_15_dataWrite),
    .io_csr_15_dataIn(ctl_io_csr_15_dataIn),
    .io_irq_readerDone(ctl_io_irq_readerDone),
    .io_irq_writerDone(ctl_io_irq_writerDone),
    .io_sync_readerSync(ctl_io_sync_readerSync),
    .io_sync_writerSync(ctl_io_sync_writerSync),
    .io_xferRead_done(ctl_io_xferRead_done),
    .io_xferRead_address(ctl_io_xferRead_address),
    .io_xferRead_length(ctl_io_xferRead_length),
    .io_xferRead_valid(ctl_io_xferRead_valid),
    .io_xferWrite_done(ctl_io_xferWrite_done),
    .io_xferWrite_address(ctl_io_xferWrite_address),
    .io_xferWrite_length(ctl_io_xferWrite_length),
    .io_xferWrite_valid(ctl_io_xferWrite_valid)
  );
  Queue queue ( // @[Decoupled.scala 294:21:@1132.4]
    .clock(queue_clock),
    .reset(queue_reset),
    .io_enq_ready(queue_io_enq_ready),
    .io_enq_valid(queue_io_enq_valid),
    .io_enq_bits(queue_io_enq_bits),
    .io_deq_ready(queue_io_deq_ready),
    .io_deq_valid(queue_io_deq_valid),
    .io_deq_bits(queue_io_deq_bits)
  );
  assign io_control_dat_o = csrFrontend_io_ctl_dat_o; // @[DMATop.scala 56:22:@1149.4]
  assign io_control_ack_o = csrFrontend_io_ctl_ack_o; // @[DMATop.scala 56:22:@1143.4]
  assign io_control_stall_o = 1'h0; // @[DMATop.scala 56:22:@1142.4]
  assign io_control_err_o = 1'h0; // @[DMATop.scala 56:22:@1141.4]
  assign io_read_dat_o = 32'h0; // @[DMATop.scala 62:11:@1236.4]
  assign io_read_cyc_o = readerFrontend_io_bus_cyc_o; // @[DMATop.scala 62:11:@1235.4]
  assign io_read_stb_o = readerFrontend_io_bus_stb_o; // @[DMATop.scala 62:11:@1234.4]
  assign io_read_we_o = 1'h0; // @[DMATop.scala 62:11:@1233.4]
  assign io_read_adr_o = readerFrontend_io_bus_adr_o; // @[DMATop.scala 62:11:@1232.4]
  assign io_read_sel_o = 4'hf; // @[DMATop.scala 62:11:@1231.4]
  assign io_write_dat_o = writerFrontend_io_bus_dat_o; // @[DMATop.scala 63:12:@1246.4]
  assign io_write_cyc_o = writerFrontend_io_bus_cyc_o; // @[DMATop.scala 63:12:@1245.4]
  assign io_write_stb_o = writerFrontend_io_bus_stb_o; // @[DMATop.scala 63:12:@1244.4]
  assign io_write_we_o = 1'h1; // @[DMATop.scala 63:12:@1243.4]
  assign io_write_adr_o = writerFrontend_io_bus_adr_o; // @[DMATop.scala 63:12:@1242.4]
  assign io_write_sel_o = 4'hf; // @[DMATop.scala 63:12:@1241.4]
  assign io_irq_readerDone = ctl_io_irq_readerDone; // @[DMATop.scala 65:10:@1249.4]
  assign io_irq_writerDone = ctl_io_irq_writerDone; // @[DMATop.scala 65:10:@1248.4]
  assign csrFrontend_io_ctl_dat_i = io_control_dat_i; // @[DMATop.scala 56:22:@1150.4]
  assign csrFrontend_io_ctl_stb_i = io_control_stb_i; // @[DMATop.scala 56:22:@1147.4]
  assign csrFrontend_io_ctl_we_i = io_control_we_i; // @[DMATop.scala 56:22:@1146.4]
  assign csrFrontend_io_ctl_adr_i = io_control_adr_i; // @[DMATop.scala 56:22:@1145.4]
  assign csrFrontend_io_bus_dataIn = csr_io_bus_dataIn; // @[DMATop.scala 57:14:@1153.4]
  assign readerFrontend_clock = clock; // @[:@1121.4]
  assign readerFrontend_reset = reset; // @[:@1122.4]
  assign readerFrontend_io_bus_dat_i = io_read_dat_i; // @[DMATop.scala 62:11:@1237.4]
  assign readerFrontend_io_bus_ack_i = io_read_ack_i; // @[DMATop.scala 62:11:@1230.4]
  assign readerFrontend_io_dataOut_ready = queue_io_enq_ready; // @[Decoupled.scala 297:17:@1137.4]
  assign readerFrontend_io_xfer_address = ctl_io_xferRead_address; // @[DMATop.scala 59:26:@1222.4]
  assign readerFrontend_io_xfer_length = ctl_io_xferRead_length; // @[DMATop.scala 59:26:@1221.4]
  assign readerFrontend_io_xfer_valid = ctl_io_xferRead_valid; // @[DMATop.scala 59:26:@1220.4]
  assign writerFrontend_clock = clock; // @[:@1124.4]
  assign writerFrontend_reset = reset; // @[:@1125.4]
  assign writerFrontend_io_bus_ack_i = io_write_ack_i; // @[DMATop.scala 63:12:@1240.4]
  assign writerFrontend_io_dataIn_valid = queue_io_deq_valid; // @[DMATop.scala 54:9:@1139.4]
  assign writerFrontend_io_dataIn_bits = queue_io_deq_bits; // @[DMATop.scala 54:9:@1138.4]
  assign writerFrontend_io_xfer_address = ctl_io_xferWrite_address; // @[DMATop.scala 60:26:@1226.4]
  assign writerFrontend_io_xfer_length = ctl_io_xferWrite_length; // @[DMATop.scala 60:26:@1225.4]
  assign writerFrontend_io_xfer_valid = ctl_io_xferWrite_valid; // @[DMATop.scala 60:26:@1224.4]
  assign csr_io_csr_0_dataIn = ctl_io_csr_0_dataIn; // @[DMATop.scala 58:14:@1156.4]
  assign csr_io_csr_1_dataIn = ctl_io_csr_1_dataIn; // @[DMATop.scala 58:14:@1160.4]
  assign csr_io_csr_2_dataIn = ctl_io_csr_2_dataIn; // @[DMATop.scala 58:14:@1164.4]
  assign csr_io_csr_3_dataIn = ctl_io_csr_3_dataIn; // @[DMATop.scala 58:14:@1168.4]
  assign csr_io_csr_4_dataIn = ctl_io_csr_4_dataIn; // @[DMATop.scala 58:14:@1172.4]
  assign csr_io_csr_5_dataIn = ctl_io_csr_5_dataIn; // @[DMATop.scala 58:14:@1176.4]
  assign csr_io_csr_6_dataIn = ctl_io_csr_6_dataIn; // @[DMATop.scala 58:14:@1180.4]
  assign csr_io_csr_7_dataIn = ctl_io_csr_7_dataIn; // @[DMATop.scala 58:14:@1184.4]
  assign csr_io_csr_8_dataIn = ctl_io_csr_8_dataIn; // @[DMATop.scala 58:14:@1188.4]
  assign csr_io_csr_9_dataIn = ctl_io_csr_9_dataIn; // @[DMATop.scala 58:14:@1192.4]
  assign csr_io_csr_10_dataIn = ctl_io_csr_10_dataIn; // @[DMATop.scala 58:14:@1196.4]
  assign csr_io_csr_11_dataIn = ctl_io_csr_11_dataIn; // @[DMATop.scala 58:14:@1200.4]
  assign csr_io_csr_12_dataIn = ctl_io_csr_12_dataIn; // @[DMATop.scala 58:14:@1204.4]
  assign csr_io_csr_13_dataIn = ctl_io_csr_13_dataIn; // @[DMATop.scala 58:14:@1208.4]
  assign csr_io_csr_14_dataIn = ctl_io_csr_14_dataIn; // @[DMATop.scala 58:14:@1212.4]
  assign csr_io_csr_15_dataIn = ctl_io_csr_15_dataIn; // @[DMATop.scala 58:14:@1216.4]
  assign csr_io_bus_addr = csrFrontend_io_bus_addr; // @[DMATop.scala 57:14:@1155.4]
  assign csr_io_bus_dataOut = csrFrontend_io_bus_dataOut; // @[DMATop.scala 57:14:@1154.4]
  assign csr_io_bus_write = csrFrontend_io_bus_write; // @[DMATop.scala 57:14:@1152.4]
  assign csr_io_bus_read = csrFrontend_io_bus_read; // @[DMATop.scala 57:14:@1151.4]
  assign ctl_clock = clock; // @[:@1130.4]
  assign ctl_reset = reset; // @[:@1131.4]
  assign ctl_io_csr_0_dataOut = csr_io_csr_0_dataOut; // @[DMATop.scala 58:14:@1158.4]
  assign ctl_io_csr_0_dataWrite = csr_io_csr_0_dataWrite; // @[DMATop.scala 58:14:@1157.4]
  assign ctl_io_csr_2_dataOut = csr_io_csr_2_dataOut; // @[DMATop.scala 58:14:@1166.4]
  assign ctl_io_csr_2_dataWrite = csr_io_csr_2_dataWrite; // @[DMATop.scala 58:14:@1165.4]
  assign ctl_io_csr_3_dataOut = csr_io_csr_3_dataOut; // @[DMATop.scala 58:14:@1170.4]
  assign ctl_io_csr_3_dataWrite = csr_io_csr_3_dataWrite; // @[DMATop.scala 58:14:@1169.4]
  assign ctl_io_csr_4_dataOut = csr_io_csr_4_dataOut; // @[DMATop.scala 58:14:@1174.4]
  assign ctl_io_csr_4_dataWrite = csr_io_csr_4_dataWrite; // @[DMATop.scala 58:14:@1173.4]
  assign ctl_io_csr_5_dataOut = csr_io_csr_5_dataOut; // @[DMATop.scala 58:14:@1178.4]
  assign ctl_io_csr_5_dataWrite = csr_io_csr_5_dataWrite; // @[DMATop.scala 58:14:@1177.4]
  assign ctl_io_csr_6_dataOut = csr_io_csr_6_dataOut; // @[DMATop.scala 58:14:@1182.4]
  assign ctl_io_csr_6_dataWrite = csr_io_csr_6_dataWrite; // @[DMATop.scala 58:14:@1181.4]
  assign ctl_io_csr_7_dataOut = csr_io_csr_7_dataOut; // @[DMATop.scala 58:14:@1186.4]
  assign ctl_io_csr_7_dataWrite = csr_io_csr_7_dataWrite; // @[DMATop.scala 58:14:@1185.4]
  assign ctl_io_csr_8_dataOut = csr_io_csr_8_dataOut; // @[DMATop.scala 58:14:@1190.4]
  assign ctl_io_csr_8_dataWrite = csr_io_csr_8_dataWrite; // @[DMATop.scala 58:14:@1189.4]
  assign ctl_io_csr_9_dataOut = csr_io_csr_9_dataOut; // @[DMATop.scala 58:14:@1194.4]
  assign ctl_io_csr_9_dataWrite = csr_io_csr_9_dataWrite; // @[DMATop.scala 58:14:@1193.4]
  assign ctl_io_csr_10_dataOut = csr_io_csr_10_dataOut; // @[DMATop.scala 58:14:@1198.4]
  assign ctl_io_csr_10_dataWrite = csr_io_csr_10_dataWrite; // @[DMATop.scala 58:14:@1197.4]
  assign ctl_io_csr_11_dataOut = csr_io_csr_11_dataOut; // @[DMATop.scala 58:14:@1202.4]
  assign ctl_io_csr_11_dataWrite = csr_io_csr_11_dataWrite; // @[DMATop.scala 58:14:@1201.4]
  assign ctl_io_csr_12_dataOut = csr_io_csr_12_dataOut; // @[DMATop.scala 58:14:@1206.4]
  assign ctl_io_csr_12_dataWrite = csr_io_csr_12_dataWrite; // @[DMATop.scala 58:14:@1205.4]
  assign ctl_io_csr_13_dataOut = csr_io_csr_13_dataOut; // @[DMATop.scala 58:14:@1210.4]
  assign ctl_io_csr_13_dataWrite = csr_io_csr_13_dataWrite; // @[DMATop.scala 58:14:@1209.4]
  assign ctl_io_csr_14_dataOut = csr_io_csr_14_dataOut; // @[DMATop.scala 58:14:@1214.4]
  assign ctl_io_csr_14_dataWrite = csr_io_csr_14_dataWrite; // @[DMATop.scala 58:14:@1213.4]
  assign ctl_io_csr_15_dataOut = csr_io_csr_15_dataOut; // @[DMATop.scala 58:14:@1218.4]
  assign ctl_io_csr_15_dataWrite = csr_io_csr_15_dataWrite; // @[DMATop.scala 58:14:@1217.4]
  assign ctl_io_sync_readerSync = io_sync_readerSync; // @[DMATop.scala 66:11:@1251.4]
  assign ctl_io_sync_writerSync = io_sync_writerSync; // @[DMATop.scala 66:11:@1250.4]
  assign ctl_io_xferRead_done = readerFrontend_io_xfer_done; // @[DMATop.scala 59:26:@1223.4]
  assign ctl_io_xferWrite_done = writerFrontend_io_xfer_done; // @[DMATop.scala 60:26:@1227.4]
  assign queue_clock = clock; // @[:@1133.4]
  assign queue_reset = reset; // @[:@1134.4]
  assign queue_io_enq_valid = readerFrontend_io_dataOut_valid; // @[Decoupled.scala 295:22:@1135.4]
  assign queue_io_enq_bits = readerFrontend_io_dataOut_bits; // @[Decoupled.scala 296:21:@1136.4]
  assign queue_io_deq_ready = writerFrontend_io_dataIn_ready; // @[DMATop.scala 54:9:@1140.4]
endmodule
