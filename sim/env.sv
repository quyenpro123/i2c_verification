`ifndef ENV
`define ENV
`include "driver.sv"
`include "generator.sv"
class environment;
    generator gen;
    driver driv;
    mailbox gen2driv;
    virtual intf_cnt vif;

    function new(virtual intf_cnt vif);
        this.vif = vif;
        gen2driv = new();
        gen = new(gen2driv);
        driv = new(vif, gen2driv);
    endfunction

    task apb_reset;
        driv.apb_reset();
    endtask

    task i2c_reset_core;
        driv.apb_write(4, 8'h00);
    endtask
    task ena_core_sr;
        driv.apb_write(4, 8'he0);
    endtask

    task ena_core_no_sr;
        driv.apb_write(4, 8'hc0);
    endtask

    task gen_data_random(int repeat_random);
        gen.main(repeat_random);
	    wait(gen.ended.triggered);
	    driv.random_data(repeat_random);
    endtask

endclass
`endif
