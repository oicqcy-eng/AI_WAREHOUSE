#!/usr/bin/env node
/**
 * check-tool-contracts.js
 * Validate the tool contract of worklog-append.js by running its validate subcommand and parsing the JSON output.
 *
 * We run: node agent/mes-report-agent/tools/worklog-append.js validate --json
 * and expect a JSON object with a summary of validation results.
 *
 * For V1r2, we only check that the command runs and returns a JSON object without throwing.
 * We can also check for the presence of certain keys if we want, but for simplicity we just ensure it doesn't fail.
 *
 * Returns { pass: boolean, error?: string }
 */
'use strict';
const { spawnSync } = require('child_process');
const path = require('path');

function runToolContractCheck() {
  const toolPath = path.join(__dirname, '..', 'agent', 'mes-report-agent', 'tools', 'worklog-append.js');
  const result = spawnSync('node', [toolPath, 'validate', '--json'], { encoding: 'utf8' });

  if (result.error) {
    return { pass: false, error: `Failed to spawn: ${result.error.message}` };
  }

  if (result.status !== 0) {
    // The command itself failed (e.g., script threw an error)
    return { pass: false, error: `Command exited with code ${result.status}: ${result.stderr}` };
  }

  // Try to parse the output as JSON
  let json;
  try {
    json = JSON.parse(result.stdout);
  } catch (e) {
    return { pass: false, error: `Failed to parse JSON output: ${e.message}` };
  }

  // If we got here, the command ran and returned valid JSON.
  // We could do more checks on the JSON structure, but for V1r2 we just consider it a pass.
  return { pass: true };
}

// Allow direct execution for testing
if (require.main === module) {
  const result = runToolContractCheck();
  if (result.pass) {
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(' AI-WAREHOUSE Contract Validation');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('[TOOLS] worklog-append.js');
    console.log('  [OK] validate subcommand runs and returns JSON');
    console.log('');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('PASS: 1  WARN: 0  FAIL: 0');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    process.exit(0);
  } else {
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(' AI-WAREHOUSE Contract Validation');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('[TOOLS] worklog-append.js');
    console.log(`  [FAIL] ${result.error}`);
    console.log('');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(`PASS: 0  WARN: 0  FAIL: 1`);
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    process.exit(1);
  }
}

module.exports = {
  runToolContractCheck
};