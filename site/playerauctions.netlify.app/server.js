// Simple HTTP Server for PlayerAuctions Website
// This server will serve your website files correctly

const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 8000;
const ROOT_DIR = __dirname;

// MIME types for different file extensions
const MIME_TYPES = {
    '.html': 'text/html',
    '.css': 'text/css',
    '.js': 'application/javascript',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.gif': 'image/gif',
    '.ico': 'image/x-icon',
    '.svg': 'image/svg+xml',
    '.txt': 'text/plain'
};

function getContentType(filePath) {
    const ext = path.extname(filePath).toLowerCase();
    return MIME_TYPES[ext] || 'application/octet-stream';
}

function serveFile(res, filePath) {
    const fullPath = path.join(ROOT_DIR, filePath);
    
    fs.readFile(fullPath, (err, data) => {
        if (err) {
            if (err.code === 'ENOENT') {
                // File not found
                res.writeHead(404, { 'Content-Type': 'text/html' });
                res.end(`
                    <!DOCTYPE html>
                    <html>
                    <head><title>404 - Not Found</title></head>
                    <body style="font-family: Arial, sans-serif; text-align: center; padding: 50px;">
                        <h1>404 - File Not Found</h1>
                        <p>The requested file <code>${filePath}</code> was not found.</p>
                        <p><a href="/">← Back to homepage</a></p>
                    </body>
                    </html>
                `);
            } else {
                // Other error
                res.writeHead(500, { 'Content-Type': 'text/html' });
                res.end(`
                    <!DOCTYPE html>
                    <html>
                    <head><title>500 - Server Error</title></head>
                    <body style="font-family: Arial, sans-serif; text-align: center; padding: 50px;">
                        <h1>500 - Internal Server Error</h1>
                        <p>Error reading file: ${err.message}</p>
                    </body>
                    </html>
                `);
            }
            return;
        }

        // Success - serve the file
        res.writeHead(200, { 'Content-Type': getContentType(fullPath) });
        res.end(data);
    });
}

const server = http.createServer((req, res) => {
    let filePath = req.url;
    
    // Default to index.html for root path
    if (filePath === '/') {
        filePath = '/working-site.html'; // Use our working site first
        
        // Check if working-site.html exists, otherwise fall back to index.html
        if (!fs.existsSync(path.join(ROOT_DIR, 'working-site.html'))) {
            filePath = '/index.html';
        }
    }
    
    // Remove leading slash and decode URL
    filePath = decodeURIComponent(filePath.substring(1));
    
    console.log(`[${new Date().toLocaleTimeString()}] ${req.method} ${req.url} -> ${filePath}`);
    
    serveFile(res, filePath);
});

server.listen(PORT, () => {
    console.log(`🚀 PlayerAuctions Website Server`);
    console.log(`=====================================\n`);
    console.log(`✅ Server running successfully!`);
    console.log(`🌐 Website URLs:`);
    console.log(`   http://localhost:${PORT}`);
    console.log(`   http://127.0.0.1:${PORT}`);
    console.log(`   http://localhost:${PORT}/working-site.html`);
    console.log(`\n📁 Serving files from: ${ROOT_DIR}`);
    console.log(`\nPress Ctrl+C to stop the server`);
    console.log(`\n🎯 Your website is ready! Open one of the URLs above in your browser.`);
});

// Handle server errors
server.on('error', (err) => {
    if (err.code === 'EADDRINUSE') {
        console.error(`❌ Port ${PORT} is already in use. Try a different port.`);
    } else {
        console.error('❌ Server error:', err);
    }
});

// Graceful shutdown
process.on('SIGINT', () => {
    console.log('\n👋 Shutting down server...');
    server.close(() => {
        console.log('✅ Server stopped. Goodbye!');
        process.exit(0);
    });
});