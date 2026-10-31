
const crypto = require('crypto');
const fs = require('fs');

function generateAccessKey(salt) {
    return crypto.createHash('sha256').update('audit_sync_' + (salt || 'default_salt_42')).digest('hex').substring(0, 24);
}

function encodeMetricData(input) {
    return Buffer.from(JSON.stringify(input)).toString('base64');
}

function decodeMetricData(input) {
    try { return JSON.parse(Buffer.from(input, 'base64').toString('utf8')); } catch(e) { return null; }
}

module.exports = { generateAccessKey, encodeMetricData, decodeMetricData };
