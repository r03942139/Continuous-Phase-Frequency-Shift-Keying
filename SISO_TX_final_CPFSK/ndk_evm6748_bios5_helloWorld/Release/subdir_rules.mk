################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
helloWorldcfg.cmd: ../helloWorld.tcf
	@echo 'Building file: $<'
	@echo 'Invoking: TConf'
	"/tconf" -b -Dconfig.importPath="C:/ti/bios_5_42_00_07/packages;" "$<"
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
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 -g -O2 --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/Users/USER/Desktop/new/ndk_evm6748_bios5_helloWorld/Release" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/new/ndk_evm6748_bios5_helloWorld/Release" --diag_warning=225 --abi=coffabi --preproc_with_compile --preproc_dependency="helloWorldcfg.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

helloWorldcfg_c.obj: ./helloWorldcfg_c.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 -g -O2 --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/Users/USER/Desktop/new/ndk_evm6748_bios5_helloWorld/Release" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/new/ndk_evm6748_bios5_helloWorld/Release" --diag_warning=225 --abi=coffabi --preproc_with_compile --preproc_dependency="helloWorldcfg_c.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


