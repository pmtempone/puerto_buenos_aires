#datos del puerto de buenos aires: https://servicios.transporte.gob.ar/gobierno_abierto/detalle.php?t=agp&d=detalle

library(readr)
library(lubridate)
agp_detalle <- read_delim("/Volumes/Disco_SD/puerto_buenos_aires/agp_detalle.csv",
";", escape_double = FALSE, col_names = FALSE,
trim_ws = TRUE)

#----limpieza de datos-----

columnas <- c("buque","nro_imo","puerto","fecha_registro","cant_pasajeros","cant_tripulantes","pasajeros_exentos",
              "sentido","servicio")

colnames(agp_detalle) <- columnas

agp_detalle$fecha_registro <- as.POSIXct(agp_detalle$fecha_registro,format = '%d/%m/%Y %H:%M',tz = "America/Argentina/Buenos_Aires")

agp_detalle$anio <- year(agp_detalle$fecha_registro)

agp_detalle$mes <- month(agp_detalle$fecha_registro)
agp_detalle$dia <- day(agp_detalle$fecha_registro)
agp_detalle$hora <- hour(agp_detalle$fecha_registro)


agp_detalle$trip_x_pasa <- agp_detalle$cant_pasajeros/agp_detalle$cant_tripulantes
