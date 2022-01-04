# Equipo_10

Follow instructions below according the simulation environment where you want to test. 
The default evironment is **Modelsim**.




### Modelsim

Go to `src/Sistema_Mem/Program_Memory.v` 
> Comment line 31  |  Uncomment line 32

Also you can manipulate the testbench:  `comment line 25` and `uncomment line 24` to see a different result when `GPIO_I == 0` or `GPIO_I != 0`

------------

### FPGA

Go to `src/Sistema_Mem/Program_Memory.v` 
> Comment line 32  |  Uncomment line 31

If Quartus can not identify the directory, add the full  path.

*Example*
>C:/Projects/Equipo_10/assembly_code/t7hex