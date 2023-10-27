import socios.*

class Actividad {
	const idiomas = new Set()
	
	method idiomas() = idiomas
	method implicaEsfuerzo()
	method sirveParaBroncearse()
	method cantidadDeDias()
	method esInteresante() = idiomas.size() > 1
	method esRecomendadaParaSocio(unSocio) = self.esInteresante() and unSocio.leAtraeActividad(self) and not unSocio.actividades().contains(self) 
}

class ViajeDePlaya inherits Actividad {
	const largoDePlaya
	
	method largoDePlaya() = largoDePlaya
	override method implicaEsfuerzo() = largoDePlaya > 1200
	override method cantidadDeDias() = largoDePlaya / 500
	override method sirveParaBroncearse() = true
}

class ExcursionACiudad inherits Actividad {
	var property atraccionesAVisitar
	
	override method implicaEsfuerzo() = atraccionesAVisitar.between(5,8)
	override method cantidadDeDias() = atraccionesAVisitar / 2
	override method sirveParaBroncearse() = false
	override method esInteresante() = super() or atraccionesAVisitar == 5
}

class EscursionACiudadTropical inherits ExcursionACiudad {
	override method cantidadDeDias() = super() + 1
	override method sirveParaBroncearse() = true
}

class SalidaDeTrekking inherits Actividad {
	const kilometrosARecorrer
	const diasDeSol
	
	method kilometrosARecorrer() = kilometrosARecorrer
	method diasDeSol() = diasDeSol
	override method implicaEsfuerzo() = kilometrosARecorrer > 80
	override method cantidadDeDias() = kilometrosARecorrer / 50
	override method sirveParaBroncearse() = diasDeSol > 200 or (diasDeSol.between(100,200) and kilometrosARecorrer > 120)
	override method esInteresante() = super() and diasDeSol > 140
}

class ClaseDeGimnasia inherits Actividad(idiomas = #{"español"}) {
	override method cantidadDeDias() = 1
	override method implicaEsfuerzo() = true
	override method sirveParaBroncearse() = false
	override method esRecomendadaParaSocio(unSocio) = unSocio.edad().between(20,30)
}

class TallerLiterario{
    const librosEnQueTrabaja = #{}
	
	method idiomas() = librosEnQueTrabaja.map({l => l.idioma()}).asSet()
    method cantidadDeDias() = librosEnQueTrabaja.size() + 1
    method tieneLibroConMasDe500Pag() = librosEnQueTrabaja.any({l => l.cantPaginas() > 500})
    method autoresDeLibros() = librosEnQueTrabaja.map({l => l.nombreDelAutor()}).asSet()
    method todosLosLibrosSonDelMismoAutor() = self.autoresDeLibros().size() == 1
    method hayMasDeUnLibro() = librosEnQueTrabaja.size() > 1
    method implicaEsfuerzo() = self.tieneLibroConMasDe500Pag() or (self.todosLosLibrosSonDelMismoAutor() and self.hayMasDeUnLibro())
    method sirveParaBroncearse() = false
    method esRecomendadaParaSocio(unSocio) = unSocio.idiomas().size() > 1
}

class Libro{
    const property idioma
    const property cantPaginas
    const property nombreDelAutor
}