
// slave's address is incorect
program testcase(intf_cnt intf);
  environment env = new(intf);

    initial 
    begin
        env.driv.apb_reset();
        #30
        env.write_n_bytes(5);

        env.configure_core(8'h08, 8'h22);
        env.ena_core_sr;
        #100000
        env.driv.apb_reset();   
    end
endprogram
