################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../emacHooks.c \
../evminit.c \
../helloWorld.c \
../udpHello.c 

TCF_SRCS += \
../helloWorld.tcf 

GEN_SRCS += \
./helloWorldcfg.cmd \
./helloWorldcfg.s?? \
./helloWorldcfg_c.c 

GEN_CMDS += \
./helloWorldcfg.cmd 

OBJS += \
./emacHooks.obj \
./evminit.obj \
./helloWorld.obj \
./helloWorldcfg.obj \
./helloWorldcfg_c.obj \
./udpHello.obj 

GEN_MISC_FILES += \
./helloWorldcfg.h \
./helloWorldcfg.h?? \
./helloWorld.cdb 

S??_DEPS += \
./helloWorldcfg.pp 

C_DEPS += \
./emacHooks.pp \
./evminit.pp \
./helloWorld.pp \
./helloWorldcfg_c.pp \
./udpHello.pp 

OBJS__QTD += \
".\emacHooks.obj" \
".\evminit.obj" \
".\helloWorld.obj" \
".\helloWorldcfg.obj" \
".\helloWorldcfg_c.obj" \
".\udpHello.obj" 

S??_DEPS__QTD += \
".\helloWorldcfg.pp" 

GEN_SRCS__QTD += \
".\helloWorldcfg.cmd" \
".\helloWorldcfg.s??" \
".\helloWorldcfg_c.c" 

C_DEPS__QTD += \
".\emacHooks.pp" \
".\evminit.pp" \
".\helloWorld.pp" \
".\helloWorldcfg_c.pp" \
".\udpHello.pp" 

GEN_MISC_FILES__QTD += \
".\helloWorldcfg.h" \
".\helloWorldcfg.h??" \
".\helloWorld.cdb" 

C_SRCS_QUOTED += \
"../emacHooks.c" \
"../evminit.c" \
"../helloWorld.c" \
"../udpHello.c" 

TCF_SRCS_QUOTED += \
"../helloWorld.tcf" 

GEN_CMDS_QUOTED += \
-l"./helloWorldcfg.cmd" 


# Each subdirectory must supply rules for building sources it contributes
emacHooks.obj: ../emacHooks.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: Compiler'
	"D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/bin/cl6x" -mv6740 -g --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/include" --include_path="D:/Program Files/Texas Instruments/ndk_2_20_00_18_eng/packages/ti/ndk/inc" --include_path="C:/Documents and Settings/a0323418/My Documents/workspace_ndk18_nsp08/ndk_evm6748_bios5_helloWorld/Debug" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/bios/include" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/rtdx/include/c6000" --diag_warning=225 --preproc_with_compile --preproc_dependency="emacHooks.pp" $(GEN_OPTS_QUOTED) $(subst #,$(wildcard $(subst $(SPACE),\$(SPACE),$<)),"#")
	@echo 'Finished building: $<'
	@echo ' '

evminit.obj: ../evminit.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: Compiler'
	"D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/bin/cl6x" -mv6740 -g --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/include" --include_path="D:/Program Files/Texas Instruments/ndk_2_20_00_18_eng/packages/ti/ndk/inc" --include_path="C:/Documents and Settings/a0323418/My Documents/workspace_ndk18_nsp08/ndk_evm6748_bios5_helloWorld/Debug" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/bios/include" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/rtdx/include/c6000" --diag_warning=225 --preproc_with_compile --preproc_dependency="evminit.pp" $(GEN_OPTS_QUOTED) $(subst #,$(wildcard $(subst $(SPACE),\$(SPACE),$<)),"#")
	@echo 'Finished building: $<'
	@echo ' '

helloWorld.obj: ../helloWorld.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: Compiler'
	"D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/bin/cl6x" -mv6740 -g --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/include" --include_path="D:/Program Files/Texas Instruments/ndk_2_20_00_18_eng/packages/ti/ndk/inc" --include_path="C:/Documents and Settings/a0323418/My Documents/workspace_ndk18_nsp08/ndk_evm6748_bios5_helloWorld/Debug" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/bios/include" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/rtdx/include/c6000" --diag_warning=225 --preproc_with_compile --preproc_dependency="helloWorld.pp" $(GEN_OPTS_QUOTED) $(subst #,$(wildcard $(subst $(SPACE),\$(SPACE),$<)),"#")
	@echo 'Finished building: $<'
	@echo ' '

helloWorldcfg.cmd: ../helloWorld.tcf
	@echo 'Building file: $<'
	@echo 'Invoking: TConf Script Compiler'
	"D:/Program Files/Texas Instruments/ccsv4.2.10016/xdctools_3_20_03_63/tconf" -b -Dconfig.importPath="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages;D:/Program Files/Texas Instruments/ndk_2_20_00_18_eng/packages/ti/ndk/inc/tci;" "$<"
	@echo 'Finished building: $<'
	@echo ' '

helloWorldcfg.s??: helloWorldcfg.cmd
helloWorldcfg_c.c: helloWorldcfg.cmd
helloWorldcfg.h: helloWorldcfg.cmd
helloWorldcfg.h??: helloWorldcfg.cmd
helloWorld.cdb: helloWorldcfg.cmd

helloWorldcfg.obj: ./helloWorldcfg.s?? $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: Compiler'
	"D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/bin/cl6x" -mv6740 -g --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/include" --include_path="D:/Program Files/Texas Instruments/ndk_2_20_00_18_eng/packages/ti/ndk/inc" --include_path="C:/Documents and Settings/a0323418/My Documents/workspace_ndk18_nsp08/ndk_evm6748_bios5_helloWorld/Debug" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/bios/include" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/rtdx/include/c6000" --diag_warning=225 --preproc_with_compile --preproc_dependency="helloWorldcfg.pp" $(GEN_OPTS_QUOTED) $(subst #,$(wildcard $(subst $(SPACE),\$(SPACE),$<)),"#")
	@echo 'Finished building: $<'
	@echo ' '

helloWorldcfg_c.obj: ./helloWorldcfg_c.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: Compiler'
	"D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/bin/cl6x" -mv6740 -g --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/include" --include_path="D:/Program Files/Texas Instruments/ndk_2_20_00_18_eng/packages/ti/ndk/inc" --include_path="C:/Documents and Settings/a0323418/My Documents/workspace_ndk18_nsp08/ndk_evm6748_bios5_helloWorld/Debug" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/bios/include" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/rtdx/include/c6000" --diag_warning=225 --preproc_with_compile --preproc_dependency="helloWorldcfg_c.pp" $(GEN_OPTS_QUOTED) $(subst #,$(wildcard $(subst $(SPACE),\$(SPACE),$<)),"#")
	@echo 'Finished building: $<'
	@echo ' '

udpHello.obj: ../udpHello.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: Compiler'
	"D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/bin/cl6x" -mv6740 -g --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/ccsv4/tools/compiler/c6000/include" --include_path="D:/Program Files/Texas Instruments/ndk_2_20_00_18_eng/packages/ti/ndk/inc" --include_path="C:/Documents and Settings/a0323418/My Documents/workspace_ndk18_nsp08/ndk_evm6748_bios5_helloWorld/Debug" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/bios/include" --include_path="D:/Program Files/Texas Instruments/ccsv4.2.10016/bios_5_41_07_24/packages/ti/rtdx/include/c6000" --diag_warning=225 --preproc_with_compile --preproc_dependency="udpHello.pp" $(GEN_OPTS_QUOTED) $(subst #,$(wildcard $(subst $(SPACE),\$(SPACE),$<)),"#")
	@echo 'Finished building: $<'
	@echo ' '


