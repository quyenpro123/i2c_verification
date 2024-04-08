//i2c master read n times
program testcase(intf_cnt intf);
    environment env = new(intf);
    int i = 0;
    initial 
    begin
        env.driv.apb_reset();
	env.driv.apb_write(4, 8'h00);
        #30
        env.driv.apb_write(0, 8'h00);
        env.gen_data_random(18);
        repeat(18)
        begin
          env.driv.apb_write(0, intf.data_master[i]);
          i = i + 1;
        end

        env.driv.apb_write(3, 8'h20);
        env.driv.apb_write(5, 8'h08);
        env.driv.apb_write(4, 8'hc0);

        repeat(5)
        begin 
            wait(intf.start);
            wait(intf.stop);
            env.driv.apb_write(3, 8'h21);
	    repeat(16)
            	env.driv.apb_read(1);
            env.driv.apb_write(4, 8'hc0);
        end
        #100000
        env.driv.apb_reset();
    end
endprogram
