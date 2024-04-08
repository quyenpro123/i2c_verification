//APB master write continously data to transfifo, exceed the depth of transfifo
program testcase(intf_cnt intf);
  environment env = new(intf);
  int i = 0;
    initial 
    begin
        env.driv.apb_reset();
        #30
        env.gen_data_random(18);
        env.driv.apb_write(0, 8'h00);
	repeat (16)
	begin
	    env.driv.apb_write(0, intf.data_master[i]);	
	    i = i + 1;
	end

        env.driv.apb_write(3, 8'h20);
        env.driv.apb_write(5, 8'h08);
        env.driv.apb_write(4, 8'hc0);
        wait(intf.start);
        wait(intf.stop);
        env.driv.apb_write(3, 8'h21);
        env.driv.apb_write(4, 8'hc0);

        wait(intf.start);
        wait(intf.stop);
        repeat (20)
        env.driv.apb_read(1);
        #100000
        env.driv.apb_reset();
    end
endprogram
