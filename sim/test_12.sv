//master wanna write 5 byte to slave
//until 4th byte, slave send NACK
//*modify slave model at line 278
program testcase(intf_cnt intf);
  environment env = new(intf);
  int i = 0;
    initial 
    begin
        env.driv.apb_reset();
        #30
        env.driv.apb_write(0, 8'h00);
        env.gen_data_random(18);
        repeat(5)
        begin
          env.driv.apb_write(0, intf.data_master[i]);
          i = i + 1;
        end

        env.driv.apb_write(3, 8'h20);
        env.driv.apb_write(5, 8'h08);
        env.driv.apb_write(4, 8'hc0);
        #100000
        env.driv.apb_reset();   
    end
endprogram
