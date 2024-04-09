//master wanna write 5 byte to slave
//until 4th byte, slave send NACK
//*modify slave model at line 278
program testcase(intf_cnt intf);
  environment env = new(intf);
    initial 
    begin
        env.driv.apb_reset();
        #30
        env.write_n_bytes(5);

        env.driv.apb_write(3, 8'h20);
        env.driv.apb_write(5, 8'h08);
        env.driv.apb_write(4, 8'he0);
        #100000
        env.driv.apb_reset();   
    end
endprogram
