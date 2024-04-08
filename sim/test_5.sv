//i2c core reset suddenly

program testcase(intf_cnt intf);
  environment env = new(intf);
  int i = 0;
    initial 
    begin
	//START -> Reset
        env.driv.apb_reset();
        #30
        env.driv.apb_write(3, 8'h20);
        env.driv.apb_write(5, 8'h08);
        env.ena_core_no_sr;
        #100
        env.i2c_reset_core();
        env.ena_core_no_sr;
	
	//ADDRESS -> Reset
	#1600
	env.i2c_reset_core();	

	//READ ACK -> Reset
	env.ena_core_no_sr;
	#3000
	env.i2c_reset_core();
	env.ena_core_no_sr;

	//WRITE DATA -> Reset
	wait(vif.stop);
	i = 0;
	env.driv.apb_write(0, 8'h00);
	env.gen_data_random(5);
        repeat(5)
        begin
          env.driv.apb_write(0, intf.data_master[i]);
          i = i + 1;
        end
	env.ena_core_no_sr;
	#7000
	env.i2c_reset_core();

	//READ LATER ACK -> Reset
	i = 0;
	env.driv.apb_write(0, 8'h00);
	env.gen_data_random(5);
        repeat(5)
        begin
          env.driv.apb_write(0, intf.data_master[i]);
          i = i + 1;
        end
	env.ena_core_no_sr;
	#5700
	env.i2c_reset_core();
	
	env.ena_core_no_sr;

	//REPEAT START -> Reset
	env.driv.apb_write(0, 8'hff);
	env.ena_core_sr;
	#5700
	env.i2c_reset_core();
	
	env.ena_core_no_sr;


	//WRITE ACK -> Reset
	wait(vif.stop);
	env.driv.apb_write(3, 8'h21);
	env.ena_core_no_sr;
	#5650
	env.i2c_reset_core();
	wait(vif.stop);
	env.ena_core_no_sr;

	//READ DATA -> Reset
	wait(vif.stop);
	env.ena_core_no_sr;
	#4000
	env.i2c_reset_core();

	#10000
        env.driv.apb_reset();
	
    end
endprogram
