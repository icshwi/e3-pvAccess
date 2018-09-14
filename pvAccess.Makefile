#
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Friday, September 14 09:58:39 CEST 2018
# version : 0.0.3

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(where_am_I)/../configure/DECOUPLE_FLAGS
include $(where_am_I)configure/CONFIG_PVACCESS_VERSION


ifneq ($(strip $(PVDATA_DEP_VERSION)),)
pvData_VERSION=$(PVDATA_DEP_VERSION)
endif



## Exclude linux-ppc64e6500
##EXCLUDE_ARCHS = linux-ppc64e6500



PVACCESS_SRC:=src



PVA:=$(PVACCESS_SRC)/pva
UTILS:=$(PVACCESS_SRC)/utils
CLIENT:=$(PVACCESS_SRC)/client
FACTORY:=$(PVACCESS_SRC)/factory
REMOTE:=$(PVACCESS_SRC)/remote
REMOTECLIENT:=$(PVACCESS_SRC)/remoteClient
SERVER:=$(PVACCESS_SRC)/server
RPCSERVICE:=$(PVACCESS_SRC)/rpcService
RPCCLIENT:=$(PVACCESS_SRC)/rpcClient
PIPELINESERVICE:=$(PVACCESS_SRC)/pipelineService
MB:=$(PVACCESS_SRC)/mb

IOC:=$(PVACCESS_SRC)/ioc
CA:=$(PVACCESS_SRC)/ca

USR_INCLUDES += -I$(COMMON_DIR)
USR_INCLUDES += -I$(where_am_I)$(PVACCESS_SRC)
USR_INCLUDES += -I$(where_am_I)$(CLIENT)
USR_INCLUDES += -I$(where_am_I)$(PVA)
USR_INCLUDES += -I$(where_am_I)$(UTILS)
USR_INCLUDES += -I$(where_am_I)$(SERVER)
USR_INCLUDES += -I$(where_am_I)$(RPCSERVICE)
USR_INCLUDES += -I$(where_am_I)$(REMOTE)
USR_INCLUDES += -I$(where_am_I)$(MB)
#USR_INCLUDES += -I$(where_am_I)$(SERVER)


# pvAccessCA lib
# CA
USR_INCLUDES += -I$(where_am_I)$(CA)
HEADERS += $(CA)/pv/caProvider.h
HEADERS += $(CA)/pv/caStatus.h
SOURCES += $(CA)/caProvider.cpp
SOURCES += $(CA)/caChannel.cpp
SOURCES += $(CA)/caStatus.cpp

# More studies are needed for  IOC
# pvAccessIOC lib
# IOC

HEADERS += $(IOC)/pv/syncChannelFind.h
HEADERS += $(IOC)/pv/iocshelper.h
HEADERS += $(IOC)/pv/iocreftrack.h

SOURCES += $(IOC)/PVAServerRegister.cpp
SOURCES += $(IOC)/PVAClientRegister.cpp
SOURCES += $(IOC)/reftrackioc.cpp

#DBDS += $(IOC)/PVACommonRegister.dbd
DBDS += $(IOC)/PVAServerRegister.dbd
DBDS += $(IOC)/PVAClientRegister.dbd

# PVA

HEADERS += $(PVA)/pv/pvaConstants.h
HEADERS += $(PVA)/pv/pvaDefs.h
HEADERS += $(PVA)/pv/pvaVersion.h
#HEADERS += $(PVA)/pv/pvaVersionNum.h
HEADERS += $(COMMON_DIR)/pv/pvaVersionNum.h
HEADERS += $(PVA)/pv/clientFactory.h

SOURCES += $(PVA)/pvaVersion.cpp
SOURCES += $(PVA)/clientFactory.cpp



# UTILS
HEADERS += $(UTILS)/pv/hexDump.h
HEADERS += $(UTILS)/pv/logger.h
HEADERS += $(UTILS)/pv/introspectionRegistry.h
HEADERS += $(UTILS)/pv/namedLockPattern.h
HEADERS += $(UTILS)/pv/referenceCountingLock.h
HEADERS += $(UTILS)/pv/configuration.h
HEADERS += $(UTILS)/pv/likely.h
HEADERS += $(UTILS)/pv/wildcard.h
HEADERS += $(UTILS)/pv/fairQueue.h
HEADERS += $(UTILS)/pv/requester.h
HEADERS += $(UTILS)/pv/destroyable.h

SOURCES += $(UTILS)/hexDump.cpp
SOURCES += $(UTILS)/inetAddressUtil.cpp
SOURCES += $(UTILS)/logger.cpp
SOURCES += $(UTILS)/introspectionRegistry.cpp
SOURCES += $(UTILS)/configuration.cpp
SOURCES += $(UTILS)/referenceCountingLock.cpp
SOURCES += $(UTILS)/requester.cpp
SOURCES += $(UTILS)/wildcard.cpp


# CLIENT
HEADERS += $(CLIENT)/pv/monitor.h
HEADERS += $(CLIENT)/pv/pvAccess.h
HEADERS += $(CLIENT)/pva/client.h

SOURCES += $(CLIENT)/pvAccess.cpp
SOURCES += $(CLIENT)/client.cpp
SOURCES += $(CLIENT)/clientSync.cpp
SOURCES += $(CLIENT)/clientGet.cpp
SOURCES += $(CLIENT)/clientRPC.cpp
SOURCES += $(CLIENT)/clientMonitor.cpp


# FACTORY
SOURCES += $(FACTORY)/ChannelAccessFactory.cpp

# REMOTE
HEADERS += $(REMOTE)/pv/security.h
HEADERS += $(REMOTE)/pv/serializationHelper.h

SOURCES += $(REMOTE)/blockingUDPTransport.cpp
SOURCES += $(REMOTE)/blockingUDPConnector.cpp
SOURCES += $(REMOTE)/beaconHandler.cpp
SOURCES += $(REMOTE)/blockingTCPConnector.cpp
SOURCES += $(REMOTE)/simpleChannelSearchManagerImpl.cpp
SOURCES += $(REMOTE)/abstractResponseHandler.cpp
SOURCES += $(REMOTE)/blockingTCPAcceptor.cpp
SOURCES += $(REMOTE)/transportRegistry.cpp
SOURCES += $(REMOTE)/serializationHelper.cpp
SOURCES += $(REMOTE)/codec.cpp
SOURCES += $(REMOTE)/security.cpp



# REMOTECLIENT
SOURCES += $(REMOTECLIENT)/clientContextImpl.cpp


# SERVER
HEADERS += $(SERVER)/pv/serverContext.h
HEADERS += $(SERVER)/pv/beaconServerStatusProvider.h

SOURCES += $(SERVER)/responseHandlers.cpp
SOURCES += $(SERVER)/serverContext.cpp
SOURCES += $(SERVER)/serverChannelImpl.cpp
SOURCES += $(SERVER)/baseChannelRequester.cpp
SOURCES += $(SERVER)/beaconEmitter.cpp
SOURCES += $(SERVER)/beaconServerStatusProvider.cpp


# RPCSERVICE
HEADERS += $(RPCSERVICE)/pv/rpcService.h
HEADERS += $(RPCSERVICE)/pv/rpcServer.h

SOURCES += $(RPCSERVICE)/rpcService.cpp
SOURCES += $(RPCSERVICE)/rpcServer.cpp

# RPCCLIENT
HEADERS += $(RPCCLIENT)/pv/rpcClient.h
SOURCES += $(RPCCLIENT)/rpcClient.cpp


# PIPELINESERVICE
HEADERS += $(PIPELINESERVICE)/pv/pipelineService.h
HEADERS += $(PIPELINESERVICE)/pv/pipelineServer.h

SOURCES += $(PIPELINESERVICE)/pipelineService.cpp
SOURCES += $(PIPELINESERVICE)/pipelineServer.cpp



pipelineServer$(DEP): $(COMMON_DIR)/pv/pvaVersionNum.h
	@echo  $(HOSTEXE)


EXPANDVARS += EPICS_PVA_MAJOR_VERSION
EXPANDVARS += EPICS_PVA_MINOR_VERSION
EXPANDVARS += EPICS_PVA_MAINTENANCE_VERSION
EXPANDVARS += EPICS_PVA_DEVELOPMENT_FLAG

EXPANDFLAGS += $(foreach var,$(EXPANDVARS),-D$(var)="$(strip $($(var)))")


# Can't use EXPAND as generated headers must appear
# in O.Common, but EXPAND emits rules for O.$(T_A)
$(COMMON_DIR)/pv/pvaVersionNum.h: $(PVA)/pvaVersionNum.h@
	$(MKDIR) $(COMMON_DIR)/pv
	$(EXPAND_TOOL) $(EXPANDFLAGS) $($@_EXPANDFLAGS) $< $@


## This RULE should be used in case of inflating DB files 
## db rule is the default in RULES_DB, so add the empty one
## Please look at e3-mrfioc2 for example.

db: 

.PHONY: db 

# EPICS_BASE_HOST_BIN = $(EPICS_BASE)/bin/$(EPICS_HOST_ARCH)
# MSI = $(EPICS_BASE_HOST_BIN)/msi
#
# USR_DBFLAGS += -I . -I ..
# USR_DBFLAGS += -I $(EPICS_BASE)/db
# USR_DBFLAGS += -I $(APPDB)
#
# SUBS=$(wildcard $(APPDB)/*.substitutions)
# TMPS=$(wildcard $(APPDB)/*.template)
#
# db: $(SUBS) $(TMPS)

# $(SUBS):
#	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
#	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
#	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
#	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

# $(TMPS):
#	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
#	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
#	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
#	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@

#
# .PHONY: db $(SUBS) $(TMPS)

vlibs:

.PHONY: vlibs

# vlibs: $(VENDOR_LIBS)

# $(VENDOR_LIBS):
# 	$(QUIET) $(SUDO) install -m 555 -d $(E3_MODULES_VENDOR_LIBS_LOCATION)/
# 	$(QUIET) $(SUDO) install -m 555 $@ $(E3_MODULES_VENDOR_LIBS_LOCATION)/

# .PHONY: $(VENDOR_LIBS) vlibs


