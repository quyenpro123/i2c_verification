//i2c master write n times

program testcase(intf_cnt intf);
    environment env = new(intf);
    int i = 0;
    initial 
    begin
        env.driv.apb_reset();
        #30
        env.driv.apb_write(0, 8'h00);
        env.gen_data_random(5);
        repeat(5)
        begin
          env.driv.apb_write(0, intf.data_master[i]);
          i = i + 1;
        end
	i = 0;
        env.driv.apb_write(3, 8'h20);
        env.driv.apb_write(5, 8'h08);
        env.driv.apb_write(4, 8'hc0);

        @(negedge intf.start);
        @(posedge intf.stop);
	env.driv.apb_write(0, 8'h00);
	env.gen_data_random(5);
        repeat(5)
        begin
          env.driv.apb_write(0, intf.data_master[i]);
          i = i + 1;
        end
	i = 0;
        env.driv.apb_write(4, 8'hc0);

	@(negedge intf.start);
        @(posedge intf.stop);
	env.driv.apb_write(0, 8'h00);
	env.gen_data_random(5);
        repeat(5)
        begin
          env.driv.apb_write(0, intf.data_master[i]);
          i = i + 1;
        end
	i = 0;
        env.driv.apb_write(4, 8'hc0);


	@(negedge intf.start);
        @(posedge intf.stop);
	env.driv.apb_write(0, 8'h00);
	env.gen_data_random(5);
        repeat(5)
        begin
          env.driv.apb_write(0, intf.data_master[i]);
          i = i + 1;
        end
	i = 0;
        env.driv.apb_write(4, 8'hc0);
        
        #1000000
        env.driv.apb_reset();
    end
endprogram
