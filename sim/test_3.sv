//apb master read default value
//apb master write
//apb master reset
//apb master read reset value
program testcase(intf_cnt intf);
  environment env = new(intf);

    initial 
    begin
	env.apb_reset();
        #30
        env.driv.apb_read(0);
	//env.driv.apb_read(1);
	env.driv.apb_read(2);
        env.driv.apb_read(3);
        env.driv.apb_read(4);
        env.driv.apb_read(5);
        #30
        env.driv.apb_write(0, 8'h11);
        env.driv.apb_write(3, 8'h22);
        env.driv.apb_write(4, 8'h33);
        env.driv.apb_write(5, 8'h44);
	#30
        env.apb_reset();
	#30
        env.driv.apb_read(0);
	//env.driv.apb_read(1);
	env.driv.apb_read(2);
        env.driv.apb_read(3);
        env.driv.apb_read(4);
        env.driv.apb_read(5);
        #100
        env.apb_reset();
    end
endprogram
