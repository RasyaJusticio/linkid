/**
 * qrcode js
 * 
 * @author RasyaJusticio
 */

const QR_CANVAS_WIDTH = 1240;
const QR_CANVAS_HEIGHT = 1748;

async function drawQRToCanvas(canvasId, qrImageUri) {
    const canvas = document.getElementById(canvasId);

    if (!canvas) {
        console.error(`Unable to find a canvas with the id #${canvasId} - [drawQRToCanvas]`);
        return;
    }

    const context = canvas.getContext("2d");

    canvas.width = QR_CANVAS_WIDTH;
    canvas.height = QR_CANVAS_HEIGHT;

    const qrImage = await getQRCodeImage(qrImageUri);

    drawQR(context, canvas, qrImage);
}

async function drawQR(context, canvas, qrImage) {
    try {
        // Getting QR Data
        const response = await $.get(ajax_path + "payments/transfer.php?do=get_qr_info");
        const data = response.data;

        // Getting Images
        const bgImage = await loadImage('qr-gradient.jpeg');
        const containerImage = await loadImage('qr-gradient-2.png');
        const logoImage = await loadImage('linkid_full_logo_white.png');
    
        // Draw Background Image
        context.drawImage(bgImage, 0, 0, QR_CANVAS_WIDTH, QR_CANVAS_HEIGHT);
    
        // Draw System Logo
        (function() {
            const IMG_RATIO = 1.778;
            const TOP_PADDING = 20;
            const HEIGHT = 300;
            const WIDTH = HEIGHT * IMG_RATIO
    
            context.drawImage(logoImage, (QR_CANVAS_WIDTH / 2) - (WIDTH / 2), TOP_PADDING, WIDTH, HEIGHT);
        })();
    
        // Main Container
        (function() {
            const PADDING = 72;
            const Y = 330;
    
            context.drawImage(containerImage, PADDING, Y, QR_CANVAS_WIDTH - PADDING * 2, QR_CANVAS_HEIGHT - Y - PADDING);
        })();

        // Draw QR Info
        (function() {
            const HALF_WIDTH = QR_CANVAS_WIDTH / 2;

            // Full Name
            context.save();

            context.font = "bold 64px Poppins";
            context.textAlign = "center";
            context.fillText(data.full_name, HALF_WIDTH, 470);

            context.restore();

            // Username
            context.save();

            context.font = "42px Poppins";
            context.textAlign = "center";
            context.fillText(`@${data.username}`, HALF_WIDTH, 520);

            context.restore();

            // QR ID
            context.save();

            context.font = "42px Poppins";
            context.textAlign = "center";
            context.fillText(`ID: ${data.transfer_token}`, HALF_WIDTH, 630);

            context.restore();

            // Created At
            context.save();

            context.font = "42px Poppins";
            context.textAlign = "center";
            context.fillText(`Dibuat: ${data.created_at}`, HALF_WIDTH, QR_CANVAS_HEIGHT - 130);

            context.restore();
        })();
    
        // QR Code
        (function() {
            const PADDING = 152 * 1.25;
            const SIZE = QR_CANVAS_WIDTH - PADDING * 2;
            context.save();
    
            context.fillStyle = "#FFFFFF";
            context.fillRect(PADDING, QR_CANVAS_HEIGHT - PADDING - SIZE - 28, SIZE, SIZE);
    
            context.drawImage(qrImage, PADDING, QR_CANVAS_HEIGHT - PADDING - SIZE - 28, SIZE, SIZE);
    
            context.restore();
        })();

        canvas.dataset.transferToken = data.transfer_token;
        canvas.dataset.isReady = "true";
    } catch (error) {
        console.warn("[drawQR]: Failed to draw QR. Error:", error);
    }
}

function getQRCodeImage(uri) {
    return new Promise((resolve, reject) => {
        const image = new Image();
        image.src = uri;

        image.onload = () => resolve(image);
        image.onerror = reject;
    });
}

function loadImage(imagePath) {
    return new Promise((resolve, reject) => {
        const image = new Image();
        image.src = `${site_path}/content/themes/default/images/${imagePath}`;

        image.onload = () => resolve(image);
        image.onerror = reject;
    });
}

$(function () {
    $('body').on('click', '.btn-download', function (e) {
        const qrCodeCanvas = $('#qrcode').get(0);

        const isReady = $('#qrcode').data('isReady');
        const transferToken = $('#qrcode').data('transferToken');
        
        if (!isReady) {
            return;
        }

        const canvasUrl = qrCodeCanvas.toDataURL("image/jpeg", 1);

        const linkEl = document.createElement("a");
        linkEl.href = canvasUrl;

        linkEl.download = `Linkid-QR-${transferToken}`;

        linkEl.click();
        linkEl.remove();
    }); 
})
