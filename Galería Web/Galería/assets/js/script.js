function mostrarElemento(idPagina, idTitulo, idInfo) {
    // Ocultamos todas las páginas
    var paginas = document.querySelectorAll('.pagina');
    for (var i = 0; i < paginas.length; i++) {
        paginas[i].style.display = 'none';
    }

    // Ocultamos todos los títulos
    var titulos = document.querySelectorAll('.titulo');
    for (var i = 0; i < titulos.length; i++) {
        titulos[i].style.display = 'none';
    }

    // Ocultamos la sección de la información de las exposiciones
    var informaciones = document.querySelectorAll('.info');
    for (var i = 0; i < informaciones.length; i++) {
        informaciones[i].style.display = 'none';
    }

    // Mostramos lo solicitado
    document.getElementById(idPagina).style.display = 'block';
    document.getElementById(idTitulo).style.display = 'block';
    document.getElementById(idInfo).style.display = 'block';

    // Actualizamos el enlace del scroll para que funcione con cada exposición
    var enlaceDesplazamiento = document.querySelector('.scrollDown1 a');
    enlaceDesplazamiento.setAttribute('href', '#' + idPagina);
}

function debounce(func, wait, immediate) {
    var timeout;
    return function() {
        var context = this, args = arguments;
        var later = function() {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
}

function desplazamientoSuaveA(y, duracion) {
    const yInicial = window.scrollY;
    const diferencia = y - yInicial;
    let inicio;

    // función de suavizado
    function suavizar(t, b, c, d) {
        t /= d / 2;
        if (t < 1) return c / 2 * t * t + b;
        t--;
        return -c / 2 * (t * (t - 2) - 1) + b;
    }

    window.requestAnimationFrame(function paso(timestamp) {
        if (!inicio) inicio = timestamp;
        const tiempo = timestamp - inicio;
        let porcentaje = Math.min(tiempo / duracion, 1);
        window.scrollTo(0, yInicial + diferencia * suavizar(porcentaje, 0, 1, 1));
        if (tiempo < duracion) {
            window.requestAnimationFrame(paso);
        }
    });
}

let estaDesplazandoAuto = false;

const manejarDesplazamiento = debounce(function() {
    if (window.innerWidth <= 1070) {
        return;
    }
    // 1. Seleccionar todos los elementos con la clase 'contacto'
    const secciones = document.querySelectorAll('.scroll-section');

    // 2. Iterar sobre esos elementos
    secciones.forEach(seccion => {
        const alturaVentana = window.innerHeight;
        const arribaSeccion = seccion.getBoundingClientRect().top;
        const alturaSeccion = seccion.offsetHeight;

        if (!estaDesplazandoAuto && arribaSeccion < alturaVentana / 2 && (arribaSeccion + alturaSeccion) > alturaVentana / 2) {
            estaDesplazandoAuto = true;
            desplazamientoSuaveA(seccion.offsetTop, 800);
            setTimeout(() => {
                estaDesplazandoAuto = false;
            }, 800); // asegurarte de que se sincroniza con la duración de desplazamientoSuaveA
        }
    });
}, 100);

window.addEventListener('scroll', manejarDesplazamiento);

// Al cargar la página, verifica el almacenamiento local
document.addEventListener('DOMContentLoaded', function() {
    if (localStorage.getItem('modo-claro') === 'activado') {
        document.body.classList.add('modo-claro');
    }
});

document.getElementById('themeToggle').addEventListener('click', function(event) {
    event.preventDefault();
    var body = document.body;

    if (body.classList.contains('light-mode')) {
        body.classList.remove('light-mode');
        localStorage.setItem('light-mode', 'disabled');
    } else {
        body.classList.add('light-mode');
        localStorage.setItem('light-mode', 'enabled');
    }
});
