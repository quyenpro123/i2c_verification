var g_data = {"name":"../rtl/sync_r2w.v","src":"\n// Module read-domain to write-domain synchronizer\n// Used to pass an n-bit pointer from the read clock domain to the write clock domain\n\nmodule sync_r2w # (parameter ADDRSIZE = 4 )\n(\n    input       [ADDRSIZE : 0]  rptr_i     , // read pointer passed to write-domain\n    input                       wclk_i     , // Clock of write-domain\n    input                       wrst_ni    , // Negative reset signal of write-domain\n    output      [ADDRSIZE : 0]  wq2_rptr_o  // The pointer synchronized from read-domain to write-domain\n    \n); \n\n    reg     [ADDRSIZE : 0]   wq1_rptr       ;\n    reg     [ADDRSIZE : 0]  wq2_rptr        ;\n    \n    assign  wq2_rptr_o      =       wq2_rptr    ;\n\n    // Multi-flop synchronizer logic for passing the pointers to avoid Metastability\n    always @ (posedge wclk_i,   negedge wrst_ni)\n    begin\n    \n        if (~wrst_ni)\n            {wq2_rptr, wq1_rptr}  <=  0                    ;\n        else\n            {wq2_rptr, wq1_rptr}  <=  {wq1_rptr, rptr_i}   ;\n    \n    end\n\nendmodule \n","lang":"verilog"};
processSrcData(g_data);