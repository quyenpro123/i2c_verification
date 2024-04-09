//i2c master write n times

program testcase(intf_cnt intf);
    environment env = new(intf);
    int i = 0;
    initial 
    begin
        env.driv.apb_reset();
        #30
	env.configure_core(8'h08, 8'h20);
	repeat (4)
	begin
	    env.write_n_bytes(5);
            env.ena_core_no_sr;
	    @(posedge intf.stop);
	end
        
        #1000000
        env.driv.apb_reset();
    end
endprogram
