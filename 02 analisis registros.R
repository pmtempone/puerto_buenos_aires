#analisis de los datos

library(ggplot2)
library(funModeling)
library(dplyr)

ggplot(data = agp_detalle,aes(cant_pasajeros,fill=sentido))+geom_density(alpha=0.4)

#mismas cantidades o distribuciones en entrada o salida

summary(agp_detalle)

#cant de pasajeros maximos 3482, tripulantes 1265

ggplot(data = agp_detalle,aes(sentido,cant_pasajeros))+geom_boxplot()

agp_detalle <- as.data.frame(agp_detalle)
freq(agp_detalle,c("sentido","servicio"))

#87% son pasajeros, el resto carga. Iguales cantidades de entradas y salidas (apenas mas entradas)

cross_plot(agp_detalle, str_input="sentido", str_target="servicio")

#mismas proporciones de entradas y salidas x tipo de servicio

ggplot(data = agp_detalle %>% filter(servicio=="Pasajeros"),aes(x=fecha_registro,y=cant_pasajeros,colour=sentido))+geom_line()+
  xlab("fecha de registro")+ylab("cantidad de pasajeros")+scale_x_datetime(date_breaks='2 week')+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

freq(agp_detalle,c("puerto"))

cross_plot(agp_detalle, str_input="puerto", str_target="sentido")

#sumarizar pasajeros x dia

cant_pasajeros <- agp_detalle %>% group_by(fecha=as.Date(fecha_registro),sentido) %>% summarise(tot_pasajeros=sum(cant_pasajeros),tot_trip=sum(cant_tripulantes))
ggplot(data = cant_pasajeros,aes(x=fecha,y=tot_pasajeros,colour=sentido))+geom_line()+
  xlab("fecha de registro")+ylab("cantidad de pasajeros")+scale_x_date(date_breaks='2 week')+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

#cantidad de pasajeros a mayo del 2016

cantidad_anio <- agp_detalle %>% filter(servicio=='Pasajeros' & sentido=='Entrada' & anio %in% c(2016,2017) & mes<6) %>% group_by(anio,mes) %>% summarise(tot_pasajeros=sum(cant_pasajeros))

ggplot(cantidad_anio,aes(x=mes,tot_pasajeros))+geom_col(aes(fill=factor(anio)), position = "dodge")+
  ylab('pasajeros')+guides(fill=guide_legend(title="Anio"))

cantidad_barcos <- agp_detalle %>% filter(servicio=='Pasajeros' & sentido=='Entrada' & anio %in% c(2016,2017) & mes<6) %>% group_by(anio,mes) %>% summarise(tot_barcos=n())

ggplot(cantidad_barcos,aes(x=mes,tot_barcos))+geom_col(aes(fill=factor(anio)), position = "dodge")+
  ylab('barcos')+guides(fill=guide_legend(title="Anio"))

#merge de codigos imo para obtener el pais de la bandera

