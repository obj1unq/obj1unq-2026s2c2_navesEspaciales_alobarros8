class NaveEspacial {

	var property velocidad = 0

	method aumentarVelocidad(cantidad) {
		velocidad = if (velocidad + cantidad > 300000) 300000 else velocidad + cantidad
	}

	method propulsarse() {
		self.aumentarVelocidad(20000)
	}

	method enfrentarEnemigo() {
		self.recibirAmenaza()
		self.propulsarse()
	}

	method recibirAmenaza()

	method prepararseParaViajar() {
		self.aumentarVelocidad(15000)
	}

}

class NaveDeCarga inherits NaveEspacial {

	var property carga = 0

	method estaSobrecargada() = carga > 100000

	method estaExcedidaDeVelocidad() = velocidad > 100000

	method estaEnFalta() = self.estaSobrecargada() and self.estaExcedidaDeVelocidad()

	override method recibirAmenaza() {
		carga = 0
	}

	method recibirControl() {
		if (self.estaEnFalta()) {
			self.recibirAmenaza()
		}
	}

}

class NaveDeCargaRadioactiva inherits NaveDeCarga {

	var property selladaAlVacio = false

	method sellarAlVacio() {
		selladaAlVacio = true
	}

	override method prepararseParaViajar() {
		self.aumentarVelocidad(15000)
		self.sellarAlVacio()
	}

	override method recibirAmenaza() {
		velocidad = 0
	}

}

class NaveDePasajeros inherits NaveEspacial {

	var property pasajeros = 0
	var property tripulacion = 4
	var property alarmaDeEmergencia = false

	method velocidadMaximaLegal() = 300000 / (pasajeros + tripulacion) - if (pasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarmaDeEmergencia

	override method recibirAmenaza() {
		alarmaDeEmergencia = true
	}

}

class NaveDeCombate inherits NaveEspacial {

	var property estaEnModoAtaque = false
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}

	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and estaEnModoAtaque

	override method prepararseParaViajar() {
		self.aumentarVelocidad(15000)
		if (estaEnModoAtaque) {
			self.emitirMensaje("Volviendo a la base")
		} else {
			self.emitirMensaje("Saliendo en misión")
			estaEnModoAtaque = true
		}
	}

	override method recibirAmenaza() {
		if (estaEnModoAtaque) {
			self.emitirMensaje("Enemigo encontrado")
		} else {
			self.emitirMensaje("¡RETIRADA!")
		}
	}

}
