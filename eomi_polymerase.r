library("ggplot2")
kapa <- cbind(read.table("/humgen/gsa-hpprojects/dev/carneiro/eomi/kapa_assay/error_rates.tbl", header<-T), polymerase<-"kapa")
taq <- cbind(read.table("/humgen/gsa-hpprojects/dev/carneiro/eomi/kapa_assay/old_error_rate", header<-T), polymerase<-"taq")
taq <- cbind(read.table("/humgen/gsa-hpprojects/dev/carneiro/eomi/kapa_assay/old_error_rates2.tbl", header<-T), polymerase<-"taq")
taq <- cbind(read.table("/humgen/gsa-hpprojects/dev/carneiro/eomi/kapa_assay/old_error_rates3.tbl", header<-T), polymerase<-"taq")

k <- rbind(taq, kapa)
qplot(PF_MISMATCH_RATE, fill<-polymerase, data<-k)