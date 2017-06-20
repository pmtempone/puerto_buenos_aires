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


