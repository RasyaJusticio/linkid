/**
 * qrcode js
 * 
 * @author RasyaJusticio
 */

const QR_CANVAS_WIDTH = 1240;
const QR_CANVAS_HEIGHT = 1748;
let bgImage = new Image();
let containerImage = new Image();
let logoImage = new Image(); 

/**
 * Asynchronously draws a QR code image onto a canvas element.
 *
 * @async
 * @function drawQRToCanvas
 * @param {string} canvasId - The ID of the `<canvas>` element to draw the QR code onto.
 * @param {Object} options - An object containing data for generating the QR code (currently unused in this function, but may be used by `getQRCodeImage` or future enhancements).
 * @param {string} options.qrCodeURI - The URI used to generate the QR code image.
 * @param {string} options.transferToken - The token associated with the transfer (potentially encoded in the QR).
 * @param {string} options.fullName - The full name of the user (for display or encoding).
 * @param {string} options.userName - The username of the user (for display or encoding).
 *
 * @returns {Promise<void>} Resolves when the QR code has been successfully drawn to the canvas.
 *
 * @throws Will log an error to the console if the canvas element with the specified ID cannot be found.
 *
 */
async function drawQRToCanvas(canvasId, options) {
    const canvas = document.getElementById(canvasId);

    if (!canvas) {
        console.error(`Unable to find a canvas with the id #${canvasId} - [drawQRToCanvas]`);
        return;
    }

    const context = canvas.getContext("2d");

    canvas.width = QR_CANVAS_WIDTH;
    canvas.height = QR_CANVAS_HEIGHT;

    const qrImage = await getQRCodeImage(options.qrCodeURI);

    drawQR(context, canvas, qrImage, options);
}

/**
 * Draws a stylized QR code onto a canvas with branding and user information.
 *
 * This includes background, logo, container, user details (full name, username, transfer token),
 * creation timestamp, and the QR code itself. It uses several preloaded images such as `bgImage`, 
 * `logoImage`, and `containerImage`, and assumes canvas dimensions are already set.
 *
 * @function drawQR
 * @param {CanvasRenderingContext2D} context - The 2D rendering context of the target canvas.
 * @param {HTMLCanvasElement} canvas - The canvas element on which to draw the QR code and surrounding visuals.
 * @param {HTMLImageElement} qrImage - The QR code image element to be drawn onto the canvas.
 * @param {Object} options - Data used to personalize the QR code with user-specific info.
 * @param {string} options.fullName - The full name of the user to display above the QR code.
 * @param {string} options.userName - The username of the user, displayed with an `@` prefix.
 * @param {string} options.transferToken - A token identifying the QR code, shown beneath the username.
 *
 * @returns {void}
 *
 * @throws Will log a warning if any error occurs during the drawing process.
 */
function drawQR(context, canvas, qrImage, options) {
    try {
        // Generate created at datetime
        const dateTime = generateQRCreatedTime();

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
            context.fillText(options.fullName, HALF_WIDTH, 470);

            context.restore();

            // Username
            context.save();

            context.font = "42px Poppins";
            context.textAlign = "center";
            context.fillText(`@${options.userName}`, HALF_WIDTH, 520);

            context.restore();

            // QR ID
            context.save();

            context.font = "42px Poppins";
            context.textAlign = "center";
            context.fillText(`ID: ${options.transferToken}`, HALF_WIDTH, 630);

            context.restore();

            // Created At
            context.save();

            context.font = "42px Poppins";
            context.textAlign = "center";
            context.fillText(`Dibuat: ${dateTime}`, HALF_WIDTH, QR_CANVAS_HEIGHT - 130);

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

        canvas.dataset.transferToken = options.transferToken;
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

async function loadImages() {
    bgImage = await loadImage('qr-gradient.jpeg');
    containerImage = await loadImage('qr-gradient-2.png');
    logoImage = await loadImage('linkid_full_logo_white.png');
}

function loadImage(imagePath) {
    return new Promise((resolve, reject) => {
        const image = new Image();
        image.src = `${site_path}/content/themes/default/images/${imagePath}`;

        image.onload = () => resolve(image);
        image.onerror = reject;
    });
}

function generateQRCreatedTime() {
  const now = new Date();

  const dd = String(now.getUTCDate()).padStart(2, '0');
  const MM = String(now.getUTCMonth() + 1).padStart(2, '0');
  const yyyy = now.getUTCFullYear();

  let hh = String(now.getUTCHours()).padStart(2, '0');
  let mm = String(now.getUTCMinutes()).padStart(2, '0');

  return `${dd}-${MM}-${yyyy} ${hh}:${mm}`;
}

loadImages();

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
