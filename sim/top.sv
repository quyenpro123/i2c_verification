`include "transactor.sv"
`include "generator.sv"
`include "interface.sv"
`include "driver.sv"
`include "env.sv"
`include "assertion.sv"

`ifdef TEST_1_2
  `include "test_1_2.sv"
`elsif TEST_2
  `include "test_2.sv"
`elsif TEST_3
  `include "test_3.sv"
`elsif TEST_4
  `include "test_4.sv"
`elsif TEST_5
  `include "test_5.sv"
`elsif TEST_6
  `include "test_6.sv"
`elsif TEST_7
  `include "test_7.sv"
`elsif TEST_8
  `include "test_8.sv"
`elsif TEST_9
  `include "test_9.sv"
`elsif TEST_10
  `include "test_10.sv"
`elsif TEST_11
  `include "test_11.sv"
`elsif TEST_12
  `include "test_12.sv"
`elsif TEST_13
  `include "test_13.sv"
`elsif TEST_14
  `include "test_14.sv"
`endif
  module top();
      reg pclk = 0;
      reg i2c_core_clock = 0;
      always #20 i2c_core_clock = ~i2c_core_clock ;
      always #5 pclk = ~pclk;
     
      intf_cnt vif(pclk, i2c_core_clock);
      i2c_top master(
        .i2c_core_clk_i(vif.i2c_core_clock)                                                 ,
        .pclk_i(vif.pclk)                                                                   ,
        .preset_ni(vif.preset)                                                              ,
        .penable_i(vif.penable)                                                             ,
        .psel_i(vif.psel)                                                                   ,
        .paddr_i(vif.paddr)                                                                 ,
        .pwdata_i(vif.pwdata)                                                               ,
        .pwrite_i(vif.pwrite)                                                               ,
        .prdata_o(vif.prdata_o)                                                             ,
        .pready_o(vif.pready_o)                                                             ,
        .sda(vif.sda_io)                                                                    ,
        .scl(vif.scl_io)
    );

    i2c_slave_model slave(
        .sda(vif.sda_io)                                                                    ,
        .scl(vif.scl_io)                                                                    ,
        .data_slave_read(vif.data_slave_read)                                               ,
        .data_slave_read_valid(vif.data_slave_read_valid)                                   ,
        .start(vif.start)                                                                   ,
        .stop(vif.stop)
    );
    testcase test(vif);
    assertion_cov assert_cov(vif);
   endmodule
