#!/usr/bin/env node
/**
 * knowledge-index-check.js - validate knowledge-index.json structure
 * Exports a function for use by validate-contract.js
 */
'use strict';
const path = require('path');

function runKnowledgeCheck() {
  const idxPath = path.join(__dirname, '..', 'knowledge-index.json');
  let idx;
  try {
    idx = require(idxPath);
  } catch (e) {
    return { issues: [{ field: 'knowledge-index.json', msg: `Cannot read file: ${e.message}`, level: 'error' }] };
  }

  const issues = [];

  if (typeof idx.version !== 'string') {
    issues.push({ field: 'version', msg: 'version must be a string', level: 'error' });
  }
  if (typeof idx.schemaVersion !== 'string') {
    issues.push({ field: 'schemaVersion', msg: 'schemaVersion must be a string', level: 'error' });
  }
  if (!Array.isArray(idx.entries)) {
    issues.push({ field: 'entries', msg: 'entries must be an array', level: 'error' });
  }

  return { issues };
}

// Allow direct execution for testing
if (require.main === module) {
  const result = runKnowledgeCheck();
  let idx;
  try {
    idx = require(path.join(__dirname, '..', 'knowledge-index.json'));
  } catch (e) {
    // should not happen if we got here, but just in case
    idx = {};
  }
  if (result.issues.length === 0) {
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(' AI-WAREHOUSE Contract Validation');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('[KNOWLEDGE] knowledge-index.json');
    console.log(`  ✓ version: ${idx.version} (string)`);
    console.log(`  ✓ schemaVersion: ${idx.schemaVersion} (string)`);
    console.log(`  ✓ entries: Array (${idx.entries.length} items)`);
    console.log('');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('PASS: 3  WARN: 0  FAIL: 0');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    process.exit(0);
  } else {
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(' AI-WAREHOUSE Contract Validation');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('[KNOWLEDGE] knowledge-index.json');
    for (const {field, msg, level} of result.issues) {
      const icon = level === 'error' ? '✗' : '⚠';
      console.log(`  ${icon} ${field}: ${msg}`);
    }
    console.log('');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(`PASS: ${3 - result.issues.filter(i=>i.level!=='error').length}  WARN: ${result.issues.filter(i=>i.level==='warn').length}  FAIL: ${result.issues.filter(i=>i.level==='error').length}`);
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    process.exit(1);
  }
}

module.exports = {
  runKnowledgeCheck
};