################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
SRC/edma.obj: ../SRC/edma.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/edma.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SRC/emacHooks.obj: ../SRC/emacHooks.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/emacHooks.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SRC/evminit.obj: ../SRC/evminit.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/evminit.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SRC/hello.obj: ../SRC/hello.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/hello.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SRC/helloWorld.obj: ../SRC/helloWorld.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/helloWorld.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SRC/interrupt.obj: ../SRC/interrupt.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/interrupt.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SRC/intvecs.obj: ../SRC/intvecs.asm $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/intvecs.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SRC/main.obj: ../SRC/main.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/main.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SRC/psc.obj: ../SRC/psc.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" --include_path="C:/ti/nsp_1_00_00_09" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/hw" --include_path="C:/Program Files/Texas Instruments/dsplib_c674x_3_1_0_0/packages" --include_path="C:/ti/nsp_1_00_00_09/packages/ti/drv/omapl138/inc" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include" --include_path="C:/ti/OMAPL138_StarterWare_1_10_03_03/include/c674x/omapl138" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc" --include_path="C:/ti/ndk_2_20_00_19/packages/ti/ndk/inc/os" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --include_path="C:/ti/bios_5_42_00_07/packages/ti/bios/include" --include_path="C:/ti/bios_5_42_00_07/packages/ti/rtdx/include/c6000" --include_path="C:/Users/USER/Desktop/SISO_RX_final_example/ndk_evm6748_bios5_helloWorld/Debug" --define=CHIP_L138 --define=omapl138 --diag_warning=225 --preproc_with_compile --preproc_dependency="SRC/psc.pp" --obj_directory="SRC" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


