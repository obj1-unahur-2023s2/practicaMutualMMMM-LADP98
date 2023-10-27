import viajes.*

class Socio{
    const property actividades = #{}
    const maximoActividad
    const property edad
    const property idiomas = #{}

    method esAdoradorDelSol() = actividades.all({a => a.sirveParaBroncear()})
    method actividadesEsforzadas() = actividades.filter({a => a.implicaEsfuerzo()})
    method realizarActividad(unaActividad){
        if(actividades.size() >= maximoActividad){
            self.error("Ya supero el maximo de actividades")
        }
        actividades.add(unaActividad)
    }
}

class SocioTranquilo inherits Socio{

    method leAtraeActividad(unaActividad) = unaActividad.cantDiasDeActividad() >= 4
}

class SocioCoherente inherits Socio{

    method leAtraeActividad(unaActividad) = (self.esAdoradorDelSol() and unaActividad.sirveParaBroncear()) or unaActividad.implicaEsfuerzo()
}

class SocioRelajado inherits Socio{

    method leAtraeActividad(unaActividad) = not idiomas.intersection(unaActividad.idiomas()).isEmpty()
}