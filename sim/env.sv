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

    task gen_data_random(int repeat_random);
        gen.main(repeat_random);
	    wait(gen.ended.triggered);
	    driv.random_data(repeat_random);
    endtask

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

    task write_n_bytes(int number);
        int count = 0;
        driv.apb_write(0, 8'h00);
        gen_data_random(number);
        repeat(number)
        begin
            driv.apb_write(0, vif.data_master[count]);
            count = count + 1;
        end
    endtask

    task read_n_bytes(int number);
        repeat (number)
        begin
            driv.apb_read(1);
        end
    endtask

    task configure_core(logic [7:0] prescale, logic [7:0] slave_addr);
        driv.apb_write(3, slave_addr);
        driv.apb_write(5, prescale);
    endtask

endclass
`endif
