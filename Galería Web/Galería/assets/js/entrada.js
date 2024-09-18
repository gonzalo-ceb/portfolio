// FUNCIÓN QUE GENERA CÓDIGO QR
function generarQR(datos) {
    return new Promise((resolver) => {
        const qr = qrcode(8, 'H');
        qr.addData(datos);
        qr.make();

        const imagenQR = new Image();
        imagenQR.src = qr.createDataURL();

        imagenQR.onload = function() {
            resolver(imagenQR);
        };
    });
}

// FUNCIÓN QUE CARGA LA IMAGEN EN LA ENTRADA DEPENDIENDO DE LA EXPOSICIÓN ELEGIDA
function cargarImagen(exposicion) {
    return new Promise((resolver) => {
        const img = new Image();
        let imagenUrl = "";

        switch (exposicion) {
            case "siluetas":
                imagenUrl = "assets/images/people-1.jpg";
                break;
            case "espejos":
                imagenUrl = "assets/images/nature-1.jpg";
                break;
            case "entrelazados":
                imagenUrl = "assets/images/mixed-1.jpg";
                break;
        }
        img.src = imagenUrl;
        img.onload = function() {
            resolver(img);
        };
    });
}

// FUNCIÓN QUE GENERA EL PDF DE LA ENTRADA
document.addEventListener("DOMContentLoaded", function() {
    const formulario = document.querySelector("#contacto form");

    formulario.addEventListener("submit", function(event) {
        event.preventDefault();

        // Guardamos valores del formulario
        const nombre = document.getElementById("nombre").value;
        const apellidos = document.getElementById("apellidos").value;
        const email = document.getElementById("email").value;
        const telefono = document.getElementById("phone").value;
        const exposicion = document.getElementById("exposicion").value;
        const exposicionTexto = document.querySelector(`#exposicion option[value="${exposicion}"]`).textContent;

        const datosQR = `Nombre: ${nombre} ${apellidos}, Exposición: ${exposicionTexto}`;

        Promise.all([generarQR(datosQR), cargarImagen(exposicion)])
            .then(([imagenQR, imagenExposicion]) => {
                const doc = new window.jspdf.jsPDF();

                // Encabezado
                doc.setFontSize(24);
                doc.text("El Refugio de las Emociones", 105, 20, { align: 'center' });
                doc.setFontSize(14);
                doc.text("ENTRADA", 105, 30, { align: 'center' });

                // Línea
                doc.setLineWidth(1);
                doc.line(20, 35, 190, 35);

                // Datos visitante
                doc.setFontSize(12);
                doc.text(`Nombre: ${nombre} ${apellidos}`, 20, 50);
                doc.text(`Email: ${email}`, 20, 60);
                doc.text(`Teléfono: ${telefono}`, 20, 70);

                // Exposición seleccionada
                doc.setFontSize(14);
                doc.setTextColor(100);
                doc.text("Exposición:", 20, 90);
                doc.setFontSize(16);
                doc.setTextColor(0, 0, 255);  // color azul
                doc.text(exposicionTexto, 20, 105);

                // Información de la entrada
                doc.setFontSize(10);
                doc.setTextColor(0);  // color negro
                doc.text("Valido sólo para la fecha y hora de emisión.", 20, 120);
                doc.text("No reembolsable. No transferible.", 20, 130);

                // Código QR
                doc.addImage(imagenQR, 'PNG', 150, 50, 30, 30);

                // Imagen de exposición
                const imagenAncho = 190;
                const relacion = imagenExposicion.width / imagenExposicion.height;
                const imagenAlto = imagenAncho / relacion;
                doc.addImage(imagenExposicion, 'JPEG', 10, 140, imagenAncho, imagenAlto);

                // Pie de página
                doc.setFontSize(10);
                doc.setTextColor(100);
                doc.text("Gracias por visitar nuestra galería. ¡Disfruta de la exposición!", 20, 280);

                doc.save("entrada.pdf");
            })
            .catch(error => {
                console.error("Error generando el PDF:", error);
            });
    });
});