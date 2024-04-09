//i2c master write n bytes
//repeat start
//i2c master read n bytes

program testcase(intf_cnt intf);
    environment env = new(intf);
    initial 
    begin
        env.driv.apb_reset();
        #30
        env.write_n_bytes(15);

        env.configure_core(8'h08, 8'h20);
        env.ena_core_no_sr;
        @(posedge intf.start);
       	@(posedge intf.stop);
        env.driv.apb_write(3, 8'h21);
        env.ena_core_no_sr;

        //#25000
        //env.configure_core(8'h08, 8'h21);
        //env.ena_core_no_sr;
        #100000
        env.driv.apb_reset();
    end
endprogram
