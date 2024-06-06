# I2C Verification
## I. Overview
    - Verify i2c module's RTL code by using Systemverilog language and Questa Sim environment
- [RTL source](https://github.com/oggrr3/i2c_code)

![block diagram verification](illlustration_image/block.png)

Figure 1: Verification hierarchy
## II. Test plan 
- [Link test plan](https://docs.google.com/spreadsheets/d/1L5LMiVRk0B01b7eIfWacH3m8a9wGSKSJkneNcRtbiQA/edit#gid=0)
## III. Instructions for checking coverage report
    - Coverage report is saved in "work/final.ucdp"
    - Open that file in Questa Sim.
    - At the taskbar on top, select "Tools/Coverage Report/HTML..." and select catagories arcording the image below: 
![alt text](illlustration_image/image-1.png)

    - Click "OK", "covhtmlreport" folder will be created. 
    - Use the web brower to open "index.html" file in that folder. All coverage reports will be showed.
![alt text](illlustration_image/image.png)
