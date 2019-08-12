################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
helloWorldcfg.cmd: ../helloWorld.tcf
	@echo 'Building file: $<'
	@echo 'Invoking: TConf'
	"C:/ti/bios_5_42_00_07/xdctools/tconf" -b -Dconfig.importPath="C:/ti/bios_5_42_00_07/packages;C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/tci;" "$<"
	@echo 'Finished building: $<'
	@echo ' '

helloWorldcfg.s??: helloWorldcfg.cmd
helloWorldcfg_c.c: helloWorldcfg.cmd
helloWorldcfg.h: helloWorldcfg.cmd
helloWorldcfg.h??: helloWorldcfg.cmd
helloWorld.cdb: helloWorldcfg.cmd

helloWorldcfg.obj: ./helloWorldcfg.s?? $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="helloWorldcfg.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

helloWorldcfg_c.obj: ./helloWorldcfg_c.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="helloWorldcfg_c.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


